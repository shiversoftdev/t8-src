// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\zombie_death.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_powerups.csc;

#namespace zm_powerup_nuke;

/*
	Name: __init__system__
	Namespace: zm_powerup_nuke
	Checksum: 0xCDA17173
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_powerup_nuke", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_nuke
	Checksum: 0x30A9902D
	Offset: 0x108
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::include_zombie_powerup("nuke");
	zm_powerups::add_zombie_powerup("nuke");
	clientfield::register("actor", "zm_nuked", 1, 1, "int", &zombie_nuked, 0, 0);
	clientfield::register("vehicle", "zm_nuked", 1, 1, "int", &zombie_nuked, 0, 0);
}

/*
	Name: zombie_nuked
	Namespace: zm_powerup_nuke
	Checksum: 0x799BD9F7
	Offset: 0x1D8
	Size: 0x54
	Parameters: 7
	Flags: Linked
*/
function zombie_nuked(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self zombie_death::flame_death_fx(localclientnum);
}

