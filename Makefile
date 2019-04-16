%.ll: %.c
	clang -S -emit-llvm $<
%.s: %.ll
	clang -O3 -S -emit-asm $<
%: %.ll
	clang -O3 -o $@ $<
%-opt.ll: %.ll
	opt -S -O3 $< -o $@
