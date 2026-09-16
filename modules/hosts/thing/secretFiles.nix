{ self, inputs, ... }: {
	flake.nixosModules.thingSecrets = { config, ... }: {
		age.secrets = {
			passwdSmurf.file = "${self}/secrets/passwdSmurf.age";
			tailscaleKey.file = "${self}/secrets/thingKey.age";
			mayGarageConfig.file = "${self}/secrets/mayGarageConfig.age";
			passwdRestic.file = "${self}/secrets/passwdRestic.age";
            vaultwardenAuth.file = "${self}/secrets/vaultwardenAuth.age";
		};
	};
}
