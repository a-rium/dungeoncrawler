
Cube cubo;
final int dimCubo = 100;
float grades = 0.01;
float orientationX;
float orientationY;
float orientationZ;

boolean phase = false;

boolean buildMode = false;

float eyeX, eyeY, eyeZ;


boolean startMouseTracking = false;

PImage wood;		//type 0
PImage stone;		//type 1

Map map;

void setup()
{
	size(1200, 700, P3D);
	
	eyeX = dimCubo / 2;
	eyeY = dimCubo / 2;
	eyeZ = (height / 2) / tan(PI / 6)  + dimCubo * 3 / 2;
	orientationX = eyeX;
	orientationY = eyeY;
	orientationZ = eyeZ - dimCubo;
	wood = loadImage("src/wood.jpg");
	stone = loadImage("src/stone.jpg");
	cubo = new Cube(0, dimCubo);
	map = new Map("src/map.csv");
	textSize(20);
	
	noStroke();
}

void draw()
{
	
	camera(eyeX, eyeY, eyeZ,
		   orientationX, orientationY,
           orientationZ, 0, 1, 0);
	//fill(255);
	//text("Hello", 0, 20, 0);//eyeX - dimCubo / 2, eyeY - dimCubo / 2 + 20, 0);
	background(180);
	pushMatrix();
	// translate(width/2, height/2);
	// rotateY(grades+=0.01);
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
		 "\nZ : " + floor(orientationZ / dimCubo), 0, 45);
	if(buildMode)
		text("EDITING", 0, 200);
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

void keyTyped()
{
	switch(key)
	{
		case 'w' : moveForward(); break;//eyeZ -= dimCubo; orientationZ -= dimCubo; break;
		case 's' : moveBack(); break; //eyeZ += dimCubo; orientationZ += dimCubo; break;
		case 'a' : turnLeft();  break;
		case 'd' : turnRight(); break;
		case 'z' : moveLeft(); break; //eyeX -= dimCubo; orientationX -= dimCubo; break;
		case 'c' : moveRight(); break; //eyeX += dimCubo; orientationX += dimCubo; break;
		case 'o' : eyeY -= dimCubo; orientationY -= dimCubo; break;
		case 'l' : eyeY += dimCubo; orientationY += dimCubo; break;
		// Guarda avanti
		case 'u' : orientationY = eyeY; orientationX = eyeX; orientationZ = eyeZ - dimCubo; break;
		// Guarda indietro
		case 'j' : orientationY = eyeY; orientationX = eyeX; orientationZ = eyeZ + dimCubo; break;
		// Guarda a sinistra
		case 'h' : orientationY = eyeY; orientationX = eyeX - dimCubo; orientationZ = eyeZ; break;
		// Guarda a destra
		case 'k' : orientationY = eyeY; orientationX = eyeX + dimCubo; orientationZ = eyeZ; break;
		// Guarda in alto
		case 't' : orientationY = eyeY - dimCubo; orientationX = eyeX; orientationZ = eyeZ; break;
		// Guarda in basso
		case 'g' : orientationY = eyeY + dimCubo; orientationX = eyeX; orientationZ = eyeZ; break;
		case 'r' : eyeX = width / 2.0; eyeY = height / 2.0; eyeZ = (height / 2) / tan(PI / 6); break;
		case 'p' : println("Facing: " + (orientationX == eyeX + dimCubo
					? "RIGHT" : (orientationX == eyeX - dimCubo
					? "LEFT" : (orientationZ == eyeZ + dimCubo 
					? "BACK" : "FORWARD")))); break;
		case '\\': switchMode(); break;
		case ' ': 
					if(buildMode)
						map.setCube(floor(orientationX / dimCubo), 
									floor(orientationY / dimCubo), 
									floor(orientationZ / dimCubo), 1);
					break;
		case CODED : switch(keyCode)
					{
					}
	}
}

void moveForward()
{
	if(orientationX == eyeX)
	{
		float aux = eyeZ;
		eyeZ += orientationZ > eyeZ ? dimCubo : -dimCubo;
		orientationZ = eyeZ + (aux > eyeZ ? - dimCubo : dimCubo);
	}
	else
	{
		float aux = eyeX;
		eyeX += orientationX > eyeX ? dimCubo : -dimCubo;
		orientationX = eyeX + (aux > eyeX ? -dimCubo : dimCubo);
	}
}

void moveBack()
{
	if(orientationX == eyeX)
	{
		float aux = eyeZ;
		eyeZ += orientationZ < eyeZ ? dimCubo : -dimCubo;
		orientationZ = eyeZ + (aux < eyeZ ? -dimCubo : dimCubo);
	}
	else
	{
		float aux = eyeX;
		eyeX += orientationX < eyeX ? dimCubo : -dimCubo;
		orientationX = eyeX + (aux < eyeX ? -dimCubo : dimCubo);
	}
}

void moveLeft()
{
	if(orientationX == eyeX)
		eyeX += orientationZ < eyeZ ? -dimCubo : dimCubo;
	else
		eyeZ += orientationX < eyeX ? dimCubo : -dimCubo;
}

void moveRight()
{
	if(orientationX == eyeX)
		eyeX += -(orientationZ < eyeZ ? -dimCubo : dimCubo);
	else
		eyeZ += -(orientationX < eyeX ? dimCubo : -dimCubo);
}

void turnLeft()
{
	if(orientationX != eyeX)
	{
		orientationZ = orientationX > eyeX ? eyeZ - dimCubo : eyeZ + dimCubo;
		orientationX = eyeX;
	}
	else
	{
		orientationX = orientationZ > eyeZ ? eyeX + dimCubo : eyeX - dimCubo;
		orientationZ = eyeZ; 
	}
}

void turnRight()
{
	if(orientationX != eyeX)
	{
		orientationZ = orientationX > eyeX ? eyeZ + dimCubo : eyeZ - dimCubo;
		orientationX = eyeX;
	}
	else
	{
		orientationX = orientationZ > eyeZ ? eyeX - dimCubo : eyeX + dimCubo;
		orientationZ = eyeZ; 
	}
}

void switchMode()
{
	if(buildMode)
		map.saveMap("src/savedMap.csv");
	buildMode = !buildMode;
}