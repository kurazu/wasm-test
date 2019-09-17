import { memory, add, get_mem, sum } from './add.wasm';
// import { promises as fs } from 'fs';

function callback(i) {
    console.log('JS callback', i);
}

// async function loadWA() {
//     const env = { callback };
//     const bytes = new Uint8Array(await fs.readFile('./add.wasm'));
//     return WebAssembly.instantiate(bytes, { env });
// }

async function main() {
    // const mod = await loadWA();
    console.log('add', add(8, 5));
    const memoryPtr = get_mem();
    console.log('ptr', memoryPtr);
    const view = new Int32Array(memory.buffer, memoryPtr, 10);
    console.log('view', view);
    for (let i = 1; i <= 10; i++) {
        view[i - 1] = i;
    }
    const s = sum();
    console.log('sum', s);

}

main().catch(err => {
    console.error('FAILED', err);
});
