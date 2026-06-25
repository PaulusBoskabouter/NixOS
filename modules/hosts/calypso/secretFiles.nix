{ self, inputs, ... }: {
	flake.nixosModules.calypsoSecrets = { config, ... }: {
		age.secrets = {
			passwdPaul.file = "${self}/secrets/passwdPaul.age";
			passwdSmurf.file = "${self}/secrets/passwdSmurf.age";
			tailscaleKey.file = "${self}/secrets/tailscaleKey.age";
			actualTSKey.file = "${self}/secrets/actualTSKey.age";
			mayGarageTSKey.file = "${self}/secrets/mayGarageTSKey.age";
			mayGarageConfig.file = "${self}/secrets/mayGarageConfig.age";
		};
	};
}
