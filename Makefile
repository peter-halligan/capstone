setup:
	python -m venv ~/.capstone

install:
	. ~/.capstone/bin/activate &&\
	pip install --upgrade pip &&\
	pip install -r ./app/requirements.txt
	
test:
	. ~/.capstone/bin/activate &&\
	python -m pytest

lint:
	. ~/.capstone/bin/activate &&\
	pylint --disable=R,C ./app/app.py
	docker run --rm -i hadolint/hadolint < Dockerfile
	

all: install lint test
