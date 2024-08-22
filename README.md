# wasm-ld-repro

Result artifacts in `/_build` produced by `make build`.

The problem is potentially the emission of LLVM IR files by Rust and their separate compilation.

## LLVM IR

File [_build/wasm_ld_mini_repro.ll](_build/wasm_ld_mini_repro.ll)

containing

```
; Function Attrs: minsize nounwind optsize
define dso_local void @bug_repro() unnamed_addr #1 {
start:
  ...
  store ptr @"_ZN4core3fmt5float52_$LT$impl$u20$core..fmt..Display$u20$for$u20$f64$GT$3fmt17h5ddc206ceda9c53aE", ptr %_10.sroa.4.0._9.sroa_idx, align 8
  ...
```

while the function is (wrongly?) declared **`dso_local`**

```
declare dso_local noundef zeroext i1 @"_ZN4core3fmt5float52_$LT$impl$u20$core..fmt..Display$u20$for$u20$f64$GT$3fmt17h5ddc206ceda9c53aE"(ptr noalias noundef readonly align 8 dereferenceable(8), ptr noalias noundef align 8 dereferenceable(64)) unnamed_addr #1
```

## LLVM objdump

File [_build/wasm_ld_repro.llvm-dump](_build/wasm_ld_repro.llvm-dump)

```
000000000000004f <bug_repro>:
        .local i64, i64
      ...
      7d: 23 82 80 80 80 00    	global.get	2
		000000000000007e:  R_WASM_GLOBAL_INDEX_LEB	__table_base+0
      83: 42 80 80 80 80 80 80 80 80 80 00     	i64.const	0
		0000000000000084:  R_WASM_TABLE_INDEX_REL_SLEB64	_ZN4core3fmt5float52_$LT$impl$u20$core..fmt..Display$u20$for$u20$f64$GT$3fmt17h5ddc206ceda9c53aE+0
      8e: 7c           	i64.add 
```

## Wasm objdump

File [_build/wasm_ld_repro.wasm-objdump](_build/wasm_ld_repro.wasm-objdump)

```
02fa2a func[749] <bug_repro>:
 02fa2b: 02 7e                      | local[0..1] type=i64
 ...
 02fa56: 23 82 80 80 80 00          | global.get 2 <__table_base>
 02fa5c: 42 80 80 80 80 80 80 80 80 | i64.const 0           <--- INVALID ELEM INDEX
 02fa65: 80 00                      | 
 02fa67: 7c                         | i64.add
```

elem[0] is **not** `_ZN4core3fmt5float52_$LT$impl$u20$core..fmt..Display$u20$for$u20$f64$GT$3fmt17h5ddc206ceda9c53aE+0`:

```
Elem[1]:
 - segment[0] flags=0 table=0 count=13 - init global=3 <__table_base32>
  - elem[0] = ref.func:120 <core::fmt::num::_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$::fmt::h4aa9028b5be59dea>
  ...
```
