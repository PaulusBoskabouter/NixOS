{ self, inputs, ...}: {
	flake.nixosModules.basePackages = { pkgs, lib, ... }: {
		environment.systemPackages = with pkgs; [
			tree
			btop
			vim
			wget
			# neovim
			inputs.agenix.packages.${pkgs.system}.default
			bat
			openssl
		];
	};



	# settings
	perSystem = { pkgs, ... }: {

	};
}
