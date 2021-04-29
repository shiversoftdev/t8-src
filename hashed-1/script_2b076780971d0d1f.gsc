// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_bba43f7d;

/*
	Name: function_89f2df9
	Namespace: namespace_bba43f7d
	Checksum: 0xCCC41BE5
	Offset: 0xF8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_291bf0f079b2eb91", &__init__, undefined, #"killstreaks");
}

/*
	Name: __init__
	Namespace: namespace_bba43f7d
	Checksum: 0x7F8A364B
	Offset: 0x148
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "supplypod_placed", 1, 1, "int", &supplypod_placed, 0, 0);
	clientfield::register("clientuimodel", "hudItems.goldenBullet", 1, 1, "int", undefined, 0, 0);
}

/*
	Name: supplypod_placed
	Namespace: namespace_bba43f7d
	Checksum: 0xA5C063D4
	Offset: 0x1D8
	Size: 0xAC
	Parameters: 7
	Flags: Linked, Private
*/
private function supplypod_placed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	playtagfxset(localclientnum, "gadget_spawnbeacon_teamlight", self);
	self useanimtree("generic");
}

