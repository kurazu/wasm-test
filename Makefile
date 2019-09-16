EMDIR=/home/kurazu/apps/emsdk/emscripten/incoming
NODEDIR=/home/kurazu/apps/node-v12.9.1-linux-x64/bin
add.wasm: add.c
	${EMDIR}/emcc add.c -s "EXPORTED_FUNCTIONS=['_add']" -O3 -o add.wasm

run: add.wasm
	${NODEDIR}/node --experimental-modules --experimental-wasm-modules main.mjs
