{ pkgs, ... }:
pkgs.mkShell.override { stdenv = pkgs.clangStdenv; } {
  nativeBuildInputs = with pkgs; [
    cmake-language-server
    clang-tools
    lldb
  ];

  shellHook = ''
    echo "Loaded tools for CC"
    export VCPKG_FORCE_SYSTEM_BINARIES=1
    export VCPKG_ROOT=${pkgs.vcpkg}/share/vcpkg
  '';
}
