#################################
#	Mohammad Nazari		#
#	98110265		#
#################################

.text

.macro done
	li $v0, 10
	syscall
.end_macro


main:
	li $v0, 5		# input n
	syscall
	la $a0, ($v0)
	li $t0, 1		# counter of current prime number
	li $s0, 2		# current prime candidate in loop
	j counter

counter:
	beq $t0, $a0, print
	add $s0, $s0, 1
	li $t1, 1		# counter of divisions loop
	j isPrime

isPrime:
	add $t1, $t1, 1
	beq $t1, $s0, primeIs
	div $s0, $t1
	mfhi $t2
	beq $t2, $zero, counter
	j isPrime

primeIs:
	add $t0, $t0, 1
	j counter

print:
	la $a0, ($s0)
	li $v0, 1
	syscall
	done
