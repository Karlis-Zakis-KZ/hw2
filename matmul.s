.text
.align 2
.global matmul
.type matmul, %function

matmul:
    stmfd sp!, {r0-r12, lr}  // Save registers to the stack

    mov r5, #0  // Initialize i

i_loop:
    ldr r3, [sp, #0]  // Load matrix1 row count
    cmp r5, r3  // Compare i with matrix1 row count
    bge end_i_loop  // If i >= matrix1 row count, exit i loop

    mov r6, #0  // Initialize j

j_loop:
    ldr r4, [sp, #56]  // Load matrix2 column count
    cmp r6, r4  // Compare j with matrix2 column count
    bge end_j_loop  // If j >= matrix2 column count, exit j loop

    mov r7, #0  // Initialize k

k_loop:
    ldr r2, [sp, #12]  // Load matrix1 column count (or matrix2 row count)
    cmp r7, r2  // Compare k with matrix1 column count
    bge end_k_loop  // If k >= matrix1 column count, exit k loop

    // Calculate the offset for matrix1[i][k] and load the value
    mov r10, r5, LSL #2
    mul r8, r10, r2
    mov r9, r7, LSL #2
    add r8, r8, r9
    ldr r0, [sp, #8]
    ldr r2, [r0, r8]

    // Calculate the offset for matrix2[k][j] and load the value
    mul r8, r9, r4
    mov r10, r6, LSL #2
    add r8, r8, r10
    ldr r1, [sp, #60]
    ldr r3, [r1, r8]

    // Multiply matrix1[i][k] and matrix2[k][j]
    mul r11, r2, r3

    // Calculate the offset for result[i][j], load the value, add the multiplication result, and store the new value
    ldr r0, [sp, #64]
    mov r10, r5, LSL #2
    mul r8, r10, r4
    mov r12, r6, LSL #2
    add r8, r8, r12
    ldr r1, [r0, r8]
    add r2, r11, r1
    str r2, [r0, r8]

    add r7, r7, #1  // Increment k
    cmp r7, r2
    blt k_loop  // Repeat k loop

end_k_loop:
    add r6, r6, #1  // Increment j
    cmp r6, r4
    blt j_loop  // Repeat j loop

end_j_loop:
    add r5, r5, #1  // Increment i
    cmp r5, r3
    blt i_loop  // Repeat i loop

end_i_loop:
    ldmfd sp!, {r0-r12, lr}  // Restore registers from the stack
    bx lr  // Return from function
