provider "aws" {
  region = "eu-north-1"

  default_tags {
    tags = {
      Environment = "Production"
      Owner       = "Ops"
      App         = "MyApp"
    }
  }
}
