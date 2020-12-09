	.file	"hw4.c"
	.text
	.globl	decode2
	.type	decode2, @function
decode2:
.LFB20:
	.cfi_startproc
	subq	%rdx, %rdi
	imulq	%rdi, %rsi
	movq	%rdi, %rax
	salq	$63, %rax
	sarq	$63, %rax
	xorq	%rsi, %rax
	addq	%rdx, %rax
	ret
	.cfi_endproc
.LFE20:
	.size	decode2, .-decode2
	.globl	loop
	.type	loop, @function
loop:
.LFB21:
	.cfi_startproc
	movl	%esi, %ecx
	movl	$1, %edx
	movl	$0, %eax
	jmp	.L3
.L4:
	movq	%rdi, %r8
	andq	%rdx, %r8
	orq	%r8, %rax
	salq	%cl, %rdx
.L3:
	cmpq	%rdi, %rdx
	jne	.L4
	rep ret
	.cfi_endproc
.LFE21:
	.size	loop, .-loop
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-39)"
	.section	.note.GNU-stack,"",@progbits
