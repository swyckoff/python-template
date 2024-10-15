from typing import Optional

from dotenv import load_dotenv
from pydantic import Field, ValidationError
from pydantic_settings import BaseSettings, SettingsConfigDict

load_dotenv()


class Settings(BaseSettings):
    host: str
    port: int
    debug: Optional[bool]

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"


def make_rich():
    from rich import traceback

    traceback.install()


try:
    settings = Settings()  # type: ignore
except ValidationError as e:
    make_rich()
    from rich.console import Console

    console = Console()

    console.print(f"[bold red]🛑 Environment variable error:[/bold red]\n{e}")
    exit(1)

if settings.debug:
    make_rich()
