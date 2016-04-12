
class Cube extends Solid
{
	public Cube(int type, int size)
	{
		super(type, size);
		solid = createShape(BOX, size);
		setCorrespondingTexture();
		solid.noStroke();
	}
}