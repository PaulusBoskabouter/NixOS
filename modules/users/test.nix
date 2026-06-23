{ self, ... }:

{
  flake.nixosModules.testuser = {

    users.users.testuser = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };

    home-manager.users.sjaak.imports = [
      self.homeModules.git
      #self.homeModules.neovim
      #self.homeModules.shell
    ];

  };
}
