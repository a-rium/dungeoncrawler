
// depth -> depth
// cols -> width
// rows -> height


import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Collections;

HashMap<Integer, PImage> textures;		// e' globale, di modo che sia visibile a tutti i solidi
HashMap<Integer, String> sources;
HashMap<Integer, String> types;

class Map
{
	private int width, height, depth;
	private ArrayList<Table> map3d;
	private ArrayList<ArrayList<ArrayList<Solid>>> cubes;
	
	


	public Map(int width, int height, int depth)
	{
		this.width = width;
		this.height = height;
		this.depth = depth;
		
		//sources = new HashMap<Integer, String>();
		//textures = new HashMap<Integer, PImage>();
		//types = new HashMap<Integer, String>();
		
		//currentTexture = -1;
		
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
		
		cubes = new ArrayList<ArrayList<ArrayList<Solid>>>(height);
		for(int h = 0; h<height; h++)
		{
			cubes.add(new ArrayList<ArrayList<Solid>>(depth));
			for(int d = 0; d<depth; d++)
			{
				cubes.get(h).add(new ArrayList<Solid>(width));
				for(int w = 0; w<width; w++)
				{
					int type = map3d.get(h).getInt(d, w);
					cubes.get(h).get(d).add(new Cube(type, dimCubo));
				}
			}
		}
	}
	
	public Map(String path)
	{
		try{
			loadMedia(path);

			cubes = new ArrayList<ArrayList<ArrayList<Solid>>>(height);
			for(int h = 0; h<height; h++)
			{
				cubes.add(new ArrayList<ArrayList<Solid>>(depth));
				for(int d = 0; d<depth; d++)
				{
					cubes.get(h).add(new ArrayList<Solid>(width));
					for(int w = 0; w<width; w++)
					{
						int type = map3d.get(h).getInt(d, w);
						if(type == 0)
							cubes.get(h).get(d).add(new Cube(type, dimCubo));
						else if(types.get(type).equals("block"))
							cubes.get(h).get(d).add(new Cube(type, dimCubo));
						else if(types.get(type).equals("stair"))
							cubes.get(h).get(d).add(new Stair(type, dimCubo));
					}
				}
			}
		}
		catch(NullPointerException n){ println("Error: accessing to null object."); }
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

		popMatrix();
	}
	
	public void setCube(int x, int y, int z, int type)
	{
		if(x < 0 || y < 0 || z < 0)
			return;
		// assert(false) : "X : " + x + " Y : " + y + " Z : " +z; 
		if(x >= width || y >= height || z >= depth)
		{
			//assert false : width + "" + height + "" + depth;
			multidimensionalResize(x, y, z);
		}
		
		// assert(false) : "Errore: d = " + depth + " r = " + height + " c = " +  width;
		if(type == 0  || types.get(type).equals("block"))
			cubes.get(y).get(z).set(x, new Cube(type, dimCubo));
		else if(types.get(type).equals("stair"))
			cubes.get(y).get(z).set(x, new Stair(type, dimCubo));
		map3d.get(y).setInt(z, x, type);
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
				cubes.add(new ArrayList<ArrayList<Solid>>(depth));
				for(int w = 0; w<width; w++)
					map3d.get(h).addColumn();
				for(int d = 0; d<depth; d++)
				{
					map3d.get(h).addRow();
					cubes.get(h).add(new ArrayList<Solid>(width));
					for(int w = 0; w<width; w++)
					{
						map3d.get(d).setInt(d, w, 0);
						cubes.get(h).get(d).add(new Cube(0, dimCubo));
					}
				}
				height++;
			}
		}
		
		if(depth <= z)
		{
			for(int h = 0; h<height; h++)
				for(int d = depth; d<=z; d++)
				{
					map3d.get(h).addRow();
					cubes.get(h).add(new ArrayList<Solid>(width));
					for(int w = 0; w<width; w++)
					{
						map3d.get(h).setInt(d, w, 0);
						cubes.get(h).get(d).add(new Cube(0, dimCubo));
					}
				}
			depth = z+1;
		}
		
		
		
	}
	public void saveMap(String path)
	{
		PrintWriter out = createWriter(path);
		out.println("" + width + "," + height + "," + depth);
		saveMedia(out);		// salvataggio dei materiali utilizzati
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
	
	public void printFloor(int f)
	{
		println("Floor " +  f);
		for(int d = 0; d<depth; d++)
		{
			for(int w = 0; w<width; w++)
				print("" + map3d.get(f).getInt(d, w) + " ");
			println();
		}
		
	}
	
	public void redoCubes()
	{
		cubes = new ArrayList<ArrayList<ArrayList<Solid>>>(height);
		for(int h = 0; h<height; h++)
		{
			cubes.add(new ArrayList<ArrayList<Solid>>(depth));
			for(int d = 0; d<depth; d++)
			{
				cubes.get(h).add(new ArrayList<Solid>(width));
				for(int w = 0; w<width; w++)
				{
					int type = map3d.get(h).getInt(d, w);
					if(types.get(type).equals("block"))
						cubes.get(h).get(d).add(new Cube(type, dimCubo));
					else if(types.get(type).equals("stair"))
						cubes.get(h).get(d).add(new Stair(type, dimCubo));
				}
			}
		}
	}
	
	private void loadMedia(String path)
	{
		try{
			Table content = loadTable(path);
			width = content.getInt(0, 0);
			height = content.getInt(0, 1);
			depth = content.getInt(0, 2);
			content.removeRow(0);
			sources = new HashMap<Integer, String>(content.getRowCount());
			textures = new HashMap<Integer, PImage>(content.getRowCount());
			types = new HashMap<Integer, String>(content.getRowCount());
			for(int i = 0; i<content.getRowCount(); i++)
			{
				sources.put(content.getInt(i, 0), content.getString(i, 1));
				textures.put(content.getInt(i, 0),loadImage(content.getString(i, 1)));
				if(content.getString(i, 2) != null)
				{
					if(content.getString(i, 2).toLowerCase().equals("stair"))
						types.put(content.getInt(i, 0), "stair");
				}
				else
					types.put(content.getInt(i, 0), "block");
			}
			map3d = new ArrayList<Table>(height);
			for(int h = height - 1; h>=0; h--)
				map3d.add(loadTable(path.substring(0, path.indexOf(".")) + "_" + h + ".csv"));
		} 
		catch(NullPointerException n)
		{ 
			println("Couldn't open file " +  path + " (Exception in loadMedia)");
			width = height = depth = 0;
		}
	}
	
	private void saveMedia(PrintWriter out)
	{
		for(Integer key : sources.keySet())
		{
			out.print("" + key + "," + sources.get(key));
			if(key > 0)
			{
				if(types.get(key).equals("stair"))
					out.print(",stair");
			}
			out.println();
		}
	}
	
	public boolean colliding(int x, int y, int z)
	{
		if(map3d.get(y).getInt(z, x) != 0)
			return true;
		return false;
	}
	
	public void printDimension()
	{
		println("Width : " + width + "\nHeight : " + height + "\nDepth : " +depth);
	}
}