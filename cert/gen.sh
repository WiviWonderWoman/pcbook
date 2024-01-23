rm *.pem

# OBS: Serverside TLS step 1-3

# 1. Generate CA's private key and self-signed certificate
openssl req -x509 -newkey rsa:4096 -days 365 -nodes -keyout ca-key.pem -out ca-cert.pem -subj "/C=SW/ST=Skane/L=Hoeganeas/O=wivi/OU=home/CN=wivianne grapenholt/emailAddress=w.grapenholt@gmail.com"

echo "CA's selg-signed certificate"
openssl x509 -in ca-cert.pem -noout -text
# 2. Generate web server's  private key and certificate signing request (CSR)
openssl req -newkey rsa:4096 -nodes -keyout server-key.pem -out server-req.pem -subj "/C=SW/ST=Skane/L=Helsingborg/O=Pc Book/OU=Computer/CN=*.pcbook.com/emailAddress=pcbook@gmail.com"

# 3. Use CA's private key to sign web server's CSR and get back signed certificate  
openssl x509 -req -in server-req.pem -days 60 -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile server-ext.cnf

echo "Server's signed certificate"
openssl x509 -in server-cert.pem -noout -text

# OBS: Mutual TLS step 1-5

# 4. Generate clients's private key and certificate signing request (CSR)
openssl req -newkey rsa:4096 -nodes -keyout client-key.pem -out client-req.pem -subj "/C=SW/ST=Skane/L=Hoeganeas/O=wivi/OU=home/CN=wivianne grapenholt/emailAddress=w.grapenholt@gmail.com"

# 5. Use CA's private key to sign clients's CSR and get back signed certificate  
openssl x509 -req -in client-req.pem -days 60 -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out client-cert.pem -extfile client-ext.cnf

echo "Client's signed certificate"
openssl x509 -in client-cert.pem -noout -text

# INFO: the -nodes option (step 1: after -days, step 2 + 4: after rsa:4096 ) 
#       generates non encrypted private keys 
#       no password to encrypt key is required
# TIPS: Check if certificate is valid: openssl verify -CAfile ca-cert.pem server-cert.pem