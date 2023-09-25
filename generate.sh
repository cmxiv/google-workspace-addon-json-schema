#!/usr/bin/env sh

if [ ! -d "./generated" ]; then
  echo "📂 Creating folders to generate file"
  mkdir generated
fi

if [ ! -d "./generated/$1" ]; then
  echo "📂 Creating sub-folder for $1 types"
  mkdir generated/"$1"
fi

FLAGS=""
if test "$1" = "typescript"; then
  FLAGS=""
fi

echo "⏳  Generating types in 'generated' folder..."
yarn run quicktype $FLAGS --lang "$1" -s schema --src SubmitFormResponse.schema.json -o generated/"$1"/SubmitFormResponse."$2"
yarn run quicktype $FLAGS --lang "$1" -s schema --src Card.schema.json -o generated/"$1"/Card."$2"
yarn run quicktype $FLAGS --lang "$1" -s schema --src CommonEvent.schema.json -o generated/"$1"/Event."$2"
yarn run quicktype $FLAGS --lang "$1" -s schema --src Deployment.schema.json -o generated/"$1"/Deployment."$2"

echo "✅  Types generated!"
