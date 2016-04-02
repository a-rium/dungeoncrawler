
// Funzioni di movimento

void moveForward()
{
	eyeX += dimCubo * sin(radians(phase));
	eyeZ -= dimCubo * cos(radians(phase));
	
	orientationX = eyeX + dimCubo * sin(radians(phase));
	orientationZ = eyeZ - dimCubo * cos(radians(phase));
	// if(orientationX == eyeX)
	// {
		// float aux = eyeZ;
		// eyeZ += orientationZ > eyeZ ? dimCubo : -dimCubo;
		// orientationZ = eyeZ + (aux > eyeZ ? - dimCubo : dimCubo);
	// }
	// else
	// {
		// float aux = eyeX;
		// eyeX += orientationX > eyeX ? dimCubo : -dimCubo;
		// orientationX = eyeX + (aux > eyeX ? -dimCubo : dimCubo);
	// }
}

void moveBack()
{
	eyeX -= dimCubo * sin(radians(phase));
	eyeZ += dimCubo * cos(radians(phase));
	
	orientationX = eyeX + dimCubo * sin(radians(phase));
	orientationZ = eyeZ - dimCubo * cos(radians(phase));
	// if(orientationX == eyeX)
	// {
		// float aux = eyeZ;
		// eyeZ += orientationZ < eyeZ ? dimCubo : -dimCubo;
		// orientationZ = eyeZ + (aux < eyeZ ? -dimCubo : dimCubo);
	// }
	// else
	// {
		// float aux = eyeX;
		// eyeX += orientationX < eyeX ? dimCubo : -dimCubo;
		// orientationX = eyeX + (aux < eyeX ? -dimCubo : dimCubo);
	// }
}

void moveLeft()
{
	eyeX += dimCubo * sin(radians(phase - 90));
	eyeZ -= dimCubo * cos(radians(phase - 90));
	
	orientationX = eyeX + dimCubo * sin(radians(phase));
	orientationZ = eyeZ - dimCubo * cos(radians(phase));
	// if(orientationX == eyeX)
	// {
		// eyeX += orientationZ < eyeZ ? -dimCubo : dimCubo;
		// orientationX = eyeX;
	// }
	// else
	// {
		// eyeZ += orientationX < eyeX ? dimCubo : -dimCubo;
		// orientationZ = eyeZ;
	// }
}

void moveRight()
{
	eyeX += dimCubo * sin(radians(phase + 90));
	eyeZ -= dimCubo * cos(radians(phase + 90));
	
	orientationX = eyeX + dimCubo * sin(radians(phase));
	orientationZ = eyeZ - dimCubo * cos(radians(phase));
	// if(orientationX == eyeX)
	// {
		// eyeX += -(orientationZ < eyeZ ? -dimCubo : dimCubo);
		// orientationX = eyeX;
	// }
	// else
	// {
		// eyeZ += -(orientationX < eyeX ? dimCubo : -dimCubo);
		// orientationZ = eyeZ;
	// }
}

// Funzioni di spostamento telecamera a destra e a sinistra

void turnLeft()
{
	phase = (phase - 90) % (360);
	orientationX = eyeX + dimCubo * sin(radians(phase));
	orientationZ = eyeZ - dimCubo * cos(radians(phase));
	
	// if(orientationX != eyeX)
	// {
		// orientationZ = orientationX > eyeX ? eyeZ - dimCubo : eyeZ + dimCubo;
		// orientationX = eyeX;
	// }
	// else
	// {
		// orientationX = orientationZ > eyeZ ? eyeX + dimCubo : eyeX - dimCubo;
		// orientationZ = eyeZ; 
	// }
}

void turnRight()
{
	phase = (phase + 90) % (360);
	orientationX = eyeX + dimCubo * sin(radians(phase));
	orientationZ = eyeZ - dimCubo * cos(radians(phase));
	// if(orientationX != eyeX)
	// {
		// orientationZ = orientationX > eyeX ? eyeZ + dimCubo : eyeZ - dimCubo;
		// orientationX = eyeX;
	// }
	// else
	// {
		// orientationX = orientationZ > eyeZ ? eyeX - dimCubo : eyeX + dimCubo;
		// orientationZ = eyeZ; 
	// }
}

void teleport(int x, int y, int z)
{
	orientationX = (orientationX == eyeX) ? x * dimCubo + dimCubo/2 : 
				   (orientationX > eyeX ? x * dimCubo + 3*dimCubo/2 : x * dimCubo - dimCubo/2);
	orientationY = y * dimCubo + dimCubo/2;
    orientationZ = (orientationZ == eyeZ) ? z * dimCubo + dimCubo/2: 
				   (orientationZ > eyeZ ? z * dimCubo + dimCubo/2 : z * dimCubo - 3*dimCubo/2);
	eyeX = x * dimCubo + dimCubo/2;
	eyeY = y * dimCubo + dimCubo/2;
	eyeZ = z * dimCubo + dimCubo/2;
	
}



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
