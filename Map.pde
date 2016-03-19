

class Map
{
	private int rows, cols;
	private Table map;
	private Cube[][] cubes;

	public Map(String path)
	{
		map = loadTable(path);
		rows = map.getInt(0, 0);
		cols = map.getInt(0, 1);
		map.removeRow(0);			//rimozione della riga contenente le dimensioni della mappa
		cubes = new Cube[rows][];
		for(int i = 0; i<rows; i++)
		{
			cubes[i] = new Cube[cols];
			for(int j = 0; j<cols; j++)
				cubes[i][j] = new Cube(map.getInt(i, j), dimCubo);
		}
	}
	public void drawGridLike()
	{
		int tY = dimCubo/2;
		for(int i = 0; i<rows; i++)
		{
			int tX = dimCubo/2;
			for(int j = 0; j<cols; j++)
				cubes[i][j].draw(tX + dimCubo * j, tY);
			tY += dimCubo;
		}
	}
}