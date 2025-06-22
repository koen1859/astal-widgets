{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ags,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    agsPackages = with ags.packages.${system}; [
      gjs
      io
      astal3
      astal4
      battery
      hyprland
      wireplumber
      network
      mpris
      powerprofiles
      tray
      bluetooth
    ];
  in {
    packages.${system}.default = ags.lib.bundle {
      inherit pkgs;
      name = "simple-bar";
      src = ./TopBar;
      entry = "app.ts";
      gtk4 = false;

      extraPackages = agsPackages ++ [pkgs.gjs];
    };

    # Apps for easy running
    apps.${system} = {
      default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/simple-bar";
      };
    };

    # Overlay for using in NixOS configurations
    overlays.default = final: prev: {
      simple-bar = self.packages.${system}.default;
    };

    devShells.${system}.default = pkgs.mkShell {
      packages = agsPackages ++ [pkgs.gjs];
    };
  };
}
