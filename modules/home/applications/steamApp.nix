{ self, inputs, ... }: {
	flake.nixosModules.steamApp = { pkgs, ... }: {
		programs.steam = {
			enable = true;
			remotePlay.openFirewall = true;
			dedicatedServer.openFirewall = false;
		};
		hardware.graphics.enable32Bit = true;
        hardware.steam-hardware.enable = true;
	};
}
