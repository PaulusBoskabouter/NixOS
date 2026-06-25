{ self, inputs, ... }: {
	flake.homeModules.paulHome = { ... }: {
		imports = [
            self.homeModules.zshSetup
            #...

            # KDE config related:
            inputs.plasma-manager.homeModules.plasma-manager
            self.homeModules.plasmaConfig
        ];
	};
}
