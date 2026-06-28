{ self, inputs, ... }: {
	flake.nixosModules.nvidiaSetup = { config, pkgs, ... }: {
		services.xserver.videoDrivers = [ "nvidia" ];

		hardware.graphics = {
			enable = true;
			enable32Bit = true;
		};

		hardware.nvidia = {
			modesetting.enable = true;
			open = false; # RTX 3070 is Ampere — proprietary driver still recommended over the open kernel module for max compatibility/performance
			nvidiaSettings = true;
			package = config.boot.kernelPackages.nvidiaPackages.stable;
		};
	};
}
