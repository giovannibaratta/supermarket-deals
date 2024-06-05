from fastapi import FastAPI, UploadFile, File

from logic.stage_flyer import FlyerManager
from models.upload_flyer import RawFlyer

app = FastAPI()
flyerManager = FlyerManager()

fifteen_mb_bytes = 1 * 1024 * 1024


@app.post("/upload-flyer")
async def upload_pdf(file: UploadFile = File(..., client_max_size=fifteen_mb_bytes)):
    pdf_data = RawFlyer(file=file.file.read(), filename=file.filename)
    await flyerManager.stage_flyer(pdf_data)

    return {"message": "PDF file uploaded successfully"}
