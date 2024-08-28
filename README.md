wget https://raw.githubusercontent.com/malol01/oracle-centos7-yum-fix/main/centos_fix.sh

sed -i 's/\r//' centos_fix.sh

cat centos_fix.sh

chmod 777 *

./centos_fix.sh

is fixing:centos yum fails installing anything or updating system
