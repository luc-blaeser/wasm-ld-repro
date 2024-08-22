# wasm-ld-repro

[mini_repro.ll](mini_repro.ll)

## Compiling

Using llvm 18.1.8

```
clang -cc1 -emit-obj -triple wasm64-unknown-unknown -mrelocation-model pic mini_repro.ll -o mini_repro.o
wasm-ld -mwasm64 --shared --no-entry --experimental-pic mini_repro.o -o mini_repro.wasm
llvm-objdump -dr mini_repro.o > mini_repro.llvm-dump
wasm-objdump -h -d -x mini_repro.wasm > mini_repro.wasm-objdump 
```

## LLVM objdump

See [mini_repro.llvm-dump](mini_repro.llvm-dump)

```
0000000000000001 <bug_repro>:
        .local i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64
      ...
      21: 42 80 80 80 80 80 80 80 80 80 00     	i64.const	0
		0000000000000022:  R_WASM_TABLE_INDEX_REL_SLEB64	test_function1+0
      2c: 21 03        	local.set	3
      ...
      57: 42 81 80 80 80 80 80 80 80 80 00     	i64.const	1
		0000000000000058:  R_WASM_TABLE_INDEX_REL_SLEB64	test_function2+0
      62: 21 08        	local.set	8
```

## Wasm objdump

See [mini_repro.wasm-objdump](mini_repro.wasm-objdump)

**no elements**

```
00011b func[2] <bug_repro>:
 ...
 000139: 42 80 80 80 80 80 80 80 80 | i64.const 0   <-- WRONG INDEX
 000142: 80 00                      | 
 000144: 21 03                      | local.set 3
 000146: 23 82 80 80 80 00          | global.get 2 <__table_base>
 00014c: 21 04                      | local.set 4
 00014e: 20 04                      | local.get 4
 000150: 20 03                      | local.get 3
 000152: 7c                         | i64.add
 ...
 00016f: 42 80 80 80 80 80 80 80 80 | i64.const 0   <-- WRONG INDEX
 000178: 80 00                      | 
 00017a: 21 08                      | local.set 8
 00017c: 20 04                      | local.get 4
 00017e: 20 08                      | local.get 8
 000180: 7c                         | i64.add
```
