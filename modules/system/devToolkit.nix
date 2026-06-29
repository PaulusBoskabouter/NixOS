{ self, inputs, ... }: {
	flake.nixosModules.devToolkit = { pkgs, ... }: {
		environment.systemPackages = [
			pkgs.python3
			pkgs.uv
			pkgs.rustc
			pkgs.cargo
		];
	};
}
