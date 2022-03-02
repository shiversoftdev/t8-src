// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_c167de75;

/*
	Name: function_89f2df9
	Namespace: namespace_c167de75
	Checksum: 0x93EAFD04
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_17338dc1539c77bb", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_c167de75
	Checksum: 0x7013DC24
	Offset: 0xF0
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	n_bits = getminbitcountfornum(4);
	clientfield::register("item", "" + #"hash_7e5c581ade235dfc", 16000, n_bits, "int", &function_c0d2e1a2, 0, 0);
	clientfield::register("toplayer", "" + #"hash_403e80cafccc207c", 16000, 1, "int", &function_e634058b, 0, 0);
}

/*
	Name: function_c0d2e1a2
	Namespace: namespace_c167de75
	Checksum: 0x38D2623F
	Offset: 0x1D0
	Size: 0xF8
	Parameters: 7
	Flags: Linked
*/
function function_c0d2e1a2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval > 0)
	{
		e_player = getentbynum(localclientnum, newval - 1);
		a_e_players = getlocalplayers();
		if(array::contains(a_e_players, e_player))
		{
			self thread function_cd5f9803(localclientnum);
			self function_bf9d3071(#"hash_46a64e44ebfa3078");
		}
	}
	else
	{
		level notify(#"hash_5a7453176272efff");
	}
}

/*
	Name: function_cd5f9803
	Namespace: namespace_c167de75
	Checksum: 0x3E7D3119
	Offset: 0x2D0
	Size: 0x5C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_cd5f9803(localclientnum)
{
	self waittill(#"hash_5a7453176272efff", #"death");
	if(isdefined(self))
	{
		self function_5d482e78(#"hash_46a64e44ebfa3078");
	}
}

/*
	Name: function_e634058b
	Namespace: namespace_c167de75
	Checksum: 0x8886A86C
	Offset: 0x338
	Size: 0x8C
	Parameters: 7
	Flags: Linked, Private
*/
function private function_e634058b(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue)
	{
		self thread postfx::playpostfxbundle(#"hash_2b92b9e84c59cfe4");
	}
	else
	{
		self thread postfx::exitpostfxbundle(#"hash_2b92b9e84c59cfe4");
	}
}

