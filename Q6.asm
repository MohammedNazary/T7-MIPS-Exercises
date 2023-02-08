#################################
#	Mohammad Nazari		#
#	98110265		#
#################################

.data
	w1:		.asciiz "please enter decimal number:\n"
	w2:		.asciiz "please enter desired decimal base:\n"
	error:		.asciiz "base must be among natural numbers 3 to 10.\n"
	result1:	.asciiz " in base = "
	result2:	.asciiz " is "
	resultBuffer:	.space 128

.text
main:
	li	$v0, 4		# print text
	la	$a0, w1
	syscall
	li	$v0, 5		# input decimal number
	syscall
	la	$s0, ($v0)	# save input
	la	$s2, ($s0)
	
	li	$v0, 4		# print text
	la	$a0, w2
	syscall
	li	$v0, 5		# input base
	syscall
	la	$s1, ($v0)	# save input
	
	jal	baseCheck
	
	la	$a1, resultBuffer
	addi	$t3, $zero, 0
	addi	$t4, $zero, 0
	j	baseConverter

baseConverter:
	beq	$s0, $zero, printResult
	div	$s0, $s1
	mfhi	$t0		# storing remainder
	sw	$t0, -4($sp)	# pushing remainder in a stack
	sub	$sp, $sp, 4
	addi	$t4, $t4, 1
	mflo	$s0		# storing quotient in place of number
	j	baseConverter

printResult:
	li	$v0, 1
	la	$a0, ($s2)
	syscall
	li	$v0, 4
	la	$a0, result1
	syscall
	li	$v0, 1
	la	$a0, ($s1)
	syscall
	li	$v0, 4
	la	$a0, result2
	syscall
	
	j	printNum
	
printNum:
	addi	$t3, $t3, 1
	lw	$t1, 0($sp)
	addi	$sp, $sp, 4
	li	$v0, 1
	la	$a0, ($t1)
	syscall
	j	removeSign
	
removeSign:
	beq	$t3, $t4, done
	addi	$t3, $t3, 1
	lw	$t1, 0($sp)
	addi	$sp, $sp, 4
	abs	$t1, $t1
	li	$v0, 1
	la	$a0, ($t1)
	syscall
	j	removeSign

baseCheck:
	addi	$t0, $zero, 11
	bge	$s1, $t0, printBaseError
	addi	$t0, $zero, 2
	blt	$s1, $t0, printBaseError
	jr	$ra

printBaseError:
	li	$v0, 4
	la	$a0, error
	syscall
	j	done

done:
	li	$v0, 10
	syscall
