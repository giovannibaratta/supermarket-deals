from fastapi import FastAPI, UploadFile, File

from models.upload_flyer import RawFlyer

app = FastAPI()

fifteen_mb_bytes = 1 * 1024 * 1024

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.post("/upload-flyer")
async def upload_pdf(file: UploadFile = File(..., client_max_size=fifteen_mb_bytes)):
    pdf_data = RawFlyer(file=file.file.read(), filename=file.filename)

    print(pdf_data.file.__sizeof__())
    # Process the uploaded PDF file (e.g., save it to disk, extract text)

    return {"message": "PDF file uploaded successfully"}