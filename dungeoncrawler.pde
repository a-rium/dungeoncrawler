
int dimCubo = 100;
float orientationX;
float orientationY;
float orientationZ;

boolean phase = false;

boolean buildMode = false;
boolean delimiter = false;

float eyeX, eyeY, eyeZ;

PImage wood;		//type 1
PImage stone;		//type 2

Map map;
Bash bash;
String command = "";
boolean inBash = false;

void setup()
{
	size(1200, 700, P3D);
	
	eyeX = dimCubo / 2;
	eyeY = dimCubo / 2;
	eyeZ = dimCubo * 7 + dimCubo / 2;//(height / 2) / tan(PI / 6)  + dimCubo * 3 / 2;
	orientationX = eyeX;
	orientationY = eyeY;
	orientationZ = eyeZ - dimCubo;
	wood = loadImage("src/wood.jpg");
	stone = loadImage("src/stone.jpg");
	noStroke();
	map = new Map("src/map.csv");
	bash = new Bash(5);
	textSize(20);
	

}

void draw()
{
	
	camera(eyeX, eyeY, eyeZ,
		   orientationX, orientationY,
           orientationZ, 0, 1, 0);
	background(180);
	if(delimiter) map.drawDelimiter();
	pushMatrix();
	noStroke();
	map.drawGridLike();
	popMatrix();
	pushMatrix();
	hint(DISABLE_DEPTH_TEST);	//passaggio a grafica 2d per l'hud
	camera();
	text("Facing: " + (orientationX == eyeX + dimCubo
					? "RIGHT" : (orientationX == eyeX - dimCubo
					? "LEFT" : (orientationZ == eyeZ + dimCubo 
					? "BACK" : "FORWARD"))), 0, 20);
	text("X : " + floor(eyeX / dimCubo) +
		 "\nY : " + floor(eyeY / dimCubo) +
		 "\nZ : " + floor(eyeZ / dimCubo) + 
		 "\nPointing to : \nX : " + floor(orientationX / dimCubo) +
		 "\nY : " + floor(orientationY / dimCubo) +
		 "\nZ : " + floor(orientationZ / dimCubo) + 
		 "\nSize : " + dimCubo +
		 (buildMode ? "\nEDITING" : ""), 0, 45);
		 
	if(inBash) text(command + "|", 0, height - 25);
	hint(ENABLE_DEPTH_TEST);
	popMatrix();
}

void mouseDragged()
{
	float rate = 0.1;
	int distanceX = pmouseX - mouseX;
	int distanceY = pmouseY - mouseY;

	//orientationY -= (pmouseY<height/2?height/2 - pmouseY : -pmouseY + height/2) * rate;
	orientationX -= distanceX;
	orientationY -= distanceY;
}

// L'implementazione delle funzioni di movimento si trova nel file Utils.pde

void keyPressed()
{
	if(!inBash)
	{
		switch(key)
		{
			// Movimento in avanti
			case 'w' : moveForward(); break;//eyeZ -= dimCubo; orientationZ -= dimCubo; break;
			// Movimento indietro
			case 's' : moveBack(); break; //eyeZ += dimCubo; orientationZ += dimCubo; break;
			// Rotazione della telecamera verso sinistra
			case 'a' : turnLeft();  break;
			// Rotazione della telecamera verso destra
			case 'd' : turnRight(); break;
			// Movimento a sinistra
			case 'z' : moveLeft(); break; //eyeX -= dimCubo; orientationX -= dimCubo; break;
			// Movimento a destra
			case 'c' : moveRight(); break; //eyeX += dimCubo; orientationX += dimCubo; break;
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
							map.setCube(floor(orientationX / dimCubo), 
										floor(orientationY / dimCubo), 
										floor(orientationZ / dimCubo), 1);
						break;
			case '<': 
				if(buildMode)
					map.setCube(floor(orientationX / dimCubo), 
								floor(orientationY / dimCubo), 
								floor(orientationZ / dimCubo), 0);
				break;
			default: break;
		}
		switch(keyCode)
		{
			// Cancella il blocco davanti alla telecamera se si e' in modalita editing
			case BACKSPACE: 
				if(buildMode)
					map.setCube(floor(orientationX / dimCubo), 
								floor(orientationY / dimCubo), 
								floor(orientationZ / dimCubo), 0);
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

void switchMode()
{
	if(buildMode)
		map.saveMap("src/savedMap.csv");
	buildMode = !buildMode;
}