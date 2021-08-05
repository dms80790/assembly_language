#David Stropkey 
#CS 447 Childers
#Project 1 - Maze Game
##################################################################################################################
.data
msgLose: .asciiz "Sorry. You were captured."
msgWin1: .asciiz "Success! You won! Your score is "
msgWin2: .asciiz " moves."
zombieZeroArray: .space 32
zombieOneArray: .space 32
zombieTwoArray: .space 32
zombieThreeArray: .space 32
direction: .byte 0,1,2,3

##################################################################################################################
.text

#main
main:

jal _MazePlot
jal _Start
li $v0, 10
syscall

##################################################################################################################

_Start:
    addi $sp, $sp, -4
    sw $ra, 0($sp)     #save ra to main method
   
   ####Setting up player initial values################################
    li $s0, 0    # set player x to 0
    li $s1, 0    # set player y to 0
    li $s2, 3    # set player color to green
    
    ####Setting up Zombie Arrays#############################################
    
    #Zombie 0
    addi $t2, $zero, 17    #Set x to initially 14
    addi $t3, $zero, 14    #set y to initially 14
    addi $t4, $zero, 0     #set x min (quad)
    addi $t5, $zero, 31     #set x max (quad)
    addi $t6, $zero, 0     #set y min (quad)
    addi $t7, $zero, 31     #set y max (quad)
    
    addi $t1, $zero, 1    #saving value at index 0 (x)
    sw $t2, zombieZeroArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 1 (y)
    sw $t3, zombieZeroArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 2 (color)
    sw $t4, zombieZeroArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 3 (quad)
    sw $t5, zombieZeroArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 3
    sw $t7, zombieTwoArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 3
    sw $t6, zombieTwoArray($t1)
    
    #Zombie 1
    addi $t2, $zero, 41    #Set x to initially 46
    addi $t3, $zero, 14    #set y to initially 14
    addi $t4, $zero, 32     #set x min (quad)
    addi $t5, $zero, 63     #set x max (quad)
    addi $t6, $zero, 0     #set y min (quad)
    addi $t7, $zero, 31     #set y max (quad)
    
    addi $t1, $zero, 1    #saving value at index 0
    sw $t2, zombieOneArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 1
    sw $t3, zombieOneArray($t4)
    
    addi $t1, $t1, 4     #saving value at index 2
    sw $t4, zombieOneArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 3
    sw $t5, zombieOneArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 3
    sw $t6, zombieTwoArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 3
    sw $t7, zombieTwoArray($t1)
    
    #Zombie 2
    addi $t2, $zero, 41    #Set x to initially 14
    addi $t3, $zero, 46    #set y to initially 46
    addi $t4, $zero, 32     #set x min (quad)
    addi $t5, $zero, 63     #set x max (quad)
    addi $t6, $zero, 32     #set y min (quad)
    addi $t7, $zero, 63     #set y max (quad)
    
    addi $t1, $zero, 1    #saving value at index 0
    sw $t2, zombieTwoArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 1
    sw $t3, zombieTwoArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 2
    sw $t4, zombieTwoArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 3
    sw $t5, zombieTwoArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 3
    sw $t6, zombieTwoArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 3
    sw $t7, zombieTwoArray($t1)
    
    #Zombie 3
    addi $t2, $zero, 17   #Set x to initially 46
    addi $t3, $zero, 46    #set y to initially 46
    addi $t4, $zero, 0     #set x min (quad)
    addi $t5, $zero, 31     #set x max (quad)
    addi $t6, $zero, 32     #set y min (quad)
    addi $t7, $zero, 63     #set y max (quad)
    
    addi $t1, $zero, 1    #saving value at index 0
    sw $t2, zombieThreeArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 1
    sw $t3, zombieThreeArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 2
    sw $t4, zombieThreeArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 3
    sw $t5, zombieThreeArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 3
    sw $t6, zombieTwoArray($t1)
    
    addi $t1, $t1, 4     #saving value at index 3
    sw $t7, zombieTwoArray($t1)
    
  ##########################################################  
    move $a0, $s0    # set x argument to 0
    move $a1, $s1    # set y argument to 0
    move $a2, $s2    # set color argument to green
    
    jal _setLED  # place player on the board
    
    
   #Setting Zombies on board
    #Zombie Zero
    addi $t1, $zero, 1
    lw $a0, zombieZeroArray($t4)
    addi $t1, $t4, 4
    lw $a1, zombieZeroArray($t4)
    addi $a2, $zero, 1
    
    jal _setLED  # place zombie zero on the board
    
    #Zombie One
    addi $t1, $zero, 1
    lw $a0, zombieOneArray($t1)
    addi $t1, $t1, 4
    lw $a1, zombieOneArray($t1)
    addi $a2, $zero, 1
    
    jal _setLED  # place zombie zero on the board
    
     #Zombie Two
    addi $t1, $zero, 1
    lw $a0, zombieTwoArray($t1)
    addi $t1, $t1, 4
    lw $a1, zombieTwoArray($t1)
    addi $a2, $zero, 1
    
    jal _setLED  # place zombie zero on the board
    
     #Zombie Three
    addi $t1, $zero, 1
    lw $a0, zombieThreeArray($t1)
    addi $t1, $t1, 4
    lw $a1, zombieThreeArray($t1)
    addi $a2, $zero, 1
    
    jal _setLED  # place zombie zero on the board
      
   ##########################################################  

