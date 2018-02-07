#!/bin/sh

# Create the CA Key and Certificate for signing Client Certs
openssl genrsa -out ca.key 4096
openssl req -new -x509 -days 365 -key ca.key -out ca.crt

# Create the Server Key, CSR, and Certificate
openssl genrsa -out server.key 1024
openssl req -new -key server.key -out server.csr

# Create the Client Key and CSR
openssl genrsa -out client.key 1024
openssl req -new -key client.key -out client.csr

# We're self signing our own server cert here.  This is a no-no in production.
openssl x509 -req -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt

# Sign the client certificate with our CA cert.  Unlike signing our own server cert, this is what we want to do.
openssl x509 -req -days 365 -in client.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out client.crt
