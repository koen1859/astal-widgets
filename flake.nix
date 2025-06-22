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
    ];
  in {
    packages.${system}.default = ags.lib.bundle {
      inherit pkgs;
      name = "TopBar";
      src = ./TopBar;
      entry = "app.ts";
      gtk4 = false;

      extraPackages = agsPackages ++ [pkgs.gjs];
    };
  };
}
