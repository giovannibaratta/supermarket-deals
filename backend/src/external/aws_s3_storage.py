import aioboto3
import os
import io


class AWSS3Storage:
    def __init__(self):
        self.__bucket_name = os.environ.get("AWS_S3_BUCKET_NAME")
        self.__region_name = os.environ.get("AWS_S3_REGION_NAME")
        self.__session = aioboto3.Session()

    async def upload_file(self, file_object, object_name : str):
        async with self.__session.client("s3") as s3:
            try:
                await s3.upload_fileobj(io.BytesIO(file_object), self.__bucket_name, object_name)
                print(f"File uploaded to S3: {object_name}")
            except Exception as e:
                print(f"Error uploading file: {e}")
