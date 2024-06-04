import boto3
import os
from botocore.exceptions import ClientError


class AWSS3Storage:
    def __init__(self):
        self.bucket_name = os.environ.get("AWS_S3_BUCKET_NAME")
        self.region_name = os.environ.get("AWS_S3_REGION_NAME")
        self.s3_client = boto3.client('s3', region_name=self.region_name)

    def upload_file(self, file_object, object_name):
        try:
            self.s3_client.upload_fileobj(file_object, self.bucket_name, object_name)
            print(f"File uploaded to S3: {object_name}")
        except ClientError as e:
            print(f"Error uploading file: {e}")
