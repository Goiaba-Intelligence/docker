FROM odoo:12.0

ADD odoo.conf /etc/odoo/odoo.conf

USER root
RUN mkdir /mnt/br-localization /mnt/add-ons && chown -R odoo:root /mnt/*
RUN pip3 install --no-cache-dir odoonfe3 python3-cnab python3-boleto pycnab240

USER odoo

WORKDIR /mnt/br-localization
RUN curl -O https://codeload.github.com/Trust-Code/odoo-brasil/tar.gz/12.0 \
  && tar -xf 12.0 && mv odoo-brasil-12.0/* ./ && rm -r *12.0*

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
