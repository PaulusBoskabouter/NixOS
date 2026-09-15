{ self, inputs, ... }: {
	flake.homeModules.kittySetup = { pkgs, ... }: {
		programs.kitty = {
			enable = true;
			themeFile = "Catppuccin-Mocha";

			shellIntegration.mode = "no-cursor"; # let zsh/our own cursor settings win, avoid kitty fighting it

			settings = {
				shell = "${pkgs.zsh}/bin/zsh";
				cursor_shape = "block";
				cursor_trail = "200";
				cursor_trail_decay = "0.1 0.4";
				cursor_trail_start_threshold = "2";
				confirm_os_window_close = "0";
			};

			font = {
				name = "MesloLGS Nerd Font";
				size = 12;
			};
		};
	};
}
