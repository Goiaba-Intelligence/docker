FROM odoo:12.0

ADD odoo.conf /etc/odoo/odoo.conf

USER root
RUN apt update && apt install --no-install-recommends -y git openssh-server \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -m 0600 /root/.ssh \
  && mkdir -m 0640 /mnt/br-localization /mnt/add-ons \
  && pip3 install --no-cache-dir odoonfe3 python3-cnab python3-boleto pycnab240

WORKDIR /tmp
RUN git clone -b 12.0 --depth=1 https://github.com/Odoo-BR/odoo-brasil.git \
 && find */* -maxdepth 0 -type d -exec mv '{}' /mnt/br-localization \; \
 && rm -rf /tmp/* \
 && chown -R odoo:odoo /mnt/*

WORKDIR /mnt
USER odoo
ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
