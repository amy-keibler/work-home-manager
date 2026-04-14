{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Databricks
    databricks-cli

    # SVS
    postgresql_14

    # Security Tooling
    dotnet-sdk_10
  ];
}
