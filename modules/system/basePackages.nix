{ self, inputs, ...}: {
	flake.nixosModules.basePackages = { pkgs, lib, ... }: {
		environment.systemPackages = with pkgs; [
			tree
			btop
			vim
			wget
			# neovim
			inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
			bat
			openssl
            eduvpn-client # Uni vpn
            openconnect # Work vpn
		];
	};



	# settings
	perSystem = { pkgs, ... }: {

	};
}
