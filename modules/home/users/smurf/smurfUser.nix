{ self, inputs, ... }: {
        flake.nixosModules.smurfUser={ pkgs, lib, config, ...}: {
		users.users."smurf" = {
				isNormalUser = true;
				description = "Smurf";
				extraGroups = [ "networkmanager" "wheel" ];
				hashedPasswordFile = config.age.secrets.passwdSmurf.path;
				openssh.authorizedKeys.keys = [
					"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDWvXdz5+8mHIbMJ0DYNZzTJm3e2A27oxUBri540rdx2 paul@calypso"
				];
		};
                programs.zsh.enable = true;
                home-manager.users.smurf.imports = [ self.homeModules.smurfHome ];
		
	};
}
