import logging

from pathlib import Path
import datetime as dt
from logging import FileHandler, StreamHandler
from colorama import init, Fore, Style

# Initialize Colorama
init()

from pythonjsonlogger import jsonlogger

DEFAULT_FORMAT = "[%(asctime)s] %(levelname)s -- %(message)s"
DEFAULT_JSON_FORMAT = "%(asctime)s %(levelname)s %(name)s %(pathname)s %(process)s %(funcName)s %(lineno)d %(message)s"
LOGGING_DIR = (
    "logs"  # Hardcoded to avoid importing the config for circular dependencies
)


class ColorFormatter(logging.Formatter):
    def format(self, record):
        level_name = record.levelname.lower()
        color_code = {
            "debug": Fore.WHITE,
            "info": Fore.BLUE,
            "warning": Fore.YELLOW,
            "error": Fore.RED,
            "critical": Fore.MAGENTA,
        }.get(level_name, "")
        formatted_record = super().format(record)
        formatted_record = formatted_record.replace(
            record.levelname, f"{color_code}{record.levelname}{Style.RESET_ALL}"
        )

        if hasattr(record, "asctime"):
            formatted_record = formatted_record.replace(
                record.asctime, f"{Fore.MAGENTA}{record.asctime}{Style.RESET_ALL}"
            )

        formatted_record = formatted_record.replace(
            record.msg, f"{color_code}{record.msg}{Style.RESET_ALL}"
        )
        return formatted_record


def _file_handler(log_level=logging.INFO):
    start_time = dt.datetime.now()
    formatted_time = str(start_time.strftime("%Y%m%d_%H_%M_%S"))
    log_root = Path(LOGGING_DIR)

    if not log_root.exists():
        log_root.mkdir(parents=True)

    log_path = log_root / f"{formatted_time}-{__name__}.log"

    file_handler = FileHandler(log_path)
    file_handler.setLevel(log_level)

    formatter = jsonlogger.JsonFormatter(DEFAULT_JSON_FORMAT)
    file_handler.setFormatter(formatter)

    return file_handler


formatter = ColorFormatter(fmt="%(asctime)s - %(levelname)s - %(message)s")
logger = logging.getLogger()
logger.setLevel(logging.DEBUG)
# logger.setLevel(logging.INFO)

file_handler = _file_handler(log_level=logging.DEBUG)
logger.addHandler(file_handler)

stream_handler = StreamHandler()
stream_handler.setFormatter(formatter)
logger.addHandler(stream_handler)


def get_default_logger():
    return logger


def log_info(message):
    get_default_logger().info(str(message))


def log_debug(message):
    get_default_logger().debug(str(message))


def log_warning(message):
    get_default_logger().warning(str(message))


def log_error(message):
    get_default_logger().error(str(message))


def log_critical(message):
    get_default_logger().critical(str(message))
