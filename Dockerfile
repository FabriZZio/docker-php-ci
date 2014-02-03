FROM ubuntu:latest
MAINTAINER Dieter Provoost <dieter.provoost@marlon.be>

RUN apt-get -y -f install python-software-properties
RUN add-apt-repository ppa:ondrej/php5

RUN echo 'deb http://us.archive.ubuntu.com/ubuntu/ precise main universe' >> /etc/apt/sources.list.d/universe.sources.list
RUN echo 'deb-src http://us.archive.ubuntu.com/ubuntu/ precise main universe' >> /etc/apt/sources.list.d/universe-src.sources.list

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get install -y -f openssh-server git-core unzip ant
RUN mkdir /var/run/sshd
RUN echo "root:root" | chpasswd

# PHP + extensions
RUN apt-get -y -f install php5-cli php5-dev php5-mysql php5-xmlrpc php5-curl curl libicu-dev php5-sqlite php5-memcache php-pear php5-xsl

# Setup SSH
RUN echo " IdentityFile /root/.ssh/id_rsa" >> /etc/ssh/ssh_config
RUN echo " StrictHostKeyChecking no" >> /etc/ssh/ssh_config

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

RUN pecl install xdebug

ADD php/custom.ini /etc/php5/cli/conf.d/40-custom.ini

RUN pecl install mongo

RUN apt-get clean -y

EXPOSE 22

ADD start.sh start.sh

CMD ["sh", "start.sh"]
