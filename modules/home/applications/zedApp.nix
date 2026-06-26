{ self, inputs, ... }: {
	flake.homeModules.zedApp = { ... }: {
		programs.zed-editor = {
			enable = true;
			extensions = [ "nix" ];
		};
	};
}
