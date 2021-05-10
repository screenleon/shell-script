# CERTBOT GENERATE KEY PATH
CERT_PATH=/etc/letsencrypt/live

# COPY KEY TO DISTINCT NEW OR NOT
SSL_PATH=[DESTINATION_PATH]

echo "Starting Script..."

for FOLDER in "$CERT_PATH"/*;
do
    if [ -d "$FOLDER" ]; then
        FOLDER=`basename $FOLDER`
        FOLDER_CERT="$FOLDER"/cert.pem
        FOLDER_KEY="$FOLDER"/privkey.pem

        if [ "$CERT_PATH"/"$FOLDER_CERT" -nt "$SSL_PATH"/"$FOLDER_CERT" ]; then
            # IF FOLDER NOT CREATE THEN CREATE
            if [ ! -e "$SSL_PATH"/"$FOLDER" ]; then
                mkdir -p "$SSL_PATH"/"$FOLDER"
            fi

            # COPY FILE TO DESTINATION
            cp "$CERT_PATH"/"$FOLDER_CERT" "$SSL_PATH"/"$FOLDER_CERT"
            cp "$CERT_PATH"/"$FOLDER_KEY" "$SSL_PATH"/"$FOLDER_KEY"

            echo "Reloading nginx..."
            # RELOAD DOCKER's NGINX CONTAINER
            docker exec [NGINX_CONTAINER] nginx -s reload
            echo "Done!"
        else
            echo "Certificate is already up-to-date."
        fi
    fi
done