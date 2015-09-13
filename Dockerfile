FROM fabrizzio/docker-php:5.5.29
MAINTAINER Dieter Provoost <dieter.provoost@marlon.be>

# PHP QA tools
RUN apt-get install -y -f --force-yes ant sqlite3 && \
    curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && \
    pear config-set auto_discover 1 && \
    pear channel-discover pear.pdepend.org && \
    pear channel-discover pear.phpmd.org && \
    composer global require 'phploc/phploc=*' && \
    pear install PHP_CodeSniffer && \
    pear install pdepend/PHP_Depend && \
    pear install --alldeps phpmd/PHP_PMD && \
    composer global require "sebastian/phpcpd=*" && \
    composer global require "theseer/phpdox=*" && \
    apt-get clean -y

ENV PATH /root/.composer/vendor/bin:$PATH
