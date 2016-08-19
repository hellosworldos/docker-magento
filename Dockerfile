FROM hellosworldos/webserver
MAINTAINER Widgento

ADD /etc/nginx/magento_rewrites.conf /etc/nginx/magento_rewrites.conf
ADD /etc/nginx/magento_security.conf /etc/nginx/magento_security.conf
ADD /etc/nginx/fastcgi_params_magento.conf /etc/nginx/fastcgi_params_magento.conf
ADD /etc/nginx/conf.d/magento.conf /etc/nginx/conf.d/magento.conf
ADD /etc/php5/fpm/conf.d/20-production.ini /etc/php5/fpm/conf.d/20-production.ini
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
    && mkdir -p /var/www/magento/shared/log \
    && chmod 0777 -R /var/www/magento/shared/var \
    && mkdir -p /var/www/magento/shared/media \
    && cd /usr/local/bin \
    && wget -nc https://raw.githubusercontent.com/netz98/n98-magerun/master/n98-magerun.phar \
    && chmod +x ./n98-magerun.phar

VOLUME ["/var/www/magento/repo_volume"]
VOLUME ["/var/www/magento/shared/var", "/var/www/magento/shared/media"]
VOLUME ["/var/www/magento/shared/sql"]
#VOLUME ["/var/www/magento/shared/media/catalog/product/cache/", "/var/www/magento/shared/media/css/", "/var/www/magento/shared/media/css_secure/", "/var/www/magento/shared/media/js/"]

CMD ["/tmp/init.sh"]
