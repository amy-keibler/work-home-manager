{ config, pkgs, ... }:

{
  imports = [
    ../modules/aws-sso.nix
  ];

  home.packages = with pkgs; [
    kubectl
  ];

  # Work AWS
  programs.aws-sso = {
    enable = true;

    defaultRegion = "us-east-1";

    profiles = {
      # Data Identity
      pipeline-dev = {
        name = "DataTeamAdministratorAccess";
        iamNumber = "732481404831";

      };

      hds-production-datamart-data-dev = {
        name = "DatamartReadOnly-Prod";
        iamNumber = "135388973902";
      };

      hds-staging-datamart-data-dev = {
        name = "DatamartReadOnly-Stage";
        iamNumber = "993883856687";
      };
    };
  };
}

