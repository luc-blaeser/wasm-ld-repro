; ModuleID = 'wasm_ld_repro.317496badac99295-cgu.0'
source_filename = "wasm_ld_repro.317496badac99295-cgu.0"
target datalayout = "e-m:e-p:64:64-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm64-unknown-unknown"

@alloc_00ae4b301f7fab8ac9617c03fcbd7274 = private unnamed_addr constant <{ [43 x i8] }> <{ [43 x i8] c"called `Result::unwrap()` on an `Err` value" }>, align 1
@vtable.0 = private unnamed_addr constant <{ ptr, [16 x i8], ptr }> <{ ptr @"_ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17h724ca4a6ca415d55E", [16 x i8] c"\00\00\00\00\00\00\00\00\01\00\00\00\00\00\00\00", ptr @"_ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h64199e53e78c0bceE" }>, align 8
@alloc_99ac8a81a24cac863217ce4a5cbfabea = private unnamed_addr constant <{ [5 x i8] }> <{ [5 x i8] c"Error" }>, align 1
@vtable.1 = private unnamed_addr constant <{ ptr, [16 x i8], ptr, ptr, ptr }> <{ ptr @"_ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17h724ca4a6ca415d55E", [16 x i8] c"\00\00\00\00\00\00\00\00\01\00\00\00\00\00\00\00", ptr @"_ZN65_$LT$wasm_ld_repro..TestFormatter$u20$as$u20$core..fmt..Write$GT$9write_str17h77802b90e1389266E", ptr @_ZN4core3fmt5Write10write_char17h77bc1ba33aad0a7bE, ptr @_ZN4core3fmt5Write9write_fmt17hb553bb9f083ce319E }>, align 8
@alloc_b99730e73100e73a81f4fbfe74b3821d = private unnamed_addr constant <{ ptr, [8 x i8] }> <{ ptr inttoptr (i64 1 to ptr), [8 x i8] zeroinitializer }>, align 8
@alloc_53973d2fe29b4adba8bb7390b5678745 = private unnamed_addr constant <{ [8 x i8] }> zeroinitializer, align 8
@alloc_f5ffd2fd1476bab43ad89fb40c72d0c5 = private unnamed_addr constant <{ [10 x i8] }> <{ [10 x i8] c"src/lib.rs" }>, align 1
@alloc_b2c36ecd0b2ba566916e7faeaae9daa3 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_f5ffd2fd1476bab43ad89fb40c72d0c5, [16 x i8] c"\0A\00\00\00\00\00\00\00\0E\00\00\002\00\00\00" }>, align 8

; core::fmt::Write::write_char
; Function Attrs: minsize mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define internal noundef zeroext i1 @_ZN4core3fmt5Write10write_char17h77bc1ba33aad0a7bE(ptr noalias nocapture nonnull readnone align 1 %self, i32 %c) unnamed_addr #0 {
start:
  ret i1 false
}

; core::fmt::Write::write_fmt
; Function Attrs: minsize nounwind optsize
define internal noundef zeroext i1 @_ZN4core3fmt5Write9write_fmt17hb553bb9f083ce319E(ptr noalias noundef nonnull align 1 %self, ptr noalias nocapture noundef readonly align 8 dereferenceable(48) %args) unnamed_addr #1 {
start:
; call core::fmt::write
  %0 = tail call noundef zeroext i1 @_ZN4core3fmt5write17h226782e17bac321dE(ptr noundef nonnull align 1 %self, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @vtable.1, ptr noalias nocapture noundef nonnull readonly align 8 dereferenceable(48) %args) #7
  ret i1 %0
}

; core::ptr::drop_in_place<core::fmt::Error>
; Function Attrs: inlinehint minsize mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define internal void @"_ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17h724ca4a6ca415d55E"(ptr noalias nocapture nonnull readnone align 1 %_1) unnamed_addr #2 {
start:
  ret void
}

