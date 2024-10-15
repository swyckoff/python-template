# PROJECT SETUP

## Setup

1. Create a new conda environment to install your target python
1. Activate the env

### Install tooling [tooling setup](https://matt.sh/python-project-structure-2024)

Run

```bash
pip install pip poetry setuptools wheel -U --no-cache-dir
```

### Poetry setup

Target poetry to the python version with

```bash
poetry env use `which python`
```

#### If you have an outdated `requirements.txt`

Populate requirements-dev.tx and requirements.txt and install them using poetry

```bash
while read requirement; do poetry add "$requirement"; done < requirements.txt
```

### Else: Use pyproject.toml

Run `poetry install`

#### Enable .env's to auto load in `poetry shell`

1. Create a `.env`

   ```env
   HOST=localhost
   PORT=5555
   DEBUG=TRUE
   ```

1. Run

   ```bash
   poetry self add poetry-dotenv-plugin
   ```

1. Load the .env file yourself once so that it's in your `~/.autoenv_authorized`
   file. Otherwise `poetry shell` will fail

#### Verification

You can see packages in the poetry shell with `poetry shell; poetry show`

## Running

### Project Structure

The
[flat vs src layout](https://packaging.python.org/en/latest/discussions/src-layout-vs-flat-layout/)
debate. Using `src` dirs does not work for running scripts because python's
import module's path, aka `sys.path` by default does not know about `src`.

The work around is to install your project. But this is not a great development
experience. So you can change the python path manually with an env var or
runtime command like `PYTHONPATH=src`.

or use `poetry install` which is similar to `pip`'s editable installs.

### Entrypoint

Run

```bash
poetry run [ENTRYPOINT]
```

#### Without Poetry

```bash
PYTHONPATH=src python -m [ENTRYPOINT]
```
