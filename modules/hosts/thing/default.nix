{ self, inputs, ... }: {

	flake.nixosConfigurations.thing = inputs.nixpkgs.lib.nixosSystem {
		modules = [
            # Machine-specific
			self.nixosModules.thingConfiguration
			self.nixosModules.thingSecrets


			# Encryption using agenix
			inputs.agenix.nixosModules.default

			# Base packages
			self.nixosModules.basePackages
			self.nixosModules.gitSetup
			self.nixosModules.neovimSetup

			# User
			self.nixosModules.homeManagerSetup
			self.nixosModules.smurfUser

			# Self-hosting stuff
			self.nixosModules.mayGarageContainer
			self.nixosModules.actualContainer
			self.nixosModules.tailscaleServer

			# Backup system
			self.nixosModules.backupDisk
			self.nixosModules.backupSystem

		];
	};
}
