FROM quay.io/astronomer/astro-runtime:12.0.0
# Switch to root user to install packages
USER root

RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    python3-dev \
    build-essential \
    libffi-dev \
    libssl-dev \
    libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
# Install soda into a virtual environment
RUN python -m venv soda_venv && source soda_venv/bin/activate && \
    pip install --upgrade pip setuptools wheel && \
    pip install --no-cache-dir soda-core-bigquery==3.0.45 && \
    pip install --no-cache-dir soda-core-scientific==3.0.45 && \
    deactivate

# install dbt into a virtual environment
RUN python -m venv dbt_venv && source dbt_venv/bin/activate && \
    pip install --no-cache-dir dbt-bigquery && deactivate
