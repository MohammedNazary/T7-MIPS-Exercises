#################################
#	Mohammad Nazari		#
#	98110265		#
#################################

.data
	w1:		.asciiz "Enter first number:\n"
	w2:		.asciiz "Enter second number:\n"
	msg:		.asciiz "your numbers after conversion are:\n"

.text
main:
	li	$v0, 4
	la	$a0, w1
	syscall
	li	$v0, 5
	syscall
	la	$s0, ($v0)	# storing first number
	
	li	$v0, 4
	la	$a0, w2
	syscall
	li	$v0, 5
	syscall
	la	$s1, ($v0)	# storing second number
	
	jal	converter
	j	print

converter:
	andi	$t3, $s0, 65504		# values for exchanging bits
	andi	$t4, $s1, 4192256
	
	not	$a0, $t0
	not	$a1, $t4
	
	and	$t5, $a0, $s0
	and	$t6, $a1, $s1
	
	sll	$t4, $t4, 6
	srl	$t3, $t3, 6
	
	add	$a0, $t5, $t4	# boolean adding of ANDs
	add	$a1, $t6, $t3	# boolean adding of ORs
	
	jr	$ra

print:
	li	$v0, 1
	la	$a0, ($a1)
	syscall
	
	j	done

done:
	li	$v0, 10
	syscall
