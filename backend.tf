terraform {
  required_version = "1.1.4"
  backend "s3" {
    bucket = "terraform-taisei-test-tfstate"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}

































