workflow "Publish" {
  on = "push"
  resolves = ["Post"]
}

action "Post" {
  uses = "swinton/httpie.action@8ab0a0e926d091e0444fcacd5eb679d2e2d4ab3d"
  args = "[\"POST\", \"httpbin.org/anything\", \"hello=world\"]"
}
