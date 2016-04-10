
int dimCubo = 100;
// float orientationX;
// float orientationY;
// float orientationZ;

// int phase = 0;

// boolean turningLeft = false;
// boolean turningRight = false;
int turningCounter = 1;
int turnSpeed = 6; // piu alto e' il valore piu veloce e' la rotazione

// boolean movingForward = false;
// boolean movingBackwards = false;
// boolean movingLeft = false;
// boolean movingRight = false;
int movingCounter = 0;
int movingSpeed = 10; // piu alto e' il valore piu veloce e' il movimento

boolean buildMode = false;
boolean delimiter = false;

// float eyeX, eyeY, eyeZ;

// PImage wood;		//type 1
// PImage stone;		//type 2

int currentTexture = -1;

Map map;
Bash bash;
Player player;
String command = "";
boolean inBash = false;

PrintWriter logger;
boolean logging = false;


void setup()
{
	size(1200, 700, P3D);
	
	// eyeX = dimCubo / 2;
	// eyeY = dimCubo / 2;
	// eyeZ = dimCubo * 7 + dimCubo / 2;//(height / 2) / tan(PI / 6)  + dimCubo * 3 / 2;
	// orientationX = eyeX;
	// orientationY = eyeY;
	// orientationZ = eyeZ - dimCubo;
	map = new Map("solid_block.csv");
	noStroke();
	//player = new Player();
	textSize(20);
	currentTexture = getNextTexture();
	bash = new Bash(5);
}

void draw()
{
	if(player.isMoving() || player.isTurning())
		player.playAnimation();
	// if(turningLeft || turningRight)
		// handleCameraTurning();
	// if(movingForward || movingBackwards || movingLeft || movingRight)
		// handleMovementAnimation();
	player.show();
	// camera(eyeX, eyeY, eyeZ,
		   // orientationX, orientationY,
           // orientationZ, 0, 1, 0);
	background(180);
	if(delimiter) map.drawDelimiter();
	pushMatrix();
	// noStroke();
	map.drawGridLike();
	popMatrix();
	pushMatrix();
	hint(DISABLE_DEPTH_TEST);	//passaggio a grafica 2d per l'hud
	camera();
	text(player.toString(), 0, 20);
	// text("Facing: " + (orientationX == eyeX + dimCubo
					// ? "RIGHT" : (orientationX == eyeX - dimCubo
					// ? "LEFT" : (orientationZ == eyeZ + dimCubo 
					// ? "BACKWARDS" : "FORWARD"))), 0, 20);
	// text("X : " + floor(eyeX / dimCubo) +
		 // "\nY : " + floor(eyeY / dimCubo) +
		 // "\nZ : " + floor(eyeZ / dimCubo) + 
		 // "\nPointing to : \nX : " + floor(orientationX / dimCubo) +
		 // "\nY : " + floor(orientationY / dimCubo) +
		 // "\nZ : " + floor(orientationZ / dimCubo) + 
		 // "\nSize : " + dimCubo +
		 // "\nMoving Speed : " + movingSpeed +
		 // "\nTurn Speed : " + turnSpeed +
		 // (buildMode ? "\nCurrent Texture ID : " + (currentTexture > 0 ? currentTexture : "None") : ""), 0, 45);
	
	if(buildMode && currentTexture > 0)
	{
		tint(255, 200);
		image(textures.get(currentTexture), 30, height - 328, 128, 128);
		tint(255, 0);
	}
	if(inBash) text(command + "|", 0, height - 25);
	hint(ENABLE_DEPTH_TEST);
	popMatrix();
}

// void mouseDragged()
// {
	// float rate = 0.1;
	// int distanceX = pmouseX - mouseX;
	// int distanceY = pmouseY - mouseY;

	// //orientationY -= (pmouseY<height/2?height/2 - pmouseY : -pmouseY + height/2) * rate;
	// orientationX -= distanceX;
	// orientationY -= distanceY;
// }

// L'implementazione delle funzioni di movimento si trova nel file Utils.pde

