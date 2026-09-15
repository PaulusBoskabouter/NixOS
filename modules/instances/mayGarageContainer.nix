{ self, inputs, ... }: {
	flake.nixosModules.mayGarageContainer = { config, pkgs, lib, ... }: {
		systemd.tmpfiles.rules = [
			"d /var/lib/may 0755 root root -"
			"d /var/lib/tailscale-mayGarage 0755 root root -"
		];
		systemd.services.mayGarage-serve-config = {
			description = "Write mayGarage serve config for may";
			wantedBy = [ "multi-user.target" ];
			before = [ "docker-tailscale-mayGarage.service" ];
			serviceConfig.Type = "oneshot";
			script = ''
				mkdir -p /etc/tailscale-mayGarage
				echo '${builtins.toJSON {
					TCP."443" = { HTTPS = true; };
					Web."garage.bearded-altair.ts.net:443".Handlers."/" = {
						Proxy = "http://127.0.0.1:5050";
					};
				}}' > /etc/tailscale-mayGarage/serve.json
			'';
		};
		virtualisation.oci-containers.containers."tailscale-mayGarage" = {
			image = "docker.io/tailscale/tailscale:latest";
			environment = {
				TS_HOSTNAME = "garage";
				TS_STATE_DIR = "/var/lib/tailscale";
				TS_SERVE_CONFIG = "/config/serve.json";
				TS_AUTHKEY = "file:/run/agenix/mayGarageTSKey";
			};
			volumes = [
				"/var/lib/tailscale-mayGarage:/var/lib/tailscale"
				"/etc/tailscale-mayGarage:/config"
				"/run/agenix/mayGarageTSKey:/run/agenix/mayGarageTSKey:ro"
			];
			extraOptions = [
				"--cap-add=NET_ADMIN"
				"--device=/dev/net/tun"
			];
			autoStart = true;
		};
		virtualisation.oci-containers.containers."mayGarage" = {
			image = "ghcr.io/dannymcc/may:latest";
			volumes = ["/var/lib/may/data:/app/data"];
			environment = {
				DATABASE_URL = "sqlite:////app/data/may.db";
				UPLOAD_FOLDER = "/app/data/uploads";
			};
			environmentFiles = [ config.age.secrets.mayGarageConfig.path ];
			extraOptions = [ "--network=container:tailscale-mayGarage" ];
			autoStart = true;
			dependsOn = [ "tailscale-mayGarage" ];
		};
	};
}