poll: 
    
    #jal _moveZombies     # move zombies
    
    la $v0,0xffff0000 # address for reading key press status
    lw $t0,0($v0) # read the key press status
    andi $t0,$t0,1
    beq $t0,$0,poll # no key pressed.. return to poll
    lw $t0,4($v0) # read key value if key was pressed

ukey:
    addi $v0,$t0,-224 # check for right key press
    bne $v0,$0,dkey # wasn't right key, so check for center
     
    addi $a1, $s1, -1    # set argument $a0 to x+1 for _getLED
   
    jal _getLED    # get values for LED to right
    
    addi $a1, $a1, 1    #restore value in $a0 to x
    beq $v1, 2, poll     #if value of LED to right is yellow, return to poll
    beq $v1, 1, gameOver    #if value of LED to right is red, game over
    
    addi $s7, $s7, 1 #updates number of moves
    seq $t0, $s0, 63
    seq $t1, $s1, 63
    and $t2, $t0, $t1
    bgtz $t2, winner 
    
    jal _pressedUpKey  #if value of LED is black, red or green, handle button push
    
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    j poll    #return to poll
dkey:
    addi $v0,$t0,-225 # check for right key press
    bne $v0,$0,lkey # wasn't right key, so check for center
     
    addi $a1, $s1, 1    # set argument $a0 to x+1 for _getLED
   
    jal _getLED    # get values for LED to right
    
    addi $a1, $a1, -1    #restore value in $a0 to x
    beq $v1, 2, poll     #if value of LED to right is yellow, return to poll
    beq $v1, 1, gameOver    #if value of LED to right is red, game over
    
    addi $s7, $s7, 1 #updates number of moves
    seq $t0, $s0, 63
    seq $t1, $s1, 63
    and $t2, $t0, $t1
    bgtz $t2, winner 
    
    jal _pressedDownKey  #if value of LED is black, red or green, handle button push
    
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    j poll    #return to poll
lkey: 
    addi $v0,$t0,-226 # check for right key press
    bne $v0,$0,rkey # wasn't right key, so check for center
     
    addi $a0, $s0, -1    # set argument $a0 to x+1 for _getLED
   
    jal _getLED    # get values for LED to right
    
    addi $a0, $a0, 1    #restore value in $a0 to x
    beq $v1, 2, poll     #if value of LED to right is yellow, return to poll
    beq $v1, 1, gameOver    #if value of LED to right is red, game over
    
    addi $s7, $s7, 1 #updates number of moves
    seq $t0, $s0, 63
    seq $t1, $s1, 63
    and $t2, $t0, $t1
    bgtz $t2, winner 
    
    jal _pressedLeftKey  #if value of LED is black, red or green, handle button push
    
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    j poll    #return to poll
rkey: 
    addi $v0,$t0,-227 # check for right key press
    bne $v0,$0,bkey # wasn't right key, so check for center
     
    addi $a0, $s0, 1    # set argument $a0 to x+1 for _getLED
   
    jal _getLED    # get values for LED to right
    
    addi $a0, $a0, -1    #restore value in $a0 to x
    beq $v1, 2, poll     #if value of LED to right is yellow, return to poll
    beq $v1, 1, gameOver    #if value of LED to right is red, game over
    
    addi $s7, $s7, 1 #updates number of moves
    seq $t0, $s0, 62
    seq $t1, $s1, 63
    and $t2, $t0, $t1
    bgtz $t2, winner    #determines winner (reached (63,63)
    
    jal _pressedRightKey  #if value of LED is black, red or green, handle button push
    
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    j poll    #return to poll
bkey: 
    addi $v0,$t0,-66 # check for center key press
    bne $v0,$0,poll # invalid key, ignore it
####END GAME########################################################################

gameOver:
    la $a0, msgLose    ##Display loser message
    li $v0, 4
    syscall
    li $v0, 10     ##close app
    syscall
    
winner:
	la $a0, msgWin1    ##display winner message
	li $v0, 4
	syscall    
	move $a0, $s7
	li $v0, 1     ##display number of moves
	syscall
	la $a0, msgWin2    ##display winner message 2
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall  ##close app
    
##################################################################################################################
_pressedUpKey:
    addi $sp, $sp, -4
    sw $ra, 12($sp)      #saves ra to rkey
    
    
    addi $a2, $s2, -3   # sets argument for current LED to turn off
    
    jal _setLED    # turns off LED
    
    
    addi $s1, $s1, -1   #moves y argument up
    addi $a2, $s2, 0   #sets argument for next LED to green
    move $a0,$s0    #sets argument for setLED to new x value
    move $a1,$s1
    move $a2,$s2
 
    jal _setLED
    
    lw $ra, 12($sp)    #restores ra to rkey
    addi $sp, $sp, 4
    
    jr $ra

