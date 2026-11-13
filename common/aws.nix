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
        name = "HDS-rds-data-dev";
        iamNumber = "135388973902";
      };

      hds-staging-datamart-data-dev = {
        name = "HDS-rds-data-dev";
        iamNumber = "993883856687";
      };

      hds-production-admin = {
        name = "DataTeamAdministratorAccess";
        iamNumber = "135388973902";
      };

      hds-staging-admin = {
        name = "DataTeamAdministratorAccess";
        iamNumber = "993883856687";
      };
    };
  };
}

