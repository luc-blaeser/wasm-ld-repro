#!/usr/bin/env bash

clang -cc1 -emit-obj -triple wasm64-unknown-unknown -Oz -mrelocation-model pic mini_repro.ll -o mini_repro.o
wasm-ld -mwasm64 --shared --no-entry --experimental-pic mini_repro.o -o mini_repro.wasm
llvm-objdump -dr mini_repro.o > mini_repro.llvm-dump
wasm-objdump -h -d -x mini_repro.wasm > mini_repro.wasm-objdump 
