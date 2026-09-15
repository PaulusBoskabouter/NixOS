{ self, inputs, ... }: {
	flake.nixosModules.neovimSetup = { pkgs, ... }: {
		imports = [ inputs.nixvim.nixosModules.nixvim ];

		programs.nixvim = {
			enable = true;
			defaultEditor = true;
			viAlias = true;
			vimAlias = true;
            version.enableNixpkgsReleaseCheck = false;
            nixpkgs.pkgs = pkgs;

			colorschemes.catppuccin = {
				enable = true;
				settings.flavour = "mocha";
			};

			opts = {
				number = true;
				relativenumber = true;
				expandtab = true;
				shiftwidth = 4;
				tabstop = 4;
				softtabstop = 4;
				smartindent = true;
				wrap = false;
				ignorecase = true;
				smartcase = true;
				termguicolors = true;
				scrolloff = 8;
				signcolumn = "yes";
			};

			extraPlugins = [ pkgs.vimPlugins.typst-preview-nvim ];
			extraConfigLua = ''
				require("typst-preview").setup()
			'';
		};
	};
}
