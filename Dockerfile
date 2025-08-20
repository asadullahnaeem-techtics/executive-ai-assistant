FROM python:3.11-slim

# Ensure stdout/err are unbuffered
ENV PYTHONUNBUFFERED=1
WORKDIR /app

# Install system dependencies (none required for this project currently)
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     build-essential \
#  && rm -rf /var/lib/apt/lists/*

# Copy only dependency files first for better layer caching
COPY pyproject.toml poetry.lock ./

# Upgrade pip and build tools
RUN python -m pip install --upgrade pip setuptools wheel

# Install project dependencies and package
COPY . .
RUN pip install --no-cache-dir -e .

# Expose default port used by langgraph-api
EXPOSE 8000

# The platform may override the CMD; this is a sensible default
CMD ["python", "-m", "langgraph_api"]


