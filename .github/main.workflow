workflow "Publish" {
  on = "push"
  resolves = [
    "Deploy to Web App",
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

action "Read GITHUB_REPOSITORY" {
  uses = "actions/bin/sh@master"
  runs = "TEST_VALUE=$GITHUB_REPOSITORY"
}

action "Read TEST_VALUE" {
  uses = "actions/bin/sh@master"
  needs = ["Read GITHUB_REPOSITORY"]
  runs = "echo $TEST_VALUE"
}
