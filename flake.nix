{
  description = "A flake for building fn06's website";

  outputs = { self, nixpkgs, flake-utils, ... }:
    (flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in {
          packages.default = pkgs.stdenv.mkDerivation {
            name = "fn06-website";

            src = self;

            buildInputs = [ pkgs.pandoc ];

            installPhase = ''
              mkdir -p $out
              ${pkgs.rsync}/bin/rsync -a --exclude '*.md' --exclude 'result' --exclude '.*' static/* $out
            '';
          };

          defaultPackage = self.packages.${system}.default;
          
          devShells.default = pkgs.mkShell {
            buildInputs = [ pkgs.pandoc ];
          };
        }
      )
    ) // {
      nixosModules.default = {
        imports = [ ./module.nix ];
      };

      nixosConfigurations."container" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            boot.isContainer = true;
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
            networking.useDHCP = false;
            networking.firewall.allowedTCPPorts = [ 80 ];
            services.nginx = {
              enable = true;
              virtualHosts."_" = {
                root = "${self.packages."x86_64-linux".default}";
                extraConfig = ''
                  error_page 403 =404 /404.html;
                  error_page 404 /404.html;
                '';
              };
            };
            system.stateVersion = "22.11";
          }
        ];
      };
    };
}
