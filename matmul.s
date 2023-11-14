.text
.align 2
.global matmul
.type matmul, %function

matmul:
    stmfd sp!, {r0-r12, lr}
    mov r8, #0

while_i:
    ldr r4, [sp, #0] @ r4 = n
    cmp r8, r4
    bge end_while_i
    mov r9, #0

while_j:
    ldr r5, [sp, #56] @ r5 = m
    cmp r9, r5
    bge end_while_j
    mov r10, #0

while_k:
    ldr r3, [sp, #12] @ r3 = p
    cmp r10, r3
    bge end_while_k

    mul r6, r8, r3
    add r6, r6, r10
    ldr r1, [sp, #8] @ r1 = A
    ldr r3, [r1, r6, LSL #2] @ r3 = A[i][k]

    mul r6, r10, r5
    add r6, r6, r9
    ldr r2, [sp, #60] @ r2 = B
    ldr r4, [r2, r6, LSL #2] @ r4 = B[k][j]

    mul r7, r3, r4 @ r7 = A[i][k] * B[k][j]

    mul r6, r8, r5
    add r6, r6, r9
    ldr r1, [sp, #64] @ r1 = C
    ldr r2, [r1, r6, LSL #2] @ r2 = C[i][j]
    add r3, r7, r2
    str r3, [r1, r6, LSL #2] @ C[i][j] = C[i][j] + A[i][k] * B[k][j]

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
