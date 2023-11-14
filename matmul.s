.text
.align 2
.global matmul
.type matmul, %function

matmul:
    stmfd sp!, {r0-r12, lr}

    mov r4, #0
    mov r5, #0
    mov r6, #0

for_i:
    ldr r2, [sp, #0]
    cmp r4, r2
    bge end_for_i

    mov r5, #0

for_j:
    ldr r3, [sp, #56]
    cmp r5, r3
    bge end_for_j

    mov r6, #0

for_k:
    ldr r1, [sp, #12]
    cmp r6, r1
    bge end_for_k

    mov r9, r4, LSL #2
    mul r7, r9, r1
    mov r10, r6, LSL #2
    add r7, r7, r10

    ldr r0, [sp, #8]
    ldr r1, [r0, r7]

    mul r7, r10, r3
    mov r9, r5, LSL #2
    add r7, r7, r9
    ldr r0, [sp, #60]
    ldr r2, [r0, r7]

    mul r11, r1, r2

    ldr r0, [sp, #64]
    mov r9, r4, LSL #2
    mul r7, r9, r3
    mov r12, r5, LSL #2
    add r7, r7, r12

    ldr r0, [r0, r7]
    add r1, r11, r0
    str r1, [r0, r7]

    add r6, r6, #1
    b for_k

end_for_k:
    add r5, r5, #1
    b for_j

end_for_j:
    add r4, r4, #1
    b for_i

end_for_i:
    ldmfd sp!, {r0-r12, lr}
    bx lr