_pressedDownKey:
    addi $sp, $sp, -4
    sw $ra, 12($sp)      #saves ra to rkey
    
    
    addi $a2, $s2, -3   # sets argument for current LED to turn off
    
    jal _setLED    # turns off LED
    
    
    addi $s1, $s1, 1   #moves x to right
    addi $a2, $s2, 0   #sets argument for next LED to green
    move $a0,$s0    #sets argument for setLED to new x value
    move $a1,$s1
    move $a2,$s2
 
    jal _setLED
    
    lw $ra, 12($sp)    #restores ra to rkey
    addi $sp, $sp, 4
   
    
    jr $ra

_pressedLeftKey:
    addi $sp, $sp, -4
    sw $ra, 12($sp)      #saves ra to rkey
    
    
    addi $a2, $s2, -3   # sets argument for current LED to turn off
    
    jal _setLED    # turns off LED
    
    
    addi $s0, $s0, -1   #moves x to right
    addi $a2, $s2, 0   #sets argument for next LED to green
    move $a0,$s0    #sets argument for setLED to new x value
    move $a1,$s1
    move $a2,$s2
 
    jal _setLED
    
    lw $ra, 12($sp)    #restores ra to rkey
    addi $sp, $sp, 4
    
    jr $ra
_pressedRightKey:
    addi $sp, $sp, -4
    sw $ra, 12($sp)      #saves ra to rkey
    
    
    addi $a2, $s2, -3   # sets argument for current LED to turn off
    
    jal _setLED    # turns off LED
    
    
    addi $s0, $s0, 1   #moves x to right
    addi $a2, $s2, 0   #sets argument for next LED to green
    move $a0,$s0    #sets argument for setLED to new x value
    move $a1,$s1
    move $a2,$s2
    
    jal _setLED
    
    lw $ra, 12($sp)    #restores ra to rkey
    addi $sp, $sp, 4
    
    jr $ra

####Zombie Movement#############################################################################################

_moveZombies:

    #zombie Zero
    
    addi $sp, $sp, -4
    sw $ra, 4($sp)
    
    addi $t1, $zero, 1
    lw $t2, zombieZeroArray($t1)
    addi $t1, $t1, 4
    lw $t3, zombieZeroArray($t1)
    addi $t1, $t1, 4
    lw $t4, zombieZeroArray($t1)
    addi $t1, $t1, 4
    lw $t5, zombieZeroArray($t1)
    addi $t1, $t1, 4
    lw $t6, zombieZeroArray($t1)
    addi $t1, $t1, 4
    lw $t7, zombieZeroArray($t1)
    
    move $a0, $t2
    move $a1, $t3
    addi $a2, $zero, 1

    
    jal zombieLeft
    
    addi $t1, $zero, 1
    sw $t2, zombieZeroArray($t1)
    addi $t1, $t1, 4
    sw $t3, zombieZeroArray($t1)
    
    #zombie One
    
    addi $t1, $zero, 1
    lw $t2, zombieOneArray($t1)
    addi $t1, $t1, 4
    lw $t3, zombieOneArray($t1)
    addi $t1, $t1, 4
    lw $t4, zombieOneArray($t1)
    addi $t1, $t1, 4
    lw $t5, zombieOneArray($t1)
    addi $t1, $t1, 4
    lw $t6, zombieOneArray($t1)
    addi $t1, $t1, 4
    lw $t7, zombieOneArray($t1)
    
    move $a0, $t2
    move $a1, $t3
    addi $a2, $zero, 1

    
    jal zombieLeft
    
    addi $t1, $zero, 1
    sw $t2, zombieOneArray($t1)
    addi $t1, $t1, 4
    sw $t3, zombieOneArray($t1)
    
    #zombie Two
    
     addi $t1, $zero, 1
    lw $t2, zombieTwoArray($t1)
    addi $t1, $t1, 4
    lw $t3, zombieTwoArray($t1)
    addi $t1, $t1, 4
    lw $t4, zombieTwoArray($t1)
    addi $t1, $t1, 4
    lw $t5, zombieTwoArray($t1)
    addi $t1, $t1, 4
    lw $t6, zombieTwoArray($t1)
    addi $t1, $t1, 4
    lw $t7, zombieTwoArray($t1)
    
    move $a0, $t2
    move $a1, $t3
    addi $a2, $zero, 1

    
    jal zombieLeft
    
    addi $t1, $zero, 1
    sw $t2, zombieTwoArray($t1)
    addi $t1, $t1, 4
    sw $t3, zombieTwoArray($t1)

   #zombie Three
   
    addi $t1, $zero, 1
    lw $t2, zombieThreeArray($t1)
    addi $t1, $t1, 4
    lw $t3, zombieThreeArray($t1)
    addi $t1, $t1, 4
    lw $t4, zombieThreeArray($t1)
    addi $t1, $t1, 4
    lw $t5, zombieThreeArray($t1)
    addi $t1, $t1, 4
    lw $t6, zombieThreeArray($t1)
    addi $t1, $t1, 4
    lw $t7, zombieThreeArray($t1)
    
    move $a0, $t2
    move $a1, $t3
    addi $a2, $zero, 1

    
    jal zombieLeft
    
    addi $t1, $zero, 1
    sw $t2, zombieThreeArray($t1)
    addi $t1, $t1, 4
    sw $t3, zombieThreeArray($t1)
    
    
    la $ra 0x00400248
    jr $ra

