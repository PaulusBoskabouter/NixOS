{ self, inputs, ... }: {
	flake.nixosModules.backupDisk = { config, pkgs, lib, ... }: {
		fileSystems."/mnt/backup" = {
			device = "/dev/disk/by-uuid/06980cbd-9047-4bd9-a404-139bb01ad357";
			fsType = "ext4";
		};
	};
}
