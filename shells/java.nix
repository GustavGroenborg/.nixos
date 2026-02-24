{ pkgs, jdk ? pkgs.jdk_headless }:

let
  maven = pkgs.maven.override { inherit jdk; };
in
pkgs.mkShellNoCC {
  packages = [
    jdk
    maven
    pkgs.jdt-language-server
    pkgs.quarkus
  ];

  shellHook = ''
    export JAVA_HOME=${jdk.home}
  '';
}
