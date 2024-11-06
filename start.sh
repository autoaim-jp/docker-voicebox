#!/bin/bash

docker pull voicevox/voicevox_engine
docker run -d --name voicevox -p 50021:50021 voicevox/voicevox_engine

