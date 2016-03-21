
class Cube
{
	private int type;
	private int size;
	private PShape solid;

	public Cube(int type, int size)
	{
		this.type = type;
		this.size = size;
		solid = createShape(BOX, size);
		setCorrespondingTexture();
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

	private void setCorrespondingTexture()
	{
		switch(type)
		{
			case 1 : solid.setTexture(wood); break;
			case 2 : solid.setTexture(stone); break;
		}
	}
}