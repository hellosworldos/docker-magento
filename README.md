# docker-magento
Docker image to run Magento1 CE web server and it's cron

## Links

* `db` - `paulczar/percona-galera` is used by default
* `cache` - currently configured to work with `memcached` image only
* `session` - currently configured to work with `memcached` image only

## Volumes

* /var/www/magento/repo_volume - Magento root dir

