so the idea of this excersie to upload tfstate to S3 bucket 


if you destory the bucket after uploading the tfstate to the bucket 
you will see this error 
Failed to save state: failed to upload state: NoSuchBucket: The specified bucket does not exist
        status code: 404, request id: xxxxxxxxxxx

just ignore it :) as it cant find the bucket on aws because you destroy it :D 
