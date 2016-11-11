#!/bin/zsh
set -e

CURRENT_DIR=`pwd`

TEMP_DIR=/tmp/curl-ca-bundle
CURL_VERSION=7.51.0
CURL_DIR=curl-$CURL_VERSION
CERT_DIR=~/.weechat/certs

test -d $TEMP_DIR && rm -rf $TEMP_DIR

mkdir $TEMP_DIR
cd $TEMP_DIR

wget http://curl.haxx.se/download/$CURL_DIR.tar.gz
tar xzf $CURL_DIR.tar.gz

cd $CURL_DIR/lib
./mk-ca-bundle.pl

test -d $CERT_DIR || mkdir $CERT_DIR

mv ca-bundle.crt $CERT_DIR

echo
echo 'Done!'

cd $CURRENT_DIR
