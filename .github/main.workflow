workflow "Publish" {
  on = "push"
  resolves = [
    "Deploy to Web App",
    "Shell"
  ]
}

action "Deploy to Web App" {
  uses = "Azure/github-actions/webapp@master"
  needs = ["Azure Login", "DotNet Publish"]
  env = {
    AZURE_APP_NAME = "testcookie1"
    AZURE_APP_PACKAGE_LOCATION = "publish"
  }
}

action "Azure Login" {
  uses = "Azure/github-actions/login@master"
  env = {
    AZURE_SUBSCRIPTION = "Visual Studio Enterprise"
  }
  secrets = [
    "AZURE_SERVICE_PASSWORD",
    "AZURE_SERVICE_APP_ID",
    "AZURE_SERVICE_TENANT",
  ]
}

action "DotNet Publish" {
  uses = "Azure/github-actions/dotnetcore-cli@master"
  args = ["publish", "-c", "Release", "-o", "../publish", "webapp"]
}

action "Shell" {
  uses = "actions/bin/sh@master"
  args = ["echo", "$GITHUB_REPOSITORY"]
}
