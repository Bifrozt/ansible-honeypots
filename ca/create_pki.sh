#!/bin/bash


mkdir /root/ca
mkdir /root/ca/certs
mkdir /root/ca/crl
mkdir /root/ca/newcerts
mkdir /root/ca/private
mkdir /root/ca/signing

chmod 0700 /root/ca/private

touch /root/ca/crlnumber
touch /root/ca/index.txt

echo 1000 > /root/ca/serial


cp openssl.cnf /root/ca/.


openssl req -new -config /root/ca/openssl.cnf -out /root/ca/root-ca.csr -keyout /root/ca/private/cakey.pem

openssl ca -selfsign -config /root/ca/openssl.cnf -in /root/ca/root-ca.csr -out /root/ca/root-ca.crt

#mkdir /root/ca/signing/private
#chmod 0700 /root/ca/signing/private

#openssl req -new -config /root/ca/openssl.cnf -out /root/ca/signing/signing-ca.csr -keyout /root/ca/signing/private/signing-ca.key
#openssl ca -config /root/ca/openssl.cnf -in /root/ca/signing/signing-ca.csr -out /root/ca/signing/signing-ca.crt


