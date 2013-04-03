	Title MainProgram
	.model small
	.stack 100H
	.Data
		 mark db '>>>>>>>>>>>>>>>>>>>>'

		 ;Strings
		 	 ;Format: active, x, y, dir, col, bgfg, len, 'String'
			 str1 db 1, 1, 1, 3, 0, 012H, 8, 'BAAAAAAA'
			 str2 db 1, 5, 2, 9, 0, 012H, 8, 'CBBBBBBB'
			 str3 db 1, 10, 3, 1, 0, 012H, 8, 'DCCCCCCC'
			 str4 db 1, 40, 5, 7, 0, 012H, 8, 'EDDDDDDD'
			 str5 db 1, 30, 4, 9, 0, 012H, 8, 'FEEEEEEE'
			 str6 db 1, 20, 6, 7, 0, 012H, 8, 'GFFFFFFF'

		 ;Current String
		 	 active db ?
		 	 x db ?
		 	 y db ?
		 	 dir db ?
		 	 col db ?
		 	 bgfg db ?
		 	 len db ? 

		 ;Shadow variables
		 	 ;Format: x1,y1,x2,y2,x3,y3,len1,len2,len3
		 	 shadows1 db 1,1,1,1,1,1,8,8,8
		 	 shadows2 db 5,2,5,2,5,2,8,8,8
		 	 shadows3 db 10,3,10,3,10,3,8,8,8
		 	 shadows4 db 40,5,40,5,40,5,8,8,8
		 	 shadows5 db 30,4,30,4,30,4,8,8,8
		 	 shadows6 db 1,20,1,20,1,20,8,8,8

		 	 ;Shadow addresses
		 	 address1 dw ?
		 	 address2 dw ?
		 	 address3 dw ?

		 	 auxX db ?
		 	 auxY db ?

		 ;Corner
		 rightWall db 67

		 ;Address to print on screen
		 screenAddr dw 0

		 ;Paddles
		 paddleA dw 0DF00H
		 x_A db 15
		 y_A db 20
		 A_moved db 0

		 paddleB dw 03F00H
		 x_B db 50
		 y_B db 20
		 B_moved db 0

		 ;Load keyboard
	     keyboardBuffer label byte
	     bufferLength db 13
	     nameLength db 0
	     playerName db 13 dup('$')

	     TestMarker db '>>>>>>>>>>>>>>>>>>>>'

	     ;Messages
	     message1 db 'Please input your name: $' 
	     message2 db 'Press any key to start a new game.$'

	     ;Auxiliary variables
	     TwoB db 2
	     OneSixtyB db 160

	     ;Score variables
	     scoreLen db ?
	     currScore dw 0
	     finalScore dw 0
	     ;Nombre: playerName
	     ;Address: screenAddr
	     scoreCol db ?
	     scoreLine db ?
	     topScore dw 1000,800,600,400,200
	     tempTop dw 0,0,0,0,0
	     nombre1 db 'Navarro$$$$$$'
	     nombre2 db 'Navarro$$$$$$'
	     nombre3 db 'Navarro$$$$$$'
	     nombre4 db 'Navarro$$$$$$'
	     nombre5 db 'Navarro$$$$$$'

	     palabra db 'ACTUAL SCORE$'
	     palabra1 db 'Top 5'
	     palabra2 db 'HIGHSCORE '
	     five dw 5


	     ;Game state variables
	     markHS db 0
	     gameOver db 0
	     gameSpeed dw 30000


	     
	     ;Background with blue text.
	     backgroundBlueT dw 2000 dup (0100H)

	     ;July 14, 2012
	     ;By Angelica Hernandez
	     ;Starting background.
		 startBackground dw 1 dup(0F00H), 78 dup(0EE00H) 
		 	 dw 1 dup(0F00H), 1 dup(0AA00H), 1 dup(0FF00H), 76 dup(0EE00H), 1 dup(0FF00H), 1 dup(4400H), 2 dup(0AA00H)
			 dw 76 dup(0F00H), 2 dup(4400H), 2 dup(0AA00H), 76 dup(0F00H), 2 dup(4400H), 2 dup(0AA00H), 76 dup(0F00H), 2 dup(4400H)
			 dw 2 dup(0AA00H), 76 dup(0F00H), 2 dup(4400H), 2 dup(0AA00H), 16 dup(0F00H), 2 dup(4400H), 3 dup(0F00H), 2 dup(4400H), 5 dup(0F00H), 4 dup(4400H), 1 dup(0F00H), 5 dup(4400H), 1 dup(0F00H), 3 dup(4400H), 2 dup(0F00H), 5 dup(4400H)
			 dw 1 dup(0F00H), 1 dup(4400H), 3 dup(0F00H), 1 dup(4400H), 1 dup(0F00H), 5 dup(4400H), 15 dup(0F00H), 2 dup(4400H), 2 dup (0AA00H), 7 dup(0F00H), 4 dup(6600H), 6 dup(0F00H), 2 dup(4400H)
			 dw 1 dup(0F00H), 2 dup(4400H), 6 dup(0F00H), 1 dup(4400H), 6 dup(0F00H), 1 dup(4400H), 3 dup(0F00H), 1 dup(4400H), 2 dup(0F00H)
			 dw 1 dup(4400H), 3 dup(0F00H), 1 dup(4400H), 3 dup(0F00H), 2 dup(4400H), 2 dup(0F00H), 1 dup(4400H), 1 dup(0F00H), 1 dup(4400H), 19 dup(0F00H), 2 dup(4400H)
			 dw 2 dup(0AA00H), 5 dup(0F00H), 3 dup(6600H), 2 dup(0FF00H), 3 dup(6600H), 5 dup(0F00H), 3 dup(4400H), 3 dup(0F00H), 2 dup(4400H), 2 dup(0F00H), 3 dup(4400H), 4 dup(0F00H), 1 dup(4400H), 3 dup(0F00H), 3 dup(4400H), 4 dup(0F00H) 
			 dw 1 dup(4400H), 3 dup(0F00H), 1 dup(4400H), 1 dup(0F00H), 1 dup(4400H), 1 dup(0F00H), 1 dup(4400H), 1 dup(0F00H), 1 dup(4400H), 1 dup(0F00H), 2 dup(4400H), 8 dup(0F00H), 2 dup(6600H), 6 dup(0F00H), 2 dup(4400H)
			 dw 2 dup(0AA00H), 4 dup(0F00H), 2 dup(6600H), 6 dup(0FF00H), 2 dup(6600H), 3 dup(0F00H), 2 dup(4400H), 1 dup(0F00H), 2 dup(4400H), 8 dup(0F00H) 
			 dw 1 dup(4400H), 4 dup(0F00H), 1 dup(4400H), 3 dup(0F00H), 1 dup(4400H), 1 dup(0F00H), 1 dup(4400H)
			 dw 4 dup(0F00H), 1 dup(4400H), 3 dup(0F00H), 1 dup(4400H), 2 dup(0F00H), 2 dup(4400H), 1 dup(0F00H), 1 dup(4400H), 2 dup(0F00H), 1 dup(4400H), 6 dup(0F00H), 4 dup(6600H), 6 dup(0F00H), 2 dup(4400H)
			 dw 2 dup(0AA00H), 3 dup(0F00H), 2 dup(6600H), 1 dup(4400H), 2 dup(0FF00H), 2 dup(4400H), 2 dup(0FF00H), 1 dup(4400H)
			 dw 2 dup(6600H), 1 dup(0F00H), 2 dup(4400H), 3 dup(0F00H), 2 dup(4400H), 4 dup(0F00H), 4 dup(4400H), 4 dup(0F00H), 1 dup(4400H)
			 dw 3 dup(0F00H), 1 dup(4400H), 1 dup(0F00H), 2 dup(4400H), 1 dup(0F00H) 
			 dw 5 dup(4400H), 1 dup(0F00H), 1 dup(4400H), 3 dup(0F00H), 1 dup(4400H), 1 dup(0F00H), 4 dup(4400H), 4 dup(0F00H), 2 dup(6600H), 1 dup(0F00H), 1 dup(6600H), 8 dup(0F00H), 2 dup(4400H)
			 dw 2 dup(0AA00H), 3 dup(0F00H), 1 dup(6600H), 1 dup(0FF00H), 8 dup(4400H), 1 dup(0FF00H), 1 dup(6600H), 48 dup(0F00H), 1 dup(6600H), 3 dup(0F00H), 1 dup(6600H), 8 dup(0F00H), 2 dup(4400H), 2 dup(0AA00H), 2 dup(0F00H)
			 dw 2 dup(6600H), 1 dup(0FF00H), 8 dup(4400H), 1 dup(0FF00H), 2 dup(6600H), 43 dup(0F00H)
			 dw 3 dup(4400H), 1 dup(6600H), 3 dup(0F00H), 1 dup(6600H), 9 dup(0F00H), 2 dup(4400H), 2 dup(0AA00H), 2 dup(0F00H), 1 dup(6600H), 3 dup(0FF00H), 2 dup(4400H)
			 dw 2 dup(0FF00H), 2 dup(4400H), 3 dup(0FF00H), 1 dup(6600H), 42 dup(0F00H), 3 dup(4400H), 1 dup(6600H), 2 dup(4400H) 
			 dw 1 dup(0F00H), 1 dup(6600H), 10 dup(0F00H), 2 dup(4400H), 2 dup(0AA00H), 2 dup(0F00H), 1 dup(6600H), 3 dup(0FF00H)
			 dw 1 dup(4400H), 4 dup(0FF00H), 1 dup(4400H), 3 dup(0FF00H), 1 dup(6600H), 12 dup(0F00H), 4 dup(0AA00H), 1 dup(0F00H)
			 dw 4 dup(0AA00H), 1 dup(0F00H), 1 dup(0AA00H), 3 dup(0F00H), 1 dup(0AA00H), 1 dup(0F00H), 5 dup(0AA00H), 9 dup(0F00H), 5 dup(4400H), 1 dup(0F00H), 1 dup(4400H), 1 dup(6600H), 2 dup(4400H) 
			 dw 8 dup(0F00H), 2 dup(4400H), 2 dup(0AA00H), 2 dup(0F00H), 1 dup(6600H), 4 dup(4400H), 4 dup(0FF00H), 4 dup(4400H), 1 dup(6600H)
			 dw 12 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 1 dup(0F00H), 1 dup(0AA00H)
			 dw 2 dup(0F00H), 1 dup(0AA00H), 1 dup(0F00H), 2 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 1 dup(0F00H), 1 dup(0AA00H)
			 dw 13 dup(0F00H), 1 dup(4400H), 1 dup(0FF00H), 2 dup(4400H), 1 dup(0F00H), 2 dup(4400H), 1 dup(6600H), 3 dup(4400H), 7 dup(0F00H), 2 dup(4400H)
			 dw 2 dup(0AA00H), 2 dup(0F00H), 1 dup(6600H), 2 dup(4400H), 8 dup(6600H), 2 dup(4400H), 1 dup(6600H), 12 dup(0F00H), 4 dup(0AA00H), 1 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 1 dup(0F00H), 1 dup(0AA00H)
			 dw 1 dup(0F00H), 1 dup(0AA00H), 1 dup(0F00H), 1 dup(0AA00H), 1 dup(0F00H), 1 dup(0AA00H), 1 dup(0F00H), 2 dup(0AA00H), 10 dup(0F00H)
			 dw 2 dup(4400H), 1 dup(0FF00H), 1 dup(4400H), 1 dup(0F00H), 6 dup(4400H), 7 dup(0F00H), 2 dup(4400H)
			 dw 2 dup(0AA00H), 2 dup(0F00H), 4 dup(6600H), 1 dup(0FF00H), 1 dup(6600H), 2 dup(0FF00H), 1 dup(6600H), 1 dup(0FF00H), 4 dup(6600H), 12 dup(0F00H), 1 dup(0AA00H), 4 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H)
			 dw 1 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 2 dup(0AA00H), 1 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H)
			 dw 11 dup(0F00H), 3 dup(4400H), 1 dup(0F00H), 1 dup(4400H), 1 dup(0FF00H), 4 dup(4400H), 7 dup(0F00H), 2 dup(4400H)
			 dw 2 dup(0AA00H), 3 dup(0F00H), 2 dup(6600H), 2 dup(0FF00H), 1 dup(6600H), 2 dup(0FF00H), 1 dup(6600H), 2 dup(0FF00H), 2 dup(6600H), 13 dup(0F00H), 1 dup(0AA00H), 4 dup(0F00H), 4 dup(0AA00H), 1 dup(0F00H), 1 dup(0AA00H)
			 dw 3 dup(0F00H), 1 dup(0AA00H), 1 dup(0F00H), 4 dup(0AA00H), 15 dup(0F00H), 2 dup(4400H), 1 dup(0FF00H), 3 dup(4400H)
			 dw 7 dup(0F00H), 2 dup(4400H), 2 dup(0AA00H), 4 dup(0F00H), 1 dup(6600H), 8 dup(0FF00H), 1 dup(6600H)
			 dw 50 dup(0F00H), 4 dup(4400H), 8 dup(0F00H), 2 dup(4400H), 2 dup(0AA00H), 4 dup(0F00H), 2 dup(6600H), 6 dup(0FF00H), 2 dup(6600H), 62 dup(0F00H), 2 dup(4400H), 2 dup(0AA00H), 5 dup(0F00H), 8 dup(6600H), 63 dup(0F00H)
			 dw 2 dup(4400H), 2 dup(0AA00H), 76 dup(0F00H), 2 dup(4400H), 1 dup(0AA00H), 1 dup(0FF00H), 76 dup(1100H), 1 dup(0FF00H), 1 dup(4400H), 1 dup(0F00H), 78 dup(1100H), 1 dup(0F00H)

		 ;July 15, 2012
		 ;By Angelica Hernandez
	 	 ;Gameplay background.
	 	 gameBackground dw 80 dup(0F00H)
			 dw 29 dup(0F00H), 10 dup(0CC00H), 14 dup(0F00H), 10 dup(0AA00H), 17 dup(0F00H)
			 dw 27 dup(0F00H), 13 dup(0CC00H), 11 dup(0F00H), 13 dup(0AA00H), 16 dup(0F00H)
			 dw 9 dup(0F00H), 5 dup(0EE00H), 13 dup(0F00H), 14 dup(0CC00H), 10 dup(0F00H), 14 dup(0AA00H), 15 dup(0F00H)
			 dw 8 dup(0F00H), 8 dup(0EE00H), 10 dup(0F00H), 16 dup(0CC00H), 8 dup(0F00H), 16 dup(0AA00H), 14 dup(0F00H)
			 dw 6 dup(0F00H), 11 dup(0EE00H), 8 dup(0F00H), 17 dup(0CC00H), 7 dup(0F00H), 17 dup(0AA00H), 14 dup(0F00H)
			 dw 5 dup(0F00H), 14 dup(0EE00H), 5 dup(0F00H), 18 dup(0CC00H), 6 dup(0F00H), 18 dup(0AA00H), 14 dup(0F00H)
			 dw 5 dup(0F00H), 14 dup(0EE00H), 5 dup(0F00H), 2 dup(0CC00H), 5 dup(0FF00H), 1 dup(0CC00H), 5 dup(0FF00H), 5 dup(0CC00H), 6 dup(0F00H), 2 dup(0AA00H), 5 dup(0FF00H), 1 dup(0AA00H), 5 dup(0FF00H), 5 dup(0AA00H), 14 dup(0F00H)
			 dw 3 dup(0F00H), 18 dup(0EE00H), 3 dup(0F00H), 2 dup(0CC00H), 5 dup(0FF00H), 1 dup(0CC00H), 5 dup(0FF00H), 5 dup(0CC00H), 6 dup(0F00H), 2 dup(0AA00H), 5 dup(0FF00H), 1 dup(0AA00H), 5 dup(0FF00H), 5 dup(0AA00H), 14 dup(0F00H)
			 dw 3 dup(0F00H), 14 dup(0EE00H), 7 dup(0F00H), 2 dup(0CC00H), 2 dup(0FF00H), 1 dup(9900H), 2 dup(0FF00H)
			 dw 1 dup(0CC00H), 2 dup(0FF00H), 1 dup(9900H), 2 dup(0FF00H), 5 dup(0CC00H), 6 dup(0F00H), 2 dup(0AA00H)
			 dw 2 dup(0FF00H), 1 dup(9900H), 2 dup(0FF00H), 1 dup(0AA00H), 2 dup(0FF00H), 1 dup(9900H), 2 dup(0FF00H), 5 dup(0AA00H), 14 dup(0F00H)
			 dw 3 dup(0F00H), 14 dup(0EE00H), 7 dup(0F00H), 2 dup(0CC00H), 2 dup(0FF00H), 1 dup(9900H), 2 dup(0FF00H)
			 dw 1 dup(0CC00H), 2 dup(0FF00H), 1 dup(9900H), 2 dup(0FF00H), 5 dup(0CC00H), 6 dup(0F00H), 2 dup(0AA00H), 2 dup(0FF00H), 1 dup(9900H), 2 dup(0FF00H), 1 dup(0AA00H), 2 dup(0FF00H), 1 dup(9900H), 2 dup(0FF00H), 5 dup(0AA00H), 14 dup(0F00H)
			 dw 2 dup(0F00H), 11 dup(0EE00H), 11 dup(0F00H), 2 dup(0CC00H), 2 dup(0FF00H), 1 dup(9900H), 2 dup(0FF00H)
			 dw 1 dup(0CC00H), 2 dup(0FF00H), 1 dup(9900H), 2 dup(0FF00H), 5 dup(0CC00H), 6 dup(0F00H), 2 dup(0AA00H), 2 dup(0FF00H), 1 dup(9900H), 2 dup(0FF00H), 1 dup(0AA00H), 2 dup(0FF00H), 1 dup(9900H), 2 dup(0FF00H), 5 dup(0AA00H), 14 dup(0F00H)
			 dw 2 dup(0F00H), 11 dup(0EE00H), 11 dup(0F00H), 2 dup(0CC00H), 5 dup(0FF00H), 1 dup(0CC00H),  5 dup(0FF00H)
			 dw 5 dup(0CC00H), 2 dup(0F00H), 2 dup(0EE00H), 2 dup(0F00H), 2 dup(0AA00H), 5 dup(0FF00H), 1 dup(0AA00H), 5 dup(0FF00H), 5 dup(0AA00H), 14 dup(0F00H)
			 dw 2 dup(0F00H), 10 dup(0EE00H), 4 dup(0F00H), 1 dup(0EE00H), 4 dup(0F00H), 1 dup(0EE00H), 2 dup(0F00H), 2 dup(0CC00H)
			 dw 5 dup(0FF00H), 1 dup(0CC00H),  5 dup(0FF00H), 5 dup(0CC00H), 2 dup(0F00H), 2 dup(0EE00H), 2 dup(0F00H), 2 dup(0AA00H), 5 dup(0FF00H), 1 dup(0AA00H), 5 dup(0FF00H), 5 dup(0AA00H), 14 dup(0F00H)  
			 dw 2 dup(0F00H), 11 dup(0EE00H), 11 dup(0F00H), 18 dup(0CC00H), 6 dup(0F00H), 18 dup(0AA00H), 14 dup(0F00H)  
			 dw 2 dup(0F00H), 11 dup(0EE00H), 11 dup(0F00H), 18 dup(0CC00H), 6 dup(0F00H), 18 dup(0AA00H), 14 dup(0F00H)
			 dw 3 dup(0F00H), 14 dup(0EE00H), 7 dup(0F00H), 18 dup(0CC00H), 6 dup(0F00H), 18 dup(0AA00H), 14 dup(0F00H)
			 dw 3 dup(0F00H), 14 dup(0EE00H), 7 dup(0F00H), 18 dup(0CC00H), 6 dup(0F00H), 18 dup(0AA00H), 14 dup(0F00H)
			 dw 3 dup(0F00H), 18 dup(0EE00H), 3 dup(0F00H), 18 dup(0CC00H), 6 dup(0F00H), 18 dup(0AA00H), 14 dup(0F00H)
			 dw 5 dup(0F00H), 14 dup(0EE00H), 5 dup(0F00H), 18 dup(0CC00H), 6 dup(0F00H), 18 dup(0AA00H), 14 dup(0F00H)
			 dw 5 dup(0F00H), 14 dup(0EE00H), 5 dup(0F00H), 18 dup(0CC00H), 6 dup(0F00H), 18 dup(0AA00H), 14 dup(0F00H)
			 dw 6 dup(0F00H), 11 dup(0EE00H), 7 dup(0F00H), 18 dup(0CC00H), 6 dup(0F00H), 18 dup(0AA00H), 14 dup(0F00H)
			 dw 8 dup(0F00H), 8 dup(0EE00H), 8 dup(0F00H), 4 dup(0CC00H), 3 dup(0F00H), 4 dup(0CC00H), 3 dup(0F00H), 4 dup(0CC00H), 6 dup(0F00H), 4 dup(0AA00H), 3 dup(0F00H), 4 dup(0AA00H), 3 dup(0F00H), 4 dup(0AA00H), 14 dup(0F00H)
			 dw 9 dup(0F00H), 5 dup(0EE00H), 11 dup(0F00H), 2 dup(0CC00H), 5 dup(0F00H), 2 dup(0CC00H), 5 dup(0F00H), 2 dup(0CC00H), 8 dup(0F00H), 2 dup(0AA00H), 5 dup(0F00H), 2 dup(0AA00H), 5 dup(0F00H), 2 dup(0AA00H), 14 dup(0F00H) 
			 dw 81 dup(0F00H) 

		 ;July 16, 2012
		 ;By Angelica Hernandez
		 ;Game over, regular score background.		 
		 overRegularScore dw 1 dup(5F00H), 78 dup(0EE00H), 1 dup(05F00H) 
			 dw 1 dup(0AA00H), 1 dup(0F00H), 76 dup(0EE00H), 1 dup(0F00H), 1 dup(0CC00H)
			 dw 2 dup(0AA00H), 76 dup(05F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 76 dup(05F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 76 dup(05F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 10 dup(05F00H), 6 dup(0F00H), 7 dup(05F00H), 28 dup(0F00H), 7 dup(05F00H), 5 dup(0CC00H), 13 dup(05F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 8 dup(05F00H), 2 dup(0F00H), 6 dup(1100H), 2 dup(0F00H), 5 dup(05F00H), 1 dup(0F00H), 5 dup(0CC00H), 2 dup(0F00H)
			 dw 3 dup(0CC00H), 3 dup(0F00H), 1 dup(0CC00H), 5 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H), 4 dup(0CC00H), 1 dup(0F00H), 6 dup(05F00H), 9 dup(0CC00H), 10 dup(05F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 7 dup(5F00H), 1 dup(0F00H), 2 dup(1100H), 1 dup(8800H), 4 dup(7700H), 1 dup(8800H), 2 dup(1100H), 1 dup(0F00H), 4 dup(5F00H)
			 dw 1 dup(0F00H), 1 dup(0CC00H), 5 dup(0F00H), 1 dup(0CC00H), 3 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H), 2 dup(0CC00H), 3 dup(0F00H), 2 dup(0CC00H)
			 dw 2 dup(0F00H), 1 dup(0CC00H), 4 dup(0F00H), 6 dup(5F00H), 3 dup(0F00H), 2 dup(7700H), 1 dup(0F00H), 1 dup(7700H), 12 dup(5F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 6 dup(05F00H), 1 dup(0F00H), 2 dup(1100H), 1 dup(8800H), 6 dup(7700H), 1 dup(8800H), 2 dup(1100H), 1 dup(0F00H), 3 dup(5F00H)
			 dw 1 dup(0F00H), 1 dup(0CC00H), 1 dup(0F00H), 2 dup(0CC00H), 2 dup(0F00H), 5 dup(0CC00H), 2 dup(0F00H), 1 dup(0CC00H), 1 dup(0F00H), 1 dup(0CC00H)
			 dw 1 dup(0F00H), 1 dup(0CC00H), 1 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H), 3 dup(0CC00H), 2 dup(0F00H), 5 dup(5F00H), 1 dup(0F00H), 1 dup(7700H), 1 dup(0F00H), 3 dup(7700H), 1 dup(0F00H), 3 dup(7700H), 10 dup(5F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 6 dup(5F00H), 1 dup(0F00H), 1 dup(1100H), 1 dup(8800H), 2 dup(7700H), 1 dup(1100H), 2 dup(7700H), 1 dup(1100H), 2 dup(7700H)
			 dw 1 dup(8800H), 1 dup(1100H), 1 dup(0F00H), 3 dup(5F00H), 1 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H), 1 dup(0CC00H)
			 dw 3 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H), 1 dup(0CC00H)
			 dw 4 dup(0F00H), 5 dup(5F00H), 1 dup(0F00H), 1 dup(7700H), 2 dup(0F00H), 3 dup(7700H), 1 dup(0F00H), 3 dup(7700H), 9 dup(5F00h), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 5 dup(5F00H), 1 dup(0F00H), 2 dup(1100H), 1 dup(8800H), 1 dup(7700H), 2 dup(1100H), 2 dup(7700H), 2 dup(1100H), 1 dup(7700H)
			 dw 1 dup(8800H), 2 dup(1100H), 1 dup(0F00H), 2 dup(5F00H), 1 dup(0F00H), 4 dup(0CC00H), 2 dup(0F00H), 1 dup(0CC00H), 3 dup(0F00H), 1 dup(0CC00H)
			 dw 2 dup(0F00H), 1 dup(0CC00H), 5 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H), 4 dup(0CC00H), 1 dup(0F00H), 5 dup(5F00H), 2 dup(0F00H), 4 dup(7700H), 4 dup(0F00H), 10 dup(5F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 5 dup(5F00H), 1 dup(0F00H), 1 dup(1100H), 2 dup(8800H), 1 dup(7700H), 2 dup(1100H), 2 dup(7700H), 2 dup(1100H), 1 dup(7700H)
			 dw 2 dup(8800H), 1 dup(1100H), 1 dup(0F00H), 2 dup(5F00H), 28 dup(0F00H), 7 dup(5F00H), 7 dup(7700H), 11 dup(5F00H), 2 dup(0CC00H) 
			 dw 2 dup(0AA00H), 5 dup(5F00H), 1 dup(0F00H), 1 dup(1100H), 3 dup(8800H), 6 dup(7700H), 3 dup(8800H), 1 dup(1100H), 1 dup(0F00H), 36 dup(5F00H)
			 dw 2 dup(0F00H), 1 dup(0CC00H), 3 dup(0F00H), 13 dup(5F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 5 dup(5F00H), 1 dup(0F00H), 1 dup(1100H), 3 dup(8800H), 2 dup(7700H), 2 dup(1100H),  2 dup(7700H), 3 dup(8800H), 1 dup(1100H)
			 dw 1 dup(0F00H), 2 dup(5F00H), 28 dup(0F00H), 5 dup(5F00H), 3 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H), 1 dup(0CC00H), 3 dup(0F00H), 10 dup(5F00H), 2 dup(0CC00H) 
			 dw 2 dup(0AA00H), 5 dup(5F00H), 1 dup(0F00H), 2 dup(1100H), 1 dup(8800H), 8 dup(1100H), 1 dup(8800H), 2 dup(1100H), 1 dup(0F00H), 2 dup(5F00H), 1 dup(0F00H)
			 dw 5 dup(0CC00H), 2 dup(0F00H), 1 dup(0CC00H), 5 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H), 4 dup(0CC00H), 2 dup(0F00H), 3 dup(0CC00H), 2 dup(0F00H), 4 dup(5F00H)
			 dw 4 dup(0F00H), 4 dup(0CC00H), 4 dup(0F00H), 9 dup(5F00H), 2 dup(0CC00H)  
			 dw 2 dup(0AA00H), 5 dup(5F00H), 1 dup(0F00H), 3 dup(1100H), 8 dup(0F00H), 3 dup(1100H), 1 dup(0F00H), 2 dup(5F00H), 1 dup(0F00H), 1 dup(0CC00H), 3 dup(0F00H)
			 dw 1 dup(0CC00H), 3 dup(0F00H), 1 dup(0CC00H), 3 dup(0F00H), 1 dup(0CC00H), 3 dup(0F00H), 1 dup(0CC00H), 5 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H)
			 dw 1 dup(0CC00H), 1 dup(0F00H), 4 dup(5F00H), 2 dup(7700H), 1 dup(0F00H), 1 dup(0CC00H), 1 dup(0EE00H), 2 dup(0CC00H), 1 dup(0EE00H), 1 dup(0CC00H)
			 dw 1 dup(0F00H), 2 dup(7700H), 9 dup(5F00H), 2 dup(0CC00H) 
			 dw 2 dup(0AA00H), 6 dup(5F00H), 1 dup(0F00H), 1 dup(1100H), 1 dup(0F00H), 1 dup(7700H), 1 dup(0F00H), 4 dup(7700H), 1 dup(0F00H)
			 dw 1 dup(7700H), 1 dup(0F00H), 1 dup(1100H), 1 dup(0F00H), 3 dup(5F00H), 1 dup(0F00H), 1 dup(0CC00H), 3 dup(0F00H), 1 dup(0CC00H), 4 dup(0F00H), 1 dup(0CC00H)
			 dw 1 dup(0F00H), 1 dup(0CC00H), 4 dup(0F00H), 3 dup(0CC00H), 3 dup(0F00H), 3 dup(0CC00H), 2 dup(0F00H), 4 dup(5F00H), 3 dup(7700H), 6 dup(0CC00H), 3 dup(7700H), 9 dup(5F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 7 dup(5F00H), 1 dup(0F00H), 1 dup(7700H), 1 dup(0FF00H), 2 dup(0F00H), 2 dup(0FF00H), 2 dup(0F00H), 1 dup(0FF00H), 1 dup(7700H)
			 dw 1 dup(0F00H), 4 dup(5F00H), 1 dup(0F00H), 1 dup(0CC00H), 3 dup(0F00H), 1 dup(0CC00H), 4 dup(0F00H), 3 dup(0CC00H), 4 dup(0F00H), 1 dup(0CC00H)
			 dw 5 dup(0F00H), 1 dup(0CC00H), 1 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H), 4 dup(5F00H), 2 dup(7700H), 8 dup(0CC00H), 2 dup(7700H), 9 dup(5F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 7 dup(5F00H), 1 dup(0F00H), 1 dup(7700H), 2 dup(0FF00H), 1 dup(0F00H), 2 dup(0FF00H), 1 dup(0F00H), 2 dup(0FF00H), 1 dup(7700H)
			 dw 1 dup(0F00H), 4 dup(5F00H), 1 dup(0F00H), 5 dup(0CC00H), 5 dup(0F00H), 1 dup(0CC00H), 5 dup(0F00H), 4 dup(0CC00H), 2 dup(0F00H), 1 dup(0CC00H)
			 dw 1 dup(0F00H), 2 dup(0CC00H), 1 dup(0F00H), 6 dup(5F00H), 3 dup(0CC00H), 2 dup(5F00H), 3 dup(0CC00H), 11 dup(5F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 8 dup(5F00H), 1 dup(0F00H), 1 dup(7700H), 6 dup(0FF00H), 1 dup(7700H), 1 dup(0F00H), 5 dup(5F00H), 28 dup(0F00H), 5 dup(5F00H)
			 dw 3 dup(0F00H), 4 dup(5F00H), 3 dup(0F00H), 10 dup(5F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 9 dup(5F00H), 8 dup(0F00H), 38 dup(5F00H), 4 dup(0F00H), 4 dup(5F00H), 4 dup(0F00H), 9 dup(5F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 76 dup(5F00H), 2 DUP(0CC00H)
			 dw 2 dup(0AA00H), 76 dup(5F00H), 2 DUP(0CC00H)
			 dw 1 dup(0AA00H), 1 dup(0F00H), 76 dup(9900H), 1 dup(0F00H), 1 dup(0CC00H)
			 dw 1 dup(5F00H), 78 dup(9900H), 1 dup(5F00H)

		 ;July 15, 2012
		 ;By Angelica Hernandez
		 ;Game over, new high score background.
		 overHighScore dw 1 dup(0F00H), 78 dup(0EE00H), 1 dup(0F00H)
			 dw 1 dup(0AA00H), 1 dup(0FF00H), 76 dup(0EE00H), 1 dup(0FF00H), 1 dup(0CC00H)
			 dw 2 dup(0AA00H), 76 dup(0F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 76 dup(0F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 76 dup(0F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 71 dup(0F00H), 1 dup(9900H), 4 dup(0F00H), 2 dup(0CC00H) 
			 dw 2 dup(0AA00H), 9 dup(0F00H), 1 dup(9900H), 3 dup(0F00H), 1 dup(9900H), 1 dup(0F00H), 4 dup(9900H), 1 dup(0F00H), 1 dup(9900H)
			 dw 5 dup(0F00H), 1 dup(9900H), 2 dup(0F00H), 5 dup(0CC00H), 1 dup(0F00H), 4 dup(0CC00H), 1 dup(0F00H), 4 dup(0CC00H), 2 dup(0F00H)
			 dw 4 dup(0EE00H), 1 dup(0F00H), 5 dup(0EE00H), 1 dup(0F00H), 1 dup(0EE00H), 3 dup(0F00H), 1 dup(0EE00H), 1 dup(0F00H), 4 dup(0EE00H)
			 dw 2 dup(0F00H), 1 dup(9900H), 3 dup(0F00H), 1 dup(9900H), 2 dup(0F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 9 dup(0F00H), 2 dup(9900H), 2 dup(0F00H), 1 dup(9900H), 1 dup(0F00H), 1 dup(9900H), 4 dup(0F00H), 1 dup(9900H)
			 dw 5 dup(0F00H), 1 dup(9900H), 4 dup(0F00H), 1 dup(0CC00H), 3 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H), 1 dup(0CC00H), 1 dup(0F00H), 1 dup(0CC00H)
			 dw 2 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H), 1 dup(0EE00H), 6 dup(0F00H), 1 dup(0EE00H), 3 dup(0F00H), 1 dup(0EE00H), 3 dup(0F00H), 1 dup(0EE00H)
			 dw 1 dup(0F00H), 1 dup(0EE00H), 6 dup(0F00H) , 1 dup(9900H) , 1 dup(0F00H), 1 dup(9900H), 3 dup(0F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 9 dup(0F00H), 1 dup(9900H), 1 dup(0F00H), 1 dup(9900H), 1 dup(0F00H), 1 dup(9900H), 1 dup(0F00H), 3 dup(9900H), 3 dup(0F00H)
			 dw 1 dup(9900H), 1 dup(0F00H), 1 dup(9900H), 1 dup(0F00H), 1 dup(9900H), 5 dup(0F00H), 1 dup(0CC00H), 3 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H)
			 dw 1 dup(0CC00H), 1 dup(0F00H), 4 dup(0CC00H), 2 dup(0F00H), 3 dup(0EE00H), 4 dup(0F00H), 1 dup(0EE00H), 4 dup(0F00H), 1 dup(0EE00H), 1 dup(0F00H)
			 dw 1 dup(0EE00H), 2 dup(0F00H), 3 dup(0EE00H), 2 dup(0F00H), 1 dup(9900H), 2 dup(0F00H), 1 dup(9900H), 2 dup(0F00H), 1 dup(9900H), 1 dup(0F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 9 dup(0F00H), 1 dup(9900H), 2 dup(0F00H), 2 dup(9900H), 1 dup(0F00H), 1 dup(9900H), 5 dup(0F00H), 1 dup(9900H), 1 dup(0F00H)
			 dw 1 dup(9900H), 1 dup(0F00H), 1 dup(9900H), 5 dup(0F00H), 1 dup(0CC00H), 3 dup(0F00H), 1 dup(0CC00H), 2 dup(0F00H), 1 dup(0CC00H), 1 dup(0F00H)
			 dw 1 dup(0CC00H), 5 dup(0F00H), 1 dup(0EE00H), 6 dup(0F00H), 1 dup(0EE00H), 4 dup(0F00H), 1 dup(0EE00H), 1 dup(0F00H), 1 dup(0EE00H), 2 dup(0F00H)
			 dw 1 dup(0EE00H), 6 dup(0F00H), 1 dup(9900H), 1 dup(0F00H), 1 dup(9900H), 3 dup(0F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 9 dup(0F00H), 1 dup(9900H), 3 dup(0F00H), 1 dup(9900H), 1 dup(0F00H), 4 dup(9900H), 3 dup(0F00H), 1 dup(9900H), 1 dup(0F00H)
			 dw 1 dup(9900H), 6 dup(0F00H), 1 dup(0CC00H), 3 dup(0F00H), 4 dup(0CC00H), 1 dup(0F00H), 1 dup(0CC00H), 5 dup(0F00H), 1 dup(0EE00H), 4 dup(0F00H), 5 dup(0EE00H)
			 dw 3 dup(0F00H), 1 dup(0EE00H), 3 dup(0F00H), 4 dup(0EE00H), 2 dup(0F00H), 1 dup(9900H), 3 dup(0F00H), 1 dup(9900H), 2 dup(0F00H), 2 dup(0CC00H) 
			 dw 2 dup(0AA00H), 71 dup(0F00H), 1 dup(9900H), 4 dup(0F00H), 2 dup(0CC00H) 
			 dw 2 dup(0AA00H), 76 dup(0F00H),  2 dup(0CC00H) 
			 dw 2 dup(0AA00H), 4 dup(0F00H), 1 dup(0EE00H), 9 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 1 dup(0F00H), 5 dup(0AA00H)
			 dw 1 dup(0F00H), 5 dup(0AA00H), 1 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 3 dup(0F00H), 5 dup(0AA00H), 1 dup(0F00H), 4 dup(0AA00H)
			 dw 1 dup(0F00H), 4 dup(0AA00H), 1 dup(0F00H), 3 dup(0AA00H), 2 dup(0F00H), 4 dup(0AA00H), 13 dup(0F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 2 dup(0F00H), 1 dup(0EE00H), 3 dup(0F00H), 1 dup(0EE00H), 7 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 3 dup(0F00H)
			 dw 1 dup(0AA00H), 3 dup(0F00H), 1 dup(0AA00H), 5 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 3 dup(0F00H), 1 dup(0AA00H), 5 dup(0F00H)
			 dw 1 dup(0AA00H), 4 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 1 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 1 dup(0F00H)
			 dw 1 dup(0AA00H), 16 dup(0F00H), 2 dup(0CC00H) 
			 dw 2 dup(0AA00H), 3 dup(0F00H), 1 dup(0EE00H), 1 dup(0F00H), 1 dup(0EE00H), 8 dup(0F00H), 4 dup(0AA00H), 3 dup(0F00H), 1 dup(0AA00H), 3 dup(0F00H)
			 dw 1 dup(0AA00H), 1 dup(0F00H), 2 dup(0AA00H), 2 dup(0F00H), 4 dup(0AA00H), 3 dup(0F00H), 4 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 4 dup(0F00H)
			 dw 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 1 dup(0F00H), 3 dup(0AA00H), 2 dup(0F00H), 3 dup(0AA00H), 14 dup(0F00H), 2 dup(0CC00H) 
			 dw 2 dup(0AA00H), 1 dup(0F00H), 1 dup(0EE00H), 2 dup(0F00H), 1 dup(0EE00H), 2 dup(0F00H), 1 dup(0EE00H), 6 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H)
			 dw 1 dup(0AA00H), 3 dup(0F00H), 1 dup(0AA00H), 3 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H)
			 dw 1 dup(0AA00H),  6 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 4 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 1 dup(0F00H)
			 dw 1 dup(0AA00H), 1 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 16 dup(0F00H), 2 dup(0CC00H) 
			 dw 2 dup(0AA00H), 3 dup(0F00H), 1 dup(0EE00H), 1 dup(0F00H), 1 dup(0EE00H), 8 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 1 dup(0F00H)
			 dw 5 dup(0AA00H), 1 dup(0F00H), 4 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 1 dup(0AA00H), 2 dup(0F00H), 5 dup(0AA00H), 2 dup(0F00H)
			 dw 4 dup(0AA00H), 1 dup(0F00H), 4 dup(0AA00H), 1 dup(0F00H), 1 dup(0AA00H), 1 dup(0F00H), 2 dup(0AA00H), 1 dup(0F00H), 4 dup(0AA00H), 13 dup(0F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 2 dup(0F00H), 1 dup(0EE00H), 3 dup(0F00H), 1 dup(0EE00H), 69 dup(0F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 4 dup(0F00H), 1 dup(0EE00H), 71 dup(0F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 76 dup(0F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 76 dup(0F00H), 2 dup(0CC00H)
			 dw 2 dup(0AA00H), 76 dup(0F00H), 2 dup(0CC00H)
			 dw 1 dup(0AA00H), 1 dup(0FF00H), 76 dup(9900H), 1 dup(0FF00H), 1 dup(0CC00H)
			 dw 1 dup(0F00H), 78 dup(9900H), 1 dup(0F00H) 

		 

	.Code
	 ;-----------------------------------------
	 ;July 13, 2012
	 ;By Ramon Saldana
	 ;Copies the string's coordinates and length to the first shadow, the first shadow's to the second's and so forth.
	 ;Expected input: The string's coordinates and length and current shadow's information.
	 ;Expected output: All of the string's shadow's coordinates and length with updated values. 
	 mShadowCoordinateUpdate macro x:REQ, y:REQ, len:REQ, shadows:REQ
	           
	     push ax
	     push bx
	     push si    
            
   	     lea si, shadows
	        
	     ;Move second shadow's coordinates and lenght
	     ;to third shadow.
	       
	     inc si
	     inc si 
	     mov al, [si]
	     inc si
	     mov bl, [si] 
	     inc si
	     mov [si], al
	     inc si
	     mov [si], bl
	     inc si
	     inc si
	     mov al, [si]
	     inc si 
	     mov [si], al
	       
	     lea si, shadows
	       
	     ;Move first shadow's coordinates and length
	     ;to second shadow.
	       
	     mov al, [si]
	     inc si
	     mov bl, [si]
	     inc si
	     mov [si], al
	     inc si
	     mov [si], bl
	     inc si
	     inc si
	     inc si 
	     mov al, [si]
	     inc si
	     mov [si], al
	       
	       
	     lea si, shadows
	       
	     ;Move string's coordinates and length
	     ;to second shadow.
	       
	     mov al, x
	     mov [si],al
	     inc si
	     mov al, y
	     mov [si],al
	     inc si
	     inc si
	     inc si
	     inc si
	     inc si
	     mov al, len
	     mov [si], al

	     pop si
	     pop bx
	     pop ax
	                
	     endm

	 ;-----------------------------------------
	 ;July 13, 2012
	 ;By: Ramon Saldana
	 ;Returns the exact adress of each shadow on screen
	 ;Expected input: 2,2 Expected output: 0144H  
	 mShadowLocationFix macro shadows:REQ, adress1:REQ, adress2:REQ, adress3:REQ   
	          
	     push ax
	     push bx
	     push cx
	     push si    
	      

	     lea si, shadows
	     mov al, [si]
	     mov auxX, al
	     inc si
	     mov bl, [si]
	     mov auxY, bl
	     mLocationFix auxX, auxY, adress1
	       
	     inc si
	     mov al, [si]
	     mov auxX, al
	     inc si
	     mov bl, [si]
	     mov auxY, bl
	     mLocationFix auxX, auxY, adress2
	       
	     inc si
	     mov al, [si]
	     mov auxX, al
	     inc si
	     mov bl, [si]
	     mov auxY, bl
	     mLocationFix auxX, auxY, adress3
	        
	     pop si
	     pop cx
	     pop bx
	     pop ax
	        
	     endm

	 ;-----------------------------------------
	 ;July 13, 2012
	 ;By Ramon Saldana
	 ;Prints the string's shadow on screen.
	 ;Expected input: The current string's information and the shadow's adresses.
	 ;Expected output: The shadows printed on screen. 
	 mShadowPrintString macro adress1:REQ, adress2:REQ, adress3:REQ, strng:REQ, len:REQ, colors:REQ
	        
	     push ax
	     push bx
	     push cx
	        
	     ;mOldPrintString macro strng, len, address, color
	     mOldPrintString strng, len, address1, bgfg	     
	     mOldPrintString strng, len, address2, bgfg	     
	     mOldPrintString strng, len, address3, bgfg
	        
	     pop cx
	     pop bx
	     pop ax    
	      
	     endm     

	 ;-----------------------------------------
	 ;July 10, 2012
	 ;By Cesar Andreu
	 ;Sets cursor at location (X,Y)
	 ;Params: x_A (byte), y_A (byte)
	 mSetCursor macro x_var:REQ, y_var:REQ
		 push ax
		 push bx
		 push cx
		 push dx

		 mov al,0
		 mov bx,0

		 ;Sets function 2
		 mov ah,2

		 ;x_A
		 mov cx,x_var
		 mov dl,cl

		 ;y_A
		 mov cx,y_var
		 mov dh,cl

		 ;Interrupt
		 int 10h

		 pop dx
		 pop cx
		 pop bx
		 pop ax
		 endm

	 ;-----------------------------------------
	 ;July 10, 2012
	 ;By Cesar Andreu
	 ;Read string from keyboard
	 mReadKeyboard macro 
		 push ax
		 push bx
		 push cx
		 push dx

		 mov ax,0
		 mov ah,0AH
		 lea dx, bufferLength
		 int 21H   

		 pop dx
		 pop cx
		 pop bx
		 pop ax
		 endm

	 ;-----------------------------------------
	 ;July 10, 2012
	 ;By Cesar Andreu
	 ;Prints string given as parameter
	 mPrintText macro print_this:REQ
	 	 push ax
	 	 push dx

	 	 lea dx, print_this
	 	 mov ax,0
	 	 mov ah,9
	 	 int 21H

	 	 pop dx
	 	 pop ax
	 	 endm

	 ;-----------------------------------------
	 ;July 4, 2012
	 ;By Cesar Andreu
	 ;Converts coordinate (X,Y) into the address on screen.
	 mLocationFix macro locationX:REQ, locationY:REQ, address:REQ
	     push ax
	     push bx
	     push cx
	    
	     ;Sets bx to the real value of locationX on screen
	     mov ax,0
	     mov al,locationX
	     mul twoB
	     mov bx,ax
	     
	     ;Sets cx to the real value of locationY on screen
	     mov ax,0
	     mov al,locationY
	     mul oneSixtyB
	     mov cx,ax
	     
	     ;Adds the values so that it's the address on screen.
	     mov ax,0
	     add ax,bx
	     add ax,cx
	    
	     ;Moves the summed value to the address variable.
	     mov address,ax
	        
	     pop cx
	     pop bx
	     pop ax
	     endm

	 ;-----------------------------------------
	 ;July 11, 2012
	 ;By Cesar Andreu
	 ;Gets key press and changes location of Paddle A or B.
	 mGetKeyPaddle macro
	 	 local letterA, letterS, letterW, letterZ, letterO, letterK, letterL, letterCom, endMacro, decreaseY_A, A_checkX_topB, A_checkX_topA, yA_collides_yB_top, noColY_A_top, increaseY_A, A_checkX_botB, A_checkX_botA, yA_collides_yB_bot, noColY_A_bot, increaseX_A, xA_collides_xBend, noColX_Aend, decreaseX_A, xA_collides_xBstart, noColX_Astart, noColX_Bstart, xB_collides_xAstart, decreaseX_B, noColX_Bend, xB_collides_xAend, increaseX_B, yB_collides_yA_bot, B_checkX_botA, B_checkX_botB, increaseY_B
	 	 local decreaseY_B, B_checkX_topA, B_checkX_topB, yB_collides_yA_bot, noColY_B_bot, noColY_B_top, yB_collides_yA_top
	 	 push bx
	 	 push cx
	 	 push dx

	     mov cx,0
	     mov dx,0

	 	 ;BL is the right wall.
	 	 ;Four is subtracted so it collides with the right end of the paddle.
	 	 mov bx, 0
	 	 mov bl, rightWall
	 	 sub bl, 4

	 	 ;Sets function and calls interrupt.
	     mov ah,6
	     mov dl, 0FFH
	     int 21H 

	     jz endMacro

	     cmp al,'a'
	     jz letterA

	     cmp al,'s'
	     jz letterS

	     cmp al,'w'
	     jz letterW

	     cmp al,'z'
	     jz letterZ

	     cmp al,'o'
	     jz letterO

	     cmp al,'k'
	     jz letterK

	     cmp al,'l'
	     jz letterL

	     cmp al,','
	     jz letterCom

	     jmp endMacro

	     ;Moves PaddleA to the right, checks for collisions.
	     letterS:
		     cmp x_A, bl ;Right edge of screen.
		     jae endMacro
		     inc x_A
		     mov dx, 0
		     mov dl, x_A
		     add dl, 3
		     cmp dl, x_B
		     je xA_collides_xBstart ;X_A collided with X_B at start.
		     noColX_Astart:
			     inc A_moved
			     jmp endMacro
		     xA_collides_xBstart:
			     mov dx, 0
			     mov dl, y_A
			     cmp dl, y_B
			     je decreaseX_A ;Jumps to decrease X_A if Y_A = Y_B.
			     jmp noColX_Astart ;Otherwise, it means there's no collision.
		     decreaseX_A:
			     dec x_A
			     jmp endMacro

		 ;Moves PaddleA to the left, checks for collisions.
	     letterA:
		     cmp x_A, 0 ;Left edge of screen.
		     je endMacro
		     dec x_A
		     mov dx, 0
		     mov dl, x_A
		     mov dh, x_B
		     add dh, 3
		     cmp dl, dh
		     je xA_collides_xBend ;x_A collided with x_B at end.
		     noColX_Aend:
		     	inc A_moved
		     	jmp endMacro
		     xA_collides_xBend:
		     	mov dx, 0
		     	mov dl, y_A
		     	cmp dl, y_B
		     	je increaseX_A ;Jumps to increase x_A if Y_A = Y_B.
		     	jmp noColX_Aend ;Otherwise, it means there's no collision.
		     increaseX_A:
		     	inc x_A
		     	jmp endMacro

		 ;Moves PaddleA up, checks for collisions.
	     letterW:
		     cmp y_A, 15 ;Maximum height PaddleA can go.
		     je endMacro
		     dec y_A
		     mov dx, 0
		     mov dl, y_A
		     mov dh, y_B
		     cmp dl, dh
		     je yA_collides_yB_bot ; y_A collided with y_B at bottom.
		     noColY_A_bot:
		     	 inc A_moved
		    	 jmp endMacro
		     yA_collides_yB_bot: ;Here it checks each x_A value with each x_B value.
		     	 mov cx, 4
		     	 mov dl, x_A
		     	 A_checkX_botA:
		     	 	 push cx
		     	 	 mov cx, 4
		     	 	 mov dh, x_B
			     	 A_checkX_botB:
			     	 	cmp dl, dh
			     	 	je increaseY_A ;If x_A is ever equal to x_B, it collides.
			     	 	inc dh
			     	 loop A_checkX_botB
			     	 inc dl
			     	 pop cx
			     loop A_checkX_botA
		     	 jmp noColY_A_bot ; Otherwise it didn't collide.
		     increaseY_A:
		     	inc y_A
		     	jmp endMacro

		 ;Moves PaddleA down, checks for collisions.
	     letterZ:
		     cmp y_A, 24 ;Bottom edge of screen.
		     je endMacro
		     inc y_A
		     mov dx, 0
		     mov dl, y_A
		     mov dh, y_B
		     cmp dl, dh
		     je yA_collides_yB_top
		     noColY_A_top:
		     	inc A_moved
		     	jmp endMacro
		     yA_collides_yB_top: ;Here it checks each x_B value with each X_A value.
		     	mov cx, 4
		     	mov dl, x_A
		     	A_checkX_topA:
		     		push cx
		     		mov cx, 4
		     		mov dh, x_B
		     		A_checkX_topB:
		     			cmp dl, dh
		     			je decreaseY_A ;If x_B is ever equal to x_A, it collides.
		     			inc dh
		     		loop A_checkX_topB
		     		inc dl
		     		pop cx
		     	loop A_checkX_topA
		     	jmp noColY_A_top ;Otherwise it didn't collide.
		     	decreaseY_A:
		     		dec y_A
		     		jmp endMacro

		 ;Moves PaddleB to the right, checks for collisions.
	     letterL:
		     cmp x_B,bl ;Right edge of screen.
		     jae endMacro
		     inc x_B
		     mov dx, 0
		     mov dl, x_B
		     add dl, 3
		     cmp dl, x_A
		     je xB_collides_xAstart ; X_B collided with X_A at start.
		     noColX_Bstart:
		     	inc B_moved
		     	jmp endMacro
		     xB_collides_xAstart:
		     	mov dx, 0
		     	mov dl, y_B
		     	cmp dl, y_A
		     	je decreaseX_B ;Jumps to increase x_A if Y_A = Y_B.
		     	jmp noColX_Bstart ;Otherwise, it means there's no collision.
		     	decreaseX_B:
		     	dec x_B
		     	jmp endMacro

		 ;Moves PaddleB to the left, checks for collisions.
	     letterK:
		     cmp x_B, 0 ;Left edge of screen.
		     je endMacro
		     dec x_B
		     mov dx, 0
		     mov dl, x_B
		     mov dh, x_A
		     add dh, 3
		     cmp dl, dh
		     je xB_collides_xAend ;x_B collided with x_B at end.
		     noColX_Bend:
		     	inc B_moved
		     	jmp endMacro
		     xB_collides_xAend:
		     	mov dx, 0
		     	mov dl, y_B
		     	cmp dl, y_A
		     	je increaseX_B ; Jumps to increase X_B if Y_A = Y_B.
		     	jmp noColX_Bend ;Otherwise, it means there's no collision.
		     increaseX_B:
		     	inc x_B
		     	jmp endMacro

		 ;Moves PaddleB up, checks for collisions.
	     letterO:
	     cmp y_B, 15 ;Maximum height PaddleB can go.
	     je endMacro
	     dec y_B
	     mov dx, 0
	     mov dl, y_B
	     mov dh, y_A
	     cmp dl, dh
	     je yB_collides_yA_bot ; y_B collided with y_A at bottom.
	     noColY_B_bot:
	     	 inc B_moved
	     	 jmp endMacro
	     yB_collides_yA_bot: ;Here it checks each x_B value with each x_A value.
	     	mov cx, 4
	     	mov dl, x_B
	     	B_checkX_botA:
	     		push cx
	     		mov cx, 4
	     		mov dh, x_A
	     		B_checkX_botB:
	     			cmp dl,dh
	     			je increaseY_B ;If x_B is ever equal to x_A, it collides.
	     			inc dh
	     		loop B_checkX_botB
	     		inc dl
	     		pop cx
	     	loop B_checkX_botA
	     	jmp noColY_B_bot ; Otherwise it didn't collide.
	     increaseY_B:
	     	inc y_B
	     	jmp endMacro

	     ;Moves PaddleB down, checks for collisions.
	     letterCom:
	     cmp y_B, 24 ;Bottom edge of screen. 
	     je endMacro
	     inc y_B
	     mov dx, 0
	     mov dl, y_B
	     mov dh, y_A
	     cmp dl, dh
	     je yB_collides_yA_top
	     noColY_B_top:
	     	inc B_moved
	     	jmp endMacro
	     yB_collides_yA_top: ;Here it checks each x_A value with each x_B value.
	     	mov cx, 4
	     	mov dl, x_B
	     	B_checkX_topA:
	     		push cx
	     		mov cx, 4
	     		mov dh, x_A
	     		B_checkX_topB:
	     			cmp dl, dh
	     			je decreaseY_B ;If x_A is ever equal to x_B, it collides.
	     			inc dh
	     		loop B_checkX_topB
	     		inc dl
	     		pop cx
	     	loop B_checkX_topA
	     	jmp noColY_B_top ;Otherwise it didn't collide.
	     	decreaseY_B:
	     		dec y_B
	     		jmp endMacro

	     endMacro:
	     pop dx
	     pop cx
	     pop bx
	     endm

	 ;-----------------------------------------
	 ;July 11, 2012
	 ;By Cesar Andreu
	 ;Draws the paddles and saves their variables.
	 mDrawPaddles macro address:REQ
	 	 local printLoopA, printLoopB
	 	 push ax
	 	 push bx
	 	 push cx
	 	 
	 	 ;Draws Paddle A
	 	 mLocationFix x_A, y_A, address
	 	 mov di,address
	 	 mov cx, 4
	 	 mov bx,paddleA
	 	 printLoopA:
	 	 	 mov es:[di],bx
	 	 	 inc di
	 	 	 inc di
	 	 loop printLoopA

	 	 ;Draws Paddle B
	 	 mLocationFix x_B, y_B, address
	 	 mov di,address
	 	 mov cx, 4
	 	 mov bx,paddleB
	 	 printLoopB:
	 	 	 mov es:[di],bx
	 	 	 inc di
	 	 	 inc di
	 	 loop printLoopB
	 	 pop cx
	 	 pop bx
	 	 pop ax
	 	 endm

	 ;-----------------------------------------
	 ;July 11, 2012
	 ;By Angelica Hernandez
	 ;Draws a background. It receives the initial location and prints the following 2000 memory locations.
	 mBackground macro bg:REQ
	 	 local backgroundLoop
	     lea si, bg
	     mov cx, 2000
	     mov di, 0
	     mov ax, 0
	     backgroundLoop:
	     mov ax,[si]
	     mov es:[di],ax
	     inc di
	     inc di
	     inc si
	     inc si
	     loop backgroundLoop
	     endm

	 ;-----------------------------------------
	 ;July 11, 2012
	 ;By Cesar Andreu
	 ;Calls all the macros needed  in order to move strings around screen.
	 mStringMagic macro strng:REQ, shadows:REQ
	 	 local notActive, printNormal, saveVar

	 	 ;Sets the global variables.
	 	 mGetVar strng

	 	 mShadowCoordinateUpdate x,y,len,shadows

	 	 mShadowLocationFix shadows, address1, address2, address3

	 	 ;Checks if it's active.
	 	 ;If it's not active it jumps to the end of this macro.
	 	 cmp active,0
	 	 je notActive


	 	 mCoordinatesIncrement x, y, dir

	 	 mCollisionDetector x, y, len, col, rightWall

		 mCollisionHappened col, dir, active, len, gameSpeed

		 cmp active,0
		 jne printNormal

		 inc len
		 mPrintString strng, screenAddr, x, y, bgfg, len
		 mShadowPrintString address1, address2, address3, strng, len, bgfg
		 dec len
		 jmp saveVar

		 printNormal:
		 mPrintString strng, screenAddr, x, y, bgfg, len
		 mShadowPrintString address1, address2, address3, strng, len, bgfg

		 saveVar:
		 mCalculateScore col, currScore, len
		 mSaveVar strng

	 	 notActive:
	 	 endm

	 ;-----------------------------------------
	 ;July 15, 2012
	 ;By Angelica Hernandez
	 ;Increments score if there's a paddle collision.
	 mCalculateScore macro colType:REQ,curScore:REQ,strLen:REQ
    	 local incrementacurScore, fin
         
		 push ax
		 push bx  

		 mov bl,colType
		 mov cl,10
		 mov ch,20  


		 cmp bl,000AH
		 je incrementacurScore
		 jmp fin
		 
		 
		 incrementacurScore:
		 ;se encarga de (10-strLen), se guarda en al
		 mov al,strLen     
		 sub cl,al
		 mov al,cl

		 ;se encarga de 20*(10-strLen), 
		 ;se guarda en ax
		 mul ch  

		 ;incrementa el current score
		 add curScore,ax 

		 pop bx
		 pop ax
		 fin:
		 endm

	 ;-----------------------------------------
	 ;July 15, 2012
	 ;By Cesar Andreu	
	 ;Old string printer from project 2.
	 ;Used for printing shadows.
	 mOldPrintString macro strng:REQ, len:REQ, address:REQ, color:REQ
	     local myLoop
	    
	     push ax
	     push bx
	     push cx
	     
	     lea si, strng
	     inc si
	     inc si
	     inc si
	     inc si
	     inc si
	     inc si
	     inc si
	     
	     mov ch,0
	     mov cl,len
	     mov di,address
	     mov bl,color
	     myLoop: 
	     mov al,[si]
	     mov es:[di],al
	     inc di
	     mov es:[di],bl
	     inc si
	     inc di
	     
	     loop myLoop
	     
	     
	     pop cx
	     pop bx
	     pop ax
	     endm

	 ;-----------------------------------------
	 ;July 11, 2012
	 ;By Cesar Andreu
	 ;Prints string in memory.
	 mPrintString macro strng:REQ, address:REQ, var_x:REQ, var_y:REQ, bg_fg:REQ, length:REQ
	 	 local noPrint, printLoop
	 	 push ax
	 	 push bx
	 	 push cx
	 	 push di
	 	 push si

	 	 cmp length, 0
	 	 je noPrint

	 	 mov cx, 0
	 	 mov bx, 0

	 	 lea si, strng
	 	 add si, 7
	 	 mov bl, bg_fg

	 	 mLocationFix var_x, var_y, address

	 	 mov di, address
	 	 mov cx, 0
	 	 mov cl, len
	 	 printLoop:
	 	 mov al,[si]
	 	 mov es:[di],al
	 	 inc di
	 	 mov es:[di],bl
	 	 inc di
	 	 inc si
	 	 loop printLoop
	 	 noPrint:
	 	 pop si
	 	 pop di
	 	 pop cx
	 	 pop bx
	 	 pop ax
	 	 endm

	 ;-----------------------------------------
	 ;July 11, 2012
	 ;By Cesar Andreu
	 ;Fills up the string's variables using global variables.
	 mSaveVar macro strng:REQ
	 	 push ax
	 	 mov ax,0
	 	 lea si, strng
	 	 mov al,active
	 	 mov [si], al
	 	 inc si
	 	 mov al,x
	 	 mov [si], al
	 	 inc si 	 
	 	 mov al,y
	 	 mov [si], al
	 	 inc si 	 
	 	 mov al,dir
	 	 mov [si], al
	 	 inc si 	 
	 	 mov al,col
	 	 mov [si], al
	 	 inc si 	 
	 	 mov al,bgfg
	 	 mov [si], al
	 	 inc si 	 
	 	 mov al,len
	 	 mov [si], al 
	 	 pop ax
	 	 endm

	 ;-----------------------------------------
	 ;July 11, 2012
	 ;By Cesar Andreu
	 ;Fills up global variables for strings.
	 mGetVar macro strng:REQ
	 	 push ax
	 	 mov ax,0
	 	 lea si, strng
	 	 mov al, [si]
	 	 mov active, al
	 	 inc si
	 	 mov al, [si]
	 	 mov x, al
	 	 inc si
	 	 mov al, [si]
	 	 mov y, al
	 	 inc si
	 	 mov al, [si]
	 	 mov dir, al
	 	 inc si
	 	 mov al, [si]
	 	 mov col, al
	 	 inc si
	 	 mov al, [si]
	 	 mov bgfg, al
	 	 inc si
	 	 mov al, [si]
	 	 mov len, al
	 	 pop ax
	 	 endm

	 ;-----------------------------------------
	 ;July 4, 2012
	 ;By Ramon Saldana
	 ;Increments coordinate depending on direction and current coordinates.
	 mCoordinatesIncrement macro xCoor:REQ, yCoor:REQ, dir_str:REQ
	 	 local fin, dir_1, dir_2, dir_3, dir_4, dir_5, dir_6, dir_7, dir_8, dir_9     
	         
	     push ax
	     push bx
	     push cx 
	    
	     mov al, xCoor
	     mov bl, yCoor
	     mov cx, 0
	     mov cl, dir_str
	               
	     ;Current direction is identified           
	     cmp cx, 1
	     je dir_1
	    
	     cmp cx, 2
	     je dir_2
	    
	     cmp cx, 3
	     je dir_3
	    
	     cmp cx, 4
	     je dir_4
	     
	     cmp cx, 5
	     je dir_5 
	     
	     cmp cx, 6
	     je dir_6
	     
	     cmp cx, 7
	     je dir_7
	     
	     cmp cx, 8
	     je dir_8
	     
	     cmp cx, 9
	     je dir_9 
	              
	     dir_1: ; move diagonally left down
	     dec al
	     inc bl
	     mov xCoor, al
	     mov yCoor, bl
	     jmp fin  
	     
	     dir_2: ; move down
	     inc bl
	     mov yCoor, bl
	     jmp fin
	     
	     dir_3: ; move diagonally right down
	     inc al
	     inc bl 
	     mov xCoor, al
	     mov yCoor, bl
	     jmp fin
	     
	     dir_4: ; move left
	     dec al  
	     mov xCoor, al
	     jmp fin
	     
	     dir_5: ; stay stil
	     jmp fin
	     
	     dir_6: ; move right
	     inc al
	     mov xCoor, al
	     jmp fin
	     
	     dir_7: ; move diagonally left up
	     dec al
	     dec bl 
	     mov xCoor, al
	     mov yCoor, bl
	     jmp fin  
	     
	     dir_8: ; move up
	     dec bl 
	     mov yCoor, bl
	     jmp fin
	     
	     dir_9: ; move diagonally right up
	     inc al
	     dec bl
	     mov xCoor, al
	     mov yCoor, bl
	     jmp fin 
	     
	     fin: 
	     
	     pop cx
	     pop bx
	     pop ax
	     endm

	 ;-----------------------------------------
	 ;July 15, 2012
	 ;By Cesar Andreu
	 ;Checks if the given string collides with the given paddle.
	 mCollidedPaddle macro str_x:REQ, str_y:REQ, strLen:REQ, col_Type:REQ, x_paddle:REQ, y_paddle:REQ
		 local possibleCol, checkPaddleX, checkStrX, paddleCol, endMacro

		 push ax
		 push bx
		 push cx
		 push dx

		 ;Paddle Coordinates
		 mov al, x_paddle
		 mov ah, y_paddle

		 ;String
		 mov dl, str_x
		 mov dh, str_y

		 ;Increments String's Y coordinate.
		 ;This would be the next Y coordinate that the string would have.
		 ;inc dh

		 ;Now it checks if the Y coordinate would be equal to the paddle's Y coordinate.
		 cmp dh, ah
		 je possibleCol

		 inc dh

		 cmp dh, ah
		 je possibleCol

		 ;If it's not possible for there to be a collision, it ends.
		 jmp endMacro

		 possibleCol:
		 	 mov al, x_paddle

		 	 ;The following loop will run 4 times.
		 	 ;Once for each X coordinate of the paddle.
		 	 mov cx, 4
		 	 checkPaddleX: ;Checks each X coordinate of paddle.
		 	 	push cx
		 	 	mov ch, 0
		 	 	mov cl, strLen ;This loop runs strLen times.
		 	 	mov dl, str_x
		 	 	checkStrX: ;Checks each X coordinate of string.
		 	 	 cmp al, dl
		 	 	 je paddleCol
		 	 	 inc dl
		 	 	 loop checkStrX
		 	 	inc al
		 	 	pop cx
		 	 loop checkPaddleX
		 	 mov col_Type, 0
		 	 jmp endMacro ;If it reaches here, there's no collision.

		 paddleCol: ;It jumps here if there's a collision.
		 mov col_Type, 0AH

		 endMacro:
		 pop dx
		 pop cx
		 pop bx
		 pop ax
		 endm
	 
	 ;-----------------------------------------
	 ;July 4, 2012
	 ;By Angelica Hernandez
	 ;Checks for collisions at location (x,y) and (x+len-1, y).
	 mCollisionDetector macro locationX:REQ, locationY:REQ, length:REQ, colType:REQ, r_wall:REQ
	 	 local col0, col1, col2, col3, col4, col6, col7, col8, col9, endMacro, colA
	 	 push ax
	 	 push bx
	 	 push cx
	 	 push dx

	 	 ;Resets variables to zero.
	 	 xor ax, ax
	 	 xor bx, bx
	 	 xor cx, cx
	 	 xor dx, dx

	 	 ;AL has X.
	 	 mov ah, 0
	 	 mov al, locationX

	 	 ;DL has X+len-1. 
	 	 mov dh, 0
	 	 mov dl, locationX
	 	 add dl, len
	 	 dec dl


	 	 ;BL has Y.
	 	 mov bh, 0
	 	 mov bl, locationY

	 	 ;CL has right side wall.
	 	 mov ch, 0
	 	 mov cl, r_wall

	 	 mov colType, 0
	 	 ;----------------------------------------
	 	 ;First it checks if there are paddle collisions.
	 	 ;First paddle A, then paddle B.
	 	 mCollidedPaddle locationX, locationY, length, colType, x_A, y_A
	 	 cmp colType, 0AH
	 	 je colA
	 	 
	 	 mCollidedPaddle locationX, locationY, length, colType, x_B, y_B
	 	 cmp colType, 0AH
	 	 je colA
	 	 ;----------------------------------------

	 	 cmp ax, 0
	 	 je col4

	 	 cmp dx, 0
	 	 je col4

	 	 ;cmp ax, cx
	 	 ;jae col6

	 	 cmp dx, cx
	 	 je col6

	 	 cmp dx, cx
	 	 ja col6

	 	 cmp bx, 0
	 	 je col8

	 	 cmp bx, 24
	 	 je col2

	 	 ;Default collision type is 0.
	 	 ;If all compares fail, it's automatically a 0.
	 	 col0:
	 	 mov colType, 0
	 	 jmp endMacro

	 	 ;This collision type is when a string hits a paddle.
	 	 colA:
	 	 mov colType, 0AH
	 	 jmp endMacro

	 	 col2:
	 	 mov colType, 2
	 	 jmp endMacro

	 	 col8:
	 	 mov colType, 8
	 	 jmp endMacro

	 	 col4:
	 	 cmp bx, 0
	 	 je col7
	 	 cmp bx, 24
	 	 je col1
	 	 mov colType, 4
	 	 jmp endMacro

	 	 col6:
	 	 cmp bx, 0
	 	 je col9
	 	 cmp bx, 24
	 	 je col3
	 	 mov colType, 6
	 	 jmp endMacro

	 	 col7:
	 	 mov colType, 7
	 	 jmp endMacro

	 	 col9:
	 	 mov colType, 9
	 	 jmp endMacro

	 	 col1:
	 	 mov colType, 1
	 	 jmp endMacro

	 	 col3:
	 	 mov colType, 3
	 	 jmp endMacro
	 	 
	 	 endMacro:
	 	 pop dx
	 	 pop cx
	 	 pop bx
	 	 pop ax
	 	 endm

	 ;-----------------------------------------
	 ;July 4, 2012
	 ;By Ramon Saldana
	 ;Depending on the collision type and current direction, changes the direction.
	 ;Parameters: collisionType, currentDirection
	 ;Output: newDirection
	 mCollisionHappened macro colType:REQ, direction:REQ, actv:REQ, length:REQ, speed:REQ   
	  	 local fin, change_south_1,change_south_2,change_south_3,change_west_7,change_west_4,change_west_1,change_north_7,change_north_8,change_north_9,change_east_9,change_east_6,change_east_3,change_paddle_1, change_paddle_2, change_paddle_3, cType2, cType4, cType6, cType1, cType3, cType5, cType7, cType8, cType9, cTypeA, notZero1, notZero2, notZero3

	     push ax
	     push bx
	     push cx
	           
	     mov cx, 0
	     mov ax, 0
	     mov cl,colType
	     mov al,direction

	     ;Checks if string is colliding with the paddle
	     cmp cx,10
	     je cTypeA

	     ;Checks the wall it's colliding with.
	     cmp cx,0
	     je fin
	     
	     cmp cx,2
	     je cType2
	     
	     cmp cx,4
	     je cType4
	     
	     cmp cx,6
	     je cType6
	     
	     cmp cx,8
	     je cType8 
	     
	     ;Checks the corner it's colliding with. 
	     
	     cmp cx,1
	     je cType1
	     
	     cmp cx,7 
	     je cType7
	     
	     cmp cx,9
	     je cType9
	     
	     cmp cx,3
	     je cType3
	                
	     ;Check Current Direction
	     
	     ;On Paddle
	     
	     cTypeA:
	     dec rightWall ;Decrements right wall edge.

	     
	     cmp ax, 1
	     je change_paddle_1
	     
	     cmp ax, 2
	     je change_paddle_2
	     
	     cmp ax, 3
	     je change_paddle_3

	     jmp fin
	     
	     
	     ; On South Wall
	     
	     cType2:

	     mov actv, 0
	     mov length, 0
	     mSpeedUpdate speed
	     jmp fin
	      
	     ;On West Wall
	     
	     cType4:
	     
	     cmp ax, 7
	     je change_west_7
	                 
	     cmp ax, 4
	     je change_west_4
	     
	     cmp ax, 1
	     je change_west_1
	           
	     ;On North Wall
	           
	     cType8:
	    
	     cmp ax, 7
	     je change_north_7
	                 
	     cmp ax, 8
	     je change_north_8
	     
	     cmp ax, 9
	     je change_north_9
	     
	     ;On East Wall  
	                   
	     cType6: 
	                   
	     cmp ax, 9
	     je change_east_9
	                 
	     cmp ax, 6
	     je change_east_6
	     
	     cmp ax, 3
	     je change_east_3  
	       
	     ; Si ocurre colision de este tipo se borra el string. 
	     ;Change Direction On South Wall  
	       
	     ;change_south_1:
	     ;add ax, 6
	     ;mov direction, al
	     ;jmp fin 
	     
	     ;change_south_2:
	     ;add ax, 6
	     ;mov direction, al
	     ;jmp fin
	     
	     ;change_south_3:
	     ;add ax, 6
	     ;mov direction, al
	     ;jmp fin
	     
	     ;Change Direction On West Wall  
	       
	     change_west_7:
	     add ax, 2
	     mov direction, al
	     jmp fin 
	     
	     change_west_4:
	     add ax, 2
	     mov direction, al
	     jmp fin
	     
	     change_west_1:
	     add ax, 2
	     mov direction, al
	     jmp fin  
	       
	     ;Change Direction On North Wall  
	       
	     change_north_7:
	     sub ax, 6
	     mov direction, al
	     jmp fin 
	     
	     change_north_8:
	     sub ax, 6
	     mov direction, al
	     jmp fin
	     
	     change_north_9:
	     sub ax, 6
	     mov direction, al
	     jmp fin
	     
	     ;Change Direction on East Wall
	     
	     change_east_9:
	     sub ax, 2
	     mov direction, al
	     jmp fin 
	     
	     change_east_6:
	     sub ax, 2
	     mov direction, al
	     jmp fin
	     
	     change_east_3:
	     sub ax, 2
	     mov direction, al
	     jmp fin  
	     
	     ;Change Direction on Corners
	     
	     cType1:
	     mov actv, 0
	     mov length, 0
	     mSpeedUpdate speed
	     jmp fin 
	     
	     cType7:
	     sub ax, 4
	     mov direction, al
	     jmp fin
	     
	     cType9:
	     sub ax, 8
	     mov direction, al
	     jmp fin
	     
	     cType3:
	     mov actv, 0
	     mov length, 0
	     mSpeedUpdate speed
	     jmp fin

	     ;Change direction on paddle

	     change_paddle_1:
	     add ax, 6
	     dec length
	     cmp length, 0
	     jnz notZero1
	     mov actv,0
	     notZero1:
	     mov direction, al
	     jmp fin 
	     
	     change_paddle_2:
	     add ax, 6
	     dec length
	     cmp length,0
	     jnz notZero2
	     mov actv,0
	     notZero2:
	     mov direction, al
	     jmp fin
	     
	     change_paddle_3:
	     add ax, 6
	     dec length
	     cmp length,0
	     jnz notZero3
	     mov actv,0
	     notZero3:
	     mov direction, al
	     jmp fin

	     fin:
	     pop cx
	     pop bx
	     pop ax   
	     endm   

	 ;-----------------------------------------
	  ;July 4, 2012
	 ;By Ramon Saldana
	 ;Delays the program execution
	 ;Param@ velocity: times the outer loop will run (type word)  
	 ;Values for speed range from 0 to 10 (base 10)
	 ;0 being a complete stop and 10 the fastest speed. 
	 mDelay macro velocity:REQ  
	 	 local outLoop, innerLoop, innerLoop2, infiLoop, finite, infinite
	         
	     push ax
	     push bx
	     push cx 
	                
	     mov cx, velocity  
	         
	     cmp cx, 0
	     ja finite
	         
	     inc cx 
	               
	     ;Infinite loop 
	     ;if the velocity passed  as parameter 
	     ;is 0 then the program execution happens only once
	     ;and as a result the strings will not move                
	                         
	     infinite:       
	     infiLoop: 
	         
	     push cx
	         
	     mov cx, 65535 
	         
	     innerLoop:
	     inc bx
	     dec bx
	     loop innerLoop
	         
	     pop cx 
	         
	     loop infiLoop
	           
	     inc cx
	     jmp infinite 
	         
	     ;end of infinite loop
	                  
	     finite:
	               
	     ;finite loop start 
	     ;speed here increases as the velocity
	     ;passed as parameter increases     
	         
	     mov cx, 65535
	     mov ax,velocity
	     sub cx, ax 
	     inc cx 

	     outLoop:
	     push cx
	        
	     mov cx, 1 
	         
	     innerLoop2:
	     inc bx
	     dec bx
	     loop innerLoop2
	        
	     pop cx    
	        
	     loop outLoop      
	     ;end of finite loop

	     pop cx
	     pop bx
	     pop ax
	     endm 

	 ;-----------------------------------------
	 ;July 15, 2012
	 ;By Jose R. Figueroa
	 ;Set the length and centralize the name 
	 ;Expected input:name,length,col         
	 mSetlen macro nombre:REQ,len:REQ,col:REQ
	     local otravez,fuera,Set,Set1,Set2,Set3,Set4,Set5,Set6,fin,skip
	     push ax
	     push si
	     push cx
	     push bx
	     
	     mov bx,0
	     mov bl, 13
	     mov ah,0
	     mov si,offset nombre
	     mov cx,12
	     otravez:
	         mov al,[si];verify the length
	         cmp al,'$'
	         je fuera 
	         mov al,0
	         inc ah   
	         inc si
	         loop otravez
	     fuera:  
	     dec si
	     cmp bl, [si]
	     jne skip
	     mov [si],'$'
	     skip:
	     inc si
	     mov len,ah
	     cmp ah,12
	     je Set
	     cmp ah,11
	     je Set
	     cmp ah,10
	     je Set1
	     cmp ah,9
	     je Set1
	     cmp ah,8
	     je Set2
	     cmp ah,7
	     je Set2
	     cmp ah,6
	     je Set3
	     cmp ah,5
	     je Set3
	     cmp ah,4
	     je Set4
	     cmp ah,3
	     je Set4
	     cmp ah,2
	     je Set5
	     cmp ah,1
	     je Set5
	     
	     Set: ;set the cursor to centraliza the name
	     mov col,68
	     jmp fin
	     Set1:
	     mov col,69
	     jmp fin
	     Set2:
	     mov col,70
	     jmp fin  
	     Set3:     
	     mov col,71
	     jmp fin
	     Set4:
	     mov col,72
	     jmp fin
	     Set5:
	     mov col,73
	     fin:
	     pop bx
	     pop cx
	     pop si
	     pop ax
	     
	     endm

	 ;-----------------------------------------
	 ;July 10, 2012
	 ;By Jose R. Figueroa
	 ;print top 5 highscores & currentscore 
	 ;Expected input:currentscore, top5 highscores 
	 mprintscores macro currentscore:REQ,nombre:REQ,len:REQ,nombre1:REQ,nombre2:REQ,nombre3:REQ,nombre4:REQ,nombre5:REQ, col:REQ, fil:REQ, address:REQ
	 	 local writecurrentscore,writecurrentscore1,writename,otravez,otravez1,otravez2,otravez3,otravez4,again,again1,again2,otherscore   
	 	 push ax                              
	 	 push bx
	 	 push cx
	 	 push dx
	 	 push si
	 	 push ds  
	  	
	  	 mov col,68
	  	 mov fil,1
	  	 mLocationFix col,fil,address
	  	 mov di,address
	 	 mov si,offset palabra
	 	 mov cx,12
	 	 again:; writes on screen Actual Score
	 	     mov al,[si]
	 	 	 mov ah,0FH
	 	 	 mov es:[di],ax
	 	 	 inc si
	 	 	 inc di
	 		 inc di
	 		 loop again 
	 		 
	 	 mov col,71
	 	 mov fil,6
	 	 mLocationFix col,fil,address
	 	 mov di,address
	 	 mov si,offset palabra1
	 	 mov cx,5
	 	 again1:; writes on screen Top5
	 	     mov al,[si]
	 	 	 mov ah,0FH
	 	 	 mov es:[di],ax
	 	 	 inc si
	 	 	 inc di
	 	 	 inc di
	 	 	 loop again1 
	 	 	
	 	 mov col,69
	 	 mov fil,7
	 	 mLocationFix col,fil,address
	 	 mov di,address
	 	 mov si,offset palabra2
	 	 mov cx,10
	 	 again2:; writes on screen Highscore
	 	     mov al,[si]
	  		 mov ah,0FH
	  		 mov es:[di],ax
	 		 inc si
	 		 inc di
	 		 inc di
	 		 loop again2
	  	
	 	 mLocationFix 75,2,address
	 	 mov ax,currentscore
	 	 mov di,address
	 	 mov cx,5
	 	 mov bx,10   
	 	 mov dx,0
	 	 writecurrentscore:;write on screen actualscore
	  		 div bx
 			 push ax
	 		 mov al,dl
	 		 add al,30H
	 		 mov ah,0FH
	 		 mov es:[di],ax
	 		 pop ax  
	 		 mov dx,0
	 		 dec di
	 		 dec di
	 		 loop writecurrentscore   
	 	 	
	 	 mov fil,10
	 	 mov cx,5  
	 	 mov si,0
	 	 otherscore:;Writes on screen Top5 high score
	 	 push cx 
	 	 mLocationFix 75,fil,address  
	 	 mov ax,topScore[si]
	 	 mov di,address
	 	 mov cx,5
	 	 mov bx,10
	 	 mov dx,0    
	 	 writecurrentscore1: 
	  		 div bx; divide by 10 to separe each decimal digit
 			 push ax
	 		 mov al,dl
	 		 add al,30H; add ASCII code of 0
	 		 mov ah,0FH
	 		 mov es:[di],ax
	 		 pop ax  
	 		 mov dx,0
	 		 dec di
	 		 dec di
	 		 loop writecurrentscore1
	 	 add fil,3 
	 	 inc si 
	 	 inc si 
	 	 pop cx
	 	 loop otherscore 
	  	
	     mov fil,3  
	     mSetlen nombre,len,col
	     mLocationFix col,fil,address
	  	 mov di,address
	  	 mov si,offset nombre;Actual player name 
	 	 mov ah,0             
	 	 mov al,len
	 	 mov cx,ax
	 	 writename:
	  		 mov al,[si]
	  		 mov ah,0FH
	 		 mov es:[di],ax
	 		 inc si
	 		 inc di
	 		 inc di
	 		 loop writename 
	  	
	  	 mov fil,11
	 	 mSetlen nombre1,len,col 
	 	 mLocationFix col,fil,address
	 	 mov di,address              
	 	 mov si,offset nombre1; Top#1 player name
	 	 mov ah,0             
	 	 mov al,len
	 	 mov cx,ax
	 	 otravez:
	 	     mov al,[si]
	  		 mov ah,0FH
	  		 mov es:[di],ax
	  		 inc si
	 		 inc di
	 		 inc di
	 		 loop otravez  
	 	 	
	 	 add fil,3
	 	 mSetlen nombre2,len,col
	 	 mLocationFix col,fil,address
	 	 mov di,address
	 	 mov si,offset nombre2  ;Top#2 player name
	 	 mov ah,0             
	 	 mov al,len
	 	 mov cx,ax
	 	 otravez1:
	 	     mov al,[si]
	  		 mov ah,0FH
	  		 mov es:[di],ax
	 		 inc si
	 		 inc di
	 		 inc di
	 		 loop otravez1   
	 	 	
	 	 add fil,3         
	 	 mSetlen nombre3,len,col
	 	 mLocationFix col,fil,address
	 	 mov di,address
	 	 mov si,offset nombre3 ;Top#3 player name
	 	 mov ah,0             
	 	 mov al,len
	 	 mov cx,ax
	 	 otravez2:
	 	     mov al,[si]
	  		 mov ah,0FH
	  		 mov es:[di],ax
	 		 inc si
	 		 inc di
	 		 inc di
	 		 loop otravez2   
	 	 	
	 	 add fil,3 
	 	 mSetlen nombre4,len,col
	 	 mLocationFix col,fil,address
	 	 mov di,address
	 	 mov si,offset nombre4 ;Top#4 player name
	 	 mov ah,0             
	 	 mov al,len
	 	 mov cx,ax
	 	 otravez3:
	 	     mov al,[si]
	  		 mov ah,0FH
	 		 mov es:[di],ax
	 		 inc si
	 		 inc di
	 		 inc di
	 		 loop otravez3  
	 	 	
	 	 add fil,3  
	 	 mSetlen nombre5,len,col
	 	 mLocationFix col,fil,address
	 	 mov di,address
	 	 mov si,offset nombre5 ;Top#5 player name
	 	 mov ah,0             
	 	 mov al,len
	 	 mov cx,ax
	 	 otravez4:
	 	     mov al,[si]
	  		 mov ah,0FH
	 		 mov es:[di],ax
	 		 inc si
	 		 inc di
	 		 inc di
	 		 loop otravez4   
	 	 	
	 	 pop ds                              
	 	 pop si
	 	 pop dx
	 	 pop cx
	 	 pop bx
	 	 pop ax
	 		
	     endm                 

	 ;-----------------------------------------
	 ;July 11,2012
	 ;By Jose R. Figueroa
	 ;Xchg strings
	 ;Expected input: two names output: two names 
	 mtransfer macro nombre:REQ,orden:REQ
		 local transfer   
		 push ax
		 push bx
		 push cx
		 push si
		 push di  
		 mov si,offset nombre;first string
		 mov di,offset orden ;second string
		 mov cx,12      
		 transfer:
		     mov al,[si]
			 mov bl,[di]
			        
			 mov [si],bl; xchg each character
			 mov [di],al
			        
			 inc si
			 inc di 
			 loop transfer 
		 pop di
		 pop si
		 pop cx		    
		 pop bx
		 pop ax
		 endm

	 ;-----------------------------------------
	 ;July 10, 2012
 	 ;By Jose R. Figueroa
 	 ;save top 5 highscore, change position highscores 
 	 ;Expected input: finalscore, expected output: top 5 highscore,top 5 player name
	 mTop5 macro finalscore:REQ,top:REQ,top1:REQ,nombre:REQ,nombre1:REQ,nombre2:REQ,nombre3:REQ,nombre4:REQ,nombre5:REQ
	 	 local cheq,verificar,terminar,copy,first,second,third,fourth,fith,names,next,replace,terminar0
	 	 push ax
	 	 push bx
	 	 push cx
	 	 push si
	 	 ;hacer un arreglo top dw 0,0,0,0,0
	 	 ;five db 5
	 	 mov cx,5
	 	 mov si,0 
	     copy:
	     mov ax,top[si]     
	     mov top1[si],ax
	     inc si
	     inc si
	     loop copy
	     
	 	 mov si,0
	 	 mov cx,5
	 	 cheq: ;verify if finalscore is one of the top5 highscores
	 	 	mov ax,top[si]
	 	 	cmp finalscore,ax
	 	 	jae replace
	 	 	inc si
	 	 	inc si
	 	 loop cheq
	     jmp terminar0

		 replace:;final score one of the top 5  
		 mov markHS, 01H ; to move highscore screen
		 mov bx,finalscore
		 mov top[si],bx
		 verificar:
		 	 inc si
		 	 inc si
		 	 mov bx,top[si]
		 	 mov top[si],ax
		 	 mov ax,bx
		 	 cmp si,8
		 	 je terminar
		 	 loop verificar
		 terminar:
		 mov al,0
		 mov si,0
		 mov cx,5
		 names:; change the position of the player names with respect their score 
		     mov bx,top[si]
		     cmp top1[si],bx
		     je next  
		     cmp al,0
		     je first
		     cmp al,1
		     je second
		     cmp al,2
		     je third
		     cmp al,3
		     je fourth
		     cmp al,4
		     je fith 
		     next:  
		     inc si
		     inc si 
		     inc al 
		     loop names
		     first:   
		     mtransfer nombre1,nombre
		     second:
		     mtransfer nombre2,nombre
		     third:
		     mtransfer nombre3,nombre
		     fourth:
		     mtransfer nombre4,nombre
		     fith:
		     mtransfer nombre5,nombre 
		 terminar0: 
	 	 pop si
	 	 pop cx
	 	 pop bx
	 	 pop ax
	 	 endm

	 ;-----------------------------------------
	 ;Created July 15, 2012
	 ;By Ramon Saldana
	 ;Checks if all the strings are inactive. If so, value 1 is moved over to GameOver variable.
	 ;Expected input: The 6 strings and the GameOver vaariable. All the variables are of type byte.
	 ;Expected output: A 1 or a 0 on the GameOver variable depening on the status of the strings.
	 mEndGameDetection macro str1:REQ, str2:REQ, str3:REQ, str4:REQ, str5:REQ, str6:REQ, GameOver:REQ
	     local continue1, continue2, continue3, continue4, continue5, GameOverScreen
	     
	     push ax
	     push bx
	     push cx
	    
	     mov al, 0
	     
	     cmp str1, al
	     je continue1
	     jmp fin
	            
	     continue1:
	     
	     cmp str2, al
	     je continue2
	     jmp fin
	     
	     continue2:
	     
	     cmp str3, al
	     je continue3
	     jmp fin
	    
	     continue3:
	    
	     cmp str4, al
	     je continue4
	     jmp fin
	     
	     continue4:
	     
	     cmp str5, al
	     je continue5
	     jmp fin
	     
	     continue5:
	     
	     cmp str6, al
	     je GameOverScreen
	     jmp fin
	     
	     GameOverScreen:
	     mov GameOver, 1
	     
	     fin:
	           
	     pop cx
	     pop bx
	     pop ax
	           
	     endm

	 ;-----------------------------------------
	 ;Created July 16, 2012
	 ;By Ramon Saldana
	 ;Resets all the strings and shadows to their original values.
	 mResetAssist macro string:REQ, shadow:REQ, x:REQ, y:REQ, dir:REQ, col:REQ, bgfg:REQ, len:REQ 
	     push ax
	     push bx
	     push cx    
	     mov bx, 0    
	     lea bx, string
	     mov [bx], 1
	     inc bx
	     mov cl, x
	     mov [bx], cl
	     inc bx
	     mov cl, y
	     mov [bx], cl
	     inc bx
	     mov cl, dir
	     mov [bx], cl
	     inc bx
	     mov cl, col
	     mov [bx], cl
	     inc bx
	     mov cl, bgfg
	     mov [bx], cl
	     inc bx
	     mov cl, len
	     mov [bx], cl
	     

	     lea bx, shadow
	     mov cl, x
	     mov [bx], cl
	     inc bx
	     mov cl, y
	     mov [bx], cl
	     inc bx
	     mov cl, x
	     mov [bx], cl
	     inc bx
	     mov cl, y
	     mov [bx], cl
	     inc bx
	     mov cl, x
	     mov [bx], cl
	     inc bx
	     mov cl, y
	     mov [bx], cl
	     inc bx
	     mov cl, len
	     mov [bx], cl
	     inc bx
	     mov [bx], cl
	     inc bx
	     mov [bx], cl
	    
	     pop cx
	     pop bx
	     pop ax    
 
     	 endm

	 ;-----------------------------------------
	 ;July 17, 2012
	 ;By Ramon Saldana
	 ;Resets a name it's 13 b bytes by a $ sign
	 ;Expected input: player name
	 ;Expected output: 13 $ sign where the name used to be.
	 mResetPlayerName macro pName:REQ
	     local myLoop
	     push bx
	     push cx
	     
	     
	     mov cx, 13
	     lea bx, pName
	     
	     myLoop:
	     mov [bx], '$'
	     inc bx
	     loop myLoop
	     
	    
	     pop cx
	     pop bx    
	     endm    
	 
	 ;-----------------------------------------
	 ;July 17, 2012
	 ;By Angelica Hernandez
	 ;Decreases the score variable by the number of movedA and movedB.
	 ;Expected Inputs: 2,2,100
	 ;Expected Outputs: 0,0,96
	 mMovingPaddleDec macro movedA:REQ, movedB:REQ, score:REQ
		 local compara,DecreScore,fin
		 push cx

		 mov cx,0
		 add cl,movedA
		 add cl,movedB
		      
		 cmp cx, 0
		 je fin
		 jmp compara  

		 compara:
		 cmp score,0
		 jne DecreScore
		 jmp fin       

		 DecreScore: 
		 dec score 
		 loop compara

		 fin:
		 mov movedA,0
		 mov movedB,0


		 pop cx
		 endm      

	 ;-----------------------------------------
	 ;July 17, 2012
	 ;By Ramon Saldana
	 ;Increments current speed by 5%
	 ;Expected input: the current velocity in type word
	 ;Expected output: the updated value of velocity
	 mSpeedUpdate macro vel:REQ
	    
	     push ax
	     push bx
	     push cx
	     push dx
	     mov ax, 0
	     mov bx, 0
	     mov dx, 0
	     mov ax, vel 
	     mov bx, 20
	     div bx
	     add vel, ax
	     pop dx
	     pop cx
	     pop bx
	     pop ax
	     endm    

	 ;-----------------------------------------
	 ;July 18, 2012
	 ;By Cesar Andreu
	 ;Prints a white line to show where the right-side collisions occur.
	 mPrintWallLine macro rWall:REQ
	 	 local myLoop
		 push ax
		 push bx
		 push cx  

		 xor ax,ax
		 mov cx,25
		 mov al, rWall
		 mul TwoB
		 mov bx, ax
		 myLoop:
		 mov es:[bx], 0FF00H
		 add bx, 160
		 loop myLoop

		 pop cx
		 pop bx
		 pop ax

		 endm

	 ;-----------------------------------------
	 main proc
	     ;Fixes the data segment and sets the extra segment to video mode.
	     mov ax,@Data
	     mov ds,ax
	     mov ax,0B800H
	     mov es,ax

	     ;This is the start screen. User inputs his name here.
	     startScreen:
		     mBackground startBackground
		     mSetCursor 22, 12
		     mPrintText message1
		     mReadKeyboard
		     mSetCursor 24, 79
		     cmp playerName, 13
		     jne doNothing
		     mov playerName, ' '
		     inc nameLength
		     inc nameLength
		     doNothing:
		     jmp gameScreen

	     ;This is the game screen.
	     gameScreen:
		     mBackground gameBackground
		     mPrintWallLine rightWall
		     mGetKeyPaddle
		     mDrawPaddles screenAddr
		     mGetKeyPaddle
		     mDrawPaddles screenAddr
		     mGetKeyPaddle
		     mDrawPaddles screenAddr
		     mGetKeyPaddle
		     mDrawPaddles screenAddr	     
		     mGetKeyPaddle
		     mDrawPaddles screenAddr
		     mGetKeyPaddle
		     mBackground gameBackground
		     mPrintWallLine rightWall
 			 mprintscores currScore, playerName, scoreLen, nombre1, nombre2, nombre3, nombre4, nombre5, scoreCol, scoreLine, screenAddr
		     mDrawPaddles screenAddr
		     mStringMagic str1, shadows1
		     mStringMagic str2, shadows2
		     mStringMagic str3, shadows3
		     mStringMagic str4, shadows4
		     mStringMagic str5, shadows5
		     mStringMagic str6, shadows6
		     mMovingPaddleDec A_moved, B_moved, currScore
		     mEndGameDetection str1,str2,str3,str4,str5,str6, gameOver
		     cmp gameOver, 1
		     je gameEnded

	     	 mDelay gameSpeed
	     	 jmp gameScreen

	     ;This is the end game screen.
	     gameEnded:
	     	 mov ax, currScore
	     	 mov finalScore, ax
	     	 mTop5 finalScore, topScore, tempTop, playerName, nombre1, nombre2, nombre3, nombre4, nombre5 	
		     mResetAssist str1, shadows1, 1, 1, 3, 0, 12H, 8
		     mResetAssist str2, shadows2, 5, 2, 9, 0, 12H, 8
		     mResetAssist str3, shadows3, 10, 3, 1, 0, 12H, 8
		     mResetAssist str4, shadows4, 40, 5, 7, 0, 12H, 8
		     mResetAssist str5, shadows5, 30, 4, 9, 0, 12H, 8
		     mResetAssist str6, shadows6, 20, 6, 7, 0, 12H, 8
		     mResetPlayerName playerName

		     mov gameSpeed, 30000
		     mov rightWall, 67
	     	 mov currScore, 0
	     	 mov gameOver, 0
	     	 cmp markHS, 1
	     	 je newHighScore
	     	 jmp regularScore

	     	 ;This screen pops up when there's a new high score.
	     	 newHighScore:
		     	 mov markHS, 0
		     	 mBackground overHighScore
		     	 mSetCursor 22,19
		     	 mPrintText message2
		     	 mov ah,8
		     	 int 21h
		     	 mDelay 5000
		     	 jmp startScreen

		     ;This screen pops up if you lose and you're not a high score.
	     	 regularScore:
		     	 mBackground overRegularScore
		     	 mSetCursor 22,21
		     	 mPrintText message2
		     	 mov ah,8
		     	 int 21h
		     	 mDelay 5000
		     	 jmp startScreen
  
	 main endp

	 end main


