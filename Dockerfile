
# Dockerfile for publishing to PyPi 
#
# (C) Ondics GmbH
#

ARG base=python:3.13-trixie
FROM ${base}
ARG base=python:3.13-trixie

RUN apt-get update && apt-get install -y \
    vim \
    jq \
    git \
    procps

# ... and uv
RUN pip install --no-cache-dir uv

WORKDIR /app

# these files are required to be published
COPY README.md .
COPY mcp_ckan_server.py .
COPY requirements.txt .
COPY pyproject.toml .
COPY LICENSE .
RUN pip install -r requirements.txt

CMD python ./mcp_ckan_server.py
ARG TZ="Europe/Berlin"
ENV TZ=${TZ}
