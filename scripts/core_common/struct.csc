// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\scene_shared.csc;

#namespace struct;

/*
	Name: __init__
	Namespace: struct
	Checksum: 0xFB5DB508
	Offset: 0xB8
	Size: 0x22
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__()
{
	if(!isdefined(level.struct))
	{
		level.struct = [];
	}
}

/*
	Name: createstruct
	Namespace: struct
	Checksum: 0xCD4D793E
	Offset: 0xE8
	Size: 0x24
	Parameters: 1
	Flags: Event
*/
event createstruct(struct)
{
	struct init();
}

/*
	Name: init
	Namespace: struct
	Checksum: 0x246243FE
	Offset: 0x118
	Size: 0xA6
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
}

/*
	Name: get
	Namespace: struct
	Checksum: 0x8048977F
	Offset: 0x1C8
	Size: 0xAE
	Parameters: 2
	Flags: Linked
*/
function get(kvp_value, kvp_key = "targetname")
{
	a_result = get_array(kvp_value, kvp_key);
	/#
		/#
			assert(a_result.size < 2, ((("" + kvp_key) + "") + kvp_value) + "");
		#/
	#/
	return (a_result.size > 0 ? a_result[0] : undefined);
}

/*
	Name: spawn
	Namespace: struct
	Checksum: 0xCFB94675
	Offset: 0x280
	Size: 0x72
	Parameters: 2
	Flags: None
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
	Checksum: 0x5E36600A
	Offset: 0x300
	Size: 0x4E
	Parameters: 2
	Flags: Linked
*/
function get_array(kvp_value, kvp_key = "targetname")
{
	if(isdefined(kvp_value))
	{
		return function_7b8e26b3(level.struct, kvp_value, kvp_key);
	}
	return [];
}

/*
	Name: delete
	Namespace: struct
	Checksum: 0x3591009E
	Offset: 0x358
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function delete()
{
	arrayremovevalue(level.struct, self);
}

/*
	Name: get_script_bundle
	Namespace: struct
	Checksum: 0xBC63C5AA
	Offset: 0x388
	Size: 0x72
	Parameters: 2
	Flags: Linked
*/
function get_script_bundle(str_type, str_name)
{
	struct = getscriptbundle(str_name);
	if(isdefined(struct) && struct.type === "scene")
	{
		struct = scene::remove_invalid_scene_objects(struct);
	}
	return struct;
}

/*
	Name: get_script_bundles
	Namespace: struct
	Checksum: 0x78D50BA6
	Offset: 0x408
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function get_script_bundles(str_type)
{
	structs = getscriptbundles(str_type);
	if(str_type === "scene")
	{
		foreach(s_scenedef in structs)
		{
			s_scenedef = scene::remove_invalid_scene_objects(s_scenedef);
		}
	}
	return structs;
}

/*
	Name: get_script_bundle_list
	Namespace: struct
	Checksum: 0x10A4B3A3
	Offset: 0x4C8
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
	Checksum: 0xEC242007
	Offset: 0x500
	Size: 0xDA
	Parameters: 2
	Flags: None
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
	Checksum: 0x30B311FA
	Offset: 0x5E8
	Size: 0xB6
	Parameters: 1
	Flags: Event
*/
event findstruct(eventstruct)
{
	if(isdefined(level.struct))
	{
		foreach(struct in level.struct)
		{
			if(distancesquared(struct.origin, eventstruct.position) < 1)
			{
				return struct;
			}
		}
	}
	return undefined;
}

