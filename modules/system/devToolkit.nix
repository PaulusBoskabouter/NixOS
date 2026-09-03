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

		environment.variables.LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [
			pkgs.stdenv.cc.cc.lib
			pkgs.zlib
			pkgs.openssl
			pkgs.glib
			pkgs.cudaPackages.cudatoolkit
			pkgs.cudaPackages.cuda_cudart
			pkgs.libGL
		]}:/run/opengl-driver/lib";

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
