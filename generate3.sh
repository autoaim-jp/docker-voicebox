#!/bin/bash

# 引数でキャラクターを切り替える
TEXT=${1:-"こんにちは、私はVOICEVOXのキャラクターです。"}
SPEAKER=${2:-2} # デフォルトはスピーカーID 2
SPEED=${3:-1.0} # 0.5〜2.0
SERVER=http://localhost:50021
OUTPUT_FILE=./data/output_${SPEAKER}.wav

# 音声クエリを生成し、その結果を直接音声合成に渡す
curl -s -X POST "${SERVER}/audio_query?speaker=${SPEAKER}" \
     --get --data-urlencode text="${TEXT}" | \
jq '.speedScale = '$SPEED | \
jq '.intonation_scale = 1.4' | \
jq '.outputSamplingRate = 48000' | \
curl -s -X POST -H "Content-Type: application/json" \
     -d @- "${SERVER}/synthesis?speaker=${SPEAKER}" > $OUTPUT_FILE

# 音声を再生
aplay $OUTPUT_FILE

