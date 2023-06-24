// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;

#namespace ai_shared;

/*
	Name: main
	Namespace: ai_shared
	Checksum: 0x54B5D6F2
	Offset: 0x78
	Size: 0x1E
	Parameters: 0
	Flags: AutoExec
*/
function autoexec main()
{
	level._customactorcbfunc = &ai::spawned_callback;
}

#namespace ai;

/*
	Name: add_ai_spawn_function
	Namespace: ai
	Checksum: 0x828AC357
	Offset: 0xA0
	Size: 0x132
	Parameters: 2
	Flags: Linked, Variadic
*/
function add_ai_spawn_function(func_spawn, vararg)
{
	if(!isdefined(level.var_71b23817))
	{
		level.var_71b23817 = [];
	}
	else if(!isarray(level.var_71b23817))
	{
		level.var_71b23817 = array(level.var_71b23817);
	}
	var_e45a16f3 = {#params:vararg, #func:func_spawn};
	if(!isdefined(level.var_71b23817))
	{
		level.var_71b23817 = [];
	}
	else if(!isarray(level.var_71b23817))
	{
		level.var_71b23817 = array(level.var_71b23817);
	}
	level.var_71b23817[level.var_71b23817.size] = var_e45a16f3;
}

/*
	Name: function_932006d1
	Namespace: ai
	Checksum: 0x218CED65
	Offset: 0x1E0
	Size: 0xB2
	Parameters: 1
	Flags: None
*/
function function_932006d1(func_spawn)
{
	if(!isdefined(level.var_71b23817))
	{
		return;
	}
	foreach(var_e45a16f3 in level.var_71b23817)
	{
		if(var_e45a16f3.func == func_spawn)
		{
			arrayremovevalue(level.var_71b23817, var_e45a16f3);
			return;
		}
	}
}

/*
	Name: add_archetype_spawn_function
	Namespace: ai
	Checksum: 0x607D5CB3
	Offset: 0x2A0
	Size: 0x1E0
	Parameters: 3
	Flags: Linked, Variadic
*/
function add_archetype_spawn_function(str_archetype, func_spawn, vararg)
{
	if(!isdefined(level.var_c18b23c1))
	{
		level.var_c18b23c1 = [];
	}
	else if(!isarray(level.var_c18b23c1))
	{
		level.var_c18b23c1 = array(level.var_c18b23c1);
	}
	if(!isdefined(level.var_c18b23c1[str_archetype]))
	{
		level.var_c18b23c1[str_archetype] = [];
	}
	else if(!isarray(level.var_c18b23c1[str_archetype]))
	{
		level.var_c18b23c1[str_archetype] = array(level.var_c18b23c1[str_archetype]);
	}
	var_6d69c0bf = {#params:vararg, #func:func_spawn};
	if(!isdefined(level.var_c18b23c1[str_archetype]))
	{
		level.var_c18b23c1[str_archetype] = [];
	}
	else if(!isarray(level.var_c18b23c1[str_archetype]))
	{
		level.var_c18b23c1[str_archetype] = array(level.var_c18b23c1[str_archetype]);
	}
	level.var_c18b23c1[str_archetype][level.var_c18b23c1[str_archetype].size] = var_6d69c0bf;
}

/*
	Name: spawned_callback
	Namespace: ai
	Checksum: 0x9A071A8F
	Offset: 0x488
	Size: 0x1D8
	Parameters: 1
	Flags: Linked
*/
function spawned_callback(localclientnum)
{
	if(isdefined(level.var_71b23817))
	{
		foreach(var_e45a16f3 in level.var_71b23817)
		{
			a_args = arraycombine(array(localclientnum), var_e45a16f3.params, 1, 0);
			util::single_func_argarray(self, var_e45a16f3.func, a_args);
		}
	}
	if(isdefined(level.var_c18b23c1) && isdefined(level.var_c18b23c1[self.archetype]))
	{
		foreach(var_6d69c0bf in level.var_c18b23c1[self.archetype])
		{
			a_args = arraycombine(array(localclientnum), var_6d69c0bf.params, 1, 0);
			util::single_func_argarray(self, var_6d69c0bf.func, a_args);
		}
	}
}

/*
	Name: shouldregisterclientfieldforarchetype
	Namespace: ai
	Checksum: 0xDB85145
	Offset: 0x668
	Size: 0x52
	Parameters: 1
	Flags: None
*/
function shouldregisterclientfieldforarchetype(archetype)
{
	if(isdefined(level.clientfieldaicheck) && level.clientfieldaicheck && !isarchetypeloaded(archetype))
	{
		return false;
	}
	return true;
}

/*
	Name: function_9139c839
	Namespace: ai
	Checksum: 0x3902E578
	Offset: 0x6C8
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_9139c839()
{
	if(!isdefined(self.var_76167463))
	{
		if(isdefined(self.aisettingsbundle))
		{
			settingsbundle = self.aisettingsbundle;
		}
		else if(isdefined(self.scriptbundlesettings))
		{
			settingsbundle = getscriptbundle(self.scriptbundlesettings).aisettingsbundle;
		}
		if(!isdefined(settingsbundle))
		{
			return undefined;
		}
		self.var_76167463 = settingsbundle;
		if(!isdefined(level.var_e3a467cf))
		{
			level.var_e3a467cf = [];
		}
		if(!isdefined(level.var_e3a467cf[self.var_76167463]))
		{
			level.var_e3a467cf[self.var_76167463] = getscriptbundle(self.var_76167463);
		}
	}
	return level.var_e3a467cf[self.var_76167463];
}

/*
	Name: function_71919555
	Namespace: ai
	Checksum: 0xDB678341
	Offset: 0x7C8
	Size: 0xDA
	Parameters: 3
	Flags: None
*/
function function_71919555(var_45302432, fieldname, archetype)
{
	if(!isdefined(level.var_e3a467cf))
	{
		level.var_e3a467cf = [];
	}
	if(!isdefined(level.var_e3a467cf[var_45302432]))
	{
		level.var_e3a467cf[var_45302432] = getscriptbundle(var_45302432);
	}
	if(isdefined(level.var_e3a467cf[var_45302432]))
	{
		if(isdefined(archetype))
		{
			return level.var_e3a467cf[var_45302432].((archetype + "_") + fieldname);
		}
		return level.var_e3a467cf[var_45302432].(fieldname);
	}
	return undefined;
}

