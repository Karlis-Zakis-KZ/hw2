.text
.align 2
.global matmul
.type matmul, %function

matmul:
    stmfd sp!, {r4-r11, lr}

    ldr r4, [sp, #0]   @ Load dimensions
    ldr r5, [sp, #4]
    ldr r6, [sp, #8]

    mov r0, #0         @ Matrix A address
    mov r1, #0         @ Matrix B address
    mov r2, #0         @ Matrix C address

for_i:
    cmp r0, r4         @ Compare i with rows of A
    bge end_for_i

    mov r1, #0         @ Reset j to 0 for every i iteration
    mov r10, r0, LSL #2 @ Calculate base address for matrix C row

for_j:
    cmp r1, r6         @ Compare j with columns of B
    bge end_for_j

    mov r3, #0         @ Reset k to 0 for every j iteration
    mov r11, r1, LSL #2 @ Calculate base address for matrix B column

    mov r12, #0        @ Initialize the result in C[i][j]

for_k:
    cmp r3, r5         @ Compare k with columns of A
    bge end_for_k

    ldr r7, [r0, r3, LSL #2]  @ Load A[i][k]
    ldr r8, [r1, r3, LSL #2]  @ Load B[k][j]

    mul r9, r7, r8     @ Multiply corresponding elements
    add r12, r12, r9   @ Accumulate the result

    add r3, r3, #1     @ Move to the next element in A and B

    b for_k

end_for_k:
    str r12, [r10]     @ Store the result C[i][j]

    add r10, r10, #4   @ Move to the next element in C
    add r1, r1, #4     @ Move to the next column in B
    b for_j

end_for_j:
    add r0, r0, #4     @ Move to the next row in A
    b for_i

end_for_i:
    ldmfd sp!, {r4-r11, lr}
    bx lr
