#!/bin/bash

echo

echo '# Expected that this will be denied due to no required ssl certificate'
echo $ curl -k --resolve server.local:443:127.0.0.1 https://server.local
echo -
docker exec -it mutual_web curl -k --resolve server.local:443:127.0.0.1 https://server.local
echo -

echo
echo

echo '# Expected 200 OK'
echo $ curl -k --resolve server.local:443:127.0.0.1 --key /conf/pki/client.key --cert /conf/pki/client.crt https://server.local
echo -
docker exec -it mutual_web curl -k --resolve server.local:443:127.0.0.1 --key /conf/pki/client.key --cert /conf/pki/client.crt https://server.local
echo -

echo
