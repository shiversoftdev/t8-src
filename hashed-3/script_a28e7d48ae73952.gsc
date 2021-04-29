// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_powerups.csc;

#namespace zm_powerup_bonus_points_player;

/*
	Name: function_89f2df9
	Namespace: zm_powerup_bonus_points_player
	Checksum: 0x87D859EC
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_powerup_bonus_points_player", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_bonus_points_player
	Checksum: 0xB04A5614
	Offset: 0x100
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::include_zombie_powerup("bonus_points_player");
	zm_powerups::add_zombie_powerup("bonus_points_player");
	zm_powerups::include_zombie_powerup("bonus_points_player_shared");
	zm_powerups::add_zombie_powerup("bonus_points_player_shared");
}

