#!/bin/bash

TEXT=${1:-こんにちは}
TEXT_ENCODED=$(echo $TEXT | jq -Rr @uri)
SERVER=http://localhost:50021

curl -X POST "${SERVER}/audio_query?speaker=1&text=${TEXT}" > query.json
curl -X POST -H "Content-Type: application/json" -d @query.json "${SERVER}/synthesis?speaker=1" --output ./data/output.wav

