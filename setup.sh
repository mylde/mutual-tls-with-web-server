#!/bin/bash

rm -rf conf/pki
mkdir -p conf/pki

NUM_BITS=4096
DAYS=3650

echo For ca
openssl genrsa -out conf/pki/ca.key $NUM_BITS
openssl req -new -key conf/pki/ca.key -out conf/pki/ca.csr -subj "/C=JP/ST=Tokyo/L=Tokyo/O=local ca/OU=ca/CN=ca.local"
openssl x509 -in conf/pki/ca.csr -days $DAYS -req -signkey conf/pki/ca.key -out conf/pki/ca.crt -sha256
echo

ARGV="server client"
for v in $ARGV; do
  echo For $v
  openssl genrsa -out conf/pki/${v}.key $NUM_BITS
  openssl req -new -key conf/pki/${v}.key -out conf/pki/${v}.csr -subj "/C=JP/ST=Tokyo/L=Tokyo/O=local ${v}/OU=${v}/CN=${v}.local"
  openssl x509 -in conf/pki/${v}.csr -days $DAYS -req -signkey conf/pki/${v}.key -out conf/pki/${v}.crt -CA conf/pki/ca.crt -CAkey ./conf/pki/ca.key -CAcreateserial -sha256
  echo
done

ls -l conf/pki