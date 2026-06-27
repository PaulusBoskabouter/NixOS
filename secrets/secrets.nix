let
	calypsokey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINfPMglUFTF9V71YpoobEqPxxLrnTDAAref9Avjz0FkR root@nixos";
	serverkey= "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKsuaOpRKRDCKPhxnU36t85PcvuTWpnTlsjdnvLQyluG root@nixos";


in {

	"passwdPaul.age".publicKeys      = [ calypsokey ];
	"passwdSmurf.age".publicKeys     = [ calypsokey serverkey ];

	# Hosting-related
	"tailscaleKey.age".publicKeys    = [ calypsokey serverkey ];
	"mayGarageConfig.age".publicKeys = [ calypsokey serverkey ];
	"mayGarageTSKey.age".publicKeys  = [ calypsokey serverkey ];
	"actualTSKey.age".publicKeys     = [ calypsokey serverkey ];
	"passwdRestic.age".publicKeys    = [ calypsokey serverkey ];
}
