{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-code

    # required for Sonatype GenAI Tooling
    appfire-cli
    beads
    tmux
  ];

  programs.zsh = {
    sessionVariables = {
      CLAUDE_CODE_ENABLE_TELEMETRY = "1";
      ANTHROPIC_BASE_URL = "https://llm-dev.sonatype.com";
      ANTHROPIC_MODEL = "anthropic-claude-4-sonnet";
      ANTHROPIC_DEFAULT_HAIKU_MODEL = "claude-haiku-4-5";
      # ANTHROPIC_DEFAULT_SONNET_MODEL = "anthropic-claude-4-sonnet";
      ANTHROPIC_DEFAULT_SONNET_MODEL="qwen3-coder-next";
      ANTHROPIC_DEFAULT_OPUS_MODEL = "claude-opus-4-5";
      CLAUDE_CODE_SUBAGENT_MODEL = "anthropic-claude-4-sonnet";
      CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS = "1";
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
