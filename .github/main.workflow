workflow "Publish" {
  on = "push"
  resolves = ["new-action"]
}

action "Deploy to Web App" {
  uses = "Azure/github-actions/webapp@master"
  needs = ["Azure Login"]
  env = {
    AZURE_APP_NAME = "githubaction"
    AZURE_APP_PACKAGE_LOCATION = "webapp.publish/"
  }
}
