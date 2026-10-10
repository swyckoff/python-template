set dotenv-load

[private]
default:
	@just --list

# What this repo does and how it works, in brief.
why:
	#!/bin/sh
	cat <<'EOF'
	python-template is a starter for small Python projects and interview exercises:
	Poetry, a src/ layout, pytest, colored logging and typed settings.

	How it works
	  - src/entry/app.py is the entry point. src/common holds the logger and settings.
	  - tests/ mirrors src/ and runs with pytest.
	  - `just package` builds pythontemplate.tar.gz, a clean copy to start a new project
	    from, with template-README.md as its README.

	How it runs
	  - Nothing runs in the background. Follow template-README.md to set up conda and
	    Poetry, then `just test`.
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

[private]
alias p := package
# Package this template as pythontemplate.tar.gz, a clean start for a new project.
package:
	@echo "📦 Package a new python project template"
	@echo "🔁 Temporarily replacing README.md with template-README.md"
	@mv README.md README.md.bak 
	@mv template-README.md README.md 
	@echo "📦 Create the archive"
	@tar --exclude='.pytest_cache'  --exclude='.mypy_cache' --exclude='__pycache__' --exclude='justfile' --exclude='.git' --exclude='README.md.bak' --exclude="pythontemplate.tar.gz" -cvf pythontemplate.tar.gz .
	@echo "🔁 Reverting README.md.bak to README.md"
	@mv README.md template-README.md
	@mv README.md.bak README.md 


[private]
alias t := test
# 🧪 perform tests. pytest FLAGS 🚩
test *FLAGS: 
	@echo "🧪 More Examples: just test -s --pdb --pdbcls=IPython.terminal.debugger:TerminalPdb -k 'test_SPECIFIC_METHOD' tests/A_DIR/test_NAME.py"
	@echo "🧪 performing tests.";
	@python -m pytest {{FLAGS}}