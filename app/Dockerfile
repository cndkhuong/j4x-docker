FROM ubuntu:bionic

LABEL name 'Alexandre ELISÉ @mralexandrelise'

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get install -y wget zip unzip curl gnupg2 apt-transport-https build-essential software-properties-common git rsync cron nginx nodejs
RUN add-apt-repository -y ppa:ondrej/php \
  && apt-get update \
  && apt-get install -y \
   php7.3-common php7.3-fpm php7.3-cli php7.3-dev php-ssh2 php7.3-zip php7.3-xml php7.3-json \
   php-igbinary php7.3-ldap php-uuid php7.3-mbstring php7.3-intl php7.3-soap \
   php7.3-curl php7.3-gd php7.3-xsl php7.3-bcmath php7.3-mysql \
   php7.3-opcache php7.3-sqlite3 php-redis php-geoip php-ast php-xdebug \
   php7.3-gmp
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --filename=composer --install-dir=/usr/local/bin \
    && php -r "unlink('composer-setup.php');"
RUN apt-get install -y locales npm && locale-gen en_US.UTF-8
RUN apt-get install -y supervisor sqlite3 tzdata \
    && echo "UTC" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata \
    && mkdir /run/php \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && echo "daemon off;" >> /etc/nginx/nginx.conf
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN chmod 777 /tmp && npm set unsafe-perm true && npm -g install npm@lts
ARG USER_ID
ARG GROUP_ID

RUN groupadd -f -g $GROUP_ID j4x
RUN useradd -u $USER_ID -g $GROUP_ID j4x

USER j4x

ADD start.sh start.sh
ADD default /etc/nginx/sites-enabled/default
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD php-fpm.conf /etc/php/7.3/fpm/php-fpm.conf
ADD www.conf /etc/php/7.3/fpm/pool.d/www.conf

CMD ["/bin/bash", "start.sh"]
EXPOSE 80


