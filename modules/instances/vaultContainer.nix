{ self, inputs, ... }: {
	flake.nixosModules.vaultwardenContainer = { config, pkgs, lib, ... }: {
		virtualisation.docker.enable = true;
		systemd.tmpfiles.rules = [
			"d /var/lib/vaultwarden 0700 root root -"
		];
		virtualisation.oci-containers.backend = "docker";

		virtualisation.oci-containers.containers."vaultwarden" = {
			image = "docker.io/vaultwarden/server:latest";
			volumes = [ "/var/lib/vaultwarden:/data" ];
			environmentFiles = [ config.age.secrets.vaultwardenAuth.path ];
			environment = {
				DOMAIN = "https://vault.binarystar.dev";
				SIGNUPS_ALLOWED = "false";
				WEBSOCKET_ENABLED = "true";
				IP_HEADER = "CF-Connecting-IP";
			};
			autoStart = true;
		};

		virtualisation.oci-containers.containers."vaultwarden_cf" = {
			image = "docker.io/cloudflare/cloudflared:latest";
			cmd = [ "tunnel" "--no-autoupdate" "run" ];
			environmentFiles = [ config.age.secrets.vaultwardenTunnel.path ];
			extraOptions = [ "--network=container:vaultwarden" ];
			autoStart = true;
			dependsOn = [ "vaultwarden" ];
		};
	};
}
