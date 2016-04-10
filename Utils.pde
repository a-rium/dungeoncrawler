
class Coordinate
{
	private int x, y, z;
	public Coordinate(int x, int y, int z)
	{
		this.x = x;
		this.y = y;
		this.z = z;
		// println("Created X " + x + " Y " + y + " Z " + z);
	}
	public int getX(){ return x; }
	public int getY(){ return y; }
	public int getZ(){ return z; }
	public boolean equals(Object o)
	{
		if(o == null) return false;
		if(o == this) return true;
		if(!(o instanceof Coordinate)) return false;
		Coordinate obj = (Coordinate)o;
		return x == obj.x && y == obj.y && z == obj.z;
	}
	public int hashCode()
	{
		return x + y + z;
	}
}


// Funzioni di movimento
/*
void moveForward()
{	
	eyeX += movingSpeed * sin(radians(phase));
	eyeZ -= movingSpeed * cos(radians(phase));
	
	orientationX = eyeX + dimCubo * sin(radians(phase));
	orientationZ = eyeZ - dimCubo * cos(radians(phase));
	// if(orientationX == eyeX)
	// {
		// float aux = eyeZ;
		// eyeZ += orientationZ > eyeZ ? movingSpeed : -movingSpeed;
		// orientationZ = eyeZ + (aux > eyeZ ? - movingSpeed : movingSpeed);
	// }
	// else
	// {
		// float aux = eyeX;
		// eyeX += orientationX > eyeX ? movingSpeed : -movingSpeed;
		// orientationX = eyeX + (aux > eyeX ? -movingSpeed : movingSpeed);
	// }
}

void moveBack()
{
	eyeX -= movingSpeed * sin(radians(phase));
	eyeZ += movingSpeed * cos(radians(phase));
	
	orientationX = eyeX + dimCubo * sin(radians(phase));
	orientationZ = eyeZ - dimCubo * cos(radians(phase));
	// if(orientationX == eyeX)
	// {
		// float aux = eyeZ;
		// eyeZ += orientationZ < eyeZ ? movingSpeed : -movingSpeed;
		// orientationZ = eyeZ + (aux < eyeZ ? -movingSpeed : movingSpeed);
	// }
	// else
	// {
		// float aux = eyeX;
		// eyeX += orientationX < eyeX ? movingSpeed : -movingSpeed;
		// orientationX = eyeX + (aux < eyeX ? -movingSpeed : movingSpeed);
	// }
}

void moveLeft()
{
	eyeX += movingSpeed * sin(radians(phase - 90));
	eyeZ -= movingSpeed * cos(radians(phase - 90));
	
	orientationX = eyeX + dimCubo * sin(radians(phase));
	orientationZ = eyeZ - dimCubo * cos(radians(phase));
	// if(orientationX == eyeX)
	// {
		// eyeX += orientationZ < eyeZ ? -movingSpeed : movingSpeed;
		// orientationX = eyeX;
	// }
	// else
	// {
		// eyeZ += orientationX < eyeX ? movingSpeed : -movingSpeed;
		// orientationZ = eyeZ;
	// }
}

void moveRight()
{
	eyeX += movingSpeed * sin(radians(phase + 90));
	eyeZ -= movingSpeed * cos(radians(phase + 90));
	
	orientationX = eyeX + dimCubo * sin(radians(phase));
	orientationZ = eyeZ - dimCubo * cos(radians(phase));
	// if(orientationX == eyeX)
	// {
		// eyeX += -(orientationZ < eyeZ ? -movingSpeed : movingSpeed);
		// orientationX = eyeX;
	// }
	// else
	// {
		// eyeZ += -(orientationX < eyeX ? movingSpeed : -movingSpeed);
		// orientationZ = eyeZ;
	// }
}

// Funzioni di spostamento telecamera a destra e a sinistra

void turnLeft()
{
	phase = (phase - turnSpeed) % (360);
	orientationX = eyeX + dimCubo * sin(radians(phase));
	orientationZ = eyeZ - dimCubo * cos(radians(phase));
	
	
	// if(orientationX != eyeX)
	// {
		// orientationZ = orientationX > eyeX ? eyeZ - movingSpeed : eyeZ + movingSpeed;
		// orientationX = eyeX;
	// }
	// else
	// {
		// orientationX = orientationZ > eyeZ ? eyeX + movingSpeed : eyeX - movingSpeed;
		// orientationZ = eyeZ; 
	// }
}

void turnRight()
{
	phase = (phase + turnSpeed) % (360);
	orientationX = eyeX + dimCubo * sin(radians(phase));
	orientationZ = eyeZ - dimCubo * cos(radians(phase));
	// if(orientationX != eyeX)
	// {
		// orientationZ = orientationX > eyeX ? eyeZ + movingSpeed : eyeZ - movingSpeed;
		// orientationX = eyeX;
	// }
	// else
	// {
		// orientationX = orientationZ > eyeZ ? eyeX - movingSpeed : eyeX + movingSpeed;
		// orientationZ = eyeZ; 
	// }
}

void teleport(int x, int y, int z)
{
	// orientationX = (orientationX == eyeX) ? x * movingSpeed + movingSpeed/2 : 
				   // (orientationX > eyeX ? x * movingSpeed + 3*movingSpeed/2 : x * movingSpeed - movingSpeed/2);
	// orientationY = y * movingSpeed + movingSpeed/2;
    // orientationZ = (orientationZ == eyeZ) ? z * movingSpeed + movingSpeed/2: 
				   // (orientationZ > eyeZ ? z * movingSpeed + movingSpeed/2 : z * movingSpeed - 3*movingSpeed/2);
	eyeX = x * dimCubo + movingSpeed/2;
	eyeY = y * dimCubo + movingSpeed/2;
	eyeZ = z * dimCubo + movingSpeed/2;
	
	orientationX = eyeX + dimCubo * sin(radians(phase));
	orientationZ = eyeZ - dimCubo * cos(radians(phase));
	orientationY = eyeY;
	
}
*/

void startLog(String path)
{
	if(logging) println("Already logging, call endlog to stop.");
	logger = createWriter(path);
	logging = true;
}

void endLog()
{
	if(logging)
	{
		logger.close();
		logging = false;
	}
	else println("No log to save. Start a new one with startlog");
}


int getNextTexture()
{
	if(Collections.max(textures.keySet()).intValue() <= currentTexture)
		return Collections.min(textures.keySet());
	for(Integer key : textures.keySet())
	{
		if(key > currentTexture)
			return key;
	}
	return -1;
}

int getPreviousTexture()
{
	if(Collections.min(textures.keySet()).intValue() >= currentTexture)
		return Collections.max(textures.keySet());
	for(Integer key : textures.keySet())
	{
		if(key < currentTexture)
			return key;
	}
	return -1;
}
