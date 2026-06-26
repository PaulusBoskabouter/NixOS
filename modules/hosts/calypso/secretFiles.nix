{ self, inputs, ... }: {
	flake.nixosModules.calypsoSecrets = { config, ... }: {
		age.secrets = {
			passwdPaul.file = "${self}/secrets/passwdPaul.age";
		};
	};
}
