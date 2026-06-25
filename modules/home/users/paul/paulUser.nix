{ self, inputs, ... }: {
	flake.nixosModules.paulUser = { pkgs, config, ... }: {
		users.users."paul" = {
			isNormalUser = true;
			description = "Paul";
			extraGroups = [ "networkmanager" "wheel" ];
			hashedPasswordFile = config.age.secrets.passwdPaul.path;
			shell = pkgs.zsh;
		};
		programs.zsh.enable = true;
		home-manager.users.paul.imports = [ self.homeModules.paulHome ];
	};
}
