{ self, inputs, ... }: {

	flake.nixosConfigurations.calypso = inputs.nixpkgs.lib.nixosSystem {
		modules = [
            # Machine-specific
			self.nixosModules.calypsoConfiguration
			self.nixosModules.calypsoSecrets

			# Encryption using agenix
			inputs.agenix.nixosModules.default
			self.nixosModules.basePackages
			self.nixosModules.gitSetup
			self.nixosModules.neovimSetup

			# User-specific
			self.nixosModules.homeManagerSetup
			self.nixosModules.paulUser
            self.nixosModules.plasmaBase
			
			# Self-hosting stuff
#			self.nixosModules.mayGarageContainer
	#		self.nixosModules.actualContainer
	#		self.nixosModules.tailscaleServer

		];
	};
}
