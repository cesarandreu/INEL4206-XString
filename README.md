#X-String


***


##What is this?

This is a game created as the final project for INEL4206 at UPRM, which is a microprocessors course. We were a team of four: two electrical and two computer engineering students. It was done using X86 assembly.

Prior to creating the game, we had another project where we had to draw some strings on screen and have them bounce around, colliding with the edges. We built upon this project in order to create X-String. The source for this project is not available. A video of the project is linked below, and the project's specifications are inside the *PDFs* folder.

The objective of the game is to bounce strings using the two paddles paddle, similar to the classic game Breakout. Upon letting all the strings fall to the bottom of the screen, you lose. 


***


###Videos

This is video demo of the XString game, as well as an explanation of the game's mechanics: 

<http://www.youtube.com/watch?v=9KaJt1ng0sU>


You go to the following link to watch a video detailing how to run the game using DOSBox 0.74 on a computer running Windows 7:

<http://www.youtube.com/watch?v=LMrvFzdSPDM>


Follow the links below to watch videos of the project that was done prior to XString:

<http://www.youtube.com/watch?v=J7QgHDa8LOQ>

<http://www.youtube.com/watch?v=LdkZM__uu1k>


***


###Folders

**src** - contains the game's source code.

**bin** - contains the game's binary executable.

**PDFs** - contains XString's specifications and the specifications for the project prior to it.


***


###Compiling

Compiling the source code requires Microsoft Macro Assembler and its Linker, along with DOSBox.

Copy *MASM.EXE* and *LINK.EXE* to a known folder along with *source.asm*. Then run DOSBox, mount the drive, and browse to the folder.

Then run the following commands

	masm source.asm
	
	link source
	
After you have compiled the code, you can run the executable inside DOSBox. For instructions on how to run it, look at the video linked above.