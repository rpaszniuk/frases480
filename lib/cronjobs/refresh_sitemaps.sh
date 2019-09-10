#!/usr/bin/env bash
# Crontab: 0 3 * * * /path/to/app/lib/cronjobs/refresh_sitemaps.sh

# load rvm ruby
source /home/ubuntu/.rvm/environments/default

cd /var/www/html/production_frases480/
rake -s sitemap:refresh RAILS_ENV=production