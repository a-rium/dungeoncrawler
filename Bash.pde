

class Bash
{
	private String[] prevCommands;
	public int arrayIndex = 0;
	public int walkIndex = 0;
	
	public Bash(int saveNumber)
	{
		prevCommands = new String[saveNumber];
	}
	
	public void command(String command)
	{
		if(arrayIndex != prevCommands.length)
		{
			prevCommands[arrayIndex] = command;
			arrayIndex++;
		}
		else
		{
			for(int i = 0; i<prevCommands.length - 1; i++)
				prevCommands[i] = prevCommands[i+1];
			prevCommands[arrayIndex - 1] = command;
		}
		walkIndex = arrayIndex;
		
		String[] cmd = command.split(" ");
		//gestione comando
		if(cmd[0].equals("edit") && cmd.length == 2)
		{
			if(cmd[1].equals("true"))
				buildMode = true;
			else if(cmd[1].equals("false"))
				buildMode = false;
		}
		else if(cmd[0].equals("save") && cmd.length == 2)
			map.saveMap(cmd[1]);
		else if(cmd[0].equals("load") && cmd.length == 2)
			map = new Map(cmd[1]);
		else if(cmd[0].equals("new") && (cmd.length == 1  || cmd.length == 4))
		{
			if(cmd.length == 1)
				map = new Map(10, 10, 10);
			if(cmd.length == 4)
				map = new Map(Integer.parseInt(cmd[1]),
							   Integer.parseInt(cmd[2]),
							   Integer.parseInt(cmd[3]));
		}
		else if(cmd[0].equals("tp") && cmd.length == 4)
			teleport(Integer.parseInt(cmd[1]),
					 Integer.parseInt(cmd[2]),
					 Integer.parseInt(cmd[3]));
		else if(cmd[0].equals("size") && cmd.length == 2)
		{
			int x = floor(eyeX / dimCubo);
			int y = floor(eyeY / dimCubo);
			int z = floor(eyeZ / dimCubo);
			dimCubo = Integer.parseInt(cmd[1]);
			teleport(x, y, z);
			map.redoCubes();
		}
		else if(cmd[0].equals("delimiter") && cmd.length == 2)
		{
			if(cmd[1].equals("on"))
				delimiter = true;
			else if(cmd[1].equals("off"))
				delimiter = false;
		}
		else if(cmd[0].equals("print") && cmd.length == 2)
			map.printFloor(Integer.parseInt(cmd[1]));
		else if(cmd[0].equals("startlog") && cmd.length == 2)
			startLog(cmd[1]);
		else if(cmd[0].equals("endlog") && cmd.length == 1)
			endLog();
		else if(cmd[0].equals("chts") && cmd.length == 2)
			turnSpeed = Integer.parseInt(cmd[1]);
		else if(cmd[0].equals("chms") && cmd.length == 2)
			movingSpeed = Integer.parseInt(cmd[1]);
		else if(cmd[0].equals("dimension") && cmd.length == 1)
			map.printDimension();
	}
	
	public String getPreviousCommand()
	{
		if(walkIndex > 0)
			return prevCommands[--walkIndex];
		else
			return prevCommands[0];
	}
	
	public String getNextCommand()
	{
		if(walkIndex + 1 < arrayIndex)
			return prevCommands[++walkIndex];
		else
		{
			walkIndex = arrayIndex;
			return "";
		}
	}
}