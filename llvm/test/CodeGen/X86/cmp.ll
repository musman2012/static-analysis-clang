; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -show-mc-encoding | FileCheck %s

@d = global i8 0, align 1

define i32 @test1(i32 %X, i32* %y) nounwind {
; CHECK-LABEL: test1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpl $0, (%rsi) # encoding: [0x83,0x3e,0x00]
; CHECK-NEXT:    je .LBB0_2 # encoding: [0x74,A]
; CHECK-NEXT:    # fixup A - offset: 1, value: .LBB0_2-1, kind: FK_PCRel_1
; CHECK-NEXT:  # %bb.1: # %cond_true
; CHECK-NEXT:    movl $1, %eax # encoding: [0xb8,0x01,0x00,0x00,0x00]
; CHECK-NEXT:    retq # encoding: [0xc3]
; CHECK-NEXT:  .LBB0_2: # %ReturnBlock
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %tmp = load i32, i32* %y
  %tmp.upgrd.1 = icmp eq i32 %tmp, 0
  br i1 %tmp.upgrd.1, label %ReturnBlock, label %cond_true

cond_true:
  ret i32 1

ReturnBlock:
  ret i32 0
}

define i32 @test2(i32 %X, i32* %y) nounwind {
; CHECK-LABEL: test2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testl $536870911, (%rsi) # encoding: [0xf7,0x06,0xff,0xff,0xff,0x1f]
; CHECK-NEXT:    # imm = 0x1FFFFFFF
; CHECK-NEXT:    je .LBB1_2 # encoding: [0x74,A]
; CHECK-NEXT:    # fixup A - offset: 1, value: .LBB1_2-1, kind: FK_PCRel_1
; CHECK-NEXT:  # %bb.1: # %cond_true
; CHECK-NEXT:    movl $1, %eax # encoding: [0xb8,0x01,0x00,0x00,0x00]
; CHECK-NEXT:    retq # encoding: [0xc3]
; CHECK-NEXT:  .LBB1_2: # %ReturnBlock
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %tmp = load i32, i32* %y
  %tmp1 = shl i32 %tmp, 3
  %tmp1.upgrd.2 = icmp eq i32 %tmp1, 0
  br i1 %tmp1.upgrd.2, label %ReturnBlock, label %cond_true

cond_true:
  ret i32 1

ReturnBlock:
  ret i32 0
}

define i8 @test2b(i8 %X, i8* %y) nounwind {
; CHECK-LABEL: test2b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testb $31, (%rsi) # encoding: [0xf6,0x06,0x1f]
; CHECK-NEXT:    je .LBB2_2 # encoding: [0x74,A]
; CHECK-NEXT:    # fixup A - offset: 1, value: .LBB2_2-1, kind: FK_PCRel_1
; CHECK-NEXT:  # %bb.1: # %cond_true
; CHECK-NEXT:    movb $1, %al # encoding: [0xb0,0x01]
; CHECK-NEXT:    retq # encoding: [0xc3]
; CHECK-NEXT:  .LBB2_2: # %ReturnBlock
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %tmp = load i8, i8* %y
  %tmp1 = shl i8 %tmp, 3
  %tmp1.upgrd.2 = icmp eq i8 %tmp1, 0
  br i1 %tmp1.upgrd.2, label %ReturnBlock, label %cond_true

cond_true:
  ret i8 1

ReturnBlock:
  ret i8 0
}

define i64 @test3(i64 %x) nounwind {
; CHECK-LABEL: test3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    testq %rdi, %rdi # encoding: [0x48,0x85,0xff]
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t = icmp eq i64 %x, 0
  %r = zext i1 %t to i64
  ret i64 %r
}

define i64 @test4(i64 %x) nounwind {
; CHECK-LABEL: test4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    testq %rdi, %rdi # encoding: [0x48,0x85,0xff]
; CHECK-NEXT:    setle %al # encoding: [0x0f,0x9e,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %t = icmp slt i64 %x, 1
  %r = zext i1 %t to i64
  ret i64 %r
}

