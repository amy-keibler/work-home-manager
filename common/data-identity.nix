{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Databricks
    databricks-cli
  ];
}
