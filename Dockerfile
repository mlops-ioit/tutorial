# Use a lightweight Python 3.9 image
FROM python:3.9-slim

# Metadata
LABEL maintainer="AISSMS"
LABEL version="1.0"

# Prevents Python from buffering output
ENV PYTHONUNBUFFERED 1

# Set the working directory
WORKDIR /app

# Copy required files into the container
COPY ./requirements.txt /requirements.txt
COPY ./models/model.joblib /models/model.joblib
COPY ./webapp /app/webapp

# Expose port 8000 (Django default)
EXPOSE 8000

# Install dependencies and setup a virtual environment
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /requirements.txt && \
    rm -rf /root/.cache && \
    adduser --disabled-password --no-create-home appuser && \
    chown -R appuser /app

# Switch to the new user
USER appuser

# Run the Django server
# CMD ["/py/bin/python", "/app/webapp/manage.py", "runserver", "0.0.0.0:8000"]
