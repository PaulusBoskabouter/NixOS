{ self, inputs, ... }: {
    flake.nixosModules.plasmaBase = { pkgs, ... }: {
        services.desktopManager.plasma6.enable = true;
        services.displayManager.sddm.enable = true;

        environment.systemPackages = [ pkgs.kitty ];
    };
}


