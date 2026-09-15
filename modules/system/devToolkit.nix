{ self, inputs, ... }: {
	flake.nixosModules.devToolkit = { pkgs, config, ... }: {
		environment.systemPackages = [
			pkgs.python3
			pkgs.uv
			pkgs.rustc
			pkgs.cargo
			pkgs.cudaPackages.cudatoolkit
			pkgs.virtualbox
		];
		programs.nix-ld = {
			enable = true;
			libraries = with pkgs; [
				stdenv.cc.cc.lib
				zlib
				openssl
				cudaPackages.cudatoolkit
				cudaPackages.cuda_cudart
				libGL
			];
		};
	};
}
