.text
.align 2
.global matmul_optimized
.type matmul_optimized, %function

matmul_optimized:
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

    vldr d0, [r2]!     @ Load C[i][j] to a NEON register
    add r2, r2, #8     @ Move to the next C element

for_k:
    cmp r3, r5         @ Compare k with columns of A
    bge end_for_k

    vldr d1, [r0, r3, LSL #2]  @ Load A[i][k] to a NEON register
    vldr d2, [r1, r3, LSL #3]  @ Load B[k][j] to a NEON register
    vmla.f32 d0, d1, d2        @ Vector matrix multiplication and accumulation

    add r3, r3, #2     @ Move to the next pair of elements in A and B

    b for_k

end_for_k:
    vstr d0, [r10]!    @ Store the result C[i][j]
    add r10, r10, #8   @ Move to the next element in C

    add r1, r1, #1     @ Move to the next column in B
    b for_j

end_for_j:
    add r0, r0, #4     @ Move to the next row in A
    b for_i

end_for_i:
    ldmfd sp!, {r4-r11, lr}
    bx lr
