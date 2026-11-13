# Claude Configuration

## Git / GitHub Behavior Expectations

- Commits should be made off of a feature branch by default. The user will
  explicitly indicate if a commit should be made against main or master. If a
  branch does not yet exist, ask the user for permission to create one before
  asking permission to commit.
- When asked for stacked PRs, create a native GitHub Stack with the official
  `gh stack` extension (`gh extension install github/gh-stack`), e.g.
  `gh stack init <branches...>` then `gh stack submit`, or `gh stack link` for
  existing PRs. PRs chained only by base branch don't count as a stack.

## Writing Expectations

- When writing a comment that will be posted under my account (e.g. a GitHub
  comment that will be associated with my GitHub account), indicate clearly when
  work was done by Claude and not the human. Avoid using "I" statements and
  prefer the third-person (e.g. "Claude analyzed the logs and identified ...").

## Shared Pages

Sonatype uses LiteLLM for Claude, which does not support publishing shared pages
using the Artifact capability. Please always create artifacts locally and
provide the file path in the console for convenience.

## Responses

When sending a response to the user that includes a JIRA ticket ID or a GitHub
PR number, please make sure that at least the first reference is a clickable
link. This will make it easier for me to open the link in the browser.
