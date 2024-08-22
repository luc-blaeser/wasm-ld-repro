# wasm-ld-repro

(See also [original issue](mini_repro.ll) observed with Rust library compiled to shared Wasm64).

## LLVM IR

[mini_repro.ll](mini_repro.ll)

## Compiling

Using llvm 18.1.8

```
clang -cc1 -emit-obj -triple wasm64-unknown-unknown -Oz -mrelocation-model pic mini_repro.ll -o mini_repro.o
wasm-ld -mwasm64 --shared --no-entry --experimental-pic mini_repro.o -o mini_repro.wasm
llvm-objdump -dr mini_repro.o > mini_repro.llvm-dump
wasm-objdump -h -d -x mini_repro.wasm > mini_repro.wasm-objdump 
```

## LLVM objdump

See [mini_repro.llvm-dump](mini_repro.llvm-dump)

```
0000000000000019:  R_WASM_GLOBAL_INDEX_LEB	__table_base+0
1e: 22 01        	local.tee	1
20: 42 80 80 80 80 80 80 80 80 80 00     	i64.const	0
0000000000000021:  R_WASM_TABLE_INDEX_REL_SLEB64	test_function1+0
2b: 7c           	i64.add 
...
3c: 20 01        	local.get	1
3e: 42 81 80 80 80 80 80 80 80 80 00     	i64.const	1
000000000000003f:  R_WASM_TABLE_INDEX_REL_SLEB64	test_function2+0
49: 7c           	i64.add 
```

## Wasm objdump


See [mini_repro.wasm-objdump](mini_repro.wasm-objdump)

**no elements**

```
 00010e: 23 82 80 80 80 00          | global.get 2 <__table_base>
 000114: 22 01                      | local.tee 1
 000116: 42 80 80 80 80 80 80 80 80 | i64.const 0       <-- INVALID
 00011f: 80 00                      | 
 000121: 7c                         | i64.add
 ...
 000132: 20 01                      | local.get 1
 000134: 42 80 80 80 80 80 80 80 80 | i64.const 0       <-- INVALID
 00013d: 80 00                      | 
 00013f: 7c                         | i64.add
```
