#!/bin/sh

echo "\033[34mHytale Docker Image (https://hub.docker.com/r/marcandreher/hytale-server)\033[0m"

if [ ! -d "/hytale/updater" ]; then
    echo "\033[34mSetting up Hytale Updater...\033[0m"
    wget https://downloader.hytale.com/hytale-downloader.zip
    unzip -o hytale-downloader.zip -d /hytale/updater
    rm hytale-downloader.zip
    cp /hytale/updater/hytale-downloader-linux-amd64 /hytale/updater/hytale-downloader
    chmod +x /hytale/updater/hytale-downloader
fi

cd /hytale/updater

if [ ! -f "/hytale/updater/.hytale-downloader-credentials.json" ]; then
    ./hytale-downloader -print-version
fi

LATESTVERSION=$(./hytale-downloader -print-version)
CURRENTVERSION=$(cat /hytale/updater/hytale.version)

if [ ! -f "/hytale/updater/hytale.version" ]; then
    ./hytale-downloader -print-version > /hytale/updater/hytale.version
fi

if [ "$LATESTVERSION" != "$CURRENTVERSION" ]; then
    echo "\033[34mA new version of Hytale is available: ${LATESTVERSION}. Downloading...\033[0m"

    ./hytale-downloader -download-path /hytale/game.zip
    
    unzip -o /hytale/game.zip -d /hytale/
    mv /hytale/Server/* /hytale/
    rm -rf /hytale/Server /hytale/game.zip
    echo $LATESTVERSION > /hytale/updater/hytale.version
else
    echo "\033[32mHytale is up to date: ${CURRENTVERSION}\033[0m"
fi

cd ../

# Set defaults if env vars are not set
HYTALE_ASSETS="${HYTALE_ASSETS:-Assets.zip}"
HYTALE_AUTH_MODE="${HYTALE_AUTH_MODE:-authenticated}"
HYTALE_BIND="${HYTALE_BIND:-0.0.0.0:5520}"
HYTALE_BACKUP="${HYTALE_BACKUP:-false}"
HYTALE_BACKUP_DIR="${HYTALE_BACKUP_DIR:-/hytale/backups}"
HYTALE_BACKUP_FREQUENCY="${HYTALE_BACKUP_FREQUENCY:-30}"

JAVA_CMD="java -jar HytaleServer.jar \
    --assets \"${HYTALE_ASSETS}\" \
    --auth-mode \"${HYTALE_AUTH_MODE}\" \
    --bind \"${HYTALE_BIND}\" \
    $( [ \"$HYTALE_BACKUP\" = \"true\" ] && echo --backup ) \
    --backup-dir \"${HYTALE_BACKUP_DIR}\" \
    --backup-frequency \"${HYTALE_BACKUP_FREQUENCY}\""

eval $JAVA_CMD