define i32 @test5(double %A) nounwind {
; CHECK-LABEL: test5:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    ucomisd {{.*}}(%rip), %xmm0 # encoding: [0x66,0x0f,0x2e,0x05,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 4, value: {{\.LCPI.*}}-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    ja .LBB5_3 # encoding: [0x77,A]
; CHECK-NEXT:    # fixup A - offset: 1, value: .LBB5_3-1, kind: FK_PCRel_1
; CHECK-NEXT:  # %bb.1: # %entry
; CHECK-NEXT:    ucomisd {{.*}}(%rip), %xmm0 # encoding: [0x66,0x0f,0x2e,0x05,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 4, value: {{\.LCPI.*}}-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    jb .LBB5_3 # encoding: [0x72,A]
; CHECK-NEXT:    # fixup A - offset: 1, value: .LBB5_3-1, kind: FK_PCRel_1
; CHECK-NEXT:  # %bb.2: # %bb12
; CHECK-NEXT:    movl $32, %eax # encoding: [0xb8,0x20,0x00,0x00,0x00]
; CHECK-NEXT:    retq # encoding: [0xc3]
; CHECK-NEXT:  .LBB5_3: # %bb8
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    jmp foo # TAILCALL
; CHECK-NEXT:    # encoding: [0xeb,A]
; CHECK-NEXT:    # fixup A - offset: 1, value: foo-1, kind: FK_PCRel_1
entry:
  %tmp2 = fcmp ogt double %A, 1.500000e+02
  %tmp5 = fcmp ult double %A, 7.500000e+01
  %bothcond = or i1 %tmp2, %tmp5
  br i1 %bothcond, label %bb8, label %bb12

bb8:
  %tmp9 = tail call i32 (...) @foo() nounwind
  ret i32 %tmp9

bb12:
  ret i32 32
}

declare i32 @foo(...)

define i32 @test6() nounwind align 2 {
; CHECK-LABEL: test6:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpq $0, -{{[0-9]+}}(%rsp) # encoding: [0x48,0x83,0x7c,0x24,0xf8,0x00]
; CHECK-NEXT:    je .LBB6_1 # encoding: [0x74,A]
; CHECK-NEXT:    # fixup A - offset: 1, value: .LBB6_1-1, kind: FK_PCRel_1
; CHECK-NEXT:  # %bb.2: # %F
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
; CHECK-NEXT:  .LBB6_1: # %T
; CHECK-NEXT:    movl $1, %eax # encoding: [0xb8,0x01,0x00,0x00,0x00]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %A = alloca { i64, i64 }, align 8
  %B = getelementptr inbounds { i64, i64 }, { i64, i64 }* %A, i64 0, i32 1
  %C = load i64, i64* %B
  %D = icmp eq i64 %C, 0
  br i1 %D, label %T, label %F

T:
  ret i32 1

F:
  ret i32 0
}

define i32 @test7(i64 %res) nounwind {
; CHECK-LABEL: test7:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    shrq $32, %rdi # encoding: [0x48,0xc1,0xef,0x20]
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %lnot = icmp ult i64 %res, 4294967296
  %lnot.ext = zext i1 %lnot to i32
  ret i32 %lnot.ext
}

define i32 @test8(i64 %res) nounwind {
; CHECK-LABEL: test8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    shrq $32, %rdi # encoding: [0x48,0xc1,0xef,0x20]
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    cmpq $3, %rdi # encoding: [0x48,0x83,0xff,0x03]
; CHECK-NEXT:    setb %al # encoding: [0x0f,0x92,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %lnot = icmp ult i64 %res, 12884901888
  %lnot.ext = zext i1 %lnot to i32
  ret i32 %lnot.ext
}

define i32 @test9(i64 %res) nounwind {
; CHECK-LABEL: test9:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    shrq $33, %rdi # encoding: [0x48,0xc1,0xef,0x21]
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %lnot = icmp ult i64 %res, 8589934592
  %lnot.ext = zext i1 %lnot to i32
  ret i32 %lnot.ext
}

define i32 @test10(i64 %res) nounwind {
; CHECK-LABEL: test10:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    shrq $32, %rdi # encoding: [0x48,0xc1,0xef,0x20]
; CHECK-NEXT:    setne %al # encoding: [0x0f,0x95,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %lnot = icmp uge i64 %res, 4294967296
  %lnot.ext = zext i1 %lnot to i32
  ret i32 %lnot.ext
}

