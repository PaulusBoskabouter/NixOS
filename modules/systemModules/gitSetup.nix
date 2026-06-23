{ self, inputs, ...}: {
	flake.nixosModules.gitSetup = { pkgs, lib, ... }: {
		environment.systemPackages = with pkgs; [
			git
		];
	#};



	# settings
	#perSystem = { pkgs, ... }: {
	programs.git = {
	    enable = true;
	    config = {
	      user.name = "PaulusBoskabouter";
	      user.email = "43268349+PaulusBoskabouter@users.noreply.github.com";
   	      init.defaultBranch = "main";
	    };
	  };

	};
}
