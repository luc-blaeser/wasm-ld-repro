; ModuleID = 'mini_repro'
source_filename = "mini_repro"
target datalayout = "e-m:e-p:64:64-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm64-unknown-unknown"

define dso_local void @bug_repro() unnamed_addr #1 {
start:
  %temp = alloca [8 x i8], align 8
  call void @llvm.lifetime.start.p0(i64 0, ptr nonnull %temp)
  store ptr @test_function1, ptr %temp, align 8
  call void @test_repro(ptr noundef nonnull align 8 %temp)
  store ptr @test_function2, ptr %temp, align 8
  call void @test_repro(ptr noundef nonnull align 8 %temp)
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %temp)
  ret void
}

define dso_local void @test_repro(ptr align 8 dereferenceable(8) %fun_ptr) unnamed_addr #1 {
start:
  call void %fun_ptr()
  ret void
}

define dso_local void @test_function1() unnamed_addr #0 {
start:
  ret void
}

define dso_local void @test_function2() unnamed_addr #0 {
start:
  unreachable
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

attributes #0 = { minsize optsize "target-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
