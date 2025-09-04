echo "Cleaning directory"
rm -rf /usr/local/apache2/htdocs/*

echo "Creating attestation.tar.gz file"
tar cfzP /usr/local/apache2/htdocs/attestation.tar.gz /var/hyperprotect/se-checksums.txt /var/hyperprotect/se-signature.bin

echo "Changing permissions"
chgrp www-data /usr/local/apache2/htdocs/
chgrp www-data /usr/local/apache2/htdocs/attestation.tar.gz
chmod g+rx /usr/local/apache2/htdocs/
chmod g+r /usr/local/apache2/htdocs/attestation.tar.gz

echo "Starting httpd"
httpd -X