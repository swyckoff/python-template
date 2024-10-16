import json

import pytest


class TestClientTable:
    def test_sample(self, datadir):
        sample_data_file = datadir / "sample_data.json"

        assert sample_data_file.exists()

        with sample_data_file.open() as f:
            data = json.load(f)

        assert data["key"] == "value"
