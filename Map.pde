
// depth -> depth
// cols -> width
// rows -> height


import java.util.ArrayList;
import java.util.Arrays;

class Map
{
	private int width, height, depth;
	private ArrayList<Table> map3d;
	private ArrayList<ArrayList<ArrayList<Cube>>> cubes;

	public Map(int width, int height, int depth)
	{
		this.width = width;
		this.height = height;
		this.depth = depth;
		
		map3d = new ArrayList<Table>(height);
		for(int h = 0; h<height; h++)		//creazione di una mappa 3d vuota di dimensioni 10x10x10
		{
			map3d.add(new Table());
			for(int w = 0; w<width; w++)
				map3d.get(h).addColumn();
			for(int d = 0; d<depth; d++)
			{
				map3d.get(h).addRow();
				for(int w = 0; w<width; w++)
					map3d.get(h).setInt(d, w, 0);
			}
		}
		
		cubes = new ArrayList<ArrayList<ArrayList<Cube>>>(height);
		for(int h = 0; h<height; h++)
		{
			cubes.add(new ArrayList<ArrayList<Cube>>(depth));
			for(int d = 0; d<depth; d++)
			{
				cubes.get(h).add(new ArrayList<Cube>(width));
				for(int w = 0; w<width; w++)
					cubes.get(h).get(d).add(new Cube(map3d.get(h).getInt(d, w), dimCubo));
			}
		}
	}
	
	public Map(String path)
	{
		Table info = loadTable(path);
		width = info.getInt(0, 0);
		height = info.getInt(0, 1);
		depth = info.getInt(0, 2);
		
		map3d = new ArrayList<Table>(height);
		for(int h = height - 1; h>=0; h--)
			map3d.add(loadTable(path.substring(0, path.indexOf(".")) + "_" + h + ".csv"));
		
		cubes = new ArrayList<ArrayList<ArrayList<Cube>>>(height);
		for(int h = 0; h<height; h++)
		{
			cubes.add(new ArrayList<ArrayList<Cube>>(depth));
			for(int d = 0; d<depth; d++)
			{
				cubes.get(h).add(new ArrayList<Cube>(width));
				for(int w = 0; w<width; w++)
					cubes.get(h).get(d).add(new Cube(map3d.get(h).getInt(d, w), dimCubo));
			}
		}
	}
	public void drawGridLike()
	{
		int tY = dimCubo / 2;
		for(int h = 0; h<height; h++)
		{
			int tZ = dimCubo / 2;
			for(int d = 0; d<depth; d++)
			{
				int tX = dimCubo/2;
				for(int w = 0; w<width; w++)
					cubes.get(h).get(d).get(w).draw(tX + dimCubo * w, tY, tZ);
				tZ += dimCubo;
			}
			tY += dimCubo;
		}
	}
	
	public void drawDelimiter()
	{
		pushMatrix();
		noFill();
		
		stroke(10);
		
		translate(width * dimCubo / 2, height * dimCubo / 2, depth * dimCubo / 2);
		box(width * dimCubo, height * dimCubo, depth * dimCubo);
		/*
		
		beginShape();
		vertex(0, 0, 0);
		vertex(width * dimCubo, 0, 0);
		vertex(0, height * dimCubo, 0);
		vertex(width * dimCubo, height * dimCubo, 0);
		
		vertex(0, 0, depth * dimCubo);
		vertex(width * dimCubo, 0, depth * dimCubo);
		vertex(0, height * dimCubo, depth * dimCubo);
		vertex(width * dimCubo, height * dimCubo, depth * dimCubo);
		
		
		
		endShape();
		*/
		popMatrix();
	}
	
	public void setCube(int x, int y, int z, int type)
	{
		if(x < 0 || y < 0 || z < 0)
			return;
		// assert(false) : "X : " + x + " Y : " + y + " Z : " +z; 
		if(x >= width || y >= height || z >= depth)
		{
			
			multidimensionalResize(x, y, z);
		}
		// assert(false) : "Errore: d = " + depth + " r = " + height + " c = " +  width;
		cubes.get(y).get(z).get(x).changeType(type);
		map3d.get(y).setInt(y, x, type);
	}
	
	private void multidimensionalResize(int x, int y, int z)
	{
		if(width <= x)
		{
			for(int h = 0; h<height; h++)
				for(int w = width; w<=x; w++)
				{
					map3d.get(h).addColumn();
					for(int d = 0; d<depth; d++)
					{
						map3d.get(h).setInt(d, w, 0);
						cubes.get(h).get(d).add(new Cube(0, dimCubo));
					}
				}
			width = x+1;
		}
		
		if(height <= y)
		{
			for(int h = height; height<=y; height++)
			{
				map3d.add(new Table());
				cubes.add(new ArrayList<ArrayList<Cube>>(depth));
				for(int w = 0; w<width; w++)
					map3d.get(h).addColumn();
				for(int d = 0; d<depth; d++)
				{
					map3d.get(h).addRow();
					cubes.get(h).add(new ArrayList<Cube>(width));
					for(int w = 0; w<width; w++)
					{
						map3d.get(d).setInt(d, w, 0);
						cubes.get(h).get(d).add(new Cube(0, dimCubo));
					}
				}
				depth++;
			}
		}
		
		if(depth <= z)
		{
			for(int h = 0; h<height; h++)
				for(int d = depth; d<=z; d++)
				{
					map3d.get(h).addRow();
					cubes.get(h).add(new ArrayList<Cube>(width));
					for(int w = 0; w<width; w++)
					{
						map3d.get(h).setInt(d, w, 0);
						cubes.get(h).get(d).add(new Cube(0, dimCubo));
					}
				}
			height = y+1;
		}
		
		
		
	}
	public void saveMap(String path)
	{
		PrintWriter out = createWriter(path);
		out.print("" + width + "," + height + "," + depth);
		out.close();
		for(int h = 0; h<height; h++)
		{
			out = createWriter(path.substring(0, path.indexOf(".")) + "_" + (height - h - 1) + ".csv");
			for(int d = 0; d<depth; d++)
			{
				for(int w = 0; w<width; w++)
				{
					out.print("" + map3d.get(h).getInt(d, w));
					if(w != width - 1)
						out.print(",");
				}
				out.println();
			}
			out.close();
		}
	}
	public void redoCubes()
	{
		cubes = new ArrayList<ArrayList<ArrayList<Cube>>>(height);
		for(int h = 0; h<height; h++)
		{
			cubes.add(new ArrayList<ArrayList<Cube>>(depth));
			for(int d = 0; d<depth; d++)
			{
				cubes.get(h).add(new ArrayList<Cube>(width));
				for(int w = 0; w<width; w++)
					cubes.get(h).get(d).add(new Cube(map3d.get(h).getInt(d, w), dimCubo));
			}
		}
	}
}