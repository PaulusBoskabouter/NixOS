{ self, inputs, ... }: {
	flake.nixosModules.backupSystem = { config, pkgs, lib, ... }: {
		environment.systemPackages = [ pkgs.restic ];

		systemd.services.restic-backup = {
			description = "Restic backup of app data to /mnt/backup";
			serviceConfig.Type = "oneshot";
			environment = {
				RESTIC_REPOSITORY = "/mnt/backup/restic-repo";
				RESTIC_PASSWORD_FILE = config.age.secrets.passwdRestic.path;
				HOME= "/root";
			};
			script = ''
				if [ ! -d "$RESTIC_REPOSITORY" ]; then
					${pkgs.restic}/bin/restic init
				fi
				${pkgs.restic}/bin/restic backup \
					/var/lib/actual/actual-data \
					/var/lib/may/data
				${pkgs.restic}/bin/restic forget \
					--keep-daily 7 \
					--keep-weekly 8 \
					--keep-monthly 12 \
					--prune
			'';
		};

		systemd.timers.restic-backup = {
			description = "Weekly restic backup timer";
			wantedBy = [ "timers.target" ];
			timerConfig = {
				OnCalendar = "Sun *-*-* 03:00:00";
				Persistent = true;
			};
		};
	};
}
