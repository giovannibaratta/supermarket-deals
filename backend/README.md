# Backend

## Serve

1. (optional) Enable Python virtual environment
1. Install Python requirements
   ```bash
   pip install -r requirements.txt
   ```
1. Set the required environment variables into a `.env` file
1. Serve the application

    ```bash
    dotenv -f .env.dev run fastapi dev src/main.py
    ```

## Update requirements

```bash
pip3 freeze > requirements.txt
```

## Build container

```bash
docker build -t supermarket-deals .
```