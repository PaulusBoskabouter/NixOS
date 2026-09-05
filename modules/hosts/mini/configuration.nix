{ self, inputs, ... }: {
    flake.nixosModules.miniConfiguration={ pkgs, lib, config, ...}: {
        imports = [ self.nixosModules.miniHardware ];


        # Bootloader.
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        networking.hostName = "mini"; # Define your hostname.

        # Enable networking
        networking.networkmanager = {
            enable = true;
            plugins = [ pkgs.networkmanager-openvpn ];
        };

        # Virtualbox
        virtualisation.virtualbox.host.enable = true;

        # Cuda toolkit things
        nix.settings = {
          substituters = [ "https://cache.nixos-cuda.org" ];
          trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
        };

        # Bluetooth things
        hardware.bluetooth = {
            enable = true;
            powerOnBoot = true;
        };

        # Set your time zone.
        time.timeZone = "Europe/Amsterdam";

        # Select internationalisation properties.
        i18n.defaultLocale = "en_US.UTF-8";

        i18n.extraLocaleSettings = {
            LC_ADDRESS = "nl_NL.UTF-8";
            LC_IDENTIFICATION = "nl_NL.UTF-8";
            LC_MEASUREMENT = "nl_NL.UTF-8";
            LC_MONETARY = "nl_NL.UTF-8";
            LC_NAME = "nl_NL.UTF-8";
            LC_NUMERIC = "nl_NL.UTF-8";
            LC_PAPER = "nl_NL.UTF-8";
            LC_TELEPHONE = "nl_NL.UTF-8";
            LC_TIME = "nl_NL.UTF-8";
        };

        # Enable the X11 windowing system.
        services.xserver.enable = true;

        nix.settings.experimental-features = ["nix-command" "flakes"];

        # Allow unfree packages
        nixpkgs.config = {
            allowUnfree = true;
            permittedInsecurePackages = [ "pnpm-10.29.2" ];
        };


        # Configure keymap in X11
        services.xserver.xkb = {
            layout = "us";
            variant = "euro";
        };

        services.printing.enable = true;

        # Enable sound with pipewire.
        services.pulseaudio.enable = false;
        security.rtkit.enable = true;
        services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        };

        # Enable touchpad support (enabled default in most desktopManager).
        services.libinput.enable = true;



        # Enable the OpenSSH daemon to trusted devices only.
        services.openssh= {
        enable = true;
            settings = {
                PasswordAuthentication = false;
                PermitRootLogin = "no";
                KbdInteractiveAuthentication = false;
            };
        };

        # Open ports in the firewall.
        # networking.firewall.allowedTCPPorts = [ ... ];
        # networking.firewall.allowedUDPPorts = [ ... ];

        system.stateVersion = "26.05";

    };

}
