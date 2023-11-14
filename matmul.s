.text
.align 2
.global matmul
.type matmul, %function

@ matmul(h1, w1, m1, h2, w2, m2, m_final);

matmul:
    stmfd sp!, {r0-r12, lr}   @ Save registers to the stack

    mov r4, r0           @ h1
    mov r5, r1           @ w1
    mov r6, r2           @ m1
    mov r7, r3           @ h2
    mov r8, r4           @ w2
    mov r9, r5           @ m2
    mov r10, r6          @ m_final

    mov r0, #0           @ Initialize loop counter

loop_i:
    mov r1, #0           @ Initialize row index for m_final

loop_j:
    mov r2, #0           @ Initialize row index for m1
    mov r3, #0           @ Initialize column index for m2
    mov r12, #0          @ Initialize temporary variable

loop_k:
    ldr r11, [r6, #4 * r2]    @ Load element from m1
    ldr lr, [r9, #4 * r3]    @ Load element from m2
    mul ip, r11, lr               @ Multiply elements
    ldr lr, [r10, #4 * r1]    @ Load element from m_final
    add lr, lr, ip               @ Add product to m_final
    str lr, [r10, #4 * r1]    @ Store result back to m_final
    add r3, r3, #1               @ Increment column index for m2
    add r12, r12, #1              @ Increment temporary variable
    cmp r12, r5                    @ Check if column index exceeds matrix width
    blt loop_k                   @ Branch back if not done

    add r1, r1, #1               @ Increment row index of m_final
    add r2, r2, #1               @ Increment row index for m1
    cmp r2, r4                    @ Check if row index for m1 exceeds matrix height
    blt loop_j                   @ Branch back if not done

    add r0, r0, #1               @ Increment loop counter
    add r9, r9, #4               @ Increment pointer to m2 by its width
    add r10, r10, #4             @ Increment pointer to m_final by its width
    cmp r0, r7                    @ Check if loop counter exceeds matrix depth
    blt loop_i                   @ Branch back if not done

    ldmfd sp!, {r0-r12, pc}    @ Restore registers from the stack
    bx lr                       @ Return
