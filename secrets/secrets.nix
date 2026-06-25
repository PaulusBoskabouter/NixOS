let
	calypsokey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP9goVCP7hVvnltNQ6QONPbqzJGGKbiHBmQ5sIfC7FmV sjaak@testding";
	serverkey= "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKsuaOpRKRDCKPhxnU36t85PcvuTWpnTlsjdnvLQyluG root@nixos";


in {

	"passwdPaul.age".publicKeys = [ calypsokey ];
	"passwdSmurf.age".publicKeys = [ serverkey ];

	# Hosting-related
	"tailscaleKey.age".publicKeys = [ serverkey ];
	"mayGarageConfig.age".publicKeys = [ serverkey ];
	"mayGarageTSKey.age".publicKeys = [ serverkey ];
	"actualTSKey.age".publicKeys = [ serverkey ];
	"passwdRestic.age".publicKeys = [ serverkey ];
}
