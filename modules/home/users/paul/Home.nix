{ self, inputs, ... }: {
	flake.homeModules.paulHome = { ... }: {
		imports = [
            # (oh-my-)zsh setup
            self.homeModules.zshSetup
            #...

            # KDE config related:
            inputs.plasma-manager.homeModules.plasma-manager
            self.homeModules.plasmaConfig

            
            #Apps:
            programs.zed-editor = {
              enable = true;
              extensions = [ "nix" ];
            };

            home.packages = [
              inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
            ];


            programs.steam = {
              enable = true;
              remotePlay.openFirewall = true;
              dedicatedServer.openFirewall = false;
          };
        ];
	};
}
