{ self, inputs, ... }: {
	flake.homeModules.paulHome = { pkgs, ... }: {
		imports = [
            # Desktop environment(s)
            inputs.plasma-manager.homeModules.plasma-manager
			self.homeModules.plasmaConfig

            # Wayland thingies
            self.homeModules.waylandSetup # clipboard stuff

            # Actual applications
            self.homeModules.standardApps
            self.homeModules.zedApp
            self.homeModules.zenBrowser

            # Terminal-related
            self.homeModules.kittySetup
            self.homeModules.zshSetup

		];
	};
}
