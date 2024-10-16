from logging import WARNING

from attr import dataclass
from tenacity import before_sleep_log, retry, stop_after_attempt, wait_fixed

from common.better_logger import (
    log_critical,
    log_debug,
    log_error,
    log_info,
    log_warning,
    logger,
)
from common.settings import settings


@dataclass
class MyClass:
    # Define self.vars
    host: str
    port: int

    @retry(
        stop=stop_after_attempt(3),
        wait=wait_fixed(2),
        before_sleep=before_sleep_log(logger, WARNING),  # Log before each retry
    )
    def run(self) -> None:
        pass


def run():
    my_class = MyClass(settings.host, settings.port)
    my_class.run()
