FROM widgento/nginx
MAINTAINER Widgento

ADD /etc/nginx/magento_rewrites.conf /etc/nginx/magento_rewrites.conf
ADD /etc/nginx/magento_security.conf /etc/nginx/magento_security.conf
ADD /etc/nginx/conf.d/magento.conf /etc/nginx/conf.d/magento.conf
ADD /magento.sh /tmp/magento.sh
ADD /cron.sh /tmp/cron.sh
ADD /init.sh /tmp/init.sh
ADD /etc/cron.d/magento.crontab /etc/cron.d/magento.crontab

RUN chmod +x /tmp/magento.sh \
    && chmod +x /tmp/cron.sh \
    && chmod +x /tmp/init.sh \
    && groupadd dev \
    && useradd -G dev magento \
    && usermod -a -G dev www-data \
    && mkdir -p /var/www/magento/shared/var \
    && chmod 0777 -R /var/www/magento/shared/var \
    && mkdir -p /var/www/magento/shared/media

VOLUME ["/var/www/magento/repo_volume"]
VOLUME ["/var/www/magento/shared/var", "/var/www/magento/shared/media"]
VOLUME ["/var/www/magento/shared/sql"]
#VOLUME ["/var/www/magento/shared/media/catalog/product/cache/", "/var/www/magento/shared/media/css/", "/var/www/magento/shared/media/css_secure/", "/var/www/magento/shared/media/js/"]

CMD ["/tmp/init.sh"]
