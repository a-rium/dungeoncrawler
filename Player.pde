

class Player
{
	private float eyeX, eyeY, eyeZ;
	private float orientationX, orientationY, orientationZ;
	private float altoX, altoY, altoZ;
	
	private boolean turningLeft, turningRight = false;
	// private int turningCounter = 1;
	
	private boolean movingForward, movingBackwards = false;
	private boolean movingLeft, movingRight = false;
	// private int movingCounter = 0;
	
	private float phase;
	
	public Player()
	{
		eyeX = dimCubo / 2;
		eyeY = dimCubo / 2;
		eyeZ = dimCubo / 2;
		
		orientationX = eyeX;
		orientationY = eyeY;
		orientationZ = eyeZ - dimCubo;
		
		altoX = 0;
		altoY = 1;
		altoZ = 0;
		
		phase = 0;
	}
	
	public void show()
	{
		camera(eyeX, eyeY, eyeZ,
			   orientationX, orientationY, orientationZ,
			   altoX, altoY, altoZ);
	}
	
	public void handle()
	{
		if(!isMoving() && !isTurning())
		{
			switch(key)
			{
					// Movimento in avanti
				case 'w' :
						   movingForward = true; break;//eyeZ -= dimCubo; orientationZ -= dimCubo; break;
				// Movimento indietro
				case 's' : 
						   movingBackwards = true; break; //eyeZ += dimCubo; orientationZ += dimCubo; break;
				// Rotazione della telecamera verso sinistra
				case 'a' : turningLeft = true;  break;
				// Rotazione della telecamera verso destra
				case 'd' : turningRight = true; break;
				// Movimento a sinistra
				case 'z' : 
						   movingLeft = true; break; //eyeX -= dimCubo; orientationX -= dimCubo; break;
				// Movimento a destra
				case 'c' : 
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
				case 'r' : eyeX = dimCubo / 2; eyeY = dimCubo / 2; eyeZ = dimCubo / 2; 
						   orientationX = eyeX; orientationY = eyeY; orientationZ = eyeZ - dimCubo; break;
				// Stampa informazioni di debug
				case 'p' : println("Facing: " + (orientationX == eyeX + dimCubo
							? "RIGHT" : (orientationX == eyeX - dimCubo
							? "LEFT" : (orientationZ == eyeZ + dimCubo 
							? "BACK" : "FORWARD")))); break;
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
				default: switch(keyCode)
				{
					// Cancella il blocco davanti alla telecamera se si e' in modalita editing
					case BACKSPACE: 
						if(buildMode)
							map.setCube(floor(orientationX / dimCubo), 
										floor(orientationY / dimCubo), 
										floor(orientationZ / dimCubo), 0);
						break;
				}
			}
		}
	}
	
	public void playAnimation()
	{
		if(isTurning())
			handlePlayerTurning();
		else if(isMoving())
			handlePlayerMovement();
	}
	
	private void handlePlayerTurning()
	{
		turn();
		if(turningCounter >= 90/turnSpeed)
		{
			turningLeft = turningRight = false;
			turningCounter = 1;
		}
		else turningCounter++;
	}
	
	private void handlePlayerMovement()
	{
		move();
		movingCounter++;
		if(movingCounter >= 100/movingSpeed)
		{
			movingForward = movingBackwards = movingLeft = movingRight = false;
			movingCounter = 0;
		}
	}
	
	public boolean isMoving()
	{
		return (movingForward || movingBackwards || movingLeft || movingRight);
	}
	
	public boolean isTurning()
	{
		return (turningLeft || turningRight);
	}
	
	public void move()
	{
		if(movingForward)
		{
			eyeX += movingSpeed * sin(radians(phase));
			eyeZ -= movingSpeed * cos(radians(phase));
		}
		else if(movingBackwards)
		{
			eyeX -= movingSpeed * sin(radians(phase));
			eyeZ += movingSpeed * cos(radians(phase));
		}
		else if(movingLeft)
		{
			eyeX += movingSpeed * sin(radians(phase - 90));
			eyeZ -= movingSpeed * cos(radians(phase - 90));
		}
		else if(movingRight)
		{
			eyeX += movingSpeed * sin(radians(phase + 90));
			eyeZ -= movingSpeed * cos(radians(phase + 90));
		}
		
		orientationX = eyeX + dimCubo * sin(radians(phase));
		orientationZ = eyeZ - dimCubo * cos(radians(phase));
	}
	/*
	public void moveForward()
	{	
		eyeX += movingSpeed * sin(radians(phase));
		eyeZ -= movingSpeed * cos(radians(phase));
		
		orientationX = eyeX + dimCubo * sin(radians(phase));
		orientationZ = eyeZ - dimCubo * cos(radians(phase));
	}

	public void moveBack()
	{
		eyeX -= movingSpeed * sin(radians(phase));
		eyeZ += movingSpeed * cos(radians(phase));
		
		orientationX = eyeX + dimCubo * sin(radians(phase));
		orientationZ = eyeZ - dimCubo * cos(radians(phase));
	}

	public void moveLeft()
	{
		eyeX += movingSpeed * sin(radians(phase - 90));
		eyeZ -= movingSpeed * cos(radians(phase - 90));
		
		orientationX = eyeX + dimCubo * sin(radians(phase));
		orientationZ = eyeZ - dimCubo * cos(radians(phase));
	}

	public void moveRight()
	{
		eyeX += movingSpeed * sin(radians(phase + 90));
		eyeZ -= movingSpeed * cos(radians(phase + 90));
		
		orientationX = eyeX + dimCubo * sin(radians(phase));
		orientationZ = eyeZ - dimCubo * cos(radians(phase));
	}
	*/
	
	// Funzioni di spostamento telecamera a destra e a sinistra
	
	public void turn()
	{
		if(turningLeft)
			phase = (phase - turnSpeed) % (360);
		else if(turningRight)
			phase = (phase + turnSpeed) % (360);
		orientationX = eyeX + dimCubo * sin(radians(phase));
		orientationZ = eyeZ - dimCubo * cos(radians(phase));
	}
	/*

	public void turnLeft()
	{
		phase = (phase - turnSpeed) % (360);
		orientationX = eyeX + dimCubo * sin(radians(phase));
		orientationZ = eyeZ - dimCubo * cos(radians(phase));
	}

	public void turnRight()
	{
		phase = (phase + turnSpeed) % (360);
		orientationX = eyeX + dimCubo * sin(radians(phase));
		orientationZ = eyeZ - dimCubo * cos(radians(phase));
	}
	*/
}