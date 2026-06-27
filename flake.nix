{
	inputs = {
        # Nix version
        nixpkgs.url = "github:nixos/nixpkgs/release-26.05";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        
        # Dendritic thingies
		flake-parts.url = "github:hercules-ci/flake-parts";
		import-tree.url = "github:vic/import-tree";

		# Encryption stuff
		agenix.url = "github:ryantm/agenix";
		agenix.inputs.nixpkgs.follows = "nixpkgs";


        # Home and KDE managing
		home-manager = {
		    url = "github:nix-community/home-manager";
		    inputs.nixpkgs.follows = "nixpkgs";
		};

    plasma-manager = {
        url = "github:nix-community/plasma-manager";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "home-manager";
    };


		# nvim config
		nixvim = {
			url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nixpkgs";
		};

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	};




	outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
