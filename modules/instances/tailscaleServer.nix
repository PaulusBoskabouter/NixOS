{ self, inputs, ... }: {
	flake.nixosModules.tailscaleServer = { config, pkgs, lib, ... }: {
		services.tailscale = {
			enable = true;
			useRoutingFeatures = "client"; # this node only, not a subnet router/exit-node
		};

		# Trust traffic arriving over the tailnet
		networking.firewall.trustedInterfaces = [ "tailscale0" ];

		# services.tailscale.enable doesn't authenticate automatically — connect on boot
		systemd.services.tailscale-autoconnect = {
			description = "Automatic connect to Tailscale";
			after = [ "network-pre.target" "tailscale.service" ];
			wants = [ "network-pre.target" "tailscale.service" ];
			wantedBy = [ "multi-user.target" ];
			serviceConfig.Type = "oneshot";
			script = ''
				sleep 2
				status=$(${pkgs.tailscale}/bin/tailscale status -json | ${pkgs.jq}/bin/jq -r .BackendState)
				if [ "$status" = "Running" ]; then
					exit 0
				fi
				${pkgs.tailscale}/bin/tailscale up --authkey=$(cat ${config.age.secrets.tailscaleKey.path})
			'';
		};

		# Declaratively expose Actual over the tailnet, so it's reproducible
		# from the flake rather than a manual `tailscale serve` command
		# systemd.services.tailscale-serve-actual = {
		# 	description = "Configure tailscale serve for Actual Budget";
		# 	after = [ "tailscale-autoconnect.service" ];
		# 	wants = [ "tailscale-autoconnect.service" ];
		# 	wantedBy = [ "multi-user.target" ];
		# 	serviceConfig.Type = "oneshot";
		# 	script = ''
		# 		${pkgs.tailscale}/bin/tailscale serve reset
		# 		${pkgs.tailscale}/bin/tailscale serve --bg --set-path=/actual http://127.0.0.1:5006;
		# 		${pkgs.tailscale}/bin/tailscale serve --bg --set-path=/garage http://127.0.0.1:5050;
		# 	'';
		# };
	};
}
