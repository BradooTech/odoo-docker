FROM odoo:latest

USER root

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
	apt-get update \
	&& apt-get install -y --no-install-recommends \
	&& curl https://raw.githubusercontent.com/gabrielbalog/odoo-docker/master/apt | xargs apt-get install -y --no-install-recommends \
	&& pip3 install wheel --no-cache-dir \
	&& pip3 install phonenumbers --no-cache-dir \
	&& pip3 install watchdog --no-cache-dir \
	&& apt-get clean

RUN set -x; \
	pip3 install --upgrade pip==9.0.3 --no-cache-dir \
	&& pip3 install --upgrade setuptools --no-cache-dir \
	&& curl https://raw.githubusercontent.com/BradooTech/scripts/master/dependencias/ubuntu/pip3 -O | xargs pip3 install -r pip3 --no-cache-dir \
	&& curl https://raw.githubusercontent.com/odoo/odoo/11.0/requirements.txt -O | xargs pip3 install -r requirements.txt --no-cache-dir

RUN set -x; \
	pip3 uninstall PyTrustNFe3 -y \
	&& pip3 install git+https://github.com/BradooTech/PyTrustNFe --no-cache-dir


RUN apt-get install systemd -y \
	&& echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf \
	&& apt-get clean \
	&& pip3 install plotly \
	&& pip3 install pandas \
	&& pip3 install unidecode 

RUN pip3 install xmltodict \
	&& pip3 install xml2json

EXPOSE 8069 8071

VOLUME ./modules:/mnt/extra-addons
VOLUME odoo_filestore:/var/lib/odoo

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
