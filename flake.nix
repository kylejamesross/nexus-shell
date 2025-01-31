{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    astal,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      pname = "nexus";
      src = ./.;
      dontUnpack = true;

      nativeBuildInputs = with pkgs; [
        wrapGAppsHook
        gobject-introspection
      ];

      buildInputs =
        (with astal.packages.${system}; [
          astal3
          io
          apps
          battery
          bluetooth
          hyprland
          mpris
          network
          notifd
          powerprofiles
          tray
          wireplumber
        ])
        ++ (with pkgs; [
          gjs
        ]);

      preFixup = ''
        gappsWrapperArgs+=(
          --prefix PATH : ${with pkgs;
          lib.makeBinPath [
            dart-sass
            fzf
          ]}
        )
      '';

      installPhase = ''
        mkdir -p "$out"/bin
        install "$src" "$out"/bin/nexus
      '';
    };
  };
}
