{ self, inputs, ... }: {
        flake.nixosModules.baseUser={ pkgs, lib, config, ...}: {
		users.users."paul" = {
				isNormalUser = true;
				description = "Paul";
				extraGroups = [ "networkmanager" "wheel" ];
				hashedPasswordFile = config.age.secrets.passwdPaul.path;
				};
	};
}
