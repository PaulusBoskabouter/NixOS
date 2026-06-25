{ self, inputs, ... }: {
	flake.homeModules.paulHome = { ... }: {
		imports = [ self.homeModules.zshSetup ];
	};
}
