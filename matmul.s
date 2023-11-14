.text
.align 2
.global matmul
.type matmul, %function

matmul:
    stmfd sp!, {r0-r12, lr}
    mov r8, #0

while_i:
    ldr r4, [sp, #0]
    cmp r8, r4
    bge end_while_i
    mov r9, #0

while_j:
    ldr r5, [sp, #56]
    cmp r9, r5
    bge end_while_j
    mov r10, #0

while_k:
    ldr r3, [sp, #12]
    cmp r10, r3
    bge end_while_k

    mov r11, r8, LSL #2
    mul r6, r11, r3
    mov r12, r10, LSL #2
    add r6, r6, r12

    ldr r1, [sp, #8]
    ldr r3, [r1, r6]

    mul r6, r12, r5
    mov r11, r9, LSL #2
    add r6, r6, r11
    ldr r2, [sp, #60]
    ldr r4, [r2, r6]

    mul r7, r3, r4

    ldr r1, [sp, #64]
    mov r11, r8, LSL #2
    mul r6, r11, r5
    mov r0, r9, LSL #2
    add r6, r6, r0

    ldr r2, [r1, r6]
    add r3, r7, r2
    str r3, [r1, r6]

    add r10, r10, #1
    b while_k

end_while_k:
    add r9, r9, #1
    b while_j

end_while_j:
    add r8, r8, #1
    b while_i

end_while_i:
    ldmfd sp!, {r0-r12, lr}
    bx lr
