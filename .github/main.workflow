workflow "Publish" {
  on = "push"
  resolves = ["Deploy to Web App"]
}

action "Deploy to Web App" {
  uses = "Azure/github-actions/webapp@master"
  needs = ["Azure Login"]
  env = {
    AZURE_APP_NAME = "testcookie1"
    AZURE_APP_PACKAGE_LOCATION = "webapp.publish"
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
