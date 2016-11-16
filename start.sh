service td-agent start
service elasticsearch start
echo "waiting start elasticsearch 10 sec"
sleep 10
echo "put template.json"
curl -X PUT "http://localhost:9200/_template/template_1?pretty" --data @/tmp/template.json
/usr/share/kibana/bin/kibana
