set dotenv-load

[private]
default:
	@just --list

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
# package: _validate_env_active
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