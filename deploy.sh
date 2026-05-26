mysql -u root <<'EOF'
CREATE DATABASE IF NOT EXISTS webdb;
CREATE USER IF NOT EXISTS 'web'@'localhost' IDENTIFIED BY 'P@ssw0rd';
GRANT ALL PRIVILEGES ON webdb.* TO 'web'@'localhost';
FLUSH PRIVILEGES;
EOF

mysql -u root webdb < /mnt/additional/web/dump.sql

sed -i 's/\$dbname = "db";/\$dbname = "webdb";/g' /var/www/html/index.php
sed -i 's/\$username = "user";/\$username = "web";/g' /var/www/html/index.php
sed -i 's/\$password = "password";/\$password = "P@ssw0rd";/g' /var/www/html/index.php

systemctl restart mariadb apache2
