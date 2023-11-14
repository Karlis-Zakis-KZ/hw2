.text
.align 2
.global matmul
.type matmul, %function

matmul:
    stmfd sp!, {r4-r11, lr} @ Save registers

    ldr r3, [sp, #4]  @ Load dimensions
    ldr r4, [sp, #8]
    ldr r5, [sp, #12]
    lsl r6, r3, #2    @ Calculate size of each row in bytes

    mov r7, #0  @ Initialize loop variables
    mov r8, #0
    mov r9, #0

outer_loop:  @ Loop for rows
    cmp r7, r3  @ Check if the row index reached the end
    bge end_outer_loop

    mov r8, #0  @ Reset column index for inner loop

    inner_loop:  @ Loop for columns
    cmp r8, r4  @ Check if the column index reached the end
    bge end_inner_loop

    mov r10, #0  @ Reset accumulator for the element at [r7][r8]

    innermost_loop:  @ Loop for innermost computation
    cmp r9, r5  @ Check if the inner index reached the end
    bge end_innermost_loop

    lsl r11, r7, #2   @ Calculate offsets
    add r11, r11, r9, LSL #2
    ldr r0, [sp, #16] @ Load matrix A base address
    ldr r1, [r0, r11] @ Load A[r7][r9]

    lsl r11, r9, #2
    add r11, r11, r8, LSL #2
    ldr r2, [sp, #20] @ Load matrix B base address
    ldr r3, [r2, r11] @ Load B[r9][r8]

    mul r1, r1, r3  @ Multiply A[r7][r9] * B[r9][r8]
    add r10, r10, r1  @ Accumulate the product

    add r9, r9, #1  @ Increment inner index
    b innermost_loop

    end_innermost_loop:
    lsl r11, r7, #2
    add r11, r11, r8, LSL #2
    ldr r2, [sp, #24]  @ Load matrix C base address
    str r10, [r2, r11]  @ Store result in C[r7][r8]

    add r8, r8, #1  @ Increment column index
    b inner_loop

    end_inner_loop:
    add r7, r7, #1  @ Increment row index
    b outer_loop

end_outer_loop:
    ldmfd sp!, {r4-r11, lr}  @ Restore registers
    bx lr  @ Return