zombieLeft:

    addi $sp, $sp, -4
    sw $ra, 8($sp)
    
    addi $a0, $a0, -1    # set argument $a0 to x-1 for _getLED (left)
    jal _getLED    # get values for LED to right
    addi $a0, $a0, 1    #restore value in $a0 to x
    beq $v1, 2, zombieRight     #if value of LED to right is yellow, try different move
    addi $a2, $a2, -1
    jal _setLED
    addi $a0, $a0, -1    # set argument $a0 to x-1 for _getLED (left)
    addi $a2, $a2, 1
    jal _setLED  # place zombie zero on the board
    
    move $t2, $a0
    move $t3, $a1
    move $t4, $a2
    
    lw $ra, 8($sp)
    addi $sp, $sp, 4
    jr $ra
    
zombieRight:

    addi $a0, $a0, 1    #set argument $a0 to x+1 for _getLED   (right)
    jal _getLED    # get values for LED to right
    addi $a0, $a0, -1    #restore value in $a0 to x
    beq $v1, 2, zombieUp     #if value of LED to right is yellow, try different move
    addi $a2, $a2, -1 
    jal _setLED
    addi $a0, $a0, 1    # set argument $a0 to x-1 for _getLED (left)
    addi $a2, $a2, 1
    jal _setLED  # place zombie zero on the board
    
    move $t2, $a0
    move $t3, $a1
    move $t4, $a2
    
    lw $ra, 8($sp)
    addi $sp, $sp, 4
    jr $ra
    
zombieUp:
    
    addi $a1, $a1, -1    # set argument $a0 to y-1 for _getLED   (up)
    jal _getLED    # get values for LED to right
    addi $a1, $a1, 1    #restore value in $a0 to x
    beq $v1, 2, zombieDown     #if value of LED to right is yellow, try different move
    addi $a2, $a2, -1
    jal _setLED
    addi $a1, $a1, -1    # set argument $a0 to x-1 for _getLED (left)
    addi $a2, $a2, 1
    jal _setLED  # place zombie zero on the board
    
    move $t2, $a0
    move $t3, $a1
    move $t4, $a2
    
    lw $ra, 8($sp)
    addi $sp, $sp, 4
    jr $ra
    
zombieDown:

    addi $a1, $a1, 1    #set argument $a0 to y+1 for _getLED    (down)
    jal _getLED    # get values for LED to right
    addi $a1, $a1, -1    #restore value in $a0 to x
    beq $v1, 2, zombieLeft     #if value of LED to right is yellow, try different move
    addi $a2, $a2, -1
    jal _setLED
    addi $a0, $a0, 1    # set argument $a0 to x-1 for _getLED (left)
    addi $a2, $a2, 1
    jal _setLED  # place zombie zero on the board
    
    move $t2, $a0
    move $t3, $a1
    move $t4, $a2
    
    lw $ra, 8($sp)
    addi $sp, $sp, 4
    jr $ra
    
##################################################################################################################
_MazePlot:
la $t1, 0xFFFF0008

#line 0
li $t0, 0xAAAAAA0A
sw $t0, 0($t1)
li $t0, 0xAAAAAAAA
sw $t0, 4($t1)
sw $t0, 8($t1)
sw $t0, 12($t1)

#line 1
li $t0, 0x0200
sh $t0, 16($t1)
li $t0, 0x0280
sh $t0, 18($t1)
sh $t0, 20($t1)
sh $t0, 22($t1)
sh $t0, 24($t1)
sh $t0, 26($t1)
sh $t0, 28($t1)
sh $t0, 30($t1)

#line 2
li $t0, 0xA28A
sh $t0, 32($t1)
sh $t0, 34($t1)
sh $t0, 36($t1)
sh $t0, 38($t1)
sh $t0, 40($t1)
sh $t0, 42($t1)
sh $t0, 44($t1)
sh $t0, 46($t1)

#line 3
li $t0, 0x2288
sh $t0, 48($t1)
sh $t0, 50($t1)
sh $t0, 52($t1)
sh $t0, 54($t1)
sh $t0, 56($t1)
sh $t0, 58($t1)
sh $t0, 60($t1)
sh $t0, 62($t1)

#line 4
li $t0, 0x2288
sh $t0, 64($t1)
sh $t0, 66($t1)
sh $t0, 68($t1)
sh $t0, 70($t1)
sh $t0, 72($t1)
sh $t0, 74($t1)
sh $t0, 76($t1)
sh $t0, 78($t1)

