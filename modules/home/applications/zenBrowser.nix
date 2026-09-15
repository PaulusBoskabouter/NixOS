{ self, inputs, ... }: {
	flake.homeModules.zenBrowser = { pkgs, ... }: {
		home.packages = [
			inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
		];
	};
}
