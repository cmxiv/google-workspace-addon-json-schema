import { addSchema } from "@hyperjump/json-schema/draft-07";
import { bundle } from "@hyperjump/json-schema/bundle";
import { readFile } from 'fs/promises';

await addSchemaFile("./event-objects/common.json")
// await addSchemaFile("./event-objects/docs.json")
await addSchemaFile("./event-objects/gmail.json")
await addSchemaFile("./event-objects/calendar.json")
await addSchemaFile("./event-objects/google-sheets.json")
await addSchemaFile("./event-objects/google-slides.json")

const bundledSchema = await bundle("https://tandosid.dev/event-objects/main.json");
console.log(JSON.stringify(bundledSchema))

async function addSchemaFile(file) {
    const out = process.stdout
    out.write(`Trying to add schema from ${file}... `);
    const content = await readFile(new URL(file, import.meta.url))
    try {
        const schema = JSON.parse(content);
        addSchema(schema)
    } catch (e) {
        out.write("\x1b[31mError!\x1b[89m\x1b[0m\n")
        throw e
    }
    out.write("\x1b[32mDone!\x1b[89m\x1b[0m\n")
}
