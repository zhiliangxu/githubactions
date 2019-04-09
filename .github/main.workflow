workflow "Publish" {
  on = "push"
  resolves = ["Post"]
}

action "Post" {
  uses = "swinton/httpie.action@master"
  args = ["POST", "httpbin.org/anything", "hello=world"]
}