; <core::fmt::Error as core::fmt::Debug>::fmt
; Function Attrs: inlinehint minsize nounwind optsize
define internal noundef zeroext i1 @"_ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h64199e53e78c0bceE"(ptr noalias nocapture nonnull readonly align 1 %self, ptr noalias noundef align 8 dereferenceable(64) %f) unnamed_addr #3 {
start:
; call core::fmt::Formatter::write_str
  %_0 = tail call noundef zeroext i1 @_ZN4core3fmt9Formatter9write_str17hc22d74c16e1de03eE(ptr noalias noundef nonnull align 8 dereferenceable(64) %f, ptr noalias noundef nonnull readonly align 1 @alloc_99ac8a81a24cac863217ce4a5cbfabea, i64 noundef 5) #7
  ret i1 %_0
}

; Function Attrs: minsize nofree norecurse noreturn nosync nounwind optsize memory(none)
define hidden void @rust_begin_unwind(ptr noalias nocapture noundef readonly align 8 dereferenceable(40) %_info) unnamed_addr #4 {
start:
  br label %bb1

bb1:                                              ; preds = %bb1, %start
  br label %bb1
}

; Function Attrs: minsize nounwind optsize
define dso_local void @bug_repro() unnamed_addr #1 {
start:
  %e.i = alloca [0 x i8], align 1
  %_9 = alloca [16 x i8], align 8
  %_5 = alloca [48 x i8], align 8
  call void @llvm.lifetime.start.p0(i64 48, ptr nonnull %_5)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %_9)
  store ptr @alloc_53973d2fe29b4adba8bb7390b5678745, ptr %_9, align 8
  %_10.sroa.4.0._9.sroa_idx = getelementptr inbounds i8, ptr %_9, i64 8
  store ptr @"_ZN4core3fmt5float52_$LT$impl$u20$core..fmt..Display$u20$for$u20$f64$GT$3fmt17h5ddc206ceda9c53aE", ptr %_10.sroa.4.0._9.sroa_idx, align 8
  store ptr @alloc_b99730e73100e73a81f4fbfe74b3821d, ptr %_5, align 8, !alias.scope !1, !noalias !4
  %0 = getelementptr inbounds i8, ptr %_5, i64 8
  store i64 1, ptr %0, align 8, !alias.scope !1, !noalias !4
  %1 = getelementptr inbounds i8, ptr %_5, i64 32
  store ptr null, ptr %1, align 8, !alias.scope !1, !noalias !4
  %2 = getelementptr inbounds i8, ptr %_5, i64 16
  store ptr %_9, ptr %2, align 8, !alias.scope !1, !noalias !4
  %3 = getelementptr inbounds i8, ptr %_5, i64 24
  store i64 1, ptr %3, align 8, !alias.scope !1, !noalias !4
; call core::fmt::Write::write_fmt
  %_3 = call noundef zeroext i1 @_ZN4core3fmt5Write9write_fmt17hb553bb9f083ce319E(ptr noalias noundef nonnull align 1 %e.i, ptr noalias nocapture noundef nonnull align 8 dereferenceable(48) %_5) #7
  call void @llvm.lifetime.end.p0(i64 48, ptr nonnull %_5)
  call void @llvm.lifetime.start.p0(i64 0, ptr nonnull %e.i)
  br i1 %_3, label %bb2.i, label %"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17ha032e569bcb17555E.exit"

bb2.i:                                            ; preds = %start
; call core::result::unwrap_failed
  call void @_ZN4core6result13unwrap_failed17h2409a90f1a5cbc71E(ptr noalias noundef nonnull readonly align 1 @alloc_00ae4b301f7fab8ac9617c03fcbd7274, i64 noundef 43, ptr noundef nonnull align 1 %e.i, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @vtable.0, ptr noalias noundef nonnull readonly align 8 dereferenceable(24) @alloc_b2c36ecd0b2ba566916e7faeaae9daa3) #8
  unreachable

"_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17ha032e569bcb17555E.exit": ; preds = %start
  call void @llvm.lifetime.end.p0(i64 0, ptr nonnull %e.i)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %_9)
  ret void
}

