{ self, inputs, ... }: {
	flake.homeModules.paulHome = { pkgs, ... }: {
		imports = [
			self.homeModules.zshSetup
			inputs.plasma-manager.homeModules.plasma-manager
			self.homeModules.plasmaConfig
			self.homeModules.zedApp
			self.homeModules.zenBrowser
		];
	};
}
