FROM odoo:11.0

USER root

RUN pip3 install wheel

RUN set -x; \
	apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get install \
	python-dev \
	python3-dev \
	build-essential \
	libxml2-dev \
	libxmlsec1-dev \
	libpython3-dev \
	python2.7-dev \
	libldap2-dev \
	libsasl2-dev \
	ldap-utils \
	python-tox \
	lcov \
	valgrind \
	libxmlsec1 -y --no-install-recommends

RUN pip3 install --upgrade pip --no-cache-dir

RUN pip3 install --upgrade setuptools --no-cache-dir

RUN pip3 install xmlsec \
	phonenumbers \
	python3-boleto \
	qrcode \
	pyldap \
	vobject \
	netifaces \
	evdev \
	python3-cnab \
	watchdog \
	gengo --no-cache-dir

RUN set -x; \
	pip3 install https://github.com/BradooTech/PyTrustNFe/archive/mergenfe4.zip --no-cache-dir

# Configuracao para executar o modo dev no Odoo
RUN set -x; \
    apt-get update \
    && apt-get install systemd -y \
	&& echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf \
	&& apt-get clean

VOLUME odoo_filestore:/var/lib/odoo

EXPOSE 8069 8071

USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
