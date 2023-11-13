.text
.align 2
.global matmul
.type matmul, %function

@ str r1, [r5, #0] ---- stores r1 into *r5[0]

@ int matmul(int h1, int w1, int *m1, int h2, int w2, int *m2, int *m3);
matmul:
  stmfd sp!, {r0-r12, lr}
@ sp -> r0, r1, r2, r3, r4, r5 ,r6 ,r7, r8, r9, r10, r11, r12, lr