#line 5
li $t0, 0xA28A
sh $t0, 80($t1)
sh $t0, 82($t1)
sh $t0, 84($t1)
sh $t0, 86($t1)
sh $t0, 88($t1)
sh $t0, 90($t1)
sh $t0, 92($t1)
sh $t0, 94($t1)

#line 6
li $t0, 0x00000080
sw $t0, 96($t1)
li $t0, 0x00000000
sw $t0, 100($t1)
sw $t0, 104($t1)
li $t0, 0x02000000
sw $t0, 108($t1)

#line 7
li $t0, 0xAA8A
sh $t0, 112($t1)
sh $t0, 114($t1)
sh $t0, 116($t1)
sh $t0, 118($t1)
sh $t0, 120($t1)
sh $t0, 122($t1)
sh $t0, 124($t1)
sh $t0, 126($t1)

#line 8
li $t0, 0xAA8A
sh $t0, 128($t1)
sh $t0, 130($t1)
sh $t0, 132($t1)
sh $t0, 134($t1)
sh $t0, 136($t1)
sh $t0, 138($t1)
sh $t0, 140($t1)
sh $t0, 142($t1)

#line 9
li $t0, 0x0280
sh $t0, 144($t1)
sh $t0, 146($t1)
sh $t0, 148($t1)
sh $t0, 150($t1)
sh $t0, 152($t1)
sh $t0, 154($t1)
sh $t0, 156($t1)
sh $t0, 158($t1)

#line 10
li $t0, 0xA28A
sh $t0, 160($t1)
sh $t0, 162($t1)
sh $t0, 164($t1)
sh $t0, 166($t1)
sh $t0, 168($t1)
sh $t0, 170($t1)
sh $t0, 172($t1)
sh $t0, 174($t1)

#line 11
li $t0, 0x2288
sh $t0, 176($t1)
sh $t0, 178($t1)
sh $t0, 180($t1)
sh $t0, 182($t1)
sh $t0, 184($t1)
sh $t0, 186($t1)
sh $t0, 188($t1)
sh $t0, 190($t1)

#line 12
li $t0, 0x2288
sh $t0, 192($t1)
sh $t0, 194($t1)
sh $t0, 196($t1)
sh $t0, 198($t1)
sh $t0, 200($t1)
sh $t0, 202($t1)
sh $t0, 204($t1)
sh $t0, 206($t1)

#line 12
li $t0, 0xA28A
sh $t0, 208($t1)
sh $t0, 210($t1)
sh $t0, 212($t1)
sh $t0, 214($t1)
sh $t0, 216($t1)
sh $t0, 218($t1)
sh $t0, 220($t1)
sh $t0, 222($t1)

#line 13
li $t0, 0x00000080
sw $t0, 224($t1)
li $t0, 0x00000000
sw $t0, 228($t1)
sw $t0, 232($t1)
li $t0, 0x02000000
sw $t0, 236($t1)

#line 14
li $t0, 0xAA8A
sh $t0, 240($t1)
sh $t0, 242($t1)
sh $t0, 244($t1)
sh $t0, 246($t1)
sh $t0, 248($t1)
sh $t0, 250($t1)
sh $t0, 252($t1)
sh $t0, 254($t1)

#line 15
li $t0, 0xAA8A
sh $t0, 256($t1)
sh $t0, 258($t1)
sh $t0, 260($t1)
sh $t0, 262($t1)
sh $t0, 264($t1)
sh $t0, 266($t1)
sh $t0, 268($t1)
sh $t0, 270($t1)

#line 16
li $t0, 0x0280
sh $t0, 272($t1)
sh $t0, 274($t1)
sh $t0, 276($t1)
sh $t0, 278($t1)
sh $t0, 280($t1)
sh $t0, 282($t1)
sh $t0, 284($t1)
sh $t0, 286($t1)

#line 17
li $t0, 0xA28A
sh $t0, 288($t1)
sh $t0, 290($t1)
sh $t0, 292($t1)
sh $t0, 294($t1)
sh $t0, 296($t1)
sh $t0, 298($t1)
sh $t0, 300($t1)
sh $t0, 302($t1)

#line 18
li $t0, 0x2288
sh $t0, 304($t1)
sh $t0, 306($t1)
sh $t0, 308($t1)
sh $t0, 310($t1)
sh $t0, 312($t1)
sh $t0, 314($t1)
sh $t0, 316($t1)
sh $t0, 318($t1)

#line 19
li $t0, 0x2288
sh $t0, 320($t1)
sh $t0, 322($t1)
sh $t0, 324($t1)
sh $t0, 326($t1)
sh $t0, 328($t1)
sh $t0, 330($t1)
sh $t0, 332($t1)
sh $t0, 334($t1)

#line 20
li $t0, 0xA28A
sh $t0, 336($t1)
sh $t0, 338($t1)
sh $t0, 340($t1)
sh $t0, 342($t1)
sh $t0, 344($t1)
sh $t0, 346($t1)
sh $t0, 348($t1)
sh $t0, 350($t1)