; <wasm_ld_repro::TestFormatter as core::fmt::Write>::write_str
; Function Attrs: minsize mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define internal noundef zeroext i1 @"_ZN65_$LT$wasm_ld_repro..TestFormatter$u20$as$u20$core..fmt..Write$GT$9write_str17h77802b90e1389266E"(ptr noalias nocapture nonnull readnone align 1 %self, ptr noalias nocapture nonnull readonly align 1 %_s.0, i64 %_s.1) unnamed_addr #0 {
start:
  ret i1 false
}

; core::fmt::float::<impl core::fmt::Display for f64>::fmt
; Function Attrs: minsize nounwind optsize
declare dso_local noundef zeroext i1 @"_ZN4core3fmt5float52_$LT$impl$u20$core..fmt..Display$u20$for$u20$f64$GT$3fmt17h5ddc206ceda9c53aE"(ptr noalias noundef readonly align 8 dereferenceable(8), ptr noalias noundef align 8 dereferenceable(64)) unnamed_addr #1

; core::result::unwrap_failed
; Function Attrs: cold minsize noinline noreturn nounwind optsize
declare dso_local void @_ZN4core6result13unwrap_failed17h2409a90f1a5cbc71E(ptr noalias noundef nonnull readonly align 1, i64 noundef, ptr noundef nonnull align 1, ptr noalias noundef readonly align 8 dereferenceable(24), ptr noalias noundef readonly align 8 dereferenceable(24)) unnamed_addr #5

; core::fmt::Formatter::write_str
; Function Attrs: minsize nounwind optsize
declare dso_local noundef zeroext i1 @_ZN4core3fmt9Formatter9write_str17hc22d74c16e1de03eE(ptr noalias noundef align 8 dereferenceable(64), ptr noalias noundef nonnull readonly align 1, i64 noundef) unnamed_addr #1

; core::fmt::write
; Function Attrs: minsize nounwind optsize
declare dso_local noundef zeroext i1 @_ZN4core3fmt5write17h226782e17bac321dE(ptr noundef nonnull align 1, ptr noalias noundef readonly align 8 dereferenceable(24), ptr noalias nocapture noundef readonly align 8 dereferenceable(48)) unnamed_addr #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #6

attributes #0 = { minsize mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) "target-cpu"="generic" "target-features"="+bulk-memory,+mutable-globals,+sign-ext,+nontrapping-fptoint" }
attributes #1 = { minsize nounwind optsize "target-cpu"="generic" "target-features"="+bulk-memory,+mutable-globals,+sign-ext,+nontrapping-fptoint" }
attributes #2 = { inlinehint minsize mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) "target-cpu"="generic" "target-features"="+bulk-memory,+mutable-globals,+sign-ext,+nontrapping-fptoint" }
attributes #3 = { inlinehint minsize nounwind optsize "target-cpu"="generic" "target-features"="+bulk-memory,+mutable-globals,+sign-ext,+nontrapping-fptoint" }
attributes #4 = { minsize nofree norecurse noreturn nosync nounwind optsize memory(none) "target-cpu"="generic" "target-features"="+bulk-memory,+mutable-globals,+sign-ext,+nontrapping-fptoint" }
attributes #5 = { cold minsize noinline noreturn nounwind optsize "target-cpu"="generic" "target-features"="+bulk-memory,+mutable-globals,+sign-ext,+nontrapping-fptoint" }
attributes #6 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #7 = { nounwind }
attributes #8 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = !{!"rustc version 1.80.0-nightly (1871252fc 2024-05-15)"}
!1 = !{!2}
!2 = distinct !{!2, !3, !"_ZN4core3fmt9Arguments6new_v117h794cf0e2d1584f0eE: %_0"}
!3 = distinct !{!3, !"_ZN4core3fmt9Arguments6new_v117h794cf0e2d1584f0eE"}
!4 = !{!5, !6}
!5 = distinct !{!5, !3, !"_ZN4core3fmt9Arguments6new_v117h794cf0e2d1584f0eE: %pieces.0"}
!6 = distinct !{!6, !3, !"_ZN4core3fmt9Arguments6new_v117h794cf0e2d1584f0eE: %args.0"}
