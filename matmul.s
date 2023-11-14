.text
.align 2
.global matmul
.type matmul, %function

@The size of each matrix is stored in the stack frame, and the base addresses of A, B, and C are stored in the stack frame as well.

@The matrix_a_loop iterates over the rows of matrix A. The matrix_b_colums loop iterates over the columns of matrix B. The row_iterator loop iterates over the rows of matrix B and the columns of matrix A.
@The multiplication of A[x][y] and B[y][z] is done by first loading A[x][y] into r3 and B[y][z] into r4. These values are then multiplied and stored in r7. The result is added to C[x][z] and stored back into C[x][z].
@The loop increments are done by adding 1 to the current value of the counter. This is done by adding 1 to the counter register and branching back to the beginning of the loop.


matmul:
    stmfd sp!, {r0-r12, lr}
    mov r8, #0  @ Initialize x to 0

matrix_a_loop:
    ldr r4, [sp, #0]  @ Load the value of n
    cmp r8, r4  @ Compare x with n
    bge end_matrix_a_loop
    mov r9, #0  @ Initialize z to 0

matrix_b_colums:
    ldr r5, [sp, #56]  @ Load the value of m
    cmp r9, r5  @ Compare z with m
    bge end_matrix_b_colums
    mov r10, #0  @ Initialize y to 0

row_iterator:
    ldr r3, [sp, #12]  @ Load the value of p
    cmp r10, r3  @ Compare y with p
    bge end_row_iterator

    @ Calculate the index for A[x][y]
    mul r6, r8, r3
    add r6, r6, r10
    ldr r1, [sp, #8]  @ Load the address of A
    ldr r3, [r1, r6, LSL #2]  @ Load the value of A[x][y]

    @ Calculate the index for B[y][z]
    mul r6, r10, r5
    add r6, r6, r9
    ldr r2, [sp, #60]  @ Load the address of B
    ldr r4, [r2, r6, LSL #2]  @ Load the value of B[y][z]

    mul r7, r3, r4  @ Multiply A[x][y] and B[y][z]

    @ Calculate the index for C[x][z]
    mul r6, r8, r5
    add r6, r6, r9
    ldr r1, [sp, #64]  @ Load the address of C
    ldr r2, [r1, r6, LSL #2]  @ Load the value of C[x][z]
    add r3, r7, r2  @ Add the product to C[x][z]
    str r3, [r1, r6, LSL #2]  @ Store the result in C[x][z]

    add r10, r10, #1  @ Increment y
    b row_iterator  @ Repeat the y loop

end_row_iterator:
    add r9, r9, #1  @ Increment the row iterator (z)
    b matrix_b_colums  @ Go back to iterating over the columns of matrix B

end_matrix_b_colums:
    add r8, r8, #1  @ Increment the column iterator (x)
    b matrix_a_loop  @ Go back to iterating over the rows of matrix A

end_matrix_a_loop:
    ldmfd sp!, {r0-r12, lr}  @ Restore the registers from the stack
    bx lr  @ Return from the function
