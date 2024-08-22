# Original Issue

Observed in Motoko RTS built with Rust version (nightly 2024-07-27):

See https://github.com/dfinity/motoko/actions/runs/10508760436?pr=4668

In artifacts: `build_output` https://github.com/dfinity/motoko/actions/runs/10508760436/artifacts/1842325524

## LLVM objdump

```
llvm-objdump -dr libmotoko_rts.o
```

```
0000000000005508 <bug_repro>:
        .local i64, i64
    ...
    5579: 23 82 80 80 80 00    	global.get	2
		000000000000557a:  R_WASM_GLOBAL_INDEX_LEB	__table_base+0
    557f: 42 83 80 80 80 80 80 80 80 80 00     	i64.const	3
		0000000000005580:  R_WASM_TABLE_INDEX_REL_SLEB64	_ZN4core3fmt5float52_$LT$impl$u20$core..fmt..Display$u20$for$u20$f64$GT$3fmt17h1d431d6089f0f768E+0
    558a: 7c           	i64.add 
```

## Wasm objdump

```
wasm-objdump -h -d -x mo-rts-eop.wasm
```

```
01dfb6 func[136] <bug_repro>:
 01dfb7: 02 7e                      | local[0..1] type=i64
 ...
 01e025: 23 82 80 80 80 00          | global.get 2 <__table_base>
 01e02b: 42 80 80 80 80 80 80 80 80 | i64.const 0           <-- INVALID ELEMENT INDEX
 01e034: 80 00                      | 
 01e036: 7c                         | i64.add
```

Table
```
Elem[1]:
 - segment[0] flags=0 table=0 count=16 - init global=3 <__table_base32>
  - elem[0] = ref.func:24 <_$LT$core..panic..panic_info..PanicMessage$u20$as$u20$core..fmt..Display$GT$::fmt::hda6a5d31f622e975>
  ...
```

elem[0] does not point to `_ZN4core3fmt5float52_$LT$impl$u20$core..fmt..Display$u20$for$u20$f64$GT$3fmt17h1d431d6089f0f768E+0`
