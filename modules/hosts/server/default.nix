{ self, inputs, ... }: {

	flake.nixosConfigurations.server = inputs.nixpkgs.lib.nixosSystem {
		modules = [
			# Encryption using agenix
			inputs.agenix.nixosModules.default
			self.nixosModules.serverSecrets

			# Base packages
			self.nixosModules.basePackages
			self.nixosModules.gitSetup
			self.nixosModules.vmConfiguration

			# User
			self.nixosModules.smurfUser

			# Self-hosting stuff
			self.nixosModules.mayGarageContainer
			self.nixosModules.actualContainer
			self.nixosModules.tailscaleServer

		];
	};
}
