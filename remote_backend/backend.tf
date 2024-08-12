terraform {
   backend "s3"{
    bucket = "value"
    region = "value"
    key    = "CutomerServices/terraform.tfstate"
    dynamodb_table = "terraform_lock"
   }  
}