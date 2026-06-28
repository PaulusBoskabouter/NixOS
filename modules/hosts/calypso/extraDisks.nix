{ self, inputs, ... }: {
	flake.nixosModules.extraDisks = { config, pkgs, lib, ... }: {
		fileSystems."/mnt/small_ssd" = {
			device = "/dev/disk/by-uuid/f5544021-a31c-4cf3-976f-8225c16e677d";
			fsType = "ext4";
		};
	};
}

