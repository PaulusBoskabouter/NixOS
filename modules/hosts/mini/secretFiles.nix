{ self, inputs, ... }: {
	flake.nixosModules.miniSecrets = { config, ... }: {
		age.secrets = {
			passwdPaul.file = "${self}/secrets/passwdMini.age";
      tailscaleKey.file = "${self}/secrets/tailscaleKey.age";
		};
	};
}
