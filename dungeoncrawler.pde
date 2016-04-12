
int dimCubo = 200;

int turningCounter = 1;
int turnSpeed = 6; // piu alto e' il valore piu veloce e' la rotazione

int movingCounter = 0;
int movingSpeed = 20; // piu alto e' il valore piu veloce e' il movimento

boolean buildMode = false;
boolean delimiter = false;

Coordinate startingPlayerPosition = new Coordinate(0, 0, 0);

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
	map = new Map("maps/stair.csv");
	noStroke();
	textSize(20);
	currentTexture = getNextTexture();
	bash = new Bash(5);
}

void draw()
{
	if(player.isMoving() || player.isTurning())
		player.playAnimation();
	player.show();
	background(180);
	if(delimiter) map.drawDelimiter();
	pushMatrix();
	map.drawCageLike(8, 3, 8);
	popMatrix();
	pushMatrix();
	hint(DISABLE_DEPTH_TEST);	//passaggio a grafica 2d per l'hud
	camera();
	
	if(buildMode) 
	{
		text(player.toString(), 0, 20);
	}
	
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
	if(!inBash)
	{
		player.handle();
		switch(key)
		{
			case '\\' : inBash = true; break;
		}
		
		switch(keyCode)
		{
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