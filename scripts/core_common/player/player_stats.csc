// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace stats;

/*
	Name: function_d92cb558
	Namespace: stats
	Checksum: 0x4C4B2921
	Offset: 0x68
	Size: 0x124
	Parameters: 2
	Flags: None
*/
function function_d92cb558(result, vararg)
{
	/#
		if(!isdefined(result))
		{
			pathstr = (ishash(vararg[0]) ? function_9e72a96(vararg[0]) : vararg[0]);
			if(!isdefined(pathstr))
			{
				return;
			}
			for(i = 1; i < vararg.size; i++)
			{
				pathstr = (pathstr + "") + (ishash(vararg[i]) ? function_9e72a96(vararg[i]) : vararg[i]);
			}
			println("" + pathstr);
		}
	#/
}

/*
	Name: get_stat
	Namespace: stats
	Checksum: 0x7D4D009B
	Offset: 0x198
	Size: 0x68
	Parameters: 2
	Flags: Linked, Variadic
*/
function get_stat(localclientnum, ...)
{
	result = readstat(localclientnum, currentsessionmode(), vararg);
	/#
		function_d92cb558(result, vararg);
	#/
	return result;
}

/*
	Name: function_842e069e
	Namespace: stats
	Checksum: 0x75A37C2B
	Offset: 0x208
	Size: 0x68
	Parameters: 3
	Flags: Variadic
*/
function function_842e069e(localclientnum, sessionmode, ...)
{
	result = readstat(localclientnum, sessionmode, vararg);
	/#
		function_d92cb558(result, vararg);
	#/
	return result;
}

/*
	Name: get_stat_global
	Namespace: stats
	Checksum: 0xBA83D867
	Offset: 0x278
	Size: 0x42
	Parameters: 2
	Flags: Linked
*/
function get_stat_global(localclientnum, statname)
{
	return get_stat(localclientnum, #"playerstatslist", statname, #"statvalue");
}

