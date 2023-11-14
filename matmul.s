.text
.align 2
.global matmul
.type matmul, %function

matmul:
    stmfd sp!, {r4-r11, lr}  @ Save registers to the stack

    mov r4, r0  @ h1
    mov r5, r1  @ w1
    mov r6, r2  @ *m1
    mov r7, r3  @ h2
    mov r8, r4  @ w2
    mov r9, r5  @ *m2
    mov r10, r6  @ *m3

    mov r0, #0
loop_i:
    mov r1, #0
loop_j:
    mov r2, #0
    mov r3, #0
loop_k:
    ldr r11, [r6, r3, lsl #2]
    ldr lr, [r9, r2, lsl #2]
    mul r11, r11, lr
    ldr lr, [r10, r1, lsl #2]
    add lr, lr, r11
    str lr, [r10, r1, lsl #2]
    add r2, r2, #1
    add r3, r3, #1
    cmp r3, r5
    blt loop_k
    add r1, r1, #1
    add r9, r9, #4
    cmp r1, r8
    blt loop_j
    add r0, r0, #1
    add r6, r6, #4
    cmp r0, r4
    blt loop_i

    ldmfd sp!, {r4-r11, pc}  @ Restore registers from the stack
