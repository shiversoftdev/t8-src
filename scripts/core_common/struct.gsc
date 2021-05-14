// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace struct;

/*
	Name: __init__
	Namespace: struct
	Checksum: 0xE1FD1FE2
	Offset: 0x118
	Size: 0x1F2
	Parameters: 0
	Flags: Linked, AutoExec
*/
autoexec function __init__()
{
	if(!isdefined(level.struct))
	{
		level.struct = [];
	}
	if(!isdefined(level.struct_class_names))
	{
		level.struct_class_names = [];
		level.struct_class_names[level.struct_class_names.size] = "target";
		level.struct_class_names[level.struct_class_names.size] = "targetname";
		level.struct_class_names[level.struct_class_names.size] = "script_noteworthy";
		level.struct_class_names[level.struct_class_names.size] = "classname";
		level.struct_class_names[level.struct_class_names.size] = "variantname";
		level.struct_class_names[level.struct_class_names.size] = "script_unitrigger_type";
		level.struct_class_names[level.struct_class_names.size] = "scriptbundlename";
		level.struct_class_names[level.struct_class_names.size] = "prefabname";
		level.struct_class_names[level.struct_class_names.size] = "script_igc_teleport_location";
		foreach(str_key in level.struct_class_names)
		{
			level.var_77fe0a41[str_key] = [];
		}
	}
	/#
		level.struct_class_names = undefined;
		level.var_77fe0a41 = undefined;
	#/
}

/*
	Name: createstruct
	Namespace: struct
	Checksum: 0xA66493C3
	Offset: 0x318
	Size: 0x34
	Parameters: 1
	Flags: Event
*/
event createstruct(struct)
{
	__init__();
	struct init();
}

/*
	Name: init
	Namespace: struct
	Checksum: 0xA3162416
	Offset: 0x358
	Size: 0x226
	Parameters: 0
	Flags: Linked
*/
function init()
{
	if(!isdefined(level.struct))
	{
		level.struct = [];
	}
	else if(!isarray(level.struct))
	{
		level.struct = array(level.struct);
	}
	level.struct[level.struct.size] = self;
	if(!isdefined(self.angles))
	{
		self.angles = (0, 0, 0);
	}
	if(isdefined(level.struct_class_names))
	{
		foreach(str_key in level.struct_class_names)
		{
			if(isdefined(self.(str_key)))
			{
				if(!isdefined(level.var_77fe0a41[str_key][self.(str_key)]))
				{
					level.var_77fe0a41[str_key][self.(str_key)] = [];
				}
				else if(!isarray(level.var_77fe0a41[str_key][self.(str_key)]))
				{
					level.var_77fe0a41[str_key][self.(str_key)] = array(level.var_77fe0a41[str_key][self.(str_key)]);
				}
				level.var_77fe0a41[str_key][self.(str_key)][level.var_77fe0a41[str_key][self.(str_key)].size] = self;
			}
		}
	}
}

/*
	Name: get
	Namespace: struct
	Checksum: 0x431F7BB
	Offset: 0x588
	Size: 0xDE
	Parameters: 2
	Flags: Linked
*/
function get(kvp_value, kvp_key = "targetname")
{
	a_result = get_array(kvp_value, kvp_key);
	/#
		/#
			loc_000005FC:
			assert(a_result.size < 2, "" + (isdefined(kvp_key) ? "" + kvp_key : "") + "" + (isdefined(kvp_value) ? "" + kvp_value : "") + "");
		#/
	#/
	return (a_result.size > 0 ? a_result[0] : undefined);
}

/*
	Name: spawn
	Namespace: struct
	Checksum: 0xADFC294D
	Offset: 0x670
	Size: 0x72
	Parameters: 2
	Flags: Linked
*/
function spawn(v_origin = (0, 0, 0), v_angles = (0, 0, 0))
{
	s = spawnstruct();
	s.origin = v_origin;
	s.angles = v_angles;
	return s;
}

