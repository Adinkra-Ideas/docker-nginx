#!/bin/sh

# Append a mapping of custom domain name to 127.0.0.1 into /etc/hosts file
echo "127.0.0.1	$DOMAIN_NAME" >> /etc/hosts

exec "$@"
