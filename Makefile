EMDIR=/home/kurazu/apps/emsdk/emscripten/incoming
NODEDIR=/home/kurazu/apps/node-v12.9.1-linux-x64/bin
# add.wasm: add.c
# 	${EMDIR}/emcc add.c -s "EXPORTED_FUNCTIONS=['_add', '_sum', '_get_memory', '_call_js']" -O3 -o add.wasm

add.s: add.c
	clang-8 \
	  --target=wasm32 \
	  -O3 \
	  -flto \
	  -emit-llvm \
	  -c \
	  -S \
	  add.c

add.s.o: add.s
	llc-8 \
	  -march=wasm32 \
	  -filetype=obj \
	  add.s

add.wasm: add.s.o
	wasm-ld-8 \
	  --no-entry \
	  --export-all \
	  --lto-O3 \
	  -o add.wasm \
	  add.s.o

run: add.wasm
	${NODEDIR}/node --experimental-modules --experimental-wasm-modules main.mjs

debug: add.wasm
	${NODEDIR}/node --inspect-brk --experimental-modules --experimental-wasm-modules main.mjs

clean:
	rm -f *.ll *.o *.s