/*
	Name: get_array
	Namespace: struct
	Checksum: 0x136C3146
	Offset: 0x6F0
	Size: 0xBE
	Parameters: 2
	Flags: Linked
*/
function get_array(kvp_value, kvp_key = "targetname")
{
	if(isdefined(kvp_value))
	{
		if(isdefined(level.var_77fe0a41) && isdefined(level.var_77fe0a41[kvp_key]))
		{
			if(isdefined(level.var_77fe0a41[kvp_key][kvp_value]))
			{
				return arraycopy(level.var_77fe0a41[kvp_key][kvp_value]);
			}
		}
		else
		{
			return function_7b8e26b3(level.struct, kvp_value, kvp_key);
		}
	}
	return [];
}

/*
	Name: delete
	Namespace: struct
	Checksum: 0xAC7ACE2D
	Offset: 0x7B8
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function delete()
{
	if(isdefined(level.struct_class_names))
	{
		foreach(str_key in level.struct_class_names)
		{
			if(isdefined(self.(str_key)))
			{
				arrayremovevalue(level.var_77fe0a41[str_key][self.(str_key)], self);
			}
		}
	}
	arrayremovevalue(level.struct, self);
}

/*
	Name: get_script_bundle
	Namespace: struct
	Checksum: 0x3BA783DD
	Offset: 0x898
	Size: 0x3A
	Parameters: 2
	Flags: Linked
*/
function get_script_bundle(str_type, str_name)
{
	struct = getscriptbundle(str_name);
	return struct;
}

/*
	Name: get_script_bundles
	Namespace: struct
	Checksum: 0xE36C98D2
	Offset: 0x8E0
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function get_script_bundles(str_type)
{
	structs = getscriptbundles(str_type);
	return structs;
}

/*
	Name: get_script_bundle_list
	Namespace: struct
	Checksum: 0x2753E715
	Offset: 0x920
	Size: 0x2A
	Parameters: 2
	Flags: None
*/
function get_script_bundle_list(str_type, str_name)
{
	return getscriptbundlelist(str_name);
}

/*
	Name: get_script_bundle_instances
	Namespace: struct
	Checksum: 0x3A5261AA
	Offset: 0x958
	Size: 0xDA
	Parameters: 2
	Flags: Linked
*/
function get_script_bundle_instances(str_type, kvp)
{
	a_instances = get_array("scriptbundle_" + str_type, "classname");
	if(a_instances.size > 0 && isdefined(kvp))
	{
		if(isarray(kvp))
		{
			str_value = kvp[0];
			str_key = kvp[1];
		}
		else
		{
			str_value = kvp;
			str_key = "scriptbundlename";
		}
		a_instances = function_7b8e26b3(a_instances, str_value, str_key);
	}
	return a_instances;
}

/*
	Name: findstruct
	Namespace: struct
	Checksum: 0x55A8915C
	Offset: 0xA40
	Size: 0x2C0
	Parameters: 3
	Flags: Event
*/
event findstruct(param1, name, index)
{
	if(isvec(param1))
	{
		position = param1;
		foreach(key in level.struct_class_names)
		{
			foreach(s_array in level.var_77fe0a41[key])
			{
				foreach(struct in s_array)
				{
					if(distancesquared(struct.origin, position) < 1)
					{
						return struct;
					}
				}
			}
		}
		if(isdefined(level.struct))
		{
			foreach(struct in level.struct)
			{
				if(distancesquared(struct.origin, position) < 1)
				{
					return struct;
				}
			}
		}
	}
	else
	{
		s = get(param1);
		if(isdefined(s))
		{
			return s;
		}
		s = get_script_bundle(param1, name);
		if(isdefined(s))
		{
			if(index < 0)
			{
				return s;
			}
			if(isdefined(s.objects))
			{
				return s.objects[index];
			}
		}
	}
	return undefined;
}

