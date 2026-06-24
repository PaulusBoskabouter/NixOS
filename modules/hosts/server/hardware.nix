{ self, inputs, ...}: {
	flake.nixosModules.serverHardware = { config, lib, pkgs, modulesPath, ... }:
	{
	  imports =
	    [ (modulesPath + "/installer/scan/not-detected.nix")
	    ];

	  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
	  boot.initrd.kernelModules = [ ];
	  boot.kernelModules = [ ];
	  boot.extraModulePackages = [ ];

	  fileSystems."/" =
	    { device = "/dev/disk/by-uuid/f308f4c2-1994-4621-b1ee-f27566908a1d";
	      fsType = "ext4";
	    };

	  swapDevices = [ ];

	  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
	};
}
