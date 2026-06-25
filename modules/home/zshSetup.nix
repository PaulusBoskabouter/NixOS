{ self, inputs, ... }: {
	flake.homeModules.zshSetup = { pkgs, ... }: {
		programs.zsh = {
			enable = true;

			oh-my-zsh = {
				enable = true;
				theme = "agnoster";
				plugins = [ "git" "sudo" ];
			};

			autosuggestion.enable = true;
			syntaxHighlighting.enable = true;
			enableCompletion = true;

			history = {
				size = 10000;
				save = 10000;
			};
		};
	};
}
