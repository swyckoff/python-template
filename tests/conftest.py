from __future__ import unicode_literals

import logging

# import os
# import random
import shutil
from pathlib import Path

from pytest import fixture

TEST_DATABASE_NAME = "test_db.db"


@fixture
def replace():
    return {}


@fixture
def datadir(tmpdir, request):
    """
    Fixture responsible for searching a folder with the same name as the test
    module and, if available, copying all contents to a temporary directory so
    tests can use them freely.
    """
    test_file = Path(request.module.__file__)
    test_dir = test_file.with_suffix("")

    print(f" TEST ****** *FINDME ************: {test_dir}\n{tmpdir}")

    if test_dir.is_dir():
        shutil.copytree(test_dir, tmpdir, dirs_exist_ok=True)

    return tmpdir


# def datadir(tmpdir, request):
#     """
#     Fixture responsible for searching a folder with the same name of test
#     module and, if available, moving all contents to a temporary directory so
#     tests can use them freely.
#     """
#     filename = request.module.__file__
#     test_dir, _ = os.path.splitext(filename)
#     print(f" TEST ****** *FINDME ************: {test_dir}\n{tmpdir}")

#     if os.path.isdir(test_dir):
#         dir_util.copy_tree(test_dir, str(tmpdir))

#     return tmpdir
