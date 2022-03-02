// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_powerups.csc;

#namespace zm_powerup_bonus_points_team;

/*
	Name: function_89f2df9
	Namespace: zm_powerup_bonus_points_team
	Checksum: 0x60911F2A
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_powerup_bonus_points_team", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_bonus_points_team
	Checksum: 0xA3CB909E
	Offset: 0xE0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::include_zombie_powerup("bonus_points_team");
	zm_powerups::add_zombie_powerup("bonus_points_team");
}