#line 21
li $t0, 0x00000080
sw $t0, 352($t1)
li $t0, 0x00000000
sw $t0, 356($t1)
sw $t0, 360($t1)
li $t0, 0x02000000
sw $t0, 364($t1)

#line 22
li $t0, 0xAA8A
sh $t0, 368($t1)
sh $t0, 370($t1)
sh $t0, 372($t1)
sh $t0, 374($t1)
sh $t0, 376($t1)
sh $t0, 378($t1)
sh $t0, 380($t1)
sh $t0, 382($t1)

#line 23
li $t0, 0xAA8A
sh $t0, 384($t1)
sh $t0, 386($t1)
sh $t0, 388($t1)
sh $t0, 390($t1)
sh $t0, 392($t1)
sh $t0, 394($t1)
sh $t0, 396($t1)
sh $t0, 398($t1)

#line 24
li $t0, 0x0280
sh $t0, 400($t1)
sh $t0, 402($t1)
sh $t0, 404($t1)
sh $t0, 406($t1)
sh $t0, 408($t1)
sh $t0, 410($t1)
sh $t0, 412($t1)
sh $t0, 414($t1)

#line 25
li $t0, 0xA28A
sh $t0, 416($t1)
sh $t0, 418($t1)
sh $t0, 420($t1)
sh $t0, 422($t1)
sh $t0, 424($t1)
sh $t0, 426($t1)
sh $t0, 428($t1)
sh $t0, 430($t1)

#line 26
li $t0, 0x2288
sh $t0, 432($t1)
sh $t0, 434($t1)
sh $t0, 436($t1)
sh $t0, 438($t1)
sh $t0, 440($t1)
sh $t0, 442($t1)
sh $t0, 444($t1)
sh $t0, 446($t1)

#line 27
li $t0, 0x2288
sh $t0, 448($t1)
sh $t0, 450($t1)
sh $t0, 452($t1)
sh $t0, 454($t1)
sh $t0, 456($t1)
sh $t0, 458($t1)
sh $t0, 460($t1)
sh $t0, 462($t1)

#line 28
li $t0, 0xA28A
sh $t0, 464($t1)
sh $t0, 466($t1)
sh $t0, 468($t1)
sh $t0, 470($t1)
sh $t0, 472($t1)
sh $t0, 474($t1)
sh $t0, 476($t1)
sh $t0, 478($t1)

#line 29
li $t0, 0x00000080
sw $t0, 480($t1)
li $t0, 0x00000000
sw $t0, 484($t1)
sw $t0, 488($t1)
li $t0, 0x02000000
sw $t0, 492($t1)

#line 30
li $t0, 0xAA8A
sh $t0, 496($t1)
sh $t0, 498($t1)
sh $t0, 500($t1)
sh $t0, 502($t1)
sh $t0, 504($t1)
sh $t0, 506($t1)
sh $t0, 508($t1)
sh $t0, 510($t1)

#line 31
li $t0, 0xAA8A
sh $t0, 512($t1)
sh $t0, 514($t1)
sh $t0, 516($t1)
sh $t0, 518($t1)
sh $t0, 520($t1)
sh $t0, 522($t1)
sh $t0, 524($t1)
sh $t0, 526($t1)

#line 32
li $t0, 0x0280
sh $t0, 528($t1)
sh $t0, 530($t1)
sh $t0, 532($t1)
sh $t0, 534($t1)
sh $t0, 536($t1)
sh $t0, 538($t1)
sh $t0, 540($t1)
sh $t0, 542($t1)

#line 33
li $t0, 0xA28A
sh $t0, 544($t1)
sh $t0, 546($t1)
sh $t0, 548($t1)
sh $t0, 550($t1)
sh $t0, 552($t1)
sh $t0, 554($t1)
sh $t0, 556($t1)
sh $t0, 558($t1)

#line 34
li $t0, 0x2288
sh $t0, 560($t1)
sh $t0, 562($t1)
sh $t0, 564($t1)
sh $t0, 566($t1)
sh $t0, 568($t1)
sh $t0, 570($t1)
sh $t0, 572($t1)
sh $t0, 574($t1)

#line 51
li $t0, 0x2288
sh $t0, 576($t1)
sh $t0, 578($t1)
sh $t0, 580($t1)
sh $t0, 582($t1)
sh $t0, 584($t1)
sh $t0, 586($t1)
sh $t0, 588($t1)
sh $t0, 590($t1)

#line 52
li $t0, 0xA28A
sh $t0, 592($t1)
sh $t0, 594($t1)
sh $t0, 596($t1)
sh $t0, 598($t1)
sh $t0, 600($t1)
sh $t0, 602($t1)
sh $t0, 604($t1)
sh $t0, 606($t1)

#line 53
li $t0, 0x00000080
sw $t0, 608($t1)
li $t0, 0x00000000
sw $t0, 612($t1)
sw $t0, 616($t1)
li $t0, 0x02000000
sw $t0, 620($t1)

