// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_ba52581a;

/*
	Name: function_89f2df9
	Namespace: namespace_ba52581a
	Checksum: 0xE1C9AB16
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_14819f0ef5a24379", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ba52581a
	Checksum: 0x93F35D1E
	Offset: 0xE0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_clientfields();
}

/*
	Name: init_clientfields
	Namespace: namespace_ba52581a
	Checksum: 0x564EA0C2
	Offset: 0x100
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("toplayer", "" + #"hash_7eefa4acee4c1d55", 1, 1, "counter", &function_f90464da, 0, 0);
}

/*
	Name: function_f90464da
	Namespace: namespace_ba52581a
	Checksum: 0xF0DB7E
	Offset: 0x168
	Size: 0xFC
	Parameters: 7
	Flags: Linked
*/
function function_f90464da(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(newval)
	{
		if(isdefined(self))
		{
			self playrumbleonentity(localclientnum, #"hash_38a12b73c9342fd9");
		}
		wait(0.3);
		if(isdefined(self))
		{
			self playrumbleonentity(localclientnum, #"hash_38a12b73c9342fd9");
		}
		wait(0.3);
		if(isdefined(self))
		{
			self playrumbleonentity(localclientnum, #"hash_38a12b73c9342fd9");
		}
	}
}

