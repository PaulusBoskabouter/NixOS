{ self, inputs, ... }: {
	flake.nixosModules.pocketIdContainer = { config, pkgs, lib, ... }: {
		virtualisation.docker.enable = true;
		systemd.tmpfiles.rules = [
			"d /var/lib/pocket-id 0700 root root -"
			"d /var/lib/tailscale-pocketid 0755 root root -"
		];
		virtualisation.oci-containers.backend = "docker";

		systemd.services.pocketid-serve-config = {
			description = "Write tailscale serve config for Pocket ID";
			wantedBy = [ "multi-user.target" ];
			before = [ "docker-tailscale-pocketid.service" ];
			serviceConfig.Type = "oneshot";
			script = ''
				mkdir -p /etc/tailscale-pocketid
				echo '${builtins.toJSON {
					TCP."443" = { HTTPS = true; };
					Web."validation.bearded-altair.ts.net:443".Handlers."/" = {
						Proxy = "http://127.0.0.1:1411";
					};
				}}' > /etc/tailscale-pocketid/serve.json
			'';
		};

		virtualisation.oci-containers.containers."tailscale-pocketid" = {
			image = "docker.io/tailscale/tailscale:latest";
			environment = {
				TS_HOSTNAME = "validation";
				TS_STATE_DIR = "/var/lib/tailscale";
				TS_SERVE_CONFIG = "/config/serve.json";
				TS_AUTHKEY = "file:/run/agenix/thingKey";
			};
			volumes = [
				"/var/lib/tailscale-pocketid:/var/lib/tailscale"
				"/etc/tailscale-pocketid:/config"
				"/run/agenix/thingKey:/run/agenix/thingKey:ro"
			];
			extraOptions = [
				"--cap-add=NET_ADMIN"
				"--device=/dev/net/tun"
			];
			autoStart = true;
		};

		virtualisation.oci-containers.containers."pocket-id" = {
			image = "ghcr.io/pocket-id/pocket-id:latest";
			volumes = [ "/var/lib/pocket-id:/app/data" ];
			environmentFiles = [ config.age.secrets.pocketidEnv.path ];
			environment = {
				APP_URL = "https://validation.bearded-altair.ts.net";
				TRUST_PROXY = "true";
			};
			extraOptions = [
				"--network=container:tailscale-pocketid"
			];
			autoStart = true;
			dependsOn = [ "tailscale-pocketid" ];
		};
	};
}