#line 54
li $t0, 0xAA8A
sh $t0, 624($t1)
sh $t0, 626($t1)
sh $t0, 628($t1)
sh $t0, 630($t1)
sh $t0, 632($t1)
sh $t0, 634($t1)
sh $t0, 636($t1)
sh $t0, 638($t1)

#line 55
li $t0, 0xAA8A
sh $t0, 640($t1)
sh $t0, 642($t1)
sh $t0, 644($t1)
sh $t0, 646($t1)
sh $t0, 648($t1)
sh $t0, 650($t1)
sh $t0, 652($t1)
sh $t0, 654($t1)

#line 56
li $t0, 0x0280
sh $t0, 656($t1)
sh $t0, 658($t1)
sh $t0, 660($t1)
sh $t0, 662($t1)
sh $t0, 664($t1)
sh $t0, 666($t1)
sh $t0, 668($t1)
sh $t0, 670($t1)

#line 57
li $t0, 0xA28A
sh $t0, 672($t1)
sh $t0, 674($t1)
sh $t0, 676($t1)
sh $t0, 678($t1)
sh $t0, 680($t1)
sh $t0, 682($t1)
sh $t0, 684($t1)
sh $t0, 686($t1)

#line 58
li $t0, 0x2288
sh $t0, 688($t1)
sh $t0, 690($t1)
sh $t0, 692($t1)
sh $t0, 694($t1)
sh $t0, 696($t1)
sh $t0, 698($t1)
sh $t0, 700($t1)
sh $t0, 702($t1)

#line 59
li $t0, 0x2288
sh $t0, 704($t1)
sh $t0, 706($t1)
sh $t0, 708($t1)
sh $t0, 710($t1)
sh $t0, 712($t1)
sh $t0, 714($t1)
sh $t0, 716($t1)
sh $t0, 718($t1)

#line 60
li $t0, 0xA28A
sh $t0, 720($t1)
sh $t0, 722($t1)
sh $t0, 724($t1)
sh $t0, 726($t1)
sh $t0, 728($t1)
sh $t0, 730($t1)
sh $t0, 732($t1)
sh $t0, 734($t1)

#line 61
li $t0, 0x00000080
sw $t0, 736($t1)
li $t0, 0x00000000
sw $t0, 740($t1)
sw $t0, 744($t1)
li $t0, 0x02000000
sw $t0, 748($t1)

#line 62
li $t0, 0xAA8A
sh $t0, 752($t1)
sh $t0, 754($t1)
sh $t0, 756($t1)
sh $t0, 758($t1)
sh $t0, 760($t1)
sh $t0, 762($t1)
sh $t0, 764($t1)
sh $t0, 766($t1)

#line 63
li $t0, 0xAA8A
sh $t0, 768($t1)
sh $t0, 770($t1)
sh $t0, 772($t1)
sh $t0, 774($t1)
sh $t0, 776($t1)
sh $t0, 778($t1)
sh $t0, 780($t1)
sh $t0, 782($t1)

#line 1
li $t0, 0x0280
sh $t0, 784($t1)
sh $t0, 786($t1)
sh $t0, 788($t1)
sh $t0, 790($t1)
sh $t0, 792($t1)
sh $t0, 794($t1)
sh $t0, 796($t1)
sh $t0, 798($t1)

#line 2
li $t0, 0xA28A
sh $t0, 800($t1)
sh $t0, 802($t1)
sh $t0, 804($t1)
sh $t0, 806($t1)
sh $t0, 808($t1)
sh $t0, 810($t1)
sh $t0, 812($t1)
sh $t0, 814($t1)

#line 3
li $t0, 0x2288
sh $t0, 816($t1)
sh $t0, 818($t1)
sh $t0, 820($t1)
sh $t0, 822($t1)
sh $t0, 824($t1)
sh $t0, 826($t1)
sh $t0, 828($t1)
sh $t0, 830($t1)

#line 4
li $t0, 0x2288
sh $t0, 832($t1)
sh $t0, 834($t1)
sh $t0, 836($t1)
sh $t0, 838($t1)
sh $t0, 840($t1)
sh $t0, 842($t1)
sh $t0, 844($t1)
sh $t0, 846($t1)

#line 5
li $t0, 0xA28A
sh $t0, 848($t1)
sh $t0, 850($t1)
sh $t0, 852($t1)
sh $t0, 854($t1)
sh $t0, 856($t1)
sh $t0, 858($t1)
sh $t0, 860($t1)
sh $t0, 862($t1)

#line 6
li $t0, 0x00000080
sw $t0, 864($t1)
li $t0, 0x00000000
sw $t0, 868($t1)
sw $t0, 872($t1)
li $t0, 0x02000000
sw $t0, 876($t1)

#line 7
li $t0, 0xAA8A
sh $t0, 880($t1)
sh $t0, 882($t1)
sh $t0, 884($t1)
sh $t0, 886($t1)
sh $t0, 888($t1)
sh $t0, 890($t1)
sh $t0, 892($t1)
sh $t0, 894($t1)

