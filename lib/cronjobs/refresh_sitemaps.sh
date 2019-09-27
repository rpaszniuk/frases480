#!/usr/bin/env bash
# Crontab: 0 3 * * * /path/to/app/lib/cronjobs/refresh_sitemaps.sh

# load rvm ruby
source /home/rodrigo/.rvm/environments/default

cd /var/www/html/newfrases480/
rake -s sitemap:refresh RAILS_ENV=production