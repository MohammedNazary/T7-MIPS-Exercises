#################################
#	Mohammad Nazari		#
#	98110265		#
#################################

.macro removeEnter(%str, %bufferSize)		# Removing enter in the end of inputs
	li	$a1, 0			# set counter = 0
	loop:
   		lb	$a3, %str($a1)		# Load character at index
		addi	$a1, $a1, 1		# Increment index
		bnez	$a3, loop		# Loop until the end of string is reached
		beq	%bufferSize, $a1, skipping	# Do not remove \n when string = maxlength
		subiu	$a1, $a1, 2		# If above not true, Backtrack index to '\n'
		sb	$0, %str($a1)		# Add the terminating character in its place
	skipping:
		.end_macro


.data
	nextLine: 	.asciiz "\n"
	space: 		.asciiz " "
	firstBuffer: 	.space 32
	secondBuffer: 	.space 32
	first_text: 	.asciiz "Please enter you first name: "
	second_text: 	.asciiz "Welcome, please enter your last name: "
	hello: 		.asciiz "Hello "

	finalMsg: 	.space 80

.text
main:
	# printing the string asking for last name
	li 	$v0, 4
	la 	$a0, second_text
	syscall
	# Getting user last name
	li	$v0, 8
	la 	$a0, secondBuffer
	li 	$a1, 32
	syscall
	# Printing the welcome text
	li 	$v0, 4
	la 	$a0, first_text
	syscall
	# Getting user first name
	li 	$v0, 8
	la 	$a0, firstBuffer
	li 	$a1, 32
	syscall
	# Removing enter in the end of inputs
	li 	$t5, 32	# max number of chracter = buffer size

	removeEnter (firstBuffer, $t5)
	removeEnter (secondBuffer, $t5)

	# Printing the final msg
	la 	$a0, finalMsg

	la 	$a1, firstBuffer
	jal 	combiner
	la	$a1, space
	jal 	combiner
	la 	$a1, secondBuffer
	jal 	combiner

	# Printing the final text
	li 	$v0, 4
	la 	$a0, hello
	syscall

	li 	$v0, 4
	la 	$a0, finalMsg
	syscall
done:
	li	$v0, 10
	syscall


combiner:
	lb 	$v0, 0($a1)
	beqz	$v0, combined
	
	sb 	$v0,0($a0)
	
	addi 	$a0, $a0, 1
	addi	$a1, $a1, 1
	
	j 	combiner

combined:
	sb 	$zero, 0($a0)
	jr 	$ra






