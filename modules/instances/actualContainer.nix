{ self, inputs, ... }: {
	flake.nixosModules.actualContainer = { config, pkgs, lib, ... }: {
		virtualisation.docker.enable = true;
		systemd.tmpfiles.rules = [
			"d /var/lib/actual 0755 root root -"
			"d /var/lib/tailscale-actual 0755 root root -"
		];
		virtualisation.oci-containers.backend = "docker";

        virtualisation.oci-containers.containers."actualinstance" = {
            image = "docker.io/actualbudget/actual-server:latest";
            volumes = ["/var/lib/actual/actual-data:/data"];
            environmentFiles = [ config.age.secrets.actualAuth.path ];
            environment = {
                ACTUAL_OPENID_ENFORCE = "true";
                ACTUAL_OPENID_DISCOVERY_URL = "https://authenticate.binarystar.dev/.well-known/openid-configuration";
                ACTUAL_OPENID_SERVER_HOSTNAME = "https://budget.binarystar.dev";
            };
            extraOptions = [
                "--health-cmd=node scripts/health-check.js"
                "--health-interval=60s"
                "--health-timeout=10s"
                "--health-retries=3"
                "--health-start-period=20s"
            ];
            autoStart = true;
        };

        virtualisation.oci-containers.containers."actual_cf" = {
            image = "docker.io/cloudflare/cloudflared:latest";
            cmd = [ "tunnel" "--no-autoupdate" "run" ];
            environmentFiles = [ config.age.secrets.actualBudgetTunnel.path ];
            extraOptions = [ 
                "--network=container:actualinstance" 
                "--pull=always"
            ];

            autoStart = true;
            dependsOn = [ "actualinstance" ];
        };
        };
}
