#!/bin/bash

curl -L https://yt-dl.org/downloads/latest/youtube-dl --fail --retry 5 --retry-max-time 15 -o ./ytdl
chmod +x ./ytdl

INPUT_URL="${INPUT_URL:-http://103.124.110.34:8082/SKY-SPORTS-CRICKET/index.m3u8}"
PRESET="${PRESET:-veryfast}"
CRF="${CRF:-24}"

if [[ -z "${SERVER_URL}" ]]; then
    echo "SERVER_URL is not set"
    exit 1
elif [[ -z "${STREAM_KEY}" ]]; then
   echo "STREAM_KEY is not set"
   exit 1
elif [[ $INPUT_URL =~ ^(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.?be)\/.+$ ]]; then
    INPUT_URL=`./ytdl -g $INPUT_URL`
    echo "GENERATED URL: $INPUT_URL \n"
fi

printf "PREPARING TO STREAM \n"
ffmpeg -headers "Referer:https://123zcast.me/" -i "https://s3.123zcast.me:8301/hls/star1in.m3u8" -preset veryfast -tune zerolatency -c:v libx264 -c:a aac -f flv $SERVER_URL$STREAM_KEY