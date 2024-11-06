#!/bin/bash

TEXT=${1:-こんにちは}
SERVER=http://localhost:50021
TMP_DIR=./data/tmp/
TEXT_FILE=${TMP_DIR}text.txt
QUERY_FILE=${TMP_DIR}query.json
OUTPUT_FILE=./data/output.wav
SPEAKER=2

mkdir -p $TMP_DIR

echo $TEXT > $TEXT_FILE
curl -s -X POST "${SERVER}/audio_query?speaker=${SPEAKER}" --get --data-urlencode text@${TEXT_FILE} > $QUERY_FILE
curl -s -X POST -H "Content-Type: application/json" -d @${QUERY_FILE} "${SERVER}/synthesis?speaker=${SPEAKER}" > $OUTPUT_FILE

aplay $OUTPUT_FILE

