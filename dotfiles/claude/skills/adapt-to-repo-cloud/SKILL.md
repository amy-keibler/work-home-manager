---
name: adapt-to-repo-cloud
description: For a given repository, make the changes necessary to adapt the repository to Repo Cloud
---

# Adapt to Repo Cloud

## Instructions

In order to adapt a repository to Sonatype's internal Repo Cloud instance, we
need to perform a series of modifications to various parts of the codebase.

### Upgrade the parent

For projects making use of the now deprecated `com.sonatype.data.commons:parent`
project, we need to switch the project to use the most recent version of
`com.sonatype.data.identity:parent`. This is an internal library and must be
retrieved from Sonatype's internal Nexus repository. If we are already using the
correct parent, ensure that we are using the latest available released (e.g. non
`-SNAPSHOT`) version.

### Clean up plugins

Remove any plugins that were related to the previous build process. This list
includes the following:

- nexus-maven-staging-plugin
- maven-release-plugin

Additionally, we should let the following configured versions be inherited from
the parent POM (or grandparent POM):

- clm-maven-plugin
- license-maven-plugin

Review other plugins and present any that appear to be unused to the user for
consideration.

### Upgrade testcontainers

We need to be on a more modern version of testcontainers, both for security and
for compatibility with local Docker environments. If the project is using
testcontainers, know that some of the artifacts have been renamed:

- `localstack` became `testcontainers-localstack`
- `junit-jupiter` became `testcontainers-junit-jupiter`

### Switch Docker images

As a part of the migration, any image that came from
`docker-all.repo.sonatype.com/` should now be retrieved from the internal
repository of `sonatype.repo.sonatype.app/docker-all/`.

Also, any images retrieved directly from DockerHub should be adjusted to pull
from the internal repository.

### Switch over Jenkins jobs

There are roughly two types of repositories that the Data Identity Team is
responsible for. The first is Maven projects that do not contain any services
themselves, and are published to the internal Sonatype Nexus instance to be
consumed by other Maven projects. The second is Maven projects that build Docker
images, push to AWS's ECR service, and deploy as ECS services.

*Important: if a repository cannot be categorized into one of these categories,
stop and ask for user input on how to proceed*

#### Common Jenkins job settings

We expect to leave the existing Jenkins files as-is and clean them up in a
follow-up PR once the new Jenkins jobs have been set up manually and tested.

We expect `runFeatureBranchPolicyEvaluations: true` configurations on the
pipelines in order to ensure that Lifecycle runs on PR branches.

We expect something like

```
  // IQ Policy Evaluation
  iqPolicyEvaluation: { stage ->
    nexusPolicyEvaluation(
      iqStage: stage,
      iqApplication: '<application name from the existing Jenkins job>',
      iqScanPatterns: [[scanPattern: 'scan_nothing']],
      failBuildOnNetworkError: false
    )
  }
```

to be added to make sure that Lifecycle is configured to defer scanning to the
`clm-maven-plugin`.

*Important: many of the Maven projects don't follow semver, which breaks the
versioning convention expected by the standard jobs*

If that is the case, do something like

```
  // Override default version calculation to handle simple integer versions
  getReleaseVersion: { env, currentBuild ->
    def currentVersion = getMavenProjectVersion('.')
    return currentVersion.replace('-SNAPSHOT', '')
  },

  getNextSnapshotVersion: { env, currentBuild, version ->
    // Handle semantic versioning (e.g., "1.34" -> "1.35-SNAPSHOT")
    def matcher = version =~ /^(?<major>\d+)\.(?<minor>\d+)$/
    if (matcher.matches()) {
      def major = matcher.group('major')
      def minor = (matcher.group('minor') as Integer) + 1
      return "${major}.${minor}-SNAPSHOT"
    } else {
      // Fallback to simple integer versioning
      def nextVersion = (version as Integer) + 1
      return "${nextVersion}-SNAPSHOT"
    }
  },
```

in the `Jenkinsfile.release` job in order to ensure the correct version update
occurs.

