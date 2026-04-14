---
name: fetch-repositories
description: Make sure that all of the Data Identity repositories have been cloned to the data-identity folder
allowed-tools: Bash(gh *)
---

# Fetch Data-Identity Repositories

## Context

- Data Identity Repositories: !`gh search repos --owner=sonatype --topic=data-identity --archived=false --json=fullName,name,url --limit 1000`
- Data Identity Local Folder: `~/code/data-identity/`

## Instructions

For each repository in the list, perform the following task:

1. Check to see if the folder exists in the Data Identity Local Folder by `name`
1. If it does not exist, clone the repository to that folder using `gh repo
   clone <fullName>`
1. List the newly cloned repositories as output for human review
