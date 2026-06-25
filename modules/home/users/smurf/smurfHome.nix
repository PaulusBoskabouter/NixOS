{ self, inputs, ... }: {
        flake.homeModules.smurfHome = { ... }: {
                imports = [ 
                self.homeModules.zshSetup
                #...
                ];
        };
}