void keyPressed()
{
	// if(turningLeft || turningRight												//se sta ruotando non fare nulla
			// || movingForward || movingBackwards || movingLeft || movingRight)	//se si sta muovendo non fare nulla	
		// return;
	if(!inBash)
	{
		player.handle();
		/*
		switch(key)
		{
			// Movimento in avanti
			case 'w' : if(!map.colliding(eyeX + dimCubo * sin(radians(phase)), eyeY, eyeZ - dimCubo * cos(radians(phase))))
					   movingForward = true; break;//eyeZ -= dimCubo; orientationZ -= dimCubo; break;
			// Movimento indietro
			case 's' : if(!map.colliding((int)(eyeX - sin(radians(phase))), (int)eyeY, (int)(eyeZ + cos(radians(phase)))))
					   movingBackwards = true; break; //eyeZ += dimCubo; orientationZ += dimCubo; break;
			// Rotazione della telecamera verso sinistra
			case 'a' : turningLeft = true;  break;
			// Rotazione della telecamera verso destra
			case 'd' : turningRight = true; break;
			// Movimento a sinistra
			case 'z' : if(!map.colliding((int)(eyeX + sin(radians(phase - 90))), (int)eyeY, (int)(eyeZ - cos(radians(phase)))))
					   movingLeft = true; break; //eyeX -= dimCubo; orientationX -= dimCubo; break;
			// Movimento a destra
			case 'c' : if(!map.colliding((int)(eyeX + sin(radians(phase + 90))), (int)eyeY, (int)(eyeZ - cos(radians(phase)))))
					   movingRight = true; break; //eyeX += dimCubo; orientationX += dimCubo; break;
			
			
			// Movimento in alto
			case 'o' : eyeY -= dimCubo; orientationY -= dimCubo; break;
			// Movimento in basso
			case 'l' : eyeY += dimCubo; orientationY += dimCubo; break;
			// Guarda avanti
			case 'u' : orientationY = eyeY; orientationX = eyeX; orientationZ = eyeZ - dimCubo; break;
			// Guarda indietro
			case 'j' : orientationY = eyeY; orientationX = eyeX; orientationZ = eyeZ + dimCubo; break;
			// Guarda a sinistra
			case 'h' : orientationY = eyeY; orientationX = eyeX - dimCubo; orientationZ = eyeZ; break;
			// Guarda a destra
			case 'k' : orientationY = eyeY; orientationX = eyeX + dimCubo; orientationZ = eyeZ; break;
			// Guarda in alto (non funzionante)
			case 't' : orientationY = eyeY - dimCubo; orientationX = eyeX; orientationZ = eyeZ; break;
			// Guarda in basso (non funzionante)
			case 'g' : orientationY = eyeY + dimCubo; orientationX = eyeX; orientationZ = eyeZ; break;
			// Riporta la telecamera alla posizione e allo stato originario
			case 'r' : eyeX = width / 2.0; eyeY = height / 2.0; eyeZ = (height / 2) / tan(PI / 6); 
					   orientationX = eyeX; orientationY = eyeY; orientationZ = eyeZ + dimCubo; break;
					   
			
			
			// Stampa informazioni di debug
			case 'p' : println("Facing: " + (orientationX == eyeX + dimCubo
						? "RIGHT" : (orientationX == eyeX - dimCubo
						? "LEFT" : (orientationZ == eyeZ + dimCubo 
						? "BACK" : "FORWARD")))); break;
			// Passa dalla modalita di esplorazione a quella di editing, e viceversa.
			// Salva la mappa editata
			case '\\': inBash = true; break;
			// Posiziona un blocco  davanti se si e' in modalita di editing
			case ' ': 
						if(buildMode)
						{
							map.setCube(floor(orientationX / dimCubo), 
										floor(orientationY / dimCubo), 
										floor(orientationZ / dimCubo), currentTexture > 0 ? currentTexture : 0);
							if(logging) logger.println("Set block at " + floor(orientationX / dimCubo) + " "
																	   + floor(orientationY / dimCubo) + " "
																	   + floor(orientationZ / dimCubo));
						}
						break;
			case '<': 
				if(buildMode)
				{
					map.setCube(floor(orientationX / dimCubo), 
								floor(orientationY / dimCubo), 
								floor(orientationZ / dimCubo), 0);
					if(logging) logger.println("Removed block at " + floor(orientationX / dimCubo) + " "
																	   + floor(orientationY / dimCubo) + " "
																	   + floor(orientationZ / dimCubo));
				}
				break;
			default: break;
		}
		*/
		switch(key)
		{
			case '\\' : inBash = true; break;
		}
		
		switch(keyCode)
		{
			// Cancella il blocco davanti alla telecamera se si e' in modalita editing
			// case BACKSPACE: 
				// if(buildMode)
					// map.setCube(floor(orientationX / dimCubo), 
								// floor(orientationY / dimCubo), 
								// floor(orientationZ / dimCubo), 0);
				// break;
			case LEFT:
				if(buildMode)
					currentTexture = getPreviousTexture();
				break;
			case RIGHT:
				if(buildMode)
					currentTexture = getNextTexture();
				break;
			default: break;
		}
	}
	else
	{
		if(key == '\\')
			inBash = false;
		else if(keyCode == ENTER)
		{
			bash.command(command);
			command = "";
		}
		else if(keyCode == UP)
			command = bash.getPreviousCommand();
		else if(keyCode == DOWN)
			command = bash.getNextCommand();
		else
		{
			if(keyCode == BACKSPACE)
				command = command.length() > 1 ? 
						  command.substring(0, command.length() - 1) :
						  "";
			else if(key != CODED)
				command += key;
			
		}
	}
}

// void handleCameraTurning()
// {
	// if(turningLeft)
	// {
		// turnLeft();
		// if(turningCounter >= 90/turnSpeed)
		// {
			// turningLeft = false;
			// turningCounter = 1;
		// }
		// else turningCounter++;
	// }
	// else
	// {
		// turnRight();
		// if(turningCounter >= 90/turnSpeed)
		// {
			// turningRight = false;
			// turningCounter = 1;
		// }
		// else turningCounter++;
	// }
// }

// void handleMovementAnimation()
// {
	// if(movingForward)
		// moveForward();
	// else if(movingBackwards)
		// moveBack();
	// else if(movingLeft)
		// moveLeft();
	// else
		// moveRight();
	// movingCounter++;
	// if(movingCounter >= 100/movingSpeed)
	// {
		// movingForward = movingBackwards = movingLeft = movingRight = false;
		// movingCounter = 0;
	// }
// }