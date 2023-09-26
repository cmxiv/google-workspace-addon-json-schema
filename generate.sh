#!/usr/bin/env sh

if [ ! -d "./generated" ]; then
  echo "📂 Creating folders to generate file"
  mkdir generated
fi

if [ ! -d "./generated/$1" ]; then
  echo "📂 Creating sub-folder for $1 types"
  mkdir generated/"$1"
fi

echo "⏳  Generating types in 'generated' folder..."

if test "$1" = "typescript"; then
  quicktype --just-types --prefer-types --lang "$1" -s schema --src *.schema.json -o generated/"$1"/index.d.ts
else
  quicktype --lang "$1" -s schema --src SubmitFormResponse.schema.json -o generated/"$1"/SubmitFormResponse."$2"
  quicktype --lang "$1" -s schema --src Card.schema.json -o generated/"$1"/Card."$2"
  quicktype --lang "$1" -s schema --src CommonEvent.schema.json -o generated/"$1"/Event."$2"
  quicktype --lang "$1" -s schema --src Deployment.schema.json -o generated/"$1"/Deployment."$2"
fi

echo "✅  Types generated!"
