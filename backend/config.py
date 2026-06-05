import os

from dotenv import load_dotenv

load_dotenv()


class Config:
    DATABASE_URL = os.environ.get("DATABASE_URL")
    DB_HOST = os.environ.get("DB_HOST", "localhost")
    DB_PORT = int(os.environ.get("DB_PORT", "5432"))
    DB_NAME = os.environ.get("DB_NAME", "vertexbit")
    DB_USER = os.environ.get("DB_USER", "postgres")
    DB_PASSWORD = os.environ.get("DB_PASSWORD", "")
    CORS_ORIGINS = [
        origin.strip()
        for origin in os.environ.get(
            "CORS_ORIGINS",
            "http://localhost:3000,http://localhost:5000,http://localhost:8080",
        ).split(",")
        if origin.strip()
    ]
    FLASK_DEBUG = os.environ.get("FLASK_DEBUG", "false").lower() == "true"
    MAX_CONTENT_LENGTH = int(os.environ.get("MAX_CONTENT_LENGTH", "1048576"))
