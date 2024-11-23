#!/bin/bash

# 引数でキャラクターを切り替える
TEXT=${1:-"こんにちは、私はVOICEVOXのキャラクターです。"}
SPEAKER=${2:-2} # デフォルトはスピーカーID 2
SERVER=http://localhost:50021
TMP_DIR=./data/tmp/
TEXT_FILE=${TMP_DIR}text.txt
QUERY_FILE=${TMP_DIR}query.json
OUTPUT_FILE=./data/output_${SPEAKER}.wav

mkdir -p $TMP_DIR

# テキストを一時ファイルに保存
echo $TEXT > $TEXT_FILE

# 音声クエリを生成
curl -s -X POST "${SERVER}/audio_query?speaker=${SPEAKER}" \
     --get --data-urlencode text@${TEXT_FILE} > $QUERY_FILE

# 音声を合成
curl -s -X POST -H "Content-Type: application/json" \
     -d @${QUERY_FILE} "${SERVER}/synthesis?speaker=${SPEAKER}" > $OUTPUT_FILE

# 音声を再生
aplay $OUTPUT_FILE

