{ self, inputs, ... }: {
	flake.nixosModules.secrets = { config, ... }: {
		age.secrets = {
			# oefen = {file = "${self}/secrets/oefen.age";};
			pwdPaul.file = "${self}/secrets/pwdPaul.age";
			tailscaleKey.file = "${self}/secrets/tailscaleKey.age";
			actualTSKey.file = "${self}/secrets/actualTSKey.age";
			mayGarageTSKey.file = "${self}/secrets/mayGarageTSKey.age";
			mayGarageConfig.file = "${self}/secrets/mayGarageConfig.age";
		};
	};
}
