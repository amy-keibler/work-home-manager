# Claude Configuration

## Git Behavior Expectations

- Commits should be made off of a feature branch by default. The user will
  explicitly indicate if a commit should be made against main or master. If a
  branch does not yet exist, ask the user for permission to create one before
  asking permission to commit.

## Java Version Selection

Java versions are provided by zsh aliases (e.g. useJdk21, useJdk17). Claude
should always prefer sourcing the `~/.zshrc` file and calling the alias over
searching for available Java versions. If an alias does not exist, prompt the
user to create one before retrying.
