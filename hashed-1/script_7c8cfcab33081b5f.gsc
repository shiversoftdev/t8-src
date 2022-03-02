// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_aeac0f57;

/*
	Name: function_89f2df9
	Namespace: namespace_aeac0f57
	Checksum: 0x49FD6603
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"snowball", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_aeac0f57
	Checksum: 0x785FD05C
	Offset: 0x118
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "" + #"hash_78aa1dc141a3e27", 24000, 1, "int", &function_25101093, 0, 0);
	clientfield::register("toplayer", "" + #"hash_2fafddfa9f85b8aa", 24000, 1, "int", &function_43d8c5f8, 0, 0);
}

/*
	Name: function_25101093
	Namespace: namespace_aeac0f57
	Checksum: 0x62BA6596
	Offset: 0x1D8
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function function_25101093(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self postfx::stoppostfxbundle("pstfx_wz_snowball_hit");
		self postfx::playpostfxbundle("pstfx_wz_snowball_hit");
	}
	else
	{
		self postfx::exitpostfxbundle("pstfx_wz_snowball_hit");
	}
}

/*
	Name: function_43d8c5f8
	Namespace: namespace_aeac0f57
	Checksum: 0xB20CE94F
	Offset: 0x288
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function function_43d8c5f8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self postfx::stoppostfxbundle("pstfx_wz_snowball_hit_yellow");
		self postfx::playpostfxbundle("pstfx_wz_snowball_hit_yellow");
	}
	else
	{
		self postfx::exitpostfxbundle("pstfx_wz_snowball_hit_yellow");
	}
}

