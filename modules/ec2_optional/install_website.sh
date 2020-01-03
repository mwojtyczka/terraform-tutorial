#!/bin/bash

# install libs
yum update -y
yum install -y httpd

# start httpd service and enable it at boot
service httpd start
chkconfig httpd on

# set permissions
groupadd www
usermod -a -G www ec2-user
chown -R root:www /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} +
find /var/www -type f -exec chmod 0664 {} +

# response
echo '<html><head><title>Success!</title></head><body><iframe width="560" height="315" src="https://www.youtube.com/embed/Js21xKMFdww" frameborder="0" allowfullscreen></iframe></body></html>' > /var/www/html/demo.html
