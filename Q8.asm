#################################
#	Mohammad Nazari		#
#	98110265		#
#################################

.data
	w: 		.asciiz "enter first districts length:\n"
	w1:		.asciiz "enter next district length:\n"
	impossible:	.asciiz "impossible.\n"
	right:		.asciiz "it is right.\n"
	acute:		.asciiz "it is acute.\n"
	obtuse:		.asciiz "it is obtuse"

.text

main:
	li	$v0, 4		# print text
	la	$a0, w
	syscall
	li	$v0, 5		# input lenghth
	syscall
	la	$s0, ($v0)	# save input
	
	li	$v0, 4		# print text
	la	$a0, w1
	syscall
	li	$v0, 5		# input lenghth
	syscall
	la	$s1, ($v0)	# save input
	
	li	$v0, 4		# print text
	la	$a0, w1
	syscall
	li	$v0, 5		# input lenghth
	syscall
	la	$s2, ($v0)	# save input
	
	jal	isPossible
	
	mul	$s0, $s0, $s0
	mul	$s1, $s1, $s1
	mul	$s2, $s2, $s2
	
	j	isAcute


isPossible:
	add	$t0, $s0, $s1
	bge	$s2, $t0, impossibleIs
	
	add	$t0, $s1, $s2
	bge	$s0, $t0, impossibleIs
	
	add	$t0, $s0, $s2
	bge	$s1, $t0, impossibleIs
	
	jr	$ra

isAcute:
	add	$t0, $s0, $s1
	la	$t1, ($s2)
	bge	$t1, $t0, notAcute
	
	add	$t0, $s0, $s2
	la	$t1, ($s1)
	bge	$t1, $t0, notAcute
	
	add	$t0, $s2, $s1
	la	$t1, ($s0)
	bge	$t1, $t0, notAcute
	
	j	acuteIs

rightIs:
	li	$v0, 4
	la	$a0, right
	syscall
	j	done

notAcute:
	beq	$t1, $t0, rightIs
	li	$v0, 4
	la	$a0, obtuse
	syscall
	j	done

impossibleIs:
	li	$v0, 4
	la	$a0, impossible
	syscall
	j	done

acuteIs:
	li	$v0, 4
	la	$a0, acute
	syscall
	j	done

done:
	li	$v0, 10
	syscall
	