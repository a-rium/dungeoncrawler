
Cube cubo;
final int dimCubo = 100;
float grades = 0.01;
float orientationX;
float orientationY;
float orientationZ;

boolean buildMode = false;

float eyeX, eyeY, eyeZ;


boolean startMouseTracking = false;

PImage wood;		//type 0
PImage stone;		//type 1

Map map;

void setup()
{
	size(1200, 700, P3D);
	orientationX = width / 2.0 + dimCubo / 2;
	orientationY = height / 2.0 + dimCubo / 2;
	eyeX = width / 2.0 + dimCubo / 2;
	eyeY = height / 2.0 + dimCubo / 2;
	eyeZ = (height / 2) / tan(PI / 6)  + dimCubo * 3 / 2;
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
	translate(width/2, height/2);
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
		 "\nZ : " + floor(eyeZ / dimCubo), 0, 45);
	if(buildMode)
		text("EDITING", 0, 105);
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
		case 'w' : eyeZ -= dimCubo; orientationZ -= dimCubo; break;
		case 's' : eyeZ += dimCubo; orientationZ += dimCubo; break;
		case 'a' : eyeX -= dimCubo; orientationX -= dimCubo; break;
		case 'd' : eyeX += dimCubo; orientationX += dimCubo; break;
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
		case ' ': break;
		case CODED : switch(keyCode)
					{
					}
	}
}

void switchMode()
{
	if(!buildMode)
		map = new Map();
	// else
		// map.saveMap();
	buildMode = !buildMode;
}