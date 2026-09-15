{ self, inputs, ... }: {
        flake.nixosModules.smurfUser={ pkgs, lib, config, ...}: {
		users.users."smurf" = {
				isNormalUser = true;
				description = "Smurf";
				extraGroups = [ "networkmanager" "wheel" ];
				hashedPasswordFile = config.age.secrets.passwdSmurf.path;
				openssh.authorizedKeys.keys = [
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPXe1jU+e3JywNfLujZ6wulSxDLETotJ3F8Izu3jBmJX paul@calypso"
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMObMI3gexjv9NC8Xro5gcojNtWn/zBVu3fxtwAAGCHl paul@mini"
				];
				shell = pkgs.zsh;
		};
                programs.zsh.enable = true;
                home-manager.users.smurf.imports = [ self.homeModules.smurfHome ];
		
	};
}
