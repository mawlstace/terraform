terraform {
  backend "s3"{
      bucket = "mawlstace" 
      key= "terraform/tfstate.tfstate" 
      region = "eu-west-2"
   }
 }

 ## first you need to comemnt this file before running the terraform apply ## 
 ## why ? because the bucket has to be created before uploading ## 
 