
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
	public String toString()
	{
		return "" + x + "," + y + "," + z;
	}	
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
