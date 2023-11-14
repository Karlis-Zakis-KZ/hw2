.text
.align 2
.global matmul
.type matmul, %function

matmul:
    stmfd sp!, {r0-r12, lr}        // push registers to stack
    mov r8, #0                      // i = 0

while_i:
    ldr r4, [sp, #0]                // load rows into r4
    cmp r8, r4                      // compare i with rows
    bge end_while_i                 // if i >= rows, exit loop
    mov r9, #0                      // j = 0

while_j:
    ldr r5, [sp, #56]               // load cols into r5
    cmp r9, r5                      // compare j with cols
    bge end_while_j                 // if j >= cols, exit loop
    mov r10, #0                     // k = 0

while_k:
    ldr r3, [sp, #12]               // load kmax into r3
    cmp r10, r3                     // compare k with kmax
    bge end_while_k                 // if k >= kmax, exit loop

    mul r6, r8, r3                  // i * kmax
    add r6, r6, r10                 // i * kmax + k
    ldr r1, [sp, #8]                // load A into r1
    ldr r3, [r1, r6, LSL #2]        // load A[i][k] into r3

    mul r6, r10, r5                 // k * cols
    add r6, r6, r9                  // k * cols + j
    ldr r2, [sp, #60]               // load B into r2
    ldr r4, [r2, r6, LSL #2]        // load B[k][j] into r4

    mul r7, r3, r4                  // A[i][k] * B[k][j]

    mul r6, r8, r5                  // i * cols
    add r6, r6, r9                  // i * cols + j
    ldr r1, [sp, #64]               // load C into r1
    ldr r2, [r1, r6, LSL #2]        // load C[i][j] into r2
    add r3, r7, r2                  // A[i][k] * B[k][j] + C[i][j]
