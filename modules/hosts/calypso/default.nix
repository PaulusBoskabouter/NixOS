{ self, inputs, ... }: {

	flake.nixosConfigurations.calypso = inputs.nixpkgs.lib.nixosSystem {
		modules = [
			# Machine-specific
			self.nixosModules.calypsoConfiguration
			self.nixosModules.calypsoSecrets

			# Encryption using agenix
			inputs.agenix.nixosModules.default
			self.nixosModules.basePackages

			# User-specific
			self.nixosModules.homeManagerSetup
			self.nixosModules.paulUser
			self.nixosModules.plasmaBase

			#Base packages
			self.nixosModules.gitSetup
			self.nixosModules.neovimSetup
			self.nixosModules.steamApp
			
		];
	};
}
