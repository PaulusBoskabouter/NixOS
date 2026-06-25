{ self, inputs, ... }: {

	flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
		modules = [
			# Encryption using agenix
			inputs.agenix.nixosModules.default
			self.nixosModules.vmSecrets
			self.nixosModules.basePackages
			self.nixosModules.gitSetup
			self.nixosModules.vmConfiguration

			# User
			self.nixosModules.homeManagerSetup
			self.nixosModules.paulUser
			
			# Self-hosting stuff
#			self.nixosModules.mayGarageContainer
	#		self.nixosModules.actualContainer
	#		self.nixosModules.tailscaleServer

		];
	};
}
