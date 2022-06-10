# generate and copy cert
cd /opt/sh
sh /opt/sh/auto-generate-cert.sh
mkdir /etc/nginx/http.d/certs
cp -r /opt/sh/localhost.localdomain/* /etc/nginx/http.d/certs

# start nginx
nginx
/bin/shaenvsubst '\$UUID,\$WS_PATH' < $config_path > /usr/local/etc/v2ray/config.json
# start v2ray
sed -i "s/uuid/${UUID}/g" /etc/v2ray/config.json
nohup v2ray --config /etc/v2ray/config.json > /var/log/v2ray.log 2>&1 &
tail -f /var/log/v2ray.log