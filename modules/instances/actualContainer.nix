{ self, inputs, ... }: {
	flake.nixosModules.actualContainer = { config, pkgs, lib, ... }: {
		virtualisation.docker.enable = true;
		systemd.tmpfiles.rules = [
			"d /var/lib/actual 0755 root root -"
			"d /var/lib/tailscale-actual 0755 root root -"
		];
		virtualisation.oci-containers.backend = "docker";

		systemd.services.actual-serve-config = {
			description = "Write tailscale serve config for Actual";
			wantedBy = [ "multi-user.target" ];
			before = [ "docker-tailscale-actual.service" ];
			serviceConfig.Type = "oneshot";
			script = ''
				mkdir -p /etc/tailscale-actual
				echo '${builtins.toJSON {
					TCP."443" = { HTTPS = true; };
					Web."budget.bearded-altair.ts.net:443".Handlers."/" = {
						Proxy = "http://127.0.0.1:5006";
					};
				}}' > /etc/tailscale-actual/serve.json
			'';
		};
		virtualisation.oci-containers.containers."tailscale-actual" = {
			image = "docker.io/tailscale/tailscale:latest";
			environment = {
				TS_HOSTNAME = "budget";
				TS_STATE_DIR = "/var/lib/tailscale";
				TS_SERVE_CONFIG = "/config/serve.json";
				TS_AUTHKEY = "file:/run/agenix/actualTSKey";
			};
			volumes = [
				"/var/lib/tailscale-actual:/var/lib/tailscale"
				"/etc/tailscale-actual:/config"
				"/run/agenix/actualTSKey:/run/agenix/actualTSKey:ro"
			];
			extraOptions = [
				"--cap-add=NET_ADMIN"
				"--device=/dev/net/tun"
			];
			autoStart = true;
		};

		virtualisation.oci-containers.containers."actualtestinstance" = {
			image = "docker.io/actualbudget/actual-server:latest";
			volumes = ["/var/lib/actual/actual-data:/data"];
			extraOptions = [
				"--health-cmd=node scripts/health-check.js"
				"--health-interval=60s"
				"--health-timeout=10s"
				"--health-retries=3"
				"--health-start-period=20s"
				"--network=container:tailscale-actual"
			];
			autoStart = true;
			environment = {};
			dependsOn = [ "tailscale-actual" ];
		};
	};
}
