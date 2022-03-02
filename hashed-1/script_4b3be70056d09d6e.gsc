// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;

#namespace zm_powerup_bonus_points_team;

/*
	Name: function_89f2df9
	Namespace: zm_powerup_bonus_points_team
	Checksum: 0xD51B5D1D
	Offset: 0xD8
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
	Checksum: 0xA17AA717
	Offset: 0x120
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::register_powerup("bonus_points_team", &grab_bonus_points_team);
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("bonus_points_team", "zombie_z_money_icon", #"zombie_powerup_bonus_points", &zm_powerups::func_should_always_drop, 0, 0, 0);
	}
}

/*
	Name: grab_bonus_points_team
	Namespace: zm_powerup_bonus_points_team
	Checksum: 0x64988313
	Offset: 0x1B0
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function grab_bonus_points_team(player)
{
	level thread bonus_points_team_powerup(self, player);
	player thread zm_powerups::powerup_vo("bonus");
}

/*
	Name: bonus_points_team_powerup
	Namespace: zm_powerup_bonus_points_team
	Checksum: 0xC87018A7
	Offset: 0x200
	Size: 0x120
	Parameters: 2
	Flags: Linked
*/
function bonus_points_team_powerup(item, player)
{
	if(isdefined(level.var_a4c782b9) && level.var_a4c782b9)
	{
		points = randomintrange(2, 11) * 100;
	}
	else
	{
		points = 500;
	}
	if(isdefined(level.bonus_points_powerup_override))
	{
		points = item [[level.bonus_points_powerup_override]](player);
	}
	foreach(e_player in level.players)
	{
		e_player zm_score::player_add_points("bonus_points_powerup", points, undefined, undefined, undefined, undefined, 1);
	}
}

