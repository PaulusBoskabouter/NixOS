{ self, inputs, ... }: {
	flake.nixosModules.devToolkit = { pkgs, ... }: {
		environment.systemPackages = [
			pkgs.python3
			pkgs.uv
			pkgs.rustc
			pkgs.cargo
		];

		# Lets UV-installed compiled wheels (numpy, scipy, etc.) find
		# standard shared libraries, the same way they'd find them on
		# any non-NixOS distro — keeps projects fully portable/non-Nix-specific.
		environment.variables.LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [
			pkgs.stdenv.cc.cc.lib
			pkgs.zlib
			pkgs.openssl
			pkgs.glib
		]}";

		programs.nix-ld.enable = true;
		programs.nix-ld.libraries = with pkgs; [
			stdenv.cc.cc.lib
			zlib
			openssl
		];
	};
}
