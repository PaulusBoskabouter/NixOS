{ self, inputs, ... }: {
	flake.nixosModules.vaultwardenContainer = { config, pkgs, lib, ... }: {
		virtualisation.docker.enable = true;
		systemd.tmpfiles.rules = [
			"d /var/lib/vaultwarden 0700 root root -"
			"d /var/lib/tailscale-vaultwarden 0755 root root -"
		];
		virtualisation.oci-containers.backend = "docker";

		systemd.services.vaultwarden-serve-config = {
			description = "Write tailscale serve config for Vaultwarden";
			wantedBy = [ "multi-user.target" ];
			before = [ "docker-tailscale-vaultwarden.service" ];
			serviceConfig.Type = "oneshot";
			script = ''
				mkdir -p /etc/tailscale-vaultwarden
				echo '${builtins.toJSON {
					TCP."443" = { HTTPS = true; };
					Web."vault.bearded-altair.ts.net:443".Handlers."/" = {
						Proxy = "http://127.0.0.1:80";
					};
				}}' > /etc/tailscale-vaultwarden/serve.json
			'';
		};
		virtualisation.oci-containers.containers."tailscale-vaultwarden" = {
			image = "docker.io/tailscale/tailscale:latest";
			environment = {
				TS_HOSTNAME = "vault";
				TS_STATE_DIR = "/var/lib/tailscale";
				TS_SERVE_CONFIG = "/config/serve.json";
				TS_AUTHKEY = "file:/run/agenix/tailscaleKey";
			};
			volumes = [
				"/var/lib/tailscale-vaultwarden:/var/lib/tailscale"
				"/etc/tailscale-vaultwarden:/config"
				"/run/agenix/tailscaleKey:/run/agenix/tailscaleKey:ro"
			];
			extraOptions = [
				"--cap-add=NET_ADMIN"
				"--device=/dev/net/tun"
			];
			autoStart = true;
		};

		virtualisation.oci-containers.containers."vaultwarden" = {
			image = "docker.io/vaultwarden/server:latest";
			volumes = [ "/var/lib/vaultwarden:/data" ];
			environmentFiles = [ config.age.secrets.vaultwardenEnv.path ];
			environment = {
				DOMAIN = "https://vault.bearded-altair.ts.net";
				SIGNUPS_ALLOWED = "false";
				WEBSOCKET_ENABLED = "true";
			};
			extraOptions = [
				"--network=container:tailscale-vaultwarden"
			];
			autoStart = true;
			dependsOn = [ "tailscale-vaultwarden" ];
		};
	};
}
