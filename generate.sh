#!/bin/bash

TEXT=${1:-こんにちは}

curl -X POST "http://localhost:50021/audio_query?speaker=1&text=${TEXT}" > query.json
curl -X POST -H "Content-Type: application/json" -d @query.json "http://localhost:50021/synthesis?speaker=1" --output output.wav

