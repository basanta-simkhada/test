FROM ubuntu:26.04

RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    php-cli \
    php-common \
    php-mbstring \
    && apt-get clean

COPY index.php /var/www/html/index.php
RUN rm /var/www/html/index.html
RUN chown -R www-data:www-data /var/www/

COPY site.conf /etc/apache2/sites-available/site.conf

RUN a2dissite 000-default.conf && \
    a2ensite site.conf && \
    a2enmod rewrite

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]