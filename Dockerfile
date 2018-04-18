FROM odoo:10

USER root

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
	apt-get update \
	&& apt-get install -y --no-install-recommends \
	&& curl https://raw.githubusercontent.com/BradooTech/odoo-docker/10.0/apt | xargs apt-get install -y --no-install-recommends \
	&& apt-get clean \
	&& apt-get autoremove -y

RUN set -x; \
	apt-get install python-dev python3-dev python-pip -y

RUN set -x; \
	pip install --upgrade pip==9.0.3 \
	&& pip install --upgrade setuptools

RUN set -x; \
	pip install wheel --no-cache-dir \
	&& pip install phonenumbers --no-cache-dir \
	&& pip install phonenumbers --no-cache-dir \
	&& pip install unidecode --no-cache-dir \
	&& curl https://raw.githubusercontent.com/BradooTech/odoo-docker/10.0/requirements.txt -O | xargs pip install -r requirements.txt --no-cache-dir \
	&& curl https://raw.githubusercontent.com/odoo/odoo/10.0/requirements.txt -O | xargs pip install -r requirements.txt --no-cache-dir

RUN apt-get install systemd -y \
  && echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf

RUN pip install PyTrustNFe \
	&& apt-get install pkg-config -y \
	&& pip install xmlsec

EXPOSE 8069 8071

VOLUME ./modules:/mnt/extra-addons
VOLUME odoo_filestore:/var/lib/odoo

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]