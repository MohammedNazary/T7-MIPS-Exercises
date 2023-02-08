#################################
#	Mohammad Nazari		#
#	98110265		#
#################################

.data
	wa:		.asciiz "enter a:\n"
	wb:		.asciiz "enter b:\n"
	wc:		.asciiz "enter c:\n"
	arithmetic:	.asciiz "b is arithmetic mean of a and c.\n"
	geometric:	.asciiz "b is geometric mean of a and c.\n"
	none:		.asciiz "b is not a mean of a and c.\n"
	both:		.asciiz "b is geometric and arithmetic mean of a and c.\n"

.text

main:
	li	$v0, 4
	la	$a0, wa
	syscall
	li	$v0, 5
	syscall
	la	$s0, ($v0)
	
	li	$v0, 4
	la	$a0, wb
	syscall
	li	$v0, 5
	syscall
	la	$s1, ($v0)
	
	li	$v0, 4
	la	$a0, wc
	syscall
	li	$v0, 5
	syscall
	la	$s2, ($v0)
	
	j	isGeometric

isGeometric:
	mul	$t0, $s0, $s2
	mul	$t1, $s1, $s1
	beq	$t0, $t1, geometricIs
	j	notGeometric

geometricIs:
	addi	$t8, $zero, 1
	j	isArithmetic

notGeometric:
	add	$t8, $zero, $zero
	j	isArithmetic


isArithmetic:
	add	$t0, $s0, $s2
	add	$t1, $s1, $s1
	beq	$t1, $t0, arithmeticIs
	j	notArithmetic

arithmeticIs:
	addi	$t9, $zero, 1
	j	result

notArithmetic:
	add	$t9, $zero, $zero
	j	result

result:
	beq	$t8, $t9, same
	beq	$t8, $zero, printArithmetic
	li	$v0, 4
	la	$a0, geometric
	syscall
	j	done

printArithmetic:
	li	$v0, 4
	la	$a0, arithmetic
	syscall
	j	done

same:
	beq	$t8, $zero, printNone
	li	$v0, 4
	la	$a0, both
	syscall
	j	done

printNone:
	li	$v0, 4
	la	$a0, none
	syscall
	j	done

done:
	li	$v0, 10
	syscall