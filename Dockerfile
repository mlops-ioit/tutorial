FROM python:3.11-slim
LABEL maintainer="AISSM"
LABEL version="1.0"

ENV PYTHONUNBUFFERED 1

WORKDIR /app
COPY ./requirements.txt /requirements.txt
COPY ./models/models.joblib /models/models.joblib
COPY ./webapp /app/webapp

EXPOSE 8000
EXPOSE 5432

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /requirements.txt && \
    rm -rf /root/.cache && \
    adduser --disabled-password --no-create-home app

ENV PATH="/py/bin:$PATH"

USER app