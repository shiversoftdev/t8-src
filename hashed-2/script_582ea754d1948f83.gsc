// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;

#namespace aispawningutility;

/*
	Name: function_e312ad4d
	Namespace: aispawningutility
	Checksum: 0x2FF42DDE
	Offset: 0x80
	Size: 0x51A
	Parameters: 3
	Flags: Linked
*/
function function_e312ad4d(str_team, var_f8de2ad5, var_82706add)
{
	var_6aa88db7 = [];
	if(isdefined(var_f8de2ad5))
	{
		var_6aa88db7 = getentarray(var_f8de2ad5, "targetname");
	}
	if(var_6aa88db7.size)
	{
		var_9e81c42 = [];
		foreach(var_46023177 in var_6aa88db7)
		{
			if(isspawner(var_46023177))
			{
				if(var_82706add === var_46023177.var_9fde8624)
				{
					if(!isdefined(var_9e81c42))
					{
						var_9e81c42 = [];
					}
					else if(!isarray(var_9e81c42))
					{
						var_9e81c42 = array(var_9e81c42);
					}
					if(!isinarray(var_9e81c42, var_46023177))
					{
						var_9e81c42[var_9e81c42.size] = var_46023177;
					}
				}
			}
		}
		if(!var_9e81c42.size)
		{
			/#
				println("" + var_82706add + "");
				iprintln("" + var_82706add + "");
			#/
			return undefined;
		}
		var_4765679a = [];
		var_4491b72a = [];
		foreach(var_faf91246 in var_9e81c42)
		{
			if(var_faf91246.count > 0 || (isdefined(var_faf91246.spawnflags) && var_faf91246.spawnflags & 64 == 64))
			{
				if(!isdefined(var_4765679a))
				{
					var_4765679a = [];
				}
				else if(!isarray(var_4765679a))
				{
					var_4765679a = array(var_4765679a);
				}
				if(!isinarray(var_4765679a, var_faf91246))
				{
					var_4765679a[var_4765679a.size] = var_faf91246;
				}
				if(isdefined(var_faf91246.spawnflags) && var_faf91246.spawnflags & 32 == 32)
				{
					if(!isdefined(var_4491b72a))
					{
						var_4491b72a = [];
					}
					else if(!isarray(var_4491b72a))
					{
						var_4491b72a = array(var_4491b72a);
					}
					if(!isinarray(var_4491b72a, var_faf91246))
					{
						var_4491b72a[var_4491b72a.size] = var_faf91246;
					}
				}
			}
		}
		if(var_4491b72a.size)
		{
			spawner = array::random(var_4491b72a);
			spawn_point[#"angles"] = spawner.angles;
			spawn_point[#"origin"] = spawner.origin;
			spawn_point[#"spawner"] = spawner;
			return spawn_point;
		}
		if(var_4765679a.size)
		{
			spawner = array::random(var_4765679a);
			spawn_point[#"angles"] = spawner.angles;
			spawn_point[#"origin"] = spawner.origin;
			spawn_point[#"spawner"] = spawner;
			return spawn_point;
		}
		/#
			println("" + var_82706add + "" + str_team + "");
			iprintln("" + var_82706add + "" + str_team + "");
		#/
		return undefined;
	}
	return undefined;
}

