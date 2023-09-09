{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.aws-vault;

  mkRoleArn = { name, iamNumber }: "arn:aws:iam::${iamNumber}:role/${name}";

  mkProfile = { mfaSerial, defaultRegion, ... }@profileArgs:
    (optionalAttrs (hasAttr "role" profileArgs) { role_arn = mkRoleArn profileArgs.role; }) //
    (optionalAttrs (hasAttr "sourceProfile" profileArgs) { source_profile = profileArgs.sourceProfile; }) //
    {
      region = if (hasAttr "region" profileArgs) then profileArgs.region else defaultRegion;
      output = "json";
      mfa_serial = mfaSerial;
    };

  mkConfig = { userName, userIamNumber, defaultRegion, profiles, ... }: let
    mfaSerial = "arn:aws:iam::${userIamNumber}:mfa/${userName}";
  in
    mapAttrs' (profileName: profile: nameValuePair "profile ${profileName}" (mkProfile ({ inherit mfaSerial defaultRegion; } // profile))) profiles;

in
{
  options.programs.aws-vault = {
    enable = mkEnableOption (mdDoc "Amazon AWS Vault Manager");

    userName = mkOption {
      type = types.string;
      description = ''
        AWS Username
      '';
    };

    userIamNumber = mkOption {
      type = types.string;
      description = ''
        AWS IAM ID Number
      '';
    };

    defaultRegion = mkOption {
      type = types.string;
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
    home.packages = [ pkgs.aws-vault ];

    home.file.".aws/config" = {
      text = generators.toINI { } (mkConfig cfg);
    };
  };
}
