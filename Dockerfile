FROM python:3.11

RUN apt-get update \
	&& apt-get install -y wget git python3-poetry\
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
	# && mv proxy_py-*/.[!.]* ./ && mv proxy_py-*/* ./ \
	# && rmdir proxy_py-* \
	&& python3 -m venv .venv \
	&& poetry env use .venv/bin/python3 \
	# they became too greedy to allow free downloading
	# && echo "Creating IP:Location database..." \
	# && mkdir /tmp/proxy_py_9910549a_7d41_4102_9e9d_15d39418a5cb \
	# && cd /tmp/proxy_py_9910549a_7d41_4102_9e9d_15d39418a5cb \
	# && wget "https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz" 2> /dev/null \
	# && tar xf GeoLite2-City.tar.gz \
	# && mv GeoLite2-City_*/GeoLite2-City.mmdb ./ \
	# && rm -r GeoLite2-City_* \
	&& cd /proxy_py \
	&& cp config_examples/settings.py proxy_py/settings.py \
	&& echo "Installing dependencies..." \
	&& poetry install --without=dev
	# && source ./env/bin/activate \
	# && pip3 install -r requirements.txt --no-cache-dir

EXPOSE 55555
