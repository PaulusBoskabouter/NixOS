{ self, inputs, ... }: {
    flake.nixosModules.plasmaBase = { pkgs, ... }: {
        services.desktopManager.plasma6 = {
            enable = true;

        };
        services.flatpak.enable = true; # Temporarily(?) for some apps
        environment.plasma6.excludePackages = with pkgs.kdePackages; [
                konsole
                kate
            ];


        services.displayManager.sddm = {
            enable = true;
            wayland.enable = true;
        };
        environment.systemPackages = [
            pkgs.kdePackages.bluedevil # bluetooth stuff
            ];
    };
}
