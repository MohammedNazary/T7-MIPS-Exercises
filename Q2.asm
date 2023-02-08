#################################
#	Mohammad Nazari		#
#	98110265		#
#################################

.data
	w1:		.asciiz "enter first number:\n"
	w2:		.asciiz "enter second number:\n"
	overflow:	.asciiz "Overflow detected!\n"
	noOverflow:	.asciiz "Overflow was not detected.\n"

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
	
	j	overflowDetect

overflowDetect:
	addu	$s2, $s0, $s1
	xor	$t0, $s0, $s2
	xor	$t1, $s1, $s2
	and	$t2, $t0, $t1
	bltz	$t2, detected
	j	notDetected

detected:
	li	$v0, 4
	la	$a0, overflow
	syscall
	j	done

notDetected:
	li	$v0, 4
	la	$a0, noOverflow
	syscall
	j	done

done:
	li	$v0, 10
	syscall