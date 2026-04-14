---
name: private-maven-dependency-versions
description: Retrieve version information from Sonatype's internal Nexus repository for the purpose of finding potential upgrades. 
---

# Private Maven Dependency Versions

## Instructions

When retrieving version information for private, proprietary Maven dependencies,
do not attempt to reach out to external, open-source sources for version
information. Instead, do the following:

1. Read the user's `~/.m2/settings.xml` file to get the following information
   - Internal Repository Maven URL from the `<url>` element on the `<mirror>`
     element
   - Credentials from the `<username>` and `password` elements on the `<server>`
     element that corresponds to the `<id>` of the above `<mirror>`
2. **Store credentials securely**:
   - Use environment variables to avoid exposing credentials in command output
   - OR use curl's `.netrc` file support
   - NEVER use verbose curl flags (-v, -i) when credentials are in use
3. Using the URL from the above step and the `groupId` and `artifactId`, create
   a URL that points to the artifact-level Maven metadata within the repository
4. Make a HTTP request to the URL with the credentials encoded as basic auth and
   parse the response as artifact level Maven Metadata
   - You will likely need to follow HTTP redirects
5. Use the list of versions in the `<versions>` element to determine what
   versions are available
   - The versions should be in order, but make sure that recommendations
     consider major, minor, and patch versioning information when that is
     available

## Security Notes

- Credentials should only be read once and stored in memory/environment
- Never echo or display credential values
- Avoid verbose curl output that shows Authorization headers
- If debugging is needed, redact sensitive values before display

## References

- <https://maven.apache.org/repositories/metadata.html#the-a-level-metadata>
