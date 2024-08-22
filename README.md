# wasm-ld Bug Repro

Result artifacts in `/_build` produced by `make build`.

The problem is potentially the emission of LLVM IR files by Rust and their separate compilation.

## LLVM IR

File [_build/combined.ll](_build/combined.ll)

containing

```
define dso_local void @bug_repro() unnamed_addr #2 {
start:
  ...
  store ptr @"_ZN4core3fmt5float52_$LT$impl$u20$core..fmt..Display$u20$for$u20$f64$GT$3fmt17h5ddc206ceda9c53aE", ptr %_10.sroa.4.0._9.sroa_idx, align 8
  ...
```


while the function is declared **`dso_local`** (in the same bitcode file!)

```
define dso_local noundef zeroext i1 @"_ZN4core3fmt5float52_$LT$impl$u20$core..fmt..Display$u20$for$u20$f64$GT$3fmt17h5ddc206ceda9c53aE"(ptr noalias nocapture noundef readonly align 8 dereferenceable(8) %self, ptr noalias nocapture noundef align 8 dereferenceable(64) %fmt) unnamed_addr #2 {
```

## LLVM objdump

File [_build/combined.llvm-dump](_build/combined.llvm-dump)

```
0000000000027133 <bug_repro>:
        .local i64, i64
   ...
   27161: 23 82 80 80 80 00    	global.get	2
		0000000000027162:  R_WASM_GLOBAL_INDEX_LEB	__table_base+0
   27167: 42 91 80 80 80 80 80 80 80 80 00     	i64.const	17
		0000000000027168:  R_WASM_TABLE_INDEX_REL_SLEB64	_ZN4core3fmt5float52_$LT$impl$u20$core..fmt..Display$u20$for$u20$f64$GT$3fmt17h5ddc206ceda9c53aE+0
   27172: 7c           	i64.add 
```

## Wasm objdump

File [_build/wasm_ld_repro.wasm-objdump](_build/wasm_ld_repro.wasm-objdump)

```
02be5b func[738] <bug_repro>:
 02be5c: 02 7e                      | local[0..1] type=i64
 ...
 02be87: 23 82 80 80 80 00          | global.get 2 <__table_base>
 02be8d: 42 80 80 80 80 80 80 80 80 | i64.const 0   <-- WRONG INDEX
 02be96: 80 00                      | 
 02be98: 7c                         | i64.add
```

elem[0] is **not** `_ZN4core3fmt5float52_$LT$impl$u20$core..fmt..Display$u20$for$u20$f64$GT$3fmt17h5ddc206ceda9c53aE+0`:

(Note: It looks similar but is different.)

```
Elem[1]:
 - segment[0] flags=0 table=0 count=9 - init global=3 <__table_base32>
  - elem[0] = ref.func:165 <core::fmt::num::_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$::fmt::h4aa9028b5be59dea>
  ...
```
