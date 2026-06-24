let
	vmkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP9goVCP7hVvnltNQ6QONPbqzJGGKbiHBmQ5sIfC7FmV sjaak@testding";
	machinekey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDUJLucqAE02IdP5gnwUrC/Fk0lMy1fp7bcKfu9VmSJp root@nixos";



in {

	"passwdPaul.age".publicKeys = [ vmkey machinekey ];
	"passwdSmurf.age".publicKeys = [ vmkey machinekey ];

	"tailscaleKey.age".publicKeys = [ vmkey machinekey ];

	"mayGarageTSKey.age".publicKeys = [ vmkey machinekey ];
	"mayGarageConfig.age".publicKeys = [ vmkey machinekey ];


	"actualBudgetKey.age".publicKeys = [vmkey machinekey];
	"actualTSKey.age".publicKeys = [vmkey machinekey];
}
