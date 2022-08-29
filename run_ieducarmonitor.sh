#!/bin/sh
cd /var/www/i-diario-1.0.8-c-0.1.7/vendor/ieducarmonitor
java -jar IEducarMonitor.jar -serve >> log.txt 2>&1
