{ self, inputs, ... }: {
	flake.nixosModules.pocketIdContainer = { config, pkgs, lib, ... }: {
		virtualisation.docker.enable = true;
		systemd.tmpfiles.rules = [
			"d /var/lib/pocket-id 0700 root root -"
		];
		virtualisation.oci-containers.backend = "docker";

		virtualisation.oci-containers.containers."pocket-id" = {
			image = "ghcr.io/pocket-id/pocket-id:latest";
			volumes = [ "/var/lib/pocket-id:/app/data" ];
			environmentFiles = [ config.age.secrets.pocketidEnv.path ];
			environment = {
				APP_URL = "https://authenticate.binarystar.dev";
				TRUST_PROXY = "true";
			};
			autoStart = true;
		};

		virtualisation.oci-containers.containers."pocketid_cf" = {
			image = "docker.io/cloudflare/cloudflared:latest";
			cmd = [ "tunnel" "--no-autoupdate" "run" ];
			environmentFiles = [ config.age.secrets.pocketidTunnel.path ];
			extraOptions = [ "--network=container:pocket-id" ];
			autoStart = true;
			dependsOn = [ "pocket-id" ];
		};
	};
}
