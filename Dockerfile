FROM fabrizzio/docker-php:latest
MAINTAINER Dieter Provoost <dieter.provoost@marlon.be>

RUN apt-get install -y -f --force-yes ant

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

ENV PATH /root/.composer/vendor/bin:$PATH

# PHP QA tools
RUN pear config-set auto_discover 1
RUN pear channel-discover pear.pdepend.org
RUN pear channel-discover pear.phpmd.org
RUN composer global require 'phploc/phploc=*'
RUN pear install PHP_CodeSniffer
RUN pear install pdepend/PHP_Depend
RUN pear install --alldeps phpmd/PHP_PMD
RUN composer global require "sebastian/phpcpd=*"
RUN wget http://phpdox.de/releases/phpdox.phar && chmod +x phpdox.phar && mv phpdox.phar /usr/local/bin/phpdox

RUN apt-get clean -y

EXPOSE 22

ADD start.sh start.sh

CMD ["sh", "start.sh"]
