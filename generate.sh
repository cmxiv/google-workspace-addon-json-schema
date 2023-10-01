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
  quicktype --just-types --lang typescript -s schema --src RenderActionResponse.schema.json --src Card.schema.json -o generated/"$1"/Card.ts
  quicktype --just-types --lang typescript -s schema --src CommonEvent.schema.json -o generated/"$1"/Event.ts
  quicktype --just-types --lang typescript -s schema --src Deployment.schema.json -o generated/"$1"/Deployment.ts

  ALL_EVENT_EXPORTS=$(cat generated/"$1"/Event.ts | grep "export" | grep -v "ConferenceSolution" | awk '{print $3}' ORS=',' | awk '{print substr($1, 1, length($1)-1)}')
  echo "export {$ALL_EVENT_EXPORTS} from \"./Event\"" > generated/"$1"/index.d.ts
  echo "export {ConferenceSolution as ConferenceSolutionObject} from \"./Event\"" >> generated/"$1"/index.d.ts
  echo "export * from \"./Deployment\"" >> generated/"$1"/index.d.ts
  echo "export * from \"./Card\"" >> generated/"$1"/index.d.ts
else
  quicktype --lang "$1" -s schema --src SubmitFormResponse.schema.json -o generated/"$1"/SubmitFormResponse."$2"
  quicktype --lang "$1" -s schema --src Card.schema.json -o generated/"$1"/Card."$2"
  quicktype --lang "$1" -s schema --src CommonEvent.schema.json -o generated/"$1"/Event."$2"
  quicktype --lang "$1" -s schema --src Deployment.schema.json -o generated/"$1"/Deployment."$2"
fi

echo "✅  Types generated!"
