{ self, inputs, ... }: {
	flake.homeModules.standardApps = { pkgs, ... }: {
		home.packages = [
			pkgs.unstable.signal-desktop
			pkgs.spotify
			pkgs.discord
            pkgs.vlc
            pkgs.kdePackages.kcalc
		];
	};
}
