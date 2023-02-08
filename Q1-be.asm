#################################
#	Mohammad Nazari		#
#	98110265		#
#################################

.macro removeEnter(%str, %bufferSize)		# Removing enter in the end of inputs
	li	$a1, 0			# set counter = 0
	loop:
   		lb	$a3, 0(%str)		# Load character at index
		addi	$a1, $a1, 1		# Increment index
		bnez	$a3, loop		# Loop until the end of string is reached
		ble	%bufferSize, $a1, skipping	# Do not remove \n when string = maxlength
		subiu	$a1, $a1, 2		# If above not true, Backtrack index to '\n'
		sb	$0, 0(%str)		# Add the terminating character in its place
	skipping:
		.end_macro

.macro printStr (%str)
	li	$v0, 4
	la	$a0, %str
	syscall
.end_macro


.data
	nextLine: 		.asciiz "\n"
	space:	 		.asciiz " "
	first_text: 		.asciiz "Welcome, please enter you last name: "
	second_text: 		.asciiz "Please enter your first name: "
	hello:	 		.asciiz "Hello "
	buffer:			.word 32
	firstBuffer:		.space 32
	secondBuffer:		.space 32
	


.text

main:
	
	li 	$v0, 9          # dynamic memory alocation
	li 	$a0, 256     	# size of alocated memory
	syscall
	move 	$s0, $v0	# address of alocated memory for heap -> $s0
	
	li	$v0, 4		# Printing the welcome text
	la	$a0, first_text
	syscall
	
	li 	$v0, 8		# Getting user last name / storing it in alocated memory
	la 	$a0, firstBuffer	# buffering input
	la 	$a1, buffer		# $a1 <- maximum number of characters to read
	syscall
		
	
	
	la	$t0, ($s0)
	la 	$t5, buffer	# max number of chracters to check = buffer size
	removeEnter ($t0, $t5)	# Removing enter in the end of inputs
	
	la	$a0, hello
	li	$a1, 0
	move	$s1, $s0
	jal	toMem		# save to heap
	
	la	$a0, firstBuffer
	li	$a1, 0
	jal	toMem		# saving to heap
	
	li 	$v0, 4		# asking for first name
	la 	$a0, second_text
	syscall
	
	li 	$v0, 8
	la	$a0, secondBuffer	# location of save in alocated memory -> pointer 2 = 64
	la 	$a1, buffer
	syscall
	
	la	$t1, ($s1)
	la 	$t5, buffer	# max number of chracters to check = buffer size
	removeEnter ($t1, $t5)	# Removing enter in the end of inputs
	la	$a0, secondBuffer
	li	$a1, 0
	jal	toMem		# save last name to heap
	
	la	$t3, ($zero)	# counter <- 0
	move	$a1, $s0
	jal	print
	
	add	$t3, $t3, 1
	jal	print
	
	add	$t3, $t3, 2
	jal	print
	
	j	done

toMem:
	lb	$t0, ($a0)
	sb	$t0, ($s1)
	addiu	$a0, $a0, 1
	addiu	$s1, $s1, 1
	beqz	$t0, copied
	j	toMem
copied:
	jr	$ra

print:
	lb	$t1, ($s0)
	add	$s0, $t3, $a1
	beqz	$t1, printed
	la	$t2, nextLine
	beq	$t1, $t2, printed
	addi	$t3, $t3, 1
	li	$v0, 11		# print single character
	la	$a0, ($s0)
	syscall
	j	print

printed:
	li	$v0, 4
	la	$a0, space
	syscall
	jr	$ra

done:
	li	$v0, 10
	syscall











