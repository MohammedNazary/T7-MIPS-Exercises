#################################
#	Mohammad Nazari		#
#	98110265		#
#################################


.data
	w1:		.asciiz "Enter a1:\n"
	w2:		.asciiz "Enter a2:\n"
	w3:		.asciiz "Enter a3:\n"
	msg:		.asciiz "The equation is: "
	x:		.asciiz "x + "
	x2:		.asciiz "x^2 + "
	nextLine:	.asciiz "\n"

.text
main:
	li	$v0, 4
	la	$a0, w1
	syscall
	li	$v0, 5
	syscall
	la	$s0, ($v0)
	
	li	$v0, 4
	la	$a0, w2
	syscall
	li	$v0, 5
	syscall
	la	$s1, ($v0)
	
	li	$v0, 4
	la	$a0, w3
	syscall
	li	$v0, 5
	syscall
	la	$s2, ($v0)
	
	j	calculate

calculate:
	# a = ( a3 - 2a2 + a1 ) / 2
	add	$s3, $s1, $s1	# calculate a
	sub	$s3, $s2, $s3
	add	$s3, $s3, $s0
	addi	$t0, $zero, 2
	div	$s3, $s3, $t0	# s3 <- a
	# b = (8a2 - 5a1 - 3a3) / 2
	mul	$s4, $s0, 5	# calculate b
	mul	$t0, $s2, 3
	mul	$t1, $s1, 8
	add	$s4, $s4, $t0
	sub	$s4, $t1, $s4
	div	$s4, $s4, 2	# s4 <- b
	# c = a3 - 3 ( a2 - a1 )
	sub	$s5, $s1, $s0	# calculate c
	mul	$s5, $s5, 3
	sub	$s5, $s2, $s5	# s5 <- c
	
	j print

print:
	li	$v0, 4
	la	$a0, msg
	syscall
	
	li	$v0, 1
	la	$a0, ($s3)
	syscall
	
	li	$v0, 4
	la	$a0, x2
	syscall

	li	$v0, 1
	la	$a0, ($s4)
	syscall

	li	$v0, 4
	la	$a0, x
	syscall

	li	$v0, 1
	la	$a0, ($s5)
	syscall

	li	$v0, 4
	la	$a0, nextLine
	syscall
	