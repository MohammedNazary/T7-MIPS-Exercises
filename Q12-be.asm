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
	li	$v0, 6
	syscall
	movf.s	$f1, $f0
	
	li	$v0, 4
	la	$a0, wb
	syscall
	li	$v0, 6
	syscall
	movf.s	$f2, $f0
	
	li	$v0, 4
	la	$a0, wc
	syscall
	li	$v0, 6
	syscall
	movf.s	$f3, $f0
	
	j	isGeometric

isGeometric:
	mul.s	$f0, $f2, $f2
	mul.s	$f4, $f1, $f3
	c.eq.s	$f0, $f4
	bc1t	geometricIs
	j	notGeometric
geometricIs:
	addi	$t8, $zero, 1
	j	isArithmetic
notGeometric:
	add	$t8, $zero, $zero
	j	isArithmetic

isArithmetic:
	move	$a1, $zero
	add.s	$f0, $f1, $f3
	add.s	$f4, $f2, $f2
	c.eq.s	$f0, $f4
	bc1t	arithmeticIs
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
