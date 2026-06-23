{ self, inputs, ...}: {
	flake.nixosModules.oldactualContainer = { pkgs, lib, ... }: {
		virtualisation.docker.enable = true;	

		systemd.tmpfiles.rules = ["d /var/lib/actual 0755 root root -"];

		virtualisation.oci-containers.backend = "docker";
		
		# Actual budget settings
		virtualisation.oci-containers.containers."actualtest" = {
			image = "docker.io/actualbudget/actual-server:latest";

			ports = ["127.0.0.1:5006:5006"]; # Bind it to localhost-only for https purposes

			volumes = ["/var/lib/actual/actual-data:/data"];

			extraOptions = [
			      "--health-cmd=node scripts/health-check.js"
			      "--health-interval=60s"
			      "--health-timeout=10s"
			      "--health-retries=3"
			      "--health-start-period=20s"
			    ];

			autoStart = true;			
			
			environment = {};


		  };
	};

}


