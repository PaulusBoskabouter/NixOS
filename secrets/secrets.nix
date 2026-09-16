let
	calypsokey  = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINfPMglUFTF9V71YpoobEqPxxLrnTDAAref9Avjz0FkR root@nixos";
	thingkey    = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKsuaOpRKRDCKPhxnU36t85PcvuTWpnTlsjdnvLQyluG root@nixos";
	minikey     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEadO+9WB6lAuMtN90TF0CzJ1HKdL+BZpE0Ue79E0SjX root@nixos";
    adminkey    = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHY+NVTLIRwkcazr0OURdqsC+/fw4XQyJZGpQP+MjPtC NixFlix";

in {

    # Inital user passwds
    "passwdPaul.age".publicKeys      = [ adminkey calypsokey ];
	"passwdMini.age".publicKeys      = [ adminkey minikey];
	"passwdSmurf.age".publicKeys     = [ adminkey thingkey ];

    # TS-auth
	"calypsoKey.age".publicKeys      = [ adminkey calypsokey ];
	"miniKey.age".publicKeys         = [ adminkey minikey ];
	"thingKey.age".publicKeys        = [ adminkey thingkey ];


	# Hosting-related
	"mayGarageConfig.age".publicKeys = [ adminkey thingkey ];
	"passwdRestic.age".publicKeys    = [ adminkey thingkey ];
	"vaultwardenAuth.age".publicKeys = [ adminkey thingkey ];
}
