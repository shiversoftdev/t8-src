// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\flagsys_shared.csc;

#namespace system;

/*
	Name: register
	Namespace: system
	Checksum: 0xF613164
	Offset: 0x88
	Size: 0x18E
	Parameters: 4
	Flags: Linked
*/
function register(str_name, func_preinit, func_postinit, reqs)
{
	if(isdefined(level.system_funcs) && isdefined(level.system_funcs[str_name]))
	{
		/#
			assert(level.system_funcs[str_name].ignore, "" + function_9e72a96(str_name) + "");
		#/
		return;
	}
	if(!isdefined(level.system_funcs))
	{
		level.system_funcs = [];
	}
	level.system_funcs[str_name] = spawnstruct();
	level.system_funcs[str_name].prefunc = func_preinit;
	level.system_funcs[str_name].postfunc = func_postinit;
	level.system_funcs[str_name].reqs = reqs;
	level.system_funcs[str_name].predone = !isdefined(func_preinit);
	level.system_funcs[str_name].postdone = !isdefined(func_postinit);
	level.system_funcs[str_name].ignore = 0;
}

/*
	Name: exec_post_system
	Namespace: system
	Checksum: 0x2E313DDD
	Offset: 0x220
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function exec_post_system(func)
{
	if(!isdefined(func) || (isdefined(func.ignore) && func.ignore))
	{
		return;
	}
	if(!func.postdone)
	{
		if(isdefined(func.reqs))
		{
			function_5095b2c6(func);
		}
		func.postdone = 1;
		[[func.postfunc]]();
	}
}

/*
	Name: function_5095b2c6
	Namespace: system
	Checksum: 0xE664E6A2
	Offset: 0x2C0
	Size: 0x1E4
	Parameters: 1
	Flags: Linked
*/
function function_5095b2c6(func)
{
	/#
		assert(func.predone || func.ignore, "");
	#/
	if(isdefined(func.reqs))
	{
		if(isarray(func.reqs))
		{
			foreach(req in func.reqs)
			{
				/#
					assert(isdefined(req), "" + req + "");
				#/
				thread exec_post_system(level.system_funcs[req]);
			}
		}
		else
		{
			/#
				assert(isdefined(level.system_funcs[func.reqs]), "" + (function_7a600918(func.reqs) ? function_9e72a96(func.reqs) : func.reqs) + "");
			#/
			thread exec_post_system(level.system_funcs[func.reqs]);
		}
	}
}

/*
	Name: run_post_systems
	Namespace: system
	Checksum: 0x136E5F24
	Offset: 0x4B0
	Size: 0xBE
	Parameters: 0
	Flags: Linked
*/
function run_post_systems()
{
	foreach(func in level.system_funcs)
	{
		function_5095b2c6(func);
		thread exec_post_system(func);
	}
	level flagsys::set("system_init_complete");
	level.system_funcs = undefined;
}

/*
	Name: exec_pre_system
	Namespace: system
	Checksum: 0xA9198406
	Offset: 0x578
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function exec_pre_system(func)
{
	if(!isdefined(func) || (isdefined(func.ignore) && func.ignore))
	{
		return;
	}
	if(!func.predone)
	{
		if(isdefined(func.reqs))
		{
			function_8dfa23e0(func);
		}
		[[func.prefunc]]();
		func.predone = 1;
	}
}

/*
	Name: function_8dfa23e0
	Namespace: system
	Checksum: 0xF7CB479E
	Offset: 0x618
	Size: 0x1A4
	Parameters: 1
	Flags: Linked
*/
function function_8dfa23e0(func)
{
	if(isdefined(func.reqs))
	{
		if(isarray(func.reqs))
		{
			foreach(req in func.reqs)
			{
				/#
					assert(isdefined(req), "" + req + "");
				#/
				thread exec_pre_system(level.system_funcs[req]);
			}
		}
		else
		{
			/#
				assert(isdefined(level.system_funcs[func.reqs]), "" + (function_7a600918(func.reqs) ? function_9e72a96(func.reqs) : func.reqs) + "");
			#/
			thread exec_pre_system(level.system_funcs[func.reqs]);
		}
	}
}

/*
	Name: run_pre_systems
	Namespace: system
	Checksum: 0xB8797DBE
	Offset: 0x7C8
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function run_pre_systems()
{
	foreach(func in level.system_funcs)
	{
		function_8dfa23e0(func);
		thread exec_pre_system(func);
	}
}

/*
	Name: wait_till
	Namespace: system
	Checksum: 0x205C29CC
	Offset: 0x868
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function wait_till(required_systems)
{
	level flagsys::wait_till("system_init_complete");
}

/*
	Name: ignore
	Namespace: system
	Checksum: 0xB1F4F633
	Offset: 0x8A0
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function ignore(str_name)
{
	/#
		assert(!isdefined(level.gametype), "");
	#/
	if(!isdefined(level.system_funcs) || !isdefined(level.system_funcs[str_name]))
	{
		register(str_name, undefined, undefined, undefined);
	}
	level.system_funcs[str_name].ignore = 1;
}

