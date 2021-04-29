// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;

#namespace mini_turret;

/*
	Name: function_89f2df9
	Namespace: mini_turret
	Checksum: 0x3B139115
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"mini_turret", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: mini_turret
	Checksum: 0x77787389
	Offset: 0x108
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("vehicle", "mini_turret_open", 1, 1, "int", &turret_open, 0, 0);
}

/*
	Name: turret_open
	Namespace: mini_turret
	Checksum: 0x6A5C26B6
	Offset: 0x160
	Size: 0xBC
	Parameters: 7
	Flags: Linked
*/
function turret_open(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!newval)
	{
		return;
	}
	self util::waittill_dobj(localclientnum);
	if(isdefined(self))
	{
		self useanimtree("generic");
		self setanimrestart(#"hash_7d361a7bb5f2ce39", 1, 0, 1);
	}
}

