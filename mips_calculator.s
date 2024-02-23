# Mips Calculator
#Author: Furdeen Hasan
     .data
prompt1:     .asciiz "Enter first number: "
prompt2:     .asciiz "Enter second number: "
prompt3:     .asciiz "Enter operation (1:Add, 2:Subtract, 3:Multiply, 4:Divide): "
result:      .asciiz "Result: "
divZero:     .asciiz "Error: Division by zero.\n"
repeatPrompt:.asciiz "\nDo you want to run again? (1:Yes, Any other key:No): "

    .text
    .globl main

main:
    # Main program loop
loop:
    # Prompt and read first number
    li $v0, 4
    la $a0, prompt1
    syscall
    li $v0, 5
    syscall
    move $t0, $v0        # Store first number in $t0

    # Prompt and read second number
    li $v0, 4
    la $a0, prompt2
    syscall
    li $v0, 5
    syscall
    move $t1, $v0        # Store second number in $t1

    # Prompt and read operation
    li $v0, 4
    la $a0, prompt3
    syscall
    li $v0, 5
    syscall
    move $t2, $v0        # Store operation in $t2

    # Perform the selected operation
    beq $t2, 1, add
    beq $t2, 2, subtract
    beq $t2, 3, multiply
    beq $t2, 4, divide
    j end                # Jump to end if an invalid operation is entered

add:
    add $t3, $t0, $t1    # Add the numbers
    j print_result

subtract:
    sub $t3, $t0, $t1    # Subtract the numbers
    j print_result

multiply:
    mul $t3, $t0, $t1    # Multiply the numbers
    j print_result

divide:
    # Check for division by zero
    beq $t1, 0, handle_div_zero
    div $t0, $t1
    mflo $t3             # Get quotient
    j print_result

handle_div_zero:
    li $v0, 4
    la $a0, divZero
    syscall
    j repeat_question

print_result:
    li $v0, 4
    la $a0, result
    syscall
    li $v0, 1
    move $a0, $t3
    syscall

repeat_question:
    # Prompt to run again
    li $v0, 4
    la $a0, repeatPrompt
    syscall
    li $v0, 5
    syscall
    li $t4, 1
    beq $v0, $t4, loop   # If input is 1, loop back to start

end:
    li $v0, 10           # Exit
    syscall
