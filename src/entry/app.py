from attr import dataclass

from common.better_logger import (
    log_critical,
    log_debug,
    log_error,
    log_info,
    log_warning,
)
from common.settings import settings


@dataclass
class MyClass:
    # Define self.vars
    host: str
    port: int


def run():
    my_class = MyClass(settings.host, settings.port)
