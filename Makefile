# current git branch
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

init::
	python -m pip install --upgrade pip
	pip install -r requirements.txt

black:
	black .

black-check:
	black --check .

flake8:
	flake8 --exclude .venv,node_modules

isort:
	isort --profile black .

download-notes:
	curl -qsL 'https://github.com/colmjude/til/raw/main/dumps/notes.db' > notes.db

commit-notes::
	git add notes.db
	git diff --quiet && git diff --staged --quiet || (git commit -m "Latest notes sqlite db $(shell date +%F)"; git push origin $(BRANCH))
