{ pkgs, ... }:
pkgs.mkShell.override { stdenv = pkgs.clangStdenv; } {
  nativeBuildInputs = with pkgs; [
    cmake
    cmake-language-server
    clang
    clang-tools
    lldb
    ninja
    pkg-config
    vcpkg
  ];

  shellHook = ''
    export VCPKG_FORCE_SYSTEM_BINARIES=1
    export VCPKG_ROOT=${pkgs.vcpkg}/share/vcpkg

    export CC=clang
    export CXX=clang++

    # CPP modules fix copied supplied by Google Gemini
    export CPLUS_INCLUDE_PATH="$(clang++ -E -x c++ - -v < /dev/null 2>&1 | grep '^ /nix/store' | sed 's/^ //' | paste -sd ':' -)"

    echo "Fixed include paths for module scanning:"
    echo "  - $CPLUS_INCLUDE_PATH"
  '';
}
