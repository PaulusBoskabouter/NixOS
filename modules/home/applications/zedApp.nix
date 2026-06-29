{ self, inputs, ... }: {
	flake.homeModules.zedApp = { pkgs, ... }: {
		programs.zed-editor = {
            package = pkgs.unstable.zed-editor;
			enable = true;
			extensions = [ 
                "nix"
                "lua"
                "nightfox"
                "catppuccin icons"
                "Charmed Icons"
                "Git Firefly"

            ];

            userSettings = {
                ui_font_size = 16;
                theme = "Terafox - opaque";
                icon_theme = "Light Charmed Icons";
            };
		};
	};
}
