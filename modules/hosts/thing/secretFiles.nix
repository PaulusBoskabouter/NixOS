{ self, inputs, ... }: {
	flake.nixosModules.thingSecrets = { config, ... }: {
		age.secrets = {
			passwdSmurf.file = "${self}/secrets/passwdSmurf.age";
			tailscaleKey.file = "${self}/secrets/tailscaleKey.age";
			mayGarageConfig.file = "${self}/secrets/mayGarageConfig.age";
			mayGarageTSKey.file = "${self}/secrets/mayGarageTSKey.age";
			actualTSKey.file = "${self}/secrets/actualTSKey.age";
			passwdRestic.file = "${self}/secrets/passwdRestic.age";
		};
	};
}