#line 8
li $t0, 0xAA8A
sh $t0, 896($t1)
sh $t0, 898($t1)
sh $t0, 900($t1)
sh $t0, 902($t1)
sh $t0, 904($t1)
sh $t0, 906($t1)
sh $t0, 908($t1)
sh $t0, 910($t1)

#line 9
li $t0, 0x0280
sh $t0, 912($t1)
sh $t0, 914($t1)
sh $t0, 916($t1)
sh $t0, 918($t1)
sh $t0, 920($t1)
sh $t0, 922($t1)
sh $t0, 924($t1)
sh $t0, 926($t1)

#line 10
li $t0, 0xA28A
sh $t0, 928($t1)
sh $t0, 930($t1)
sh $t0, 932($t1)
sh $t0, 934($t1)
sh $t0, 936($t1)
sh $t0, 938($t1)
sh $t0, 940($t1)
sh $t0, 942($t1)

#line 11
li $t0, 0x2288
sh $t0, 944($t1)
sh $t0, 946($t1)
sh $t0, 948($t1)
sh $t0, 950($t1)
sh $t0, 952($t1)
sh $t0, 954($t1)
sh $t0, 956($t1)
sh $t0, 958($t1)

#line 12
li $t0, 0x2288
sh $t0, 960($t1)
sh $t0, 962($t1)
sh $t0, 964($t1)
sh $t0, 966($t1)
sh $t0, 968($t1)
sh $t0, 970($t1)
sh $t0, 972($t1)
sh $t0, 974($t1)

#line 12
li $t0, 0xA28A
sh $t0, 976($t1)
sh $t0, 978($t1)
sh $t0, 980($t1)
sh $t0, 982($t1)
sh $t0, 984($t1)
sh $t0, 986($t1)
sh $t0, 988($t1)
sh $t0, 990($t1)

#line 13
li $t0, 0x00000080
sw $t0, 992($t1)
li $t0, 0x00000000
sw $t0, 996($t1)
sw $t0, 1000($t1)
li $t0, 0x02000000
sw $t0, 1004($t1)

#line 0
li $t0, 0xAAAAAAAA
sw $t0, 1008($t1)
sw $t0, 1012($t1)
sw $t0, 1016($t1)
li $t0, 0xA0AAAAAA
sw $t0, 1020($t1)

jr $ra


	
##################################################################################################################	
	
	
	# void _setLED(int x, int y, int color)
	#   sets the LED at (x,y) to color
	#   color: 0=off, 1=red, 2=yellow, 3=green
	#
	# arguments: $a0 is x, $a1 is y, $a2 is color
	# trashes:   $t0-$t3
	# returns:   none
	#
_setLED:
	# byte offset into display = y * 16 bytes + (x / 4)
	sll	$t0,$a1,4      # y * 16 bytes
	srl	$t1,$a0,2      # x / 4
	add	$t0,$t0,$t1    # byte offset into display
	li	$t2,0xffff0008 # base address of LED display
	add	$t0,$t2,$t0    # address of byte with the LED
	# now, compute led position in the byte and the mask for it
	andi	$t1,$a0,0x3    # remainder is led position in byte
	neg	$t1,$t1        # negate position for subtraction
	addi	$t1,$t1,3      # bit positions in reverse order
	sll	$t1,$t1,1      # led is 2 bits
	# compute two masks: one to clear field, one to set new color
	li	$t2,3		
	sllv	$t2,$t2,$t1
	not	$t2,$t2        # bit mask for clearing current color
	sllv	$t1,$a2,$t1    # bit mask for setting color
	# get current LED value, set the new field, store it back to LED
	lbu	$t3,0($t0)     # read current LED value	
	and	$t3,$t3,$t2    # clear the field for the color
	or	$t3,$t3,$t1    # set color field
	sb	$t3,0($t0)     # update display
	jr	$ra
	
	# int _getLED(int x, int y)
	#   returns the value of the LED at position (x,y)
	#
	#  arguments: $a0 holds x, $a1 holds y
	#  trashes:   $t0-$t2
	#  returns:   $v1 holds the value of the LED (0, 1, 2 or 3)
	#
_getLED:
	# byte offset into display = y * 16 bytes + (x / 4)
	sll  $t0,$a1,4      # y * 16 bytes
	srl  $t1,$a0,2      # x / 4
	add  $t0,$t0,$t1    # byte offset into display
	la   $t2,0xffff0008
	add  $t0,$t2,$t0    # address of byte with the LED
	# now, compute bit position in the byte and the mask for it
	andi $t1,$a0,0x3    # remainder is bit position in byte
	neg  $t1,$t1        # negate position for subtraction
	addi $t1,$t1,3      # bit positions in reverse order
    	sll  $t1,$t1,1      # led is 2 bits
	# load LED value, get the desired bit in the loaded byte
	lbu  $t2,0($t0)
	srlv $t2,$t2,$t1    # shift LED value to lsb position
	andi $v1,$t2,0x3    # mask off any remaining upper bits
	jr   $ra