If the repository contains a `staleProdChecker` job, we want to keep that, but
adapt it for the two new jobs by changing the `stagingBuild` and
`productionBuild` variables (which may require prompting the user for input), as
these might not be standard paths in Jenkins.

#### Switching Jenkins jobs for Maven libraries

We want to adapt these projects to the standard Sonatype Build And Release
Jenkins pipelines. We expect the following:

- A single `Jenkinsfile` that runs the `mavenSnapshotPipeline` on pull requests
  and main branch (where it will push a new version of the current `-SNAPSHOT`
  version).
- A single `Jenkinsfile.release` that runs the `mavenReleasePipeline` when
  manually triggered in Jenkins.

#### Switching Jenkins jobs for ECR/ECS services

Follow the Data Identity ECR/ECS Jenkins library documentation (referenced
below). We expect the following:

- A single `Jenkinsfile` that runs the `mavenSnapshotPipeline`, with the
  addition of the `snapshotBuildAndTest:
  StandardPipelineHelpers.snapshotBuildWithDockerBuildOnly(this,
  deploymentConfig),` and the `onSuccess:
  StandardPipelineHelpers.onSuccessStagingDeployment(this, deploymentConfig)`
  configurations
- A single `Jenkinsfile.release` that runs the `mavenReleasePipeline`, with the
  addition of `onSuccess:
  StandardPipelineHelpers.onSuccessProductionPromotion(...)` that creates
  configurations for every service in the repository
- An equivalent `Dockerfile` for every service that is currently configured to
  build the Docker image via Maven
   - All referenced docker images should pull from Sonatype's internal Nexus
     Docker proxy (e.g.
     `sonatype.repo.sonatype.app/docker-all/eclipse-temurin:21-jdk`)
   - JAR files copyied from `target` directories should use the `VERSION` build
     argument to find only the JAR needed for the image to avoid pulling in
     `-sources`, `-javadoc`, and other JARs
   - All `Dockerfile` files should be able to be built locally by `cd <service
     folder> && docker build .` (so file references should be relevant to that
     image, not the root of the project)
   - `ENTRYPOINT` should be preferred over `CMD`
   - The existing Maven configuration should be left untouched and cleaned up in
     a follow-up PR
   - Because IAC defines services using Prisma Cloud Defender, docker images are
     expected to have a `/data-identity/entrypoint.sh` file as the entrypoint
   - The existing Maven Docker build infrastructure should be left as-is and
     cleaned up in a follow-up PR. However, we should configure it to be skipped
     during builds so that it does not run in CI.

We should consider adding to the `nexusPolicyEvaluation` section

```
      reachability: [
        javaAnalysis: [
          enable: true,
          entrypointStrategy: 'JAVA_MAIN'
        ]
      ]
```

in order to make sure that the reachability checks in CI behave as expected.

### Ensure tests pass locally

Run `mvn clean install` and identify issues that need to be addressed before a
PR can be opened. Perform an initial investigation for each issue and present
them to the user to be addressed interactively.

Also, run `mvn checkstyle:check` to make sure that checkstyle will pass CI.

Lastly, run `mvn license:check -Dlicense.failIfMissing=false -e -C -N -`.
Notably, the CI will faill the checks for `[WARNING] Missing header` lines, even
if the command itself exits with a status `0`.

Note: This may require setting a Java version different from the default
version. For the required Java version, expect a ZSH alias of the form
`useJdk<version number>` to be available to set the `JAVA_HOME` environment
correctly.

## References

- Parent POM repository: `~/code/data-identity/data-identity-parent/`
- Sonatype Grandparent POM: `~/code/sonatype/buildsupport/`
- Sonatype Standard Build and Release Jenkins Pipeline:
  `~/code/sonatype/jenkins-shared/`
- Data Identity ECR/ECS Jenkins pipeline / library repository:
  `~/code/data-identity/pipeline-jenkins-common/`
   - Documentation lives in `docs/standard-ecs-pipelines.md`
- Data Identity IAC repository: `~/code/data-identity/data-identity-aws-config/`
- Skill to fetch available versions of internal libraries:
  `private-maven-dependency-versions`
