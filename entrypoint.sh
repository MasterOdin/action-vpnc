#!/usr/bin/env bash

cat > /etc/vpnc/default.conf <<EOF
IPSec gateway ${gateway}
IPSec ID ${id}
IPSec secret ${secret}
Xauth username ${username}
Xauth password ${password}
Domain ${domain}
DPD idle timeout (our side) 0
EOF

# Use docker to rsync files from build directory to Union FTP server
# docker run --rm -ti -v ${TRAVIS_BUILD_DIR}:/srv --privileged --env-file .env --dns 8.8.8.8 masterodin/vpnc:latest /sbin/my_init --quiet -- /bin/sh -c "sleep 5 && sshpass -p \"${RPI_FTP_PASSWORD}\" rsync -e \"ssh -o StrictHostKeyChecking=no\" --exclude '.travis*' --exclude '.docker' --exclude '.git' --exclude '.dpl' --exclude '*.example.php' --exclude '.*_config.php' -r /srv/ ${RPI_FTP_USERNAME}@ftp.union.rpi.edu:/home/ambulanc/public_html/"

exec /usr/sbin/vpnc default --no-detach --non-inter
sleep 4
bash -c "${1}"
