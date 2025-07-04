{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    ags,
    ...
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
      apps
    ];
  in {
    packages.${system} = {
      TopBar = ags.lib.bundle {
        inherit pkgs;
        name = "TopBar";
        src = ./TopBar;
        entry = "TopBar.ts";
        gtk4 = false;

        extraPackages = agsPackages ++ [pkgs.gjs];
      };
      AppLauncher = ags.lib.bundle {
        inherit pkgs;
        name = "AppLauncher";
        src = ./AppLauncher;
        entry = "AppLauncher.ts";
        gtk4 = false;

        extraPackages = agsPackages ++ [pkgs.gjs];
      };
    };
    devShells.${system}.default = pkgs.mkShell {
      packages = agsPackages ++ [pkgs.ags];
    };
  };
}
