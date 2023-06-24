// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_170a9c130859c688;
#using scripts\core_common\system_shared.gsc;

#namespace wz_common_fixup;

/*
	Name: __init__system__
	Namespace: wz_common_fixup
	Checksum: 0xFBCD4EB1
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"wz_common_fixup", &__init__, undefined, undefined);
}

/*
	Name: __init
	Namespace: wz_common_fixup
	Checksum: 0x4FDB420A
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init()
{
	function_41453b43();
}

/*
	Name: __init__
	Namespace: wz_common_fixup
	Checksum: 0x80F724D1
	Offset: 0xE0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
}

/*
	Name: item_remover
	Namespace: wz_common_fixup
	Checksum: 0x2289C380
	Offset: 0xF0
	Size: 0x52
	Parameters: 3
	Flags: Linked
*/
function item_remover(func1, func2, param1)
{
	if(!isdefined(param1))
	{
		return;
	}
	if(isdefined(func1))
	{
		[[func1]](param1);
	}
	if(isdefined(func2))
	{
		[[func2]](param1);
	}
}

/*
	Name: function_149cbc84
	Namespace: wz_common_fixup
	Checksum: 0x31ADAC2A
	Offset: 0x150
	Size: 0x70
	Parameters: 4
	Flags: Linked
*/
function function_149cbc84(func1, func2, var_f3ef555b, var_e3c89f9)
{
	if(!isdefined(var_f3ef555b) || !isdefined(var_e3c89f9))
	{
		return;
	}
	if(isdefined(func1))
	{
		[[func1]](var_f3ef555b, var_e3c89f9);
	}
	if(isdefined(func2))
	{
		[[func2]](var_f3ef555b, var_e3c89f9);
	}
}

/*
	Name: function_41453b43
	Namespace: wz_common_fixup
	Checksum: 0x5029C5F8
	Offset: 0x1C8
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function function_41453b43()
{
	var_a12b4736 = &namespace_b0722f43::function_96ff7b88;
	var_d2223309 = &namespace_b0722f43::function_261ab7f5;
	var_b5014996 = &namespace_b0722f43::function_19089c75;
	var_87d0eef8 = &namespace_b0722f43::remove_item;
	var_74257310 = &namespace_b0722f43::function_6da5e673;
	var_f8a4c541 = &namespace_b0722f43::function_6991057;
}

