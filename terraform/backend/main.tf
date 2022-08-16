provider "aws" {
    region = "eu-west-2"
}

resource "aws_s3_bucket" "terraform_state" {
    bucket = "tfstate"
    lifecycle {
        prevent_destroy = true
    }
    tags = {
        system = "Datamart"
        environment = "production"
    }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
    bucket = aws_s3_bucket.terraform_state.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
    name = "tfstate-locks"
    read_capacity = 1
    write_capacity = 1
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "5"
    }
}