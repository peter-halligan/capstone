setup:
	python3 -m venv ~/.capstone

install:
	pip install --upgrade pip &&\
	pip install -r requirements.txt
	

test:
	python -m pytest -vv --cov=tests/*.py

lint:
	pylint --disable=R,C app.py
	docker run --rm -i hadolint/hadolint < Dockerfile
	

all: install lint test
