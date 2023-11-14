.text
.align 2
.global matmul
.type matmul, %function

matmul:
    stmfd sp!, {r0-r12, lr}   @ Save registers and LR on the stack

    mov r5, #0                 @ Initialize loop indices
    mov r6, #0 
    mov r7, #0 

for_i:
    ldr r3, [sp, #0]          @ Load matrix dimensions
    cmp r5, r3                @ Compare i with the number of rows of matrix A
    bge end_for_i             @ Break if i >= rows_A

    mov r6, #0                @ Reset j loop index to 0

for_j:
    ldr r4, [sp, #56]         @ Load matrix dimension
    cmp r6, r4                @ Compare j with the number of columns of matrix B
    bge end_for_j             @ Break if j >= cols_B

    mov r7, #0                @ Reset k loop index to 0

for_k:
    ldr r2, [sp, #12]         @ Load dimension common to both matrices
    cmp r7, r2                @ Compare k with cols_A/rows_B
    bge end_for_k             @ Break if k >= cols_A/rows_B

    mov r10, r5, LSL #2      @ Calculate index for element in matrix A
    mul r8, r10, r2          
    mov r9, r7, LSL #2       @ Calculate index for element in matrix B
    add r8, r8, r9 

    ldr r0, [sp, #8]         @ Load base addresses of matrices
    ldr r2, [r0, r8]         @ Load element from matrix A

    mul r8, r9, r4           @ Calculate index for element in matrix C
    mov r10, r6, LSL #2      
    add r8, r8, r10 
    ldr r1, [sp, #60]        @ Load base address of result matrix
    ldr r3, [r1, r8]         @ Load element from matrix B

    mul r11, r2, r3          @ Multiply corresponding elements

    ldr r0, [sp, #64]        @ Load base address of result matrix
    mov r10, r5, LSL #2      @ Calculate index for element in matrix C
    mul r8, r10, r4          
    mov r12, r6, LSL #2      
    add r8, r8, r12 

    ldr r1, [r0, r8]         @ Load element from result matrix
    add r2, r11, r1          @ Add product to existing value in result matrix
    str r2, [r0, r8]         @ Store the updated value in result matrix

    add r7, r7, #1           @ Increment k
    b for_k                  

end_for_k:
    add r6, r6, #1           @ Increment j
    b for_j                  

end_for_j:
    add r5, r5, #1           @ Increment i
    b for_i                  

end_for_i:
    ldmfd sp!, {r0-r12, lr}  @ Restore registers and LR from the stack
    bx lr                     @ Return from the function
