{ self, inputs, ... }: {
	flake.nixosModules.paulUser = { pkgs, config, ... }: {
		programs.zsh.enable = true;
		users.users."paul" = {
			isNormalUser = true;
			description = "Paul";
			extraGroups = [ "networkmanager" "wheel" ];
			hashedPasswordFile = config.age.secrets.passwdPaul.path;
			shell = pkgs.zsh;
		};
		home-manager.users.paul.imports = [ self.homeModules.paulHome ];
	};
}
