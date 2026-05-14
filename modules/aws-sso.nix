{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.aws-sso;

  mkProfile = { name, iamNumber, defaultRegion, ... }@profileArgs:
    {
      sso_session = "sonatype";
      sso_account_id = iamNumber;
      sso_role_name = name;
      region = if (hasAttr "region" profileArgs) then profileArgs.region else defaultRegion;
    };

  mkConfig = { defaultRegion, profiles, ... }:
    let
      commonConfig = {
        default = { "output" = "json"; };
        "sso-session sonatype" = {
          "sso_start_url" = "https://sonatype-aws.awsapps.com/start";
          "sso_region" = "us-east-1";
          "sso_registration_scopes" = "sso:account:access";
        };
      };

    in
    commonConfig //
    mapAttrs' (profileName: profile: nameValuePair "profile ${profileName}" (mkProfile ({ inherit defaultRegion; } // profile))) profiles;

  mkProfileLoginShellAliases = { profiles, ... }:
    let
      mkAliasName = profileName: "aws-login-${profileName}";
      mkLoginCommand = profileName: ''aws sso login --profile "${profileName}" && export AWS_PROFILE="${profileName}"'';
    in
    mapAttrs' (profileName: _: nameValuePair (mkAliasName profileName) (mkLoginCommand profileName)) profiles;
in
{
  options.programs.aws-sso = {
    enable = mkEnableOption (mdDoc "Amazon AWS SSO Profile Configuration");

    defaultRegion = mkOption {
      type = types.str;
      description = ''
        Default AWS region to use if none is specified
      '';
    };

    profiles = mkOption {
      type = types.attrs;
      default = { };
      description = ''
        The AWS Profiles to be created
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      awscli2
      ssm-session-manager-plugin
    ];

    home.file.".aws/config" = {
      text = generators.toINI { } (mkConfig cfg);
    };

    programs.zsh.shellAliases = mkProfileLoginShellAliases cfg;
  };
}
