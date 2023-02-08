#################################
#	Mohammad Nazari		#
#	98110265		#
#################################

.data
	w1:		.asciiz "Enter x:\n"
	w2:		.asciiz "Enter y:\n"
	msg:		.asciiz "x by y equals to: "
	nextLine:	.asciiz "\n"

.text
main:
	#x
	li	$v0, 4
	la	$a0, w1
	syscall
	li	$v0, 5
	syscall
	la	$s0, ($v0)
	#y
	li	$v0, 4
	la	$a0, w2
	syscall
	li	$v0, 5
	syscall
	la	$s1, ($v0)
	
	la	$s2, ($zero)
	la	$t0, ($zero)
	
	bltz	$s1, multiplyNeg
	j	multiplyPos

multiplyPos:
	beq	$s1, $t0, print
	add	$s2, $s2, $s0
	addi	$t0, $t0, 1
	j	multiplyPos

multiplyNeg:
	beq	$s1, $t0, print
	sub	$s2, $s2, $s0
	addi	$t0, $t0, -1
	j	multiplyNeg

print:
	li	$v0, 4
	la	$a0, msg
	syscall
	li	$v0, 1
	la	$a0, ($s2)
	syscall
	li	$v0, 4
	la	$a0, nextLine
	syscall
	j	done

done:
	li	$v0, 10
	syscall


