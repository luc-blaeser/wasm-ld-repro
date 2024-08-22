CLANG ?= clang-18
WASM_CLANG ?= clang-18
WASM_LD ?= wasm-ld-18

WASM64_RELEASE_FOLDER = target/wasm64-unknown-unknown/release
DEPS_FOLDER = $(WASM64_RELEASE_FOLDER)/deps
BUILD_FOLDER = _build
CLANG = clang -cc1 -triple wasm64-unknown-unknown -emit-obj -Oz \
	-mrelocation-model pic

EXPORTED_SYMBOLS = \
	__wasm_call_ctors \
	__wasm_apply_data_relocs \
	bug_repro

WASM_LD = wasm-ld -mwasm64 --import-memory --shared --no-entry --gc-sections \
	$(EXPORTED_SYMBOLS:%=--export=%) \
	--whole-archive --experimental-pic

all: build

llvmir:
	rm -rf $(WASM64_RELEASE_FOLDER)
	RUSTFLAGS="--emit=llvm-ir" cargo build --target=wasm64-unknown-unknown -Zbuild-std=core --release
	mkdir -p $(BUILD_FOLDER)/partial
	cp $(DEPS_FOLDER)/core-*.ll $(BUILD_FOLDER)/partial/core.ll
	cp $(DEPS_FOLDER)/compiler_builtins-*.ll $(BUILD_FOLDER)/partial/compiler_builtins.ll
	cp $(DEPS_FOLDER)/wasm_ld_repro-*.ll $(BUILD_FOLDER)/partial/wasm_ld_repro.ll
	

build: llvmir
	llvm-link -o $(BUILD_FOLDER)/combined.bc \
		$(BUILD_FOLDER)/partial/core.ll \
		$(BUILD_FOLDER)/partial/compiler_builtins.ll \
		$(BUILD_FOLDER)/partial/wasm_ld_repro.ll
	llvm-dis $(BUILD_FOLDER)/combined.bc
	$(CLANG) -o $(BUILD_FOLDER)/combined.o $(BUILD_FOLDER)/combined.bc
	llvm-objdump -dr $(BUILD_FOLDER)/combined.o > $(BUILD_FOLDER)/combined.llvm-objdump
	$(WASM_LD) -o $(BUILD_FOLDER)/output.wasm $(BUILD_FOLDER)/combined.o
	wasm-objdump -h -d -x -r $(BUILD_FOLDER)/output.wasm > $(BUILD_FOLDER)/output.wasm-objdump

clean:
	rm -rf _build
	rm -rf target
