# generate and copy cert
cd /opt/sh
sh /opt/sh/auto-generate-cert.sh
mkdir /etc/nginx/http.d/certs
cp -r /opt/sh/localhost.localdomain/* /etc/nginx/http.d/certs

# start nginx
nginx
/bin/sh envsubst '\$UUID' < /etc/v2ray/config.json > /etc/v2ray/config.json
# start v2ray
sed -i "s/uuid/${uuid}/g" /etc/v2ray/config.json
nohup v2ray --config /etc/v2ray/config.json > /var/log/v2ray.log 2>&1 &
tail -f /var/log/v2ray.log