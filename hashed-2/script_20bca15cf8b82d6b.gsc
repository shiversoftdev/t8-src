// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\archetype_brutus.csc;
#using scripts\zm\ai\zm_ai_brutus.csc;
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;

#namespace zombie_brutus_util;

/*
	Name: __init__system__
	Namespace: zombie_brutus_util
	Checksum: 0xC892978
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zombie_brutus_util", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zombie_brutus_util
	Checksum: 0x4305C72
	Offset: 0x120
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "brutus_lock_down", 1, 1, "int", &function_6f198c81, 0, 0);
}

/*
	Name: function_6f198c81
	Namespace: zombie_brutus_util
	Checksum: 0xEB380BAD
	Offset: 0x178
	Size: 0xBC
	Parameters: 7
	Flags: Linked
*/
function function_6f198c81(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(bwasdemojump)
	{
		return;
	}
	if(bnewent)
	{
		/#
			println("");
		#/
	}
	if(binitialsnap)
	{
		/#
			println("");
		#/
	}
	playrumbleonposition(localclientnum, "explosion_generic", self.origin);
}

