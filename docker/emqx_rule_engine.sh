webServerWebhookUrl="WEB_HOST"
emqxContainerName="EMQX_CONTAINER_NAME"
emqxCID=$(docker container ls -a --format "table {{.ID}}\t{{.Image}}\t{{.Names}}" | grep "${emqxContainerName}" | awk '{print $1}')
resourceId=$(docker exec -i $emqxCID emqx_ctl resources create 'web_hook' -c '{"url":"'"$webServerWebhookUrl"'","request_timeout":5,"method":"POST","content_type":"application/json","connect_timeout":5}' | awk '{print $2}')
docker exec -i $emqxCID emqx_ctl rules create "SELECT * FROM \"\$events/client_disconnected\" WHERE reason='error'" '[{"name":"data_to_webserver","params":{"$resource":"'"$resourceId"'"}}]' -d "Forward Connect error information to webserver"
unset webServerWebhookUrl emqxContainerName emqxCID resourceId
