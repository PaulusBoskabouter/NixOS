{ self, inputs, ... }: {
	flake.homeModules.standardApps = { pkgs, ... }: {
		home.packages = [
			pkgs.unstable.signal-desktop
			pkgs.spotify
			pkgs.discord
		];
	};
}
