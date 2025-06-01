FROM python:3.9-slim

# Create a user to run the application (don't run as root)
RUN useradd --uid 1000 theia && \
    mkdir /app && \
    chown -R theia:theia /app

# Set the working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY service/ ./service/

# Switch to non-root user
USER theia

# Expose the application port
EXPOSE 8080

# Use gunicorn as the entry point
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]