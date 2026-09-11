{ self, inputs, ... }: {
	flake.nixosModules.backupDisk = { config, pkgs, lib, ... }: {
		fileSystems."/mnt/backup" = {
			device = "/dev/disk/by-uuid/3b2c2665-8208-4790-8da6-de43158b8c28";
			fsType = "ext4";
		};
	};
}
