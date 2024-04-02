{ config, pkgs, ... }:

{
  imports = [
    ../modules/aws-vault.nix
  ];

  home.packages = with pkgs; [
    awscli2
    kubectl
    ssm-session-manager-plugin
  ];

  # Work AWS
  programs.aws-vault = {
    enable = true;

    userName = "amelia.keibler";
    userIamNumber = "451349303221";

    defaultRegion = "us-east-1";

    profiles = {
      default = {
        region = "us-west-2";
      };

      sonatype-ops = {
        sourceProfile = "default";
      };

      sonatype = {
        sourceProfile = "default";
      };

      dev = {
        role = {
          name = "admin";
          iamNumber = "233747045000";
        };
        sourceProfile = "sonatype";
      };

      prod-admins = {
        role = {
          name = "admin";
          iamNumber = "488733969274";
        };
        sourceProfile = "sonatype-ops";
      };

      # Main Central AWS Account
      sonatype-central = {
        role = {
          name = "admin";
          iamNumber = "455059387302";
        };
        region = "us-west-2";
        sourceProfile = "sonatype-ops";
      };

      central-dev = {
        role = {
          name = "admin";
          iamNumber = "436630530419";
        };
        sourceProfile = "sonatype-ops";
      };

      cloudy = {
        role = {
          name = "cloudy-mccloudface-stable-central";
          iamNumber = "119982741445";
        };
        region = "us-east-2";
        sourceProfile = "sonatype";
      };

      stargate = {
        role = {
          name = "admin";
          iamNumber = "341287603216";
        };
        region = "us-east-2";
        sourceProfile = "sonatype";
      };

      betacloud = {
        role = {
          name = "cloudy-mccloudface-beta-central";
          iamNumber = "119982741445";
        };
        region = "us-west-2";
        sourceProfile = "sonatype-ops";
      };
    };
  };
}

