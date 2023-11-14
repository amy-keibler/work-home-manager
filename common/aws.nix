{ config, pkgs, ... }:

{
  imports = [
    ../modules/aws-vault.nix
  ];

  home.packages = with pkgs; [
    awscli2
    kubectl
  ];

  # Work AWS
  programs.aws-vault = {
    enable = true;

    userName = "amelia.keibler";
    userIamNumber = "451349303221";

    defaultRegion = "us-east-1";

    profiles = {
      sonatype-ops = { };

      sonatype = { };

      ops = { };

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

      default = {
        region = "us-west-2";
      };
    };
  };
}

