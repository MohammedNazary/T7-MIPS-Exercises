#################################
#	Mohammad Nazari		#
#	98110265		#
#################################

.data  
	fileAdress: 	.asciiz "fileAddress.txt"	# filename for input
	buffer: 	.space 128
	buffer1:	.asciiz "\n"
	val:		.space 128
	nextLine:	.asciiz "\n"
	newFile:	.asciiz "newFile.txt"
	ans:		.asciiz ""

.text


main:
	li   	$v0, 13       		# Open file
	la	$a0, fileAdress      	# input file name label
	li	$a1, 0
	li	$a2, 0
	syscall
	move	$s0, $v0

	li   	$v0, 14		# reading from file
	move 	$a0, $s0
	la	$a1, buffer   	# address of buffer to read in
	li   	$a2, 8096
	syscall 

	lb 	$t1, buffer

	li      $t2, 0

strLen:                
	lb      $t0, buffer($t2)   
	add     $t2, $t2, 1
	bne     $t0, $zero, strLen

	li      $v0, 11

loop:
	sub     $t2, $t2, 1    #reversing
	la      $t0, buffer($t2)   
	lb      $a0, ($t0)
	syscall
	bnez    $t2, loop
	

write:
	li	$v0, 15
	la	$a0, buffer1
	la	$a1, newFile
	la	$a2, 512
	
	j	done

done:
	li      $v0, 10
	syscall
