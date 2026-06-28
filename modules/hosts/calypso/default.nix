{ self, inputs, ... }: {

	flake.nixosConfigurations.calypso = inputs.nixpkgs.lib.nixosSystem {
		modules = [
			# Machine-specific
			self.nixosModules.calypsoConfiguration
			self.nixosModules.calypsoSecrets
			self.nixosModules.extraDisks
			self.nixosModules.nvidiaSetup

			# Encryption using agenix
			inputs.agenix.nixosModules.default
			self.nixosModules.basePackages

			# User-specific
			self.nixosModules.homeManagerSetup
			self.nixosModules.paulUser
			self.nixosModules.plasmaBase

			#Base packages
			self.nixosModules.unstableOverlay # For grabbing unstable releases
			self.nixosModules.gitSetup
			self.nixosModules.neovimSetup
			self.nixosModules.steamApp
			self.nixosModules.tailscaleServer
			
		];
	};
}
