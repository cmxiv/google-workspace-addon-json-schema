import {
    quicktype,
    InputData,
    JSONSchemaInput,
    FetchingJSONSchemaStore
} from "quicktype-core";
import {readFile} from 'fs/promises';


async function readSchemaFile(file) {
    return (await readFile(new URL(file, import.meta.url))).toString()
}

async function quickTypeJSONSchema(targetLanguage, typeName, jsonSchema) {
    const schemaInput = new JSONSchemaInput(new FetchingJSONSchemaStore());

    const jsonSchemaString = await readSchemaFile(jsonSchema)
    await schemaInput.addSource({name: typeName, schema: jsonSchemaString});

    const inputData = new InputData();
    inputData.addInput(schemaInput);

    return await quicktype({
        inputData,
        lang: targetLanguage
    });
}

async function main() {

    const {lines: typescriptCard} = await quickTypeJSONSchema(
        "typescript",
        "RenderAction",
        "RenderActionResponse.schema.json"
    );
    console.log(typescriptCard.join("\n"));
}

main();