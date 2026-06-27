{ self, inputs, ... }: {
	flake.homeModules.standardApps = { pkgs, ... }: {
		home.packages = [
			pkgs.signal-desktop
			pkgs.spotify
			pkgs.discord
		];
	};
}
