#!/bin/bash


openssl req -new -nodes -config /root/ca/openssl.cnf -out /root/ca/certs/$1.csr -keyout /root/ca/certs/$1.key

openssl ca -config /root/ca/openssl.cnf -in /root/ca/certs/$1.csr -out /root/ca/certs/$1.crt 
