#!/bin/bash

rm -Rf /tmp/*
mkdir -p $1/instantclient_12_1 && cd $1 && \
unzip -o instantclient-basic-linux.x64-12.1.0.2.0.zip -d $1 && \
        unzip -o instantclient-sdk-linux.x64-12.1.0.1.0.zip -d $1 && \
        ln -s -f $1/instantclient_12_1/libclntsh.so.12.1 $1/instantclient_12_1/libclntsh.so && \
        ln -s -f $1/instantclient_12_1/libocci.so.12.1 $1/instantclient_12_1/libocci.so && \
        rm -Rf /opt/*.zip && \
        cd /tmp && wget https://pecl.php.net/get/oci8-2.0.11.tgz && \
        tar -xvf oci8-2.0.11.tgz && cd oci8-2.0.11 && \
        phpize && ./configure --with-oci8=shared,instantclient,/opt/oracle/instantclient_12_1 && \
        make && make install && \
        touch /etc/php5/mods-available/oci8.ini && \
        echo "extension = oci8.so"> /etc/php5/mods-available/oci8.ini && \
        php5enmod oci8
