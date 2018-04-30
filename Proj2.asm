#Aaron Cai
#810-379-273
#02/20/2018

.data
string: .asciiz "Array[C]: "				#store string "Array[C]: "
arrayA: .word 0, 30, 10, 10, 20, 20, 6, 18, 1, 27	#ArrayA to store the first list
arrayB: .word 11, 40, 10, 8, 4, 1, 1, 9, 10, 20		#ArrayB to store the second list
arrayC: .word 1, 1, 1, 1, 1, 1, 1, 1, 1, 1		#ArrayC to store 0s or 1s (0 if arrayA[i] < arrayB[I], 1 otherwise)
.text

main:   
	la $t1, arrayA  				#$t1 = address of arrayA
	la $t2, arrayB					#$t2 = address of arrayB
	la $t3,	arrayC					#$t3 = address of arrayC
     	
	li $t4, 0					#setting $t4 = 0; t4 will serve as a counter
	li $s1, 10					#setting $s1 = 10
	
	li $v0, 4					#printing out strings
	la $a0, string					#print out the actual string
	syscall 					#system call

	j for						#jump to loop

for:							#for(int i = 0; i<array.length; i++)
	beq $t4, $s1, reset				#if $t1 == $s1, then go to final
	
	lw $t5, 0($t1)					#get value from array cell and store in $t5
	lw $t6, 0($t2)					#get value from array cell and store in $t6
	
	slt $t0, $t5, $t6				#if t5 < t6, set t0 to 1, 0 otherwise
	beq $t0, $zero, sideboard			#go to sideboard if t0 != 0

	sw $zero, 0($t3)				#store $zero into the address of $t3
	
	j sideboard					#go to sideboard


sideboard:						#incrementing stuff
	addi $t1, $t1, 4				#incrementing $t1 by 4
	addi $t2, $t2, 4				#incrementing $t2 by 4
	addi $t3, $t3, 4				#incrementing $t3 by 4
	addi $t4, $t4, 1				#incrementing $t1 by 1
	j for						#go back to for

	
reset:							#resetting stuff
	li $t4, 0					#resetting t4 = 0
	la $t3, arrayC					#resetting the array of $t3
	j print						#go to print


print:							#printing arrayC
	beq $t4, $s1, final				#if t4 == s1, go to final
	
	lw $s2, 0($t3)					#store value from t3 into s2

	li $v0, 1					#print integer
	move $a0, $s2					#move $s2 into $a0
	syscall						#system call
	
	li $a0, 32					#print the ASCII representation of 32 which is space
	li $v0, 11					#system call for printing character
	syscall						#system call

	addi $t3, $t3, 4				#move pointer up the array
	addi $t4, $t4, 1				#increment counter

	j print						#go back to print

final:
	li $v0, 10		
	syscall						#end program
	

