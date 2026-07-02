{ self, inputs, ... }: {
    flake.homeModules.waylandSetup = { pkgs, ... }: {
        services.cliphist.enable = true;
        home.packages = [ pkgs.wl-clipboard ];
    };
}
