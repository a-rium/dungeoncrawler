
import java.util.ArrayList;
import java.util.Arrays;

class Map
{
	private int rows, cols, depth;
	private ArrayList<Table> map3d;
	private ArrayList<ArrayList<ArrayList<Cube>>> cubes;

	public Map(int rows, int cols, int depths)
	{
		this.rows = rows;
		this.cols = cols;
		this.depth = depth;
		
		map3d = new ArrayList<Table>(depth);
		for(int d = 0; d<depth; d++)		//creazione di una mappa 3d vuota di dimensioni 10x10x10
		{
			map3d.add(new Table());
			for(int j = 0; j<cols; j++)
				map3d.get(d).addColumn();
			for(int i = 0; i<rows; i++)
			{
				map3d.get(d).addRow();
				for(int j = 0; j<cols; j++)
					map3d.get(d).setInt(i, j, 0);
			}
		}
		
		cubes = new ArrayList<ArrayList<ArrayList<Cube>>>(depth);
		for(int d = 0; d<depth; d++)
		{
			cubes.add(new ArrayList<ArrayList<Cube>>(rows));
			for(int i = 0; i<rows; i++)
			{
				cubes.get(d).add(new ArrayList<Cube>(cols));
				for(int j = 0; j<cols; j++)
					cubes.get(d).get(i).add(new Cube(map3d.get(d).getInt(i, j), dimCubo));
			}
		}
	}
	
	public Map(String path)
	{
		Table info = loadTable(path);
		rows = info.getInt(0, 0);
		cols = info.getInt(0, 1);
		depth = info.getInt(0, 2);
		
		map3d = new ArrayList<Table>(depth);
		for(int d = 0; d<depth; d++)
			map3d.add(loadTable(path.substring(0, path.indexOf(".")) + "_" + d + ".csv"));
		
		cubes = new ArrayList<ArrayList<ArrayList<Cube>>>(depth);
		for(int d = 0; d<depth; d++)
		{
			cubes.add(new ArrayList<ArrayList<Cube>>(rows));
			for(int i = 0; i<rows; i++)
			{
				cubes.get(d).add(new ArrayList<Cube>(cols));
				for(int j = 0; j<cols; j++)
					cubes.get(d).get(i).add(new Cube(map3d.get(d).getInt(i, j), dimCubo));
			}
		}
	}
	public void drawGridLike()
	{
		int tZ = dimCubo / 2;
		for(int d = 0; d<depth; d++)
		{
			int tY = dimCubo / 2;
			for(int i = 0; i<rows; i++)
			{
				int tX = dimCubo/2;
				for(int j = 0; j<cols; j++)
					cubes.get(d).get(i).get(j).draw(tX + dimCubo * j, tY, tZ);
				tY += dimCubo;
			}
			tZ += dimCubo;
		}
	}
	
	public void setCube(int x, int y, int z, int type)
	{
		if(x < 0 || y < 0 || z < 0)
			return;
		// assert(false) : "X : " + x + " Y : " + y + " Z : " +z; 
		if(x >= cols || y >= rows || z >= depth)
		{
			
			multidimensionalResize(x, y, z);
		}
		// assert(false) : "Errore: d = " + depth + " r = " + rows + " c = " +  cols;
		cubes.get(z).get(y).get(x).changeType(type);
		map3d.get(z).setInt(y, x, type);
	}
	
	private void multidimensionalResize(int x, int y, int z)
	{
		if(cols <= x)
		{
			for(int d = 0; d<depth; d++)
				for(int j = cols; j<=x; j++)
				{
					map3d.get(d).addColumn();
					for(int i = 0; i<rows; i++)
					{
						map3d.get(d).setInt(i, j, 0);
						cubes.get(d).get(i).add(new Cube(0, dimCubo));
					}
				}
			cols = x+1;
		}
		
		if(rows <= y)
		{
			for(int d = 0; d<depth; d++)
				for(int i = rows; i<=y; i++)
				{
					map3d.get(d).addRow();
					cubes.get(d).add(new ArrayList<Cube>(cols));
					for(int j = 0; j<cols; j++)
					{
						map3d.get(d).setInt(i, j, 0);
						cubes.get(d).get(i).add(new Cube(0, dimCubo));
					}
				}
			rows = y+1;
		}
		
		if(depth <= z)
		{
			for(int d = depth; d<=z; d++)
			{
				map3d.add(new Table());
				cubes.add(new ArrayList<ArrayList<Cube>>(rows));
				for(int j = 0; j<cols; j++)
					map3d.get(d).addColumn();
				for(int i = 0; i<rows; i++)
				{
					map3d.get(d).addRow();
					cubes.get(d).add(new ArrayList<Cube>(cols));
					for(int j = 0; j<cols; j++)
					{
						map3d.get(d).setInt(i, j, 0);
						cubes.get(d).get(i).add(new Cube(0, dimCubo));
					}
				}
				depth++;
			}
		}
		
	}
	public void saveMap(String path)
	{
		PrintWriter out = createWriter(path);
		out.print("" + cols + "," + rows + "," + depth);
		out.close();
		for(int d = 0; d<depth; d++)
		{
			out = createWriter(path.substring(0, path.indexOf(".")) + "_" + d + ".csv");
			for(int i = 0; i<rows; i++)
			{
				for(int j = 0; j<cols; j++)
				{
					out.print("" + map3d.get(d).getInt(i, j));
					if(j != cols - 1)
						out.print(",");
				}
				out.println();
			}
			out.close();
		}
	}
	public void redoCubes()
	{
		cubes = new ArrayList<ArrayList<ArrayList<Cube>>>(depth);
		for(int d = 0; d<depth; d++)
		{
			cubes.add(new ArrayList<ArrayList<Cube>>(rows));
			for(int i = 0; i<rows; i++)
			{
				cubes.get(d).add(new ArrayList<Cube>(cols));
				for(int j = 0; j<cols; j++)
					cubes.get(d).get(i).add(new Cube(map3d.get(d).getInt(i, j), dimCubo));
			}
		}
	}
}