// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_orange_mq_hell.csc;
#using scripts\zm\zm_orange_mq_sendoff.csc;
#using scripts\zm\zm_orange_mq_blood.csc;
#using scripts\zm\zm_orange_mq_fuse.csc;
#using scripts\zm\perk\zm_perk_death_perception.csc;
#using script_6fdaa897ed596805;
#using scripts\zm\zm_orange_mq_campfire.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\exploder_shared.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_orange_mq_mgr;

/*
	Name: preload
	Namespace: zm_orange_mq_mgr
	Checksum: 0xD8ECAD75
	Offset: 0xD8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	zm_orange_mq_blood::preload();
	zm_orange_mq_campfire::preload();
	zm_orange_mq_hell::preload();
	zm_orange_mq_fuse::preload();
	namespace_4b68b2b3::preload();
	zm_orange_mq_sendoff::preload();
	clientfield::register("toplayer", "" + #"hash_668f474410d5c1d0", 24000, 1, "int", &clear_hud, 0, 0);
}

/*
	Name: clear_hud
	Namespace: zm_orange_mq_mgr
	Checksum: 0x71D1A945
	Offset: 0x1A0
	Size: 0x6C
	Parameters: 7
	Flags: Linked
*/
function clear_hud(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self zm::function_92f0c63(localclientnum);
	self zm_perk_death_perception::function_25410869(localclientnum);
}

