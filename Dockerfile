FROM python:3.11

RUN apt-get update \
	&& apt-get install -y wget git python3-poetry openssh-server\
	&& rm -rf /var/lib/apt/lists/* \
	&& rm /bin/sh \
	&& ln -s /bin/bash /bin/sh \
	&& groupadd -r user \
	&& useradd --create-home --no-log-init -r -g user user \
	&& mkdir /proxy_py \
	&& chown user:user /proxy_py

WORKDIR /proxy_py
USER user

ARG VERSION=exec_bug

RUN echo "Downloading proxy_py sources..." \
	&& git clone https://github.com/Kom46/proxy_py.git -b ${VERSION} /proxy_py \
	&& git clone https://github.com/nibrag/aiosocks.git \
	&& python3 -m venv .venv \
	&& poetry env use .venv/bin/python3 \
	&& poetry add ./aiosocks \
	&& cd /proxy_py \
	&& cp config_examples/docker_settings.py /proxy_py/proxy_py/settings.py \
	&& mkdir -p /proxy_py/local \
	&& ln -sr /proxy_py/proxy_py/settings.py /proxy_py/local/settings.py \
	&& echo "Installing dependencies..." \
	&& poetry add pytest \
	&& poetry install --without=dev

EXPOSE 55555
