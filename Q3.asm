#################################
#	Mohammad Nazari		#
#	98110265		#
#################################
.data
	w:		.asciiz "Please enter your desired n:\n"
	msg:		.asciiz "The result is: "
	inError:	.asciiz "N must be equal or greater then 1.\n"
	overError:	.asciiz "\nOverflow happend due to greatness of n.\n"

.text
main:
	li	$v0, 4
	la	$a0, w
	syscall
	li	$v0, 5
	syscall
	la	$s0, ($v0)
	
	la	$t0, ($zero)	# counter
	la	$s1, 1		# result buffer
	
	jal	inputCheck
	j	factCal

inputCheck:
	blez	$s0, inputError
	jr	$ra

factCal:
	beq	$t0, $s0, result
	addi	$t0, $t0, 1
	mul	$s1, $t0, $s1
	blez	$s1, overflowError
	j	factCal


result:
	li	$v0, 1
	la	$a0, ($s1)
	syscall
	j	done

inputError:
	li	$v0, 4
	la	$a0, inError
	syscall
	j	done

overflowError:
	li	$v0, 1
	li	$a0, -1
	syscall
	li	$v0, 4
	la	$a0, overError
	syscall
	j	done

done:
	li	$v0, 10
	syscall
