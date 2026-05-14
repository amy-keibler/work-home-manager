{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-code

    # required for Sonatype GenAI Tooling
    acli
    beads
    tmux
  ];

  programs.zsh = {
    sessionVariables = {
      CLAUDE_CODE_ENABLE_TELEMETRY = "1";
      ANTHROPIC_BASE_URL = "https://llm-dev.sonatype.com";

      # Models
      ANTHROPIC_MODEL = "glm-5";
      ANTHROPIC_DEFAULT_HAIKU_MODEL = "kimi-k2-5";
      ANTHROPIC_DEFAULT_SONNET_MODEL = "claude-sonnet-4-6";
      ANTHROPIC_DEFAULT_OPUS_MODEL = "claude-opus-4-7";
      CLAUDE_CODE_SUBAGENT_MODEL = "glm-5";

      # Experiment flags
      CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS = "1";
      CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS = "1";
    };

    envExtra = ''
      # Attempt to read the key from a known file
      if [ -f ~/.config/llm/env_vars.sh ]
      then
        set -o allexport; source ~/.config/llm/env_vars.sh; set +o allexport
      else
        echo 'Could not find expected environment variables'
      fi
    '';
  };

  home.file = {
    ".claude/skills/" = {
      source = ../dotfiles/claude/skills;
      recursive = true;
    };
  };
}
