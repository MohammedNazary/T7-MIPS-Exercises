#################################
#	Mohammad Nazari		#
#	98110265		#
#################################

# اسپیس هم میگذاره این کد. برای اینکه با مثال تمرین همخوانی داشته باشه

.data
	w1:		.asciiz "Main string:\n"
	w2:		.asciiz "Side string:\n"
	w3:		.asciiz "Index of merge:\n"
	mainBuffer:	.space 512
	sideBuffer:	.space 512
	space:		.asciiz " "
	resultBuffer:	.space 1024
	nError:		.asciiz "n must be among length of main string.\n"
	stringError:	.asciiz "Enter a longer string."
	stop:		.asciiz "!"

.text



main:
	li	$v0, 4		# main string address and input
	la	$a0, w1
	syscall
	
	li	$v0, 9		# input address (dynamic mem aloc)
	li	$a0, 512
	syscall
	move	$s0, $v0	# main str address = $s0
	
	li	$v0, 8
	move	$a0, $s0
	li	$a1, 512	# inputting main str
	syscall
	########################################################
	li	$v0, 4		# side string address and input
	la	$a0, w2
	syscall
	
	li	$v0, 9		# input address	(dynamic mem aloc)
	li	$a0, 512
	syscall
	move	$s1, $v0	# side str address = $s1
	
	li	$v0, 8
	move	$a0, $s1
	li	$a1, 512
	syscall
	########################################################
	li	$v0, 4
	la	$a0, w3
	syscall
	li	$v0, 5		# inputing index n
	syscall
	la	$s5, ($v0)	# storing index number $s5
	########################################################
		
	li	$v0, 9		# using dynamic memory allocation
	li	$a0, 1024	#	creating a place for final
	syscall			#	result (merged string).
	move	$s6, $v0	# merged str address -> $s6
	########################################################
	
	move	$t0, $s0	# address of main str -> $t0
	move	$t1, $s1	# address of side str -> $t1
	move	$t5, $s5	# value of insertion index -> $t5
	move	$t6, $s6	# address of merged str -> $t6
	add	$t7, $t0, $t5	# address of insertion point -> $t7
	

	la	$a1, ($zero)
	j	indexCheck

merge:		# merging first part of main str (i <= n) in addresss of final str
	beq	$t0, $t7, mergeSide
	lb	$t3, 0($t0)	# loading characters of first part of main str
	
	
	beqz	$t3, strError
	sb	$t3, 0($t6)	# merging (writing) on address of final string
	
	addi	$t0, $t0, 1
	addi	$t6, $t6, 1
	
	j	merge

mergeSide:	# merging side str after first part of main str in final address
	lb	$t3, 0($t1)	# loading characters of side str
	addi	$t5, $0, 10	# ascii
	beq	$t3, $t5, mergeSpace
	sb	$t3, 0($t6)
	addi	$t1, $t1, 1
	addi	$t6, $t6, 1
	
	j mergeSide

mergeSpace:
	la	$t8, space
	lb	$t3, 0($t8)	# merging space for khoshgel shodane result
	addi	$t5, $0, 10	# ascii	
	sb	$t3, 0($t6)
	addi	$t6, $t6, 1
	
	j mergeEnd
	
mergeEnd:	# merging other part of main str at the end of final str address
	lb	$t3, 0($t0)
	beq	$t3, $zero, backToMain
	sb	$t3, 0($t6)
	addi	$t0, $t0, 1
	addi	$t6, $t6, 1
	j	mergeEnd

backToMain:
	j	print

print:
	li	$v0, 4
	move	$a0, $s6
	syscall
	j	done

indexCheck:
	la	$a0, ($t0)
	j	len
indexFinalCheck:
	bgt	$s5, $a1, inputError
	j	merge

len:
	lb	$v0, 0($a0)
	beqz	$v0, returnLen
	addi	$a0, $a0, 1
	addi	$a1, $a1, 1
	j len

returnLen:
	j	indexFinalCheck

inputError:
	li	$v0, 4
	la	$a0, nError
	syscall
	j	done

strError:
	li	$v0, 4
	la	$a0, stringError
	syscall

done:
	li	$v0, 10
	syscall
