set dotenv-load

[private]
default:
    @just --list

# What this repo does and how it works, in brief.
why:
    #!/usr/bin/env bash
    render() { if command -v rich >/dev/null; then rich --markdown --max-width 100 -; echo; else cat; fi; }
    render <<'EOF'
    # python-template

    A starter for small Python projects and interview exercises: Poetry, a `src/` layout, pytest, colored logging and typed settings.

    ## How it works

    - `src/entry/app.py` is the entry point. `src/common` holds the logger and settings.
    - `tests/` mirrors `src/` and runs with pytest.
    - `just build` makes `pythontemplate.tar.gz`, a clean copy to start a new project from, with `template-README.md` as its README.
    - `just check` is the merge gate: `check-justfile`, then pytest. There is no CI; run it before merging.

    ## How it runs

    - **Nothing runs in the background.** Follow `template-README.md` to set up conda and Poetry, then `just test`.
    EOF

# How to use this repo: the commands to run and what each does.
how:
    #!/usr/bin/env bash
    render() { if command -v rich >/dev/null; then rich --markdown --max-width 100 -; echo; else cat; fi; }
    render <<'EOF'
    # Using python-template

    | Run | To |
    |---|---|
    | `just build` | Build `pythontemplate.tar.gz`, a clean copy to start a new project from. Unpack it and follow its README. |
    | `poetry install` | Set up this checkout, in a conda environment with Python 3.12 (`template-README.md`). |
    | `poetry run python src/entry/app.py` | Run the entry point. |
    | `just test` | Run pytest. Flags pass through: `just test -k name`. |
    | `just check` | Run everything a merge needs: `check-justfile`, then the tests. |

    Start with `just build` for a new project, or `just check` when changing the template.
    EOF

[private]
_validate_conda_exists:
    @if command -v conda > /dev/null 2>&1 ; then \
        echo "🟢 'conda' found"; \
    else \
        echo "🛑 'conda' missing. 💭 Visit --> https://github.com/conda-forge/miniforge."; \
        exit 1; \
    fi

[private]
_validate_env_name_set:
    @if [ "${ENV_NAME:-}" ]; then \
        echo "🟢 ENV_NAME='${ENV_NAME}' set."; \
    else \
        echo "🛑 ENV_NAME not set. 💭 Check the '.env' file, or environment variables."; \
        exit 1; \
    fi

alias c := check
# Run everything a merge needs, without changing a file: the justfile convention, then the tests.
check:
    check-justfile
    python -m pytest

alias b := build
# Build pythontemplate.tar.gz, a clean start for a new project.
build:
    @echo "📦 Package a new python project template"
    @echo "🔁 Temporarily replacing README.md with template-README.md"
    @mv README.md README.md.bak
    @mv template-README.md README.md
    @echo "📦 Create the archive"
    @tar --exclude='.pytest_cache'  --exclude='.mypy_cache' --exclude='__pycache__' --exclude='justfile' --exclude='.git' --exclude='README.md.bak' --exclude="pythontemplate.tar.gz" -cvf pythontemplate.tar.gz .
    @echo "🔁 Reverting README.md.bak to README.md"
    @mv README.md template-README.md
    @mv README.md.bak README.md

alias t := test
# Run the tests. Flags go to pytest: `just test -k name`.
test *FLAGS:
    @echo "🧪 More Examples: just test -s --pdb --pdbcls=IPython.terminal.debugger:TerminalPdb -k 'test_SPECIFIC_METHOD' tests/A_DIR/test_NAME.py"
    @echo "🧪 performing tests.";
    @python -m pytest {{ FLAGS }}
