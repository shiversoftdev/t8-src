// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\flagsys_shared.gsc;

#namespace item_world_fixup;

/*
	Name: __init__
	Namespace: item_world_fixup
	Checksum: 0xC666AD10
	Offset: 0x78
	Size: 0x66
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__()
{
	level.itemreplacement = [];
	level.var_ee46a98d = [];
	level.var_ee110db8 = [];
	level.var_db0e7b82 = [];
	level.var_93c59949 = [];
	level.var_1d777960 = [];
	level.var_bf9b06d3 = [];
	level.var_8d50adaa = [];
}

/*
	Name: function_59c1a869
	Namespace: item_world_fixup
	Checksum: 0x42DE1EE3
	Offset: 0xE8
	Size: 0xE4
	Parameters: 3
	Flags: Linked, Private
*/
function private function_59c1a869(&replacementarray, var_d1c21f6f, var_b06dd57e)
{
	if(!function_bbc0b67f(0))
	{
		return;
	}
	if(!ishash(var_d1c21f6f) || !ishash(var_b06dd57e))
	{
		/#
			assert(0);
		#/
		return;
	}
	/#
		assert(!isdefined(replacementarray[var_d1c21f6f]));
	#/
	if(isdefined(replacementarray[var_d1c21f6f]))
	{
		return;
	}
	/#
		function_d50342ad(var_b06dd57e);
	#/
	replacementarray[var_d1c21f6f] = var_b06dd57e;
}

