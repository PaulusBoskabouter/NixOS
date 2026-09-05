let
	calypsokey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINfPMglUFTF9V71YpoobEqPxxLrnTDAAref9Avjz0FkR root@nixos";
	serverkey= "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKsuaOpRKRDCKPhxnU36t85PcvuTWpnTlsjdnvLQyluG root@nixos";
	userkey= "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPXe1jU+e3JywNfLujZ6wulSxDLETotJ3F8Izu3jBmJX paul@calypso";
	minikey= "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO1rn6HySohKJS65a5vF4f7iOU+/sdUC3T7EWMNFliYx paul@nixos";

in {

	"passwdPaul.age".publicKeys      = [ calypsokey userkey ];
	"passwdMini.age".publicKeys      = [ calypsokey userkey minikey];
	"passwdSmurf.age".publicKeys     = [ calypsokey serverkey userkey];

	# Hosting-related
	"tailscaleKey.age".publicKeys    = [ calypsokey serverkey userkey minikey];
	"mayGarageConfig.age".publicKeys = [ calypsokey serverkey userkey];
	"mayGarageTSKey.age".publicKeys  = [ calypsokey serverkey userkey];
	"actualTSKey.age".publicKeys     = [ calypsokey serverkey userkey];
	"passwdRestic.age".publicKeys    = [ calypsokey serverkey userkey];
}
