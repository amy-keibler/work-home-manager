{ config, pkgs, ... }:
let
  hbaseHome = "/Users/amy/local/hbase";
in
{
  home.packages = with pkgs; [
    # Databricks
    databricks-cli

    # SVS
    postgresql_14

    # HBase
    # Installed manually due to NixOS HBase only being Linux

    # Datamart
    mysql84

    # Security Tooling
    dotnet-sdk_10
  ];

  programs.zsh = {
    sessionVariables = {
      HBASE_HOME = hbaseHome;
    };

  };

  home.sessionPath = [
    "${hbaseHome}/bin"
  ];

}
