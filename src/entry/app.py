from logging import WARNING

from attr import dataclass
from tenacity import (
    before_sleep_log,
    retry,  # type: ignore
    stop_after_attempt,
    wait_fixed,
)

from common.better_logger import (
    log_critical,  # noqa: F401
    log_debug,  # noqa: F401
    log_error,  # noqa: F401
    log_info,  # noqa: F401
    log_warning,  # noqa: F401
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
        before_sleep=before_sleep_log(logger, WARNING),
    )
    def run(self) -> None:
        pass


def run():
    my_class = MyClass(settings.host, settings.port)
    my_class.run()


if __name__ == "__main__":
    run()
