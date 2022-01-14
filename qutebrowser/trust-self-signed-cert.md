# Trust self-signed certificate in Qutebrowser

<https://qutebrowser.org/FAQ.html>

```sh
sudo apt install libnss3-tools -y

dotnet dev-certs https -ep dotnet-dev-cert.der
openssl x509 -in dotnet-dev-cert.der -inform der -outform pem > dotnet-dev-cert.pem
CERT_PEM_FILE='./dotnet-dev-cert.pem'
CERT_CA_NAME='.NET dev cert'
certutil -d "sql:${HOME}/.pki/nssdb" -A -i "$CERT_PEM_FILE" -n "$CERT_CA_NAME" -t "TC,C,T"
```
