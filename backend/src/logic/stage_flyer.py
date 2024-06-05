from external.aws_s3_storage import AWSS3Storage
from models.upload_flyer import RawFlyer


class FlyerManager:
    def __init__(self):
        self.__s3_uploader = AWSS3Storage()

    async def stage_flyer(self, flyer : RawFlyer):
        await self.__s3_uploader.upload_file(flyer.file, flyer.filename)