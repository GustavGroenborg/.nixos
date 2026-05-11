{ pkgs, baseShell }:

pkgs.mkShell {
  inputsFrom = [ baseShell ];

  nativeBuildInputs = with pkgs; [
    wayland-scanner
  ];

  buildInputs = with pkgs; [
    # X11
    xorg.libX11
    xorg.libXext
    xorg.libXft
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    xorg.libXScrnSaver
    
    # Wayland & Input
    wayland
    wayland-protocols
    libxkbcommon
  ];

  shellHook = ''
    echo "Loaded SDL3 environment (X11 + Wayland)"
  '';
}
