.text
.align 2
.global matmul
.type matmul, %function

matmul:
    stmfd sp!, {r0-r12, lr}  @ Save registers to the stack

    mov r4, r0  @ h1
    mov r5, r1  @ w1
    mov r6, r2  @ m1
    mov r7, r3  @ h2
    mov r8, r4  @ w2
    mov r9, r5  @ m2
    mov r10, r6  @ m_final

    mov r0, #0  @ Initialize loop counter

loop_i:
    mov r1, #0  @ Initialize row index for m_final
    mov r11, r6  @ Save start of row for m1

loop_j:
    mov r2, #0  @ Initialize row index for m1
    mov r3, #0  @ Initialize column index for m2
    mov lr, r9  @ Save start of row for m2

loop_k:
    ldr r12, [r11, r2, lsl #2]  @ Load element from m1
    ldr ip, [lr, r3, lsl #2]  @ Load element from m2
    mul r12, r12, ip  @ Multiply elements
    str r12, [r10, r1, lsl #2]  @ Store result in m_final
    add r3, r3, #1  @ Increment column index for m2
    add r1, r1, #1  @ Increment row index for m_final
    cmp r3, r5  @ Check if column index for m2 exceeds matrix width
    blt loop_k  @ Branch back if not done

    add r1, r1, #1  @ Increment row index of m_final
    add r11, r11, r5, lsl #2  @ Increment pointer to m1 by its width
    cmp r1, r8  @ Check if row index for m_final exceeds matrix width
    blt loop_j  @ Branch back if not done

    add r0, r0, #1  @ Increment loop counter
    add r6, r6, r5, lsl #2  @ Increment pointer to m1 by its height
