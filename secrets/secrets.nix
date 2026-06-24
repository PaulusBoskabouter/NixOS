let
	vmkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP9goVCP7hVvnltNQ6QONPbqzJGGKbiHBmQ5sIfC7FmV sjaak@testding";
	machinekey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDUJLucqAE02IdP5gnwUrC/Fk0lMy1fp7bcKfu9VmSJp root@nixos";
	serverkey= "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKsuaOpRKRDCKPhxnU36t85PcvuTWpnTlsjdnvLQyluG root@nixos";


in {

	"passwdPaul.age".publicKeys = [ vmkey machinekey ];
	"passwdSmurf.age".publicKeys = [ vmkey machinekey serverkey];

	"tailscaleKey.age".publicKeys = [ vmkey machinekey serverkey];

	"mayGarageTSKey.age".publicKeys = [ vmkey machinekey serverkey];
	"mayGarageConfig.age".publicKeys = [ vmkey machinekey serverkey];


	"actualTSKey.age".publicKeys = [vmkey machinekey serverkey];
}
