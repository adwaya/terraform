#! /bin/sh

echo "Getting IPv4 of the instance...."

IPv4=$(curl -s 'http://169.254.169.254/latest/meta-data/local-ipv4')

echo The Private IP of the instance is = $IPv4