/*
	Name: function_41015db1
	Namespace: item_world_fixup
	Checksum: 0x5A18EFC2
	Offset: 0x1D8
	Size: 0x10C
	Parameters: 3
	Flags: Linked, Private
*/
function private function_41015db1(&replacementarray, itemname, replacementitemname)
{
	if(!function_bbc0b67f(0))
	{
		return;
	}
	if(!ishash(itemname) || !ishash(replacementitemname))
	{
		/#
			assert(0);
		#/
		return;
	}
	/#
		assert(!isdefined(replacementarray[itemname]));
	#/
	if(isdefined(replacementarray[itemname]))
	{
		return;
	}
	if(replacementitemname == #"")
	{
		replacementitemname = "";
	}
	/#
		function_cd5f2152(replacementitemname);
	#/
	replacementarray[itemname] = replacementitemname;
}

/*
	Name: function_bbc0b67f
	Namespace: item_world_fixup
	Checksum: 0x81663DAE
	Offset: 0x2F0
	Size: 0x94
	Parameters: 1
	Flags: Linked, Private
*/
function private function_bbc0b67f(prematch = 0)
{
	if(prematch)
	{
		flag = #"hash_11c9cde7b522c5a9";
	}
	else
	{
		flag = #"hash_67b445a4b1d59922";
	}
	if(level flagsys::get(flag))
	{
		/#
			assert(0, "");
		#/
		return false;
	}
	return true;
}

/*
	Name: function_cd5f2152
	Namespace: item_world_fixup
	Checksum: 0x2BADF7E7
	Offset: 0x390
	Size: 0x22
	Parameters: 1
	Flags: Private
*/
function private function_cd5f2152(itemname)
{
	/#
		if(itemname == "")
		{
			return;
		}
	#/
}

/*
	Name: function_d50342ad
	Namespace: item_world_fixup
	Checksum: 0x36BE93CB
	Offset: 0x3C0
	Size: 0x22
	Parameters: 1
	Flags: Private
*/
function private function_d50342ad(var_d1c21f6f)
{
	/#
		if(var_d1c21f6f == "")
		{
			return;
		}
	#/
}

/*
	Name: function_6991057
	Namespace: item_world_fixup
	Checksum: 0x459646EE
	Offset: 0x3F0
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function function_6991057(var_d1c21f6f, var_b06dd57e)
{
	function_59c1a869(level.var_ee110db8, var_d1c21f6f, var_b06dd57e);
}

/*
	Name: function_19089c75
	Namespace: item_world_fixup
	Checksum: 0x841F204
	Offset: 0x430
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function function_19089c75(var_d1c21f6f, var_b06dd57e)
{
	function_59c1a869(level.var_db0e7b82, var_d1c21f6f, var_b06dd57e);
}

/*
	Name: add_item_replacement
	Namespace: item_world_fixup
	Checksum: 0x7524245D
	Offset: 0x470
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function add_item_replacement(itemname, replacementitemname)
{
	function_41015db1(level.itemreplacement, itemname, replacementitemname);
}

/*
	Name: function_261ab7f5
	Namespace: item_world_fixup
	Checksum: 0xE7A56C32
	Offset: 0x4B0
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function function_261ab7f5(itemname, replacementitemname)
{
	function_41015db1(level.var_ee46a98d, itemname, replacementitemname);
}

/*
	Name: add_spawn_point
	Namespace: item_world_fixup
	Checksum: 0x94F09CB9
	Offset: 0x4F0
	Size: 0x13C
	Parameters: 3
	Flags: None
*/
function add_spawn_point(origin, targetname, angles = (0, 0, 0))
{
	if(!function_bbc0b67f(1))
	{
		return;
	}
	if(!isvec(origin) || !isvec(angles) || !ishash(targetname))
	{
		/#
			assert(0);
		#/
		return;
	}
	if(!isdefined(level.var_1d777960[targetname]))
	{
		level.var_1d777960[targetname] = array();
	}
	var_3cc38ddd = level.var_1d777960[targetname].size;
	level.var_1d777960[targetname][var_3cc38ddd] = {#angles:angles, #origin:origin};
}

/*
	Name: function_e70fa91c
	Namespace: item_world_fixup
	Checksum: 0x3EF61DBB
	Offset: 0x638
	Size: 0x124
	Parameters: 3
	Flags: Linked
*/
function function_e70fa91c(var_cf456610, var_2ab9d3bd, var_6647c284 = -1)
{
	if(!function_bbc0b67f())
	{
		return;
	}
	if(!ishash(var_cf456610) || !ishash(var_2ab9d3bd) || !isint(var_6647c284))
	{
		/#
			assert(0);
		#/
		return;
	}
	if(!isdefined(level.var_93c59949[var_cf456610]))
	{
		level.var_93c59949[var_cf456610] = [];
	}
	var_f532cd9f = level.var_93c59949[var_cf456610].size;
	level.var_93c59949[var_cf456610][var_f532cd9f] = {#count:var_6647c284, #replacement:var_2ab9d3bd};
}

/*
	Name: function_2749fcc3
	Namespace: item_world_fixup
	Checksum: 0x4DAE4D93
	Offset: 0x768
	Size: 0x13C
	Parameters: 4
	Flags: Linked
*/
function function_2749fcc3(var_89b7987e, var_cf456610, var_2ab9d3bd, var_6647c284 = 1)
{
	if(!function_bbc0b67f())
	{
		return;
	}
	if(!ishash(var_cf456610) || !ishash(var_2ab9d3bd) || !isint(var_6647c284))
	{
		/#
			assert(0);
		#/
		return;
	}
	if(!isdefined(level.var_93c59949[var_cf456610]))
	{
		level.var_93c59949[var_cf456610] = [];
	}
	var_f532cd9f = level.var_93c59949[var_cf456610].size;
	level.var_93c59949[var_cf456610][var_f532cd9f] = {#hash_52a66db0:var_89b7987e, #count:var_6647c284, #replacement:var_2ab9d3bd};
}

/*
	Name: function_96ff7b88
	Namespace: item_world_fixup
	Checksum: 0xB0192084
	Offset: 0x8B0
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function function_96ff7b88(itemname)
{
	if(!function_bbc0b67f(1))
	{
		return;
	}
	if(!ishash(itemname))
	{
		/#
			assert(0);
		#/
		return;
	}
	level.var_ee46a98d[itemname] = "";
}

/*
	Name: remove_item
	Namespace: item_world_fixup
	Checksum: 0x4FBDF496
	Offset: 0x930
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function remove_item(itemname)
{
	if(!function_bbc0b67f(0))
	{
		return;
	}
	if(!ishash(itemname))
	{
		/#
			assert(0);
		#/
		return;
	}
	level.itemreplacement[itemname] = "";
}

/*
	Name: function_a997e342
	Namespace: item_world_fixup
	Checksum: 0xC06F7DA8
	Offset: 0x9B0
	Size: 0xFC
	Parameters: 2
	Flags: None
*/
function function_a997e342(origin, radius)
{
	if(!function_bbc0b67f(1))
	{
		return;
	}
	if(!isvec(origin) || (!isfloat(radius) && !isint(radius)))
	{
		/#
			assert(0);
		#/
		return;
	}
	level.var_bf9b06d3[level.var_bf9b06d3.size] = origin;
	level.var_8d50adaa[level.var_8d50adaa.size] = radius;
	/#
		assert(level.var_bf9b06d3.size == level.var_8d50adaa.size);
	#/
}

