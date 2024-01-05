// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace map;

/*
	Name: init
	Namespace: map
	Checksum: 0x752E8654
	Offset: 0x68
	Size: 0x14
	Parameters: 0
	Flags: None
*/
function init()
{
	get_script_bundle();
}

/*
	Name: get_script_bundle
	Namespace: map
	Checksum: 0xC7700528
	Offset: 0x88
	Size: 0x6E
	Parameters: 0
	Flags: None
*/
function get_script_bundle()
{
	if(!isdefined(level.var_427d6976))
	{
		level.var_427d6976 = function_2717b55f();
	}
	if(!isdefined(level.var_427d6976))
	{
		level.var_179eaba8 = 1;
		level.var_427d6976 = {};
	}
	else
	{
		level.var_179eaba8 = 0;
	}
	return level.var_427d6976;
}

/*
	Name: is_default
	Namespace: map
	Checksum: 0x921A99BF
	Offset: 0x100
	Size: 0x2A
	Parameters: 0
	Flags: None
*/
function is_default()
{
	if(!isdefined(level.var_179eaba8))
	{
		level.var_179eaba8 = 1;
	}
	return level.var_179eaba8;
}

