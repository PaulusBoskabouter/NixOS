{ self, inputs, ... }: {
  flake.nixosModules.f5cli = { config, pkgs, ... }:
    let
      f5cli = pkgs.stdenv.mkDerivation {
        pname = "f5cli";
        version = "7182.2019.0923";
        src = ../../pkgs/f5cli;   # adjust relative path to match your repo layout
        dontBuild = true;
        installPhase = ''
          mkdir -p $out/local
          cp -r usr/local/* $out/local/
        '';
      };
    in {
      systemd.tmpfiles.rules = [
        "C /usr/local/lib/F5Networks - - - - ${f5cli}/local/lib/F5Networks"
        "L+ /usr/local/bin/f5fpc - - - - /usr/local/lib/F5Networks/f5fpc_x86_64"
        "z /usr/local/lib/F5Networks/SSLVPN/svpn_x86_64 4711 root root"
      ];
    };
}
