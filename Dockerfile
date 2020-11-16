FROM odoo:14.0

ADD odoo.conf /etc/odoo/odoo.conf

USER root
RUN apt update && apt install --no-install-recommends -y git openssh-server \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -m 600 /root/.ssh \
  && mkdir -m 755 /mnt/br-localization \
  && pip3 install --no-cache-dir odoonfe3 python3-cnab python3-boleto pycnab240

WORKDIR /tmp
RUN git clone -b 14.0 --depth=1 https://github.com/Odoo-BR/odoo-brasil.git \
 && find */* -maxdepth 0 -type d -exec mv '{}' /mnt/br-localization \; \
 && rm -rf /tmp/* \
 && chown -R odoo:root /mnt/*

WORKDIR /mnt
USER odoo
ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
