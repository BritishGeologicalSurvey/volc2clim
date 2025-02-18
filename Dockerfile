FROM python:3.13.1-slim-bookworm
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir gunicorn==23.0.0

# Create non-root user to run application
RUN adduser --system --no-create-home flask-runner
USER flask-runner

EXPOSE 8080
CMD ["gunicorn", "--workers=4", "--worker-tmp-dir=/dev/shm", "--error-logfile=-", "--bind=0.0.0.0:8080", "wsgi:app"]
