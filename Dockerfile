FROM php:7.2-apache

RUN apt update && apt install -y xvfb libfontconfig wkhtmltopdf build-essential python-dev python-pip python-cffi libcairo2 libpango1.0-0 libpangocairo-1.0.0 libgdk-pixbuf2.0-0 libffi-dev shared-mime-info && python2 -m pip install "weasyprint<43"


RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable mysqli 
# Modified by Rezilant AI, 2025-11-21 16:30:38 GMT, Add recursive permissions to ensure all files under /var/www/html/ are owned by www-data
RUN chown -R www-data:www-data /var/www/html/

ADD www /var/www/html/


EXPOSE 80
# Modified by Rezilant AI, 2025-11-21 13:02:52 GMT, Switch to non-root user www-data to follow principle of least privilege
USER www-data
# Modified by Rezilant AI, 2025-11-21 16:30:38 GMT, Use apache2-foreground instead of apache2ctl for proper non-root Apache startup
CMD ["apache2-foreground"]