FROM odoo:12.0

ADD odoo.conf /etc/odoo/odoo.conf

USER root
WORKDIR /mnt

RUN curl -O https://codeload.github.com/Trust-Code/odoo-brasil/tar.gz/12.0
RUN tar -xf 12.0 && rm 12.0 && mv odoo-brasil-12.0 br_localization
RUN chown -R odoo /mnt/br_localization

RUN pip3 install --no-cache-dir odoonfe3 python3-cnab python3-boleto pycnab240

WORKDIR /
USER odoo
ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
