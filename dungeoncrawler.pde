
Cube cubo;
final int dimCubo = 100;
float grades = 0.01;
float orientationX;
float orientationY;

float eyeX, eyeY, eyeZ;


boolean startMouseTracking = false;

PImage wood;		//type 0
PImage stone;		//type 1

Map map;

void setup()
{
	size(1200, 700, P3D);
	orientationX = width / 2.0;
	orientationY = height / 2.0;
	eyeX = width / 2.0;
	eyeY = height / 2.0;
	eyeZ = (height / 2) / tan(PI / 6);
	wood = loadImage("src/wood.jpg");
	stone = loadImage("src/stone.jpg");
	cubo = new Cube(0, dimCubo);
	map = new Map("src/map.csv");
}

void draw()
{
	noStroke();
	camera(eyeX, eyeY, eyeZ,
		   orientationX, orientationY,
           -eyeZ + 10*dimCubo, 0, 1, 0);
	background(180);
	translate(width/2, height/2);
	//rotateY(grades+=0.01);
	map.drawGridLike();
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
		case 'w' : eyeZ -= dimCubo; break;
		case 's' : eyeZ += dimCubo; break;
		case 'a' : eyeX -= dimCubo; orientationX -= dimCubo; break;
		case 'd' : eyeX += dimCubo; orientationX += dimCubo;; break;
		case 'l' : eyeY -= dimCubo; orientationY -= dimCubo; break;
		case 'o' : eyeY += dimCubo; orientationY += dimCubo; break;
	}
}