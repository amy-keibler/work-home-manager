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

      cloudy = {
        role = {
          name = "cloudy-mccloudface-stable-central";
          iamNumber = "119982741445";
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

      prod-admins = {
        role = {
          name = "admin";
          iamNumber = "488733969274";
        };
        sourceProfile = "sonatype-ops";
      };

      # Data Identity
      pipeline-dev = {
        sourceProfile = "default";
        role = {
          name = "pipeline-dev";
          iamNumber = "732481404831";
        };
      };

      hds-production-datamart-data-dev = {
        sourceProfile = "default";
        role = {
          name = "DatamartIamAuth-data-dev";
          iamNumber = "135388973902";
        };
      };

      hds-staging-datamart-data-dev = {
        sourceProfile = "default";
        role = {
          name = "DatamartIamAuth-data-dev";
          iamNumber = "993883856687";
        };
      };

      # Main Central AWS Account
      sonatype-central = {
        role = {
          name = "admin";
          iamNumber = "455059387302";
        };
        region = "us-west-2";
        sourceProfile = "sonatype-ops";
        credentialProcess = "aws-vault exec --duration 12h --json sonatype-central";
      };

      sdk-sonatype-central = {
        region = "us-west-2";
        sourceProfile = "sonatype-central";
        credentialProcess = "aws-vault exec --duration 12h --json sonatype-central";
      };

      central-dev = {
        role = {
          name = "admin";
          iamNumber = "436630530419";
        };
        sourceProfile = "sonatype-ops";
      };

      stargate = {
        role = {
          name = "admin";
          iamNumber = "341287603216";
        };
        region = "us-east-2";
        sourceProfile = "sonatype";
      };
    };
  };
}

