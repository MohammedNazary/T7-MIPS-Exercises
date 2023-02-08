#################################
#	Mohammad Nazari		#
#	98110265		#
#################################

.text
main:
	
	li	$v0, 5
	syscall
	la	$a0, ($v0)
	li	$s0, 2
	jal	recur
	
	la	$a0, ($v0)
	j	result

recur:
	addi	$sp, $sp, -8
	sw	$ra, 0($sp)	# storing next program line in stack
	la	$t0, ($a0)
	li	$t2, 1
	beq	$t0, $t2, return
	
	div	$t0, $s0
	mfhi	$t1
	mflo	$a0
	sw 	$t1, 4($sp)
	jal	recur
	
	lw	$t1, 4($sp)
	beqz	$t1, odd
	beq	$t1, 1, even

odd:
	sll	$v0, $v0, 1
	j	finish

even:
	sll	$v0, $v0, 2
	j	finish

return:
	li	$v0, 1
	j	finish

finish:
	lw	$ra, 0($sp)
	addi	$sp, $sp, 8
	jr	$ra

result:
	li	$v0, 1
	syscall

done:
	li	$v0, 10
	syscall