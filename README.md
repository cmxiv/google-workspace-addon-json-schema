# google-workspace-addon-json-schema
JSON schema files required while developing Google Workspace add-ons with alternative runtimes

These schema files are taken from guide to build [Google Workspace add-ons using alternative runtimes](https://developers.google.com/workspace/add-ons/guides/alternate-runtimes) 
and were later modify to correct inconsistencies in the schema.


mkdir generated
yarn run quicktype --just-types --lang typescript -s schema --src RenderActionResponse.schema.json -o generated/RenderAction.ts
yarn run quicktype --just-types --lang typescript -s schema --src Card.schema.json -o generated/Card.ts
yarn run quicktype --just-types --lang typescript -s schema --src CommonEvent.schema.json -o generated/Event.ts
yarn run quicktype --just-types --lang typescript -s schema --src Deployment.schema.json -o generated/Deployment.ts