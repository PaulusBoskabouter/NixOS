{ self, inputs, ... }: {
	flake.nixosModules.homeManagerSetup = { ... }: {
		imports = [ inputs.home-manager.nixosModules.home-manager ];
		home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;
		home-manager.sharedModules = [
			{ home.stateVersion = "26.05"; home.enableNixpkgsReleaseCheck = false;}
		];
	};
}
