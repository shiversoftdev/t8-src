// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\flagsys_shared.csc;

#namespace namespace_b0722f43;

/*
	Name: __init__
	Namespace: namespace_b0722f43
	Checksum: 0xD83B3B83
	Offset: 0x78
	Size: 0x66
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__()
{
	level.var_f726653d = [];
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
	Namespace: namespace_b0722f43
	Checksum: 0x7B8D41B2
	Offset: 0xE8
	Size: 0xE4
	Parameters: 3
	Flags: Linked, Private
*/
function private function_59c1a869(var_8dd0b014, var_d1c21f6f, var_b06dd57e)
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
		assert(!isdefined(var_8dd0b014[var_d1c21f6f]));
	#/
	if(isdefined(var_8dd0b014[var_d1c21f6f]))
	{
		return;
	}
	/#
		function_d50342ad(var_b06dd57e);
	#/
	var_8dd0b014[var_d1c21f6f] = var_b06dd57e;
}

/*
	Name: function_41015db1
	Namespace: namespace_b0722f43
	Checksum: 0x909DE49B
	Offset: 0x1D8
	Size: 0x10C
	Parameters: 3
	Flags: Linked, Private
*/
function private function_41015db1(var_8dd0b014, itemname, var_44ed74a7)
{
	if(!function_bbc0b67f(0))
	{
		return;
	}
	if(!ishash(itemname) || !ishash(var_44ed74a7))
	{
		/#
			assert(0);
		#/
		return;
	}
	/#
		assert(!isdefined(var_8dd0b014[itemname]));
	#/
	if(isdefined(var_8dd0b014[itemname]))
	{
		return;
	}
	if(var_44ed74a7 == #"")
	{
		var_44ed74a7 = "";
	}
	/#
		function_cd5f2152(var_44ed74a7);
	#/
	var_8dd0b014[itemname] = var_44ed74a7;
}

/*
	Name: function_bbc0b67f
	Namespace: namespace_b0722f43
	Checksum: 0x302EC9DF
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
	Namespace: namespace_b0722f43
	Checksum: 0xBED0C73
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
	Namespace: namespace_b0722f43
	Checksum: 0x86C480C4
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
	Namespace: namespace_b0722f43
	Checksum: 0x22CCE035
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
	Namespace: namespace_b0722f43
	Checksum: 0x17E0063
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
	Name: function_6da5e673
	Namespace: namespace_b0722f43
	Checksum: 0x67F3B5A6
	Offset: 0x470
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function function_6da5e673(itemname, var_44ed74a7)
{
	function_41015db1(level.var_f726653d, itemname, var_44ed74a7);
}

/*
	Name: function_261ab7f5
	Namespace: namespace_b0722f43
	Checksum: 0xBE1D32EA
	Offset: 0x4B0
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function function_261ab7f5(itemname, var_44ed74a7)
{
	function_41015db1(level.var_ee46a98d, itemname, var_44ed74a7);
}

/*
	Name: add_spawn_point
	Namespace: namespace_b0722f43
	Checksum: 0xC4B4C06
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
	Namespace: namespace_b0722f43
	Checksum: 0x2CA3AABF
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
	Namespace: namespace_b0722f43
	Checksum: 0xA61EF5BD
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
	Namespace: namespace_b0722f43
	Checksum: 0x9109BC1F
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
	Namespace: namespace_b0722f43
	Checksum: 0xA18B8B77
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
	level.var_f726653d[itemname] = "";
}

/*
	Name: function_a997e342
	Namespace: namespace_b0722f43
	Checksum: 0x79CCFF89
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

