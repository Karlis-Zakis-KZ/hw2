.text
.align 2
.global matmul
.type matmul, %function

matmul:
    stmfd sp!, {r0-r12, lr}

    mov r5, #0          // Initialize loop counters
    mov r6, #0
    mov r7, #0

    ldr r3, [sp, #0]    // Load matrix dimensions
    ldr r4, [sp, #56]
    ldr r2, [sp, #12]

for_i:
    cmp r5, r3          // Check if outer loop is complete
    bge end_for_i

    mov r6, #0          // Initialize inner loop counters

for_j:
    cmp r6, r4
    bge end_for_j

    mov r7, #0

for_k:
    cmp r7, r2
    bge end_for_k

    mov r10, r5, LSL #2   // Calculate offsets for matrix elements
    mul r8, r10, r2
    mov r9, r7, LSL #2
    add r8, r8, r9

    ldr r0, [sp, #8]    // Load matrices
    ldr r2, [r0, r8]

    mul r8, r9, r4
    mov r10, r6, LSL #2
    add r8, r8, r10

    ldr r1, [sp, #60]
    ldr r3, [r1, r8]

    mul r11, r2, r3        // Calculate element product

    ldr r0, [sp, #64]    // Destination matrix
    mov r10, r5, LSL #2
    mul r8, r10, r4
    mov r12, r6, LSL #2
    add r8, r8, r12

    ldr r1, [r0, r8]
    add r2, r11, r1        // Update destination element
    str r2, [r0, r8]

    add r7, r7, #1          // Increment loop counters
    b for_k

end_for_k:
    add r6, r6, #1
    b for_j

end_for_j:
    add r5, r5, #1
    b for_i

end_for_i:
    ldmfd sp!, {r0-r12, lr}
    bx lr
