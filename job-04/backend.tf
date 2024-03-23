

resource "aws_s3_bucket" "my-bucket" {

    bucket =  "my-save-state-bucket"
 
    tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }

}

resource "aws_kms_key" "my_key" {
  description = "This key is used to encrypt objects"
  deletion_window_in_days = 10  //var.day_delation
}

resource "aws_s3_bucket_server_side_encryption_configuration" "my_server_side_config" {
  bucket = aws_s3_bucket.my-bucket.id

  rule {
        apply_server_side_encryption_by_default {
            kms_master_key_id = aws_kms_key.my_key.arn
            sse_algorithm     = "aws:kms"
        }
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}



# resource "aws_dynamodb_table" "my_state_lock" {

#   name = "state-lock"
#   hash_key         = "LockID"
#   billing_mode     = "PAY_PER_REQUEST"
# #   stream_enabled   = true
# #   stream_view_type = "NEW_AND_OLD_IMAGES"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

# #   replica {
# #     region_name = "us-east-2"
# #   }

# #   replica {
# #     region_name = "us-west-2"
# #   }
# }