define i32 @test11(i64 %l) nounwind {
; CHECK-LABEL: test11:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    shrq $47, %rdi # encoding: [0x48,0xc1,0xef,0x2f]
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    cmpq $1, %rdi # encoding: [0x48,0x83,0xff,0x01]
; CHECK-NEXT:    sete %al # encoding: [0x0f,0x94,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %shr.mask = and i64 %l, -140737488355328
  %cmp = icmp eq i64 %shr.mask, 140737488355328
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define i32 @test12() ssp uwtable {
; CHECK-LABEL: test12:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rax # encoding: [0x50]
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    callq test12b # encoding: [0xe8,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 1, value: test12b-4, kind: FK_PCRel_4
; CHECK-NEXT:    testb %al, %al # encoding: [0x84,0xc0]
; CHECK-NEXT:    je .LBB12_2 # encoding: [0x74,A]
; CHECK-NEXT:    # fixup A - offset: 1, value: .LBB12_2-1, kind: FK_PCRel_1
; CHECK-NEXT:  # %bb.1: # %T
; CHECK-NEXT:    movl $1, %eax # encoding: [0xb8,0x01,0x00,0x00,0x00]
; CHECK-NEXT:    popq %rcx # encoding: [0x59]
; CHECK-NEXT:    retq # encoding: [0xc3]
; CHECK-NEXT:  .LBB12_2: # %F
; CHECK-NEXT:    movl $2, %eax # encoding: [0xb8,0x02,0x00,0x00,0x00]
; CHECK-NEXT:    popq %rcx # encoding: [0x59]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %tmp1 = call zeroext i1 @test12b()
  br i1 %tmp1, label %T, label %F

T:
  ret i32 1

F:
  ret i32 2
}

declare zeroext i1 @test12b()

define i32 @test13(i32 %mask, i32 %base, i32 %intra) {
; CHECK-LABEL: test13:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testb $8, %dil # encoding: [0x40,0xf6,0xc7,0x08]
; CHECK-NEXT:    cmovnel %edx, %esi # encoding: [0x0f,0x45,0xf2]
; CHECK-NEXT:    movl %esi, %eax # encoding: [0x89,0xf0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %and = and i32 %mask, 8
  %tobool = icmp ne i32 %and, 0
  %cond = select i1 %tobool, i32 %intra, i32 %base
  ret i32 %cond

}

define i32 @test14(i32 %mask, i32 %base, i32 %intra) {
; CHECK-LABEL: test14:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    shrl $7, %edi # encoding: [0xc1,0xef,0x07]
; CHECK-NEXT:    cmovnsl %edx, %esi # encoding: [0x0f,0x49,0xf2]
; CHECK-NEXT:    movl %esi, %eax # encoding: [0x89,0xf0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %s = lshr i32 %mask, 7
  %tobool = icmp sgt i32 %s, -1
  %cond = select i1 %tobool, i32 %intra, i32 %base
  ret i32 %cond

}

; PR19964
define zeroext i1 @test15(i32 %bf.load, i32 %n) {
; CHECK-LABEL: test15:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    shrl $16, %edi # encoding: [0xc1,0xef,0x10]
; CHECK-NEXT:    sete %cl # encoding: [0x0f,0x94,0xc1]
; CHECK-NEXT:    cmpl %esi, %edi # encoding: [0x39,0xf7]
; CHECK-NEXT:    setae %al # encoding: [0x0f,0x93,0xc0]
; CHECK-NEXT:    orb %cl, %al # encoding: [0x08,0xc8]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %bf.lshr = lshr i32 %bf.load, 16
  %cmp2 = icmp eq i32 %bf.lshr, 0
  %cmp5 = icmp uge i32 %bf.lshr, %n
  %.cmp5 = or i1 %cmp2, %cmp5
  ret i1 %.cmp5

}

define i8 @test16(i16 signext %L) {
; CHECK-LABEL: test16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testw %di, %di # encoding: [0x66,0x85,0xff]
; CHECK-NEXT:    setns %al # encoding: [0x0f,0x99,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %lshr = lshr i16 %L, 15
  %trunc = trunc i16 %lshr to i8
  %not = xor i8 %trunc, 1
  ret i8 %not

}

define i8 @test17(i32 %L) {
; CHECK-LABEL: test17:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testl %edi, %edi # encoding: [0x85,0xff]
; CHECK-NEXT:    setns %al # encoding: [0x0f,0x99,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %lshr = lshr i32 %L, 31
  %trunc = trunc i32 %lshr to i8
  %not = xor i8 %trunc, 1
  ret i8 %not

}

define i8 @test18(i64 %L) {
; CHECK-LABEL: test18:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testq %rdi, %rdi # encoding: [0x48,0x85,0xff]
; CHECK-NEXT:    setns %al # encoding: [0x0f,0x99,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %lshr = lshr i64 %L, 63
  %trunc = trunc i64 %lshr to i8
  %not = xor i8 %trunc, 1
  ret i8 %not

}

define zeroext i1 @test19(i32 %L) {
; CHECK-LABEL: test19:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testl %edi, %edi # encoding: [0x85,0xff]
; CHECK-NEXT:    setns %al # encoding: [0x0f,0x99,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %lshr = lshr i32 %L, 31
  %trunc = trunc i32 %lshr to i1
  %not = xor i1 %trunc, true
  ret i1 %not

}

; This test failed due to incorrect handling of "shift + icmp" sequence
define void @test20(i32 %bf.load, i8 %x1, i8* %b_addr) {
; CHECK-LABEL: test20:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    testl $16777215, %edi # encoding: [0xf7,0xc7,0xff,0xff,0xff,0x00]
; CHECK-NEXT:    # imm = 0xFFFFFF
; CHECK-NEXT:    setne %al # encoding: [0x0f,0x95,0xc0]
; CHECK-NEXT:    movzbl %sil, %ecx # encoding: [0x40,0x0f,0xb6,0xce]
; CHECK-NEXT:    addl %eax, %ecx # encoding: [0x01,0xc1]
; CHECK-NEXT:    setne (%rdx) # encoding: [0x0f,0x95,0x02]
; CHECK-NEXT:    testl $16777215, %edi # encoding: [0xf7,0xc7,0xff,0xff,0xff,0x00]
; CHECK-NEXT:    # imm = 0xFFFFFF
; CHECK-NEXT:    setne {{.*}}(%rip) # encoding: [0x0f,0x95,0x05,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 3, value: d-4, kind: reloc_riprel_4byte
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %bf.shl = shl i32 %bf.load, 8
  %bf.ashr = ashr exact i32 %bf.shl, 8
  %tobool4 = icmp ne i32 %bf.ashr, 0
  %conv = zext i1 %tobool4 to i32
  %conv6 = zext i8 %x1 to i32
  %add = add nuw nsw i32 %conv, %conv6
  %tobool7 = icmp ne i32 %add, 0
  %frombool = zext i1 %tobool7 to i8
  store i8 %frombool, i8* %b_addr, align 1
  %tobool14 = icmp ne i32 %bf.shl, 0
  %frombool15 = zext i1 %tobool14 to i8
  store i8 %frombool15, i8* @d, align 1
  ret void

}

define i32 @test21(i64 %val) {
; CHECK-LABEL: test21:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    shrq $41, %rdi # encoding: [0x48,0xc1,0xef,0x29]
; CHECK-NEXT:    setne %al # encoding: [0x0f,0x95,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %and = and i64 %val, -2199023255552
  %cmp = icmp ne i64 %and, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret

}

; AND-to-SHR transformation is enabled for eq/ne condition codes only.
define i32 @test22(i64 %val) {
; CHECK-LABEL: test22:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %and = and i64 %val, -2199023255552
  %cmp = icmp ult i64 %and, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret

}

define i32 @test23(i64 %val) {
; CHECK-LABEL: test23:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    testq $-1048576, %rdi # encoding: [0x48,0xf7,0xc7,0x00,0x00,0xf0,0xff]
; CHECK-NEXT:    # imm = 0xFFF00000
; CHECK-NEXT:    setne %al # encoding: [0x0f,0x95,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %and = and i64 %val, -1048576
  %cmp = icmp ne i64 %and, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret

}

define i32 @test24(i64 %val) {
; CHECK-LABEL: test24:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    shlq $16, %rdi # encoding: [0x48,0xc1,0xe7,0x10]
; CHECK-NEXT:    setne %al # encoding: [0x0f,0x95,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %and = and i64 %val, 281474976710655
  %cmp = icmp ne i64 %and, 0
  %ret = zext i1 %cmp to i32
  ret i32 %ret

}
