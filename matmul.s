.text
.align 2
.global matmul
.type matmul, %function

matmul:
    stmfd sp!, {r4-r12, lr}   @ Save registers and LR on the stack

    mov r4, #0                 @ Initialize loop indices

    ldr r1, [sp, #0]           @ Load matrix A dimensions
    ldr r2, [sp, #4]           @ Load matrix B dimensions
    ldr r3, [sp, #8]           @ Load result matrix dimensions

    mov r5, r1, LSL #2         @ Calculate total size of matrix A
    mov r6, r2, LSL #2         @ Calculate total size of matrix B
    mov r7, r3, LSL #2         @ Calculate total size of result matrix

    cmp r5, #0                 @ Check if any matrix dimension is 0
    beq end_matmul

    cmp r6, #0
    beq end_matmul

    cmp r7, #0
    beq end_matmul

    mov r8, #0                  @ r8 will store the current index in result matrix

    mov r9, #0                  @ Initialize i loop index to 0
outer_loop:
    cmp r9, r1                  @ Compare i with rows of matrix A
    bge end_outer_loop          @ Break if i >= rows_A

    mov r10, #0                 @ Initialize j loop index to 0
middle_loop:
    cmp r10, r2                 @ Compare j with cols of matrix B
    bge end_middle_loop         @ Break if j >= cols_B

    mov r11, #0                 @ Initialize k loop index to 0
    mov r12, #0                 @ r12 will store the current index in matrix A and B
inner_loop:
    cmp r11, r3                 @ Compare k with cols_A/rows_B
    bge end_inner_loop          @ Break if k >= cols_A/rows_B

    mul r12, r9, r1             @ Calculate index for element in matrix A
    add r12, r12, r11           @ r12 holds the index for matrix A

    mul r4, r10, r2             @ Calculate index for element in matrix B
    add r4, r4, r11             @ r4 holds the index for matrix B

    ldr r5, [sp, #12]           @ Load base address of matrix A
    ldr r6, [sp, #16]           @ Load base address of matrix B
    ldr r7, [sp, #20]           @ Load base address of result matrix

    ldr r5, [r5, r12, LSL #2]  @ Load element from matrix A
    ldr r6, [r6, r4, LSL #2]   @ Load element from matrix B

    mul r5, r5, r6              @ Multiply corresponding elements

    ldr r6, [r7, r8, LSL #2]   @ Load element from result matrix
    add r5, r5, r6              @ Add product to existing value in result matrix
    str r5, [r7, r8, LSL #2]   @ Store the updated value in result matrix

    add r8, r8, #1              @ Increment result matrix index
    add r11, r11, #1            @ Increment k
    b inner_loop

end_inner_loop:
    add r10, r10, #1            @ Increment j
    b middle_loop

end_middle_loop:
    add r9, r9, #1              @ Increment i
    b outer_loop

end_outer_loop:
    ldmfd sp!, {r4-r12, lr}     @ Restore registers and LR from the stack
    bx lr                        @ Return from the function

end_matmul:
    ldmfd sp!, {r4-r12, lr}     @ Restore registers and LR from the stack
    bx lr                        @ Return from the function
