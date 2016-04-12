

class Stair extends Solid
{
	public Stair(int type, int size)
	{
		super(type, size);
		solid = createShape();
		solid.beginShape();
		solid.vertex(0, 0, 0);
		solid.vertex(dimCubo, 0, 0);
		solid.vertex(dimCubo, 0, dimCubo / 4);
		solid.vertex(0, 0, dimCubo / 4);
		solid.vertex(0, 0, 0);		//primo piano
		solid.vertex(0, 0, dimCubo / 4);
		solid.vertex(0, dimCubo / 4, dimCubo / 4);
		solid.vertex(dimCubo, dimCubo / 4, dimCubo / 4);
		solid.vertex(dimCubo, 0, dimCubo / 4); // primo scalino
		solid.vertex(dimCubo, dimCubo / 4, dimCubo / 4);
		solid.vertex(dimCubo, dimCubo / 4, dimCubo / 2);
		solid.vertex(0, dimCubo / 4, dimCubo / 2);
		solid.vertex(0, dimCubo / 4, dimCubo / 4);
		solid.vertex(0, dimCubo / 4, dimCubo / 2);
		solid.vertex(0, dimCubo / 2, dimCubo / 2);
		solid.vertex(dimCubo, dimCubo / 2, dimCubo / 2);
		solid.vertex(dimCubo, dimCubo / 4, dimCubo / 2);
		solid.vertex(dimCubo, dimCubo / 2, dimCubo / 2); // secondo scalino
		solid.vertex(dimCubo, dimCubo / 2, dimCubo * 3 / 4);
		solid.vertex(0, dimCubo / 2, dimCubo * 3 / 4);
		solid.vertex(0, dimCubo / 2, dimCubo / 2);
		solid.vertex(0, dimCubo / 2, dimCubo * 3 / 4);
		solid.vertex(0, dimCubo * 3 / 4, dimCubo * 3 / 4);
		solid.vertex(dimCubo, dimCubo * 3 / 4, dimCubo * 3 / 4);
		solid.vertex(dimCubo, dimCubo / 2, dimCubo * 3 / 4);
		solid.vertex(dimCubo, dimCubo * 3 / 4, dimCubo * 3 / 4);
		solid.vertex(dimCubo, dimCubo * 3 / 4, dimCubo);
		solid.vertex(0, dimCubo * 3 / 4, dimCubo);
		solid.vertex(0, dimCubo * 3 / 4, dimCubo * 3 / 4);
		solid.vertex(0, dimCubo * 3 / 4, dimCubo);
		solid.vertex(0, dimCubo, dimCubo);
		solid.vertex(dimCubo, dimCubo, dimCubo);
		solid.vertex(dimCubo, dimCubo * 3 / 4, dimCubo);
		solid.vertex(dimCubo, dimCubo, dimCubo);
		solid.vertex(dimCubo, dimCubo, 0);
		solid.vertex(dimCubo, 0, 0);
		solid.vertex(dimCubo, dimCubo, 0);
		solid.vertex(0, dimCubo, 0);
		solid.vertex(0, 0, 0);
		solid.vertex(0, dimCubo, 0);
		solid.vertex(0, dimCubo, dimCubo);
		solid.vertex(0, 0, dimCubo);
		solid.vertex(0, 0, 0);
		solid.endShape(CLOSE);
		
		solid.setStroke(5);
		
		setCorrespondingTexture();
	}
	
	public void draw(int tX, int tY, int tZ)
	{
		solid.fill(0, 0, 0);
		super.draw(tX - dimCubo / 2, tY - dimCubo / 2, tZ - dimCubo / 2);
	}
}