FROM odoo:10

USER root

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
	apt-get update \
	&& apt-get install -y --no-install-recommends \
	&& curl https://raw.githubusercontent.com/BradooTech/odoo-docker/10/apt | xargs apt-get install -y --no-install-recommends \
	&& apt-get install pip2 \
	&& pip2 install wheel \
	&& pip2 install phonenumbers \
	&& pip2 install phonenumbers \
	&& pip2 install unidecode

RUN set -x; \
	pip2 install --upgrade pip \
	&& pip2 install --upgrade setuptools \
	&& curl https://raw.githubusercontent.com/BradooTech/scripts/master/dependencias/ubuntu/pip -O | xargs pip2 install -r pip2\
	&& curl https://raw.githubusercontent.com/odoo/odoo/10.0/requirements.txt -O | xargs pip2 install -r requirements.txt

RUN set -x; \
	pip2 uninstall PyTrustNFe3 -y \
	&& pip2 install git+https://github.com/BradooTech/PyTrustNFe


RUN apt-get install systemd -y \
  && echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf


EXPOSE 8069 8071

VOLUME ./modules:/mnt/extra-addons
VOLUME odoo_filestore:/var/lib/odoo

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
