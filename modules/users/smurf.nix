{ self, inputs, ... }: {
        flake.nixosModules.smurfUser={ pkgs, lib, config, ...}: {
		users.users."smurf" = {
				isNormalUser = true;
				description = "Smurf";
				extraGroups = [ "networkmanager" "wheel" ];
				hashedPasswordFile = config.age.secrets.psswdSmurf.path;
				};
	};
}
