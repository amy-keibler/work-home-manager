{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    colima
    docker-client
    docker-compose
  ];

  programs.zsh.sessionVariables = {
    "DOCKER_HOST" = "unix:///Users/amy/.colima/docker.sock";
    "TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE" = "/var/run/docker.sock";
  };
}
