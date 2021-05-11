#!/bin/bash

# Generate key without passphrase
openssl genrsa -out private.key 2048
openssl rsa -in private.key -pubout -out public.key

# Generate key with passphrase
openssl genrsa -passout pass:_passphrase_ -out private.key 2048
openssl rsa -in private.key -passin pass:_passphrase_ -pubout -out public.key
