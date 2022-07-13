#!/bin/sh
cd /var/www/i-diario-1.0.8-c-0.1.7
bundle exec sidekiq -d -L log/sidekiq.log -C config/sidekiq.yml -e production
exit 0
