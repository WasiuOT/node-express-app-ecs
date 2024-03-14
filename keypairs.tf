resource "aws_key_pair" "nodeapp-key" {
  key_name   = "nodeapp-key"
  public_key = file(var.PUB_KEY_PATH)
}