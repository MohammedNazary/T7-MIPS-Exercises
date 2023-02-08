#################################
#	Mohammad Nazari		#
#	98110265		#
#################################

.data
	w1:	.asciiz "first line\n"
	w2:	.asciiz "second line\n"

.text
main:
	jal	selfModifyierCode
	jal	selfModifyierCode
	
	j	done

selfModifyierCode:

	li	$v0, 4
	la	$a0, w1
	syscall
	
	la	$a0, w2
	syscall
	
	# because la is combination of lui and ori and ore is
	# 	bitwise OR immediate
	#	I will be changing lines of code inside of subroutine
	#	with instruction inside that subroutine
	la	$t0, selfModifyierCode	
	lw	$t1, 8($t0)	# index of code of first ori
	lw	$t2, 20($t0)	# index of bits of second ori
	# la is two basic instruction so we should count that
	andi	$t3, $t1, 65535		# morroring 16 first bits
	andi	$t4, $t2, 65535
	andi	$t1, $t1, 4294901760
	andi	$t2, $t2, 4294901760
	
	add	$t1, $t1, $t4
	add	$t2, $t2, $t3
	
	sw	$t1, 8($t0)	# replacing mirrored instructions (first ori)
	sw	$t2, 20($t0)	# (second ori)
	jr	$ra

done:
	li	$v0, 10
	syscall
