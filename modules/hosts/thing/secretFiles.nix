{ self, inputs, ... }: {
	flake.nixosModules.thingSecrets = { config, ... }: {
		age.secrets = {
            #User/machine-related
			passwdSmurf.file = "${self}/secrets/passwdSmurf.age";
			thingKey.file = "${self}/secrets/thingKey.age";


            # Tunnels
            pocketidTunnel.file = "${self}/secrets/pocketidTunnel.age";
            vaultwardenTunnel.file = "${self}/secrets/vaultTunnel.age";
            actualBudgetTunnel.file = "${self}/secrets/actualTunnel.age";


            # Container settings
            pocketidEnv.file = "${self}/secrets/pocketidEnv.age";
			mayGarageConfig.file = "${self}/secrets/mayGarageConfig.age";
			passwdRestic.file = "${self}/secrets/passwdRestic.age";
            vaultwardenAuth.file = "${self}/secrets/vaultwardenAuth.age";
            actualAuth.file = "${self}/secrets/actualAuth.age";
		};
	};
}
