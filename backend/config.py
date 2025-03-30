from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    MONGO_URI: str
    VIBEPICK:str

    class Config:
        env_file = ".env"

settings = Settings()
