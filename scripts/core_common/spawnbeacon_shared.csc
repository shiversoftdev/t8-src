// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace spawn_beacon;

/*
	Name: init_shared
	Namespace: spawn_beacon
	Checksum: 0x81EE5C1
	Offset: 0x110
	Size: 0x14
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	setupclientfields();
}

/*
	Name: setupclientfields
	Namespace: spawn_beacon
	Checksum: 0x57AC8500
	Offset: 0x130
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function setupclientfields()
{
	clientfield::register("scriptmover", "spawnbeacon_placed", 1, 1, "int", &spawnbeacon_placed, 0, 0);
	clientfield::register("clientuimodel", "hudItems.spawnbeacon.active", 1, 1, "int", undefined, 0, 0);
}

/*
	Name: spawnbeacon_placed
	Namespace: spawn_beacon
	Checksum: 0xA230F625
	Offset: 0x1C0
	Size: 0xE4
	Parameters: 7
	Flags: Private
*/
function private spawnbeacon_placed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	playtagfxset(localclientnum, "gadget_spawnbeacon_teamlight", self);
	self useanimtree("generic");
	self setanimrestart("o_spawn_beacon_deploy", 1, 0, 1);
}

