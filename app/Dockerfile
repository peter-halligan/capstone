FROM python:3.7.3-slim-stretch AS builder

WORKDIR /app

COPY . /app/

RUN python -m venv .venv && .venv/bin/pip install --upgrade pip --no-cache-dir -U pip setuptools

RUN .venv/bin/pip3 install --no-cache-dir -r requirements.txt &&\
 	find /app/.venv \( -type d -a -name test -o -name tests \) -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' \+


FROM python:3.7-alpine
WORKDIR /app

COPY --from=builder /app .

ENV PATH="/app/.venv/bin:$PATH"

EXPOSE 8081

CMD ["python3", "app.py"]


