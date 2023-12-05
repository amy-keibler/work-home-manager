{ config, pkgs, ... }:
let
  dockerWrapper = pkgs.writeScriptBin "docker" ''
    #!/bin/sh
    [ -e /etc/containers/nodocker ] || \
    echo "Emulate Docker CLI using podman. Create /etc/containers/nodocker to quiet msg." >&2
    exec podman "$@"
  '';
in
{
  home.packages = [
    dockerWrapper
  ];
}
