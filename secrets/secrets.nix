let
	vmkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP9goVCP7hVvnltNQ6QONPbqzJGGKbiHBmQ5sIfC7FmV sjaak@testding";
	machinekey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDUJLucqAE02IdP5gnwUrC/Fk0lMy1fp7bcKfu9VmSJp root@nixos";
	tempserverkey= "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAAl5Pkn2c6l3j+LdseYJpQmUFxbVJ9lWx16XvLCPXt8 temp@nixos";



in {

	"passwdPaul.age".publicKeys = [ vmkey machinekey ];
	"passwdSmurf.age".publicKeys = [ vmkey machinekey tempserverkey];

	"tailscaleKey.age".publicKeys = [ vmkey machinekey tempserverkey];

	"mayGarageTSKey.age".publicKeys = [ vmkey machinekey tempserverkey];
	"mayGarageConfig.age".publicKeys = [ vmkey machinekey tempserverkey];


	"actualBudgetKey.age".publicKeys = [vmkey machinekey tempserverkey];
	"actualTSKey.age".publicKeys = [vmkey machinekey tempserverkey];
}
