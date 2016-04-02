

abstract class Solid
{
	protected PShape solid;
	protected int type, size;
	
	protected Solid(int type, int size)
	{
		this.type = type;
		this.size = size;
	}
	
	public void draw()
	{
		shape(solid);
	}

	public void draw(int tX, int tY, int tZ)
	{
		if(type > 0)
		{
			pushMatrix();
			translate(tX, tY, tZ);
			shape(solid);
			popMatrix();
		}
	}

	public int getSize()
	{
		return size;
	}

	public int getType()
	{
		return type;
	}

	public void changeType(int type)
	{
		this.type = type;
		setCorrespondingTexture();
	}

	protected void setCorrespondingTexture()
	{
		switch(type)
		{
			case 1 : solid.setTexture(wood); break;
			case 2 : solid.setTexture(stone); break;
		}
	}
}