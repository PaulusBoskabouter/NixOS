{ self, inputs, ... }: {

	flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
		modules = [
			# Encryption using agenix
			inputs.agenix.nixosModules.default
			self.nixosModules.secrets
			self.nixosModules.basePackages
			self.nixosModules.gitSetup
			self.nixosModules.vmConfiguration
			# Self-hosting stuff
			self.nixosModules.mayGarageContainer
			self.nixosModules.actualContainer
			self.nixosModules.tailscaleServer

		];
	};
}
