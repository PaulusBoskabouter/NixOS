{ self, inputs, ... }: {
    flake.nixosModules.plasmaBase = { pkgs, ... }: {
        services.desktopManager.plasma6 = {
            enable = true;
            excludePackages = with pkgs.kdePackages; [
                konsole
                kate
            ];
        };

        services.displayManager.sddm = {
            enable = true;
            wayland.enable = true;
        };
        environment.systemPackages = [ 
            pkgs.kdePackages.bluedevil # bluetooth stuff
            ];
    };
}


