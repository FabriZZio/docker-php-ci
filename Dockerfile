FROM fabrizzio/docker-php:latest
MAINTAINER Dieter Provoost <dieter.provoost@marlon.be>

RUN apt-get install -y ant

# PHP QA tools
RUN pear config-set auto_discover 1
RUN pear channel-discover pear.pdepend.org
RUN pear channel-discover pear.phpmd.org
RUN pear install pear.phpunit.de/phploc
RUN pear install PHP_CodeSniffer
RUN pear install pdepend/PHP_Depend
RUN pear install --alldeps phpmd/PHP_PMD
RUN pear install pear.phpunit.de/phpcpd
RUN wget http://phpdox.de/releases/phpdox.phar && chmod +x phpdox.phar && mv phpdox.phar /usr/local/bin/phpdox

RUN apt-get clean -y

EXPOSE 22

ADD start.sh start.sh

CMD ["sh", "start.sh"]
