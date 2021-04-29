// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_5660bae5b402a1eb;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_powerup_double_points;

/*
	Name: function_89f2df9
	Namespace: zm_powerup_double_points
	Checksum: 0x1F070DF7
	Offset: 0x188
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_powerup_double_points", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_double_points
	Checksum: 0x4B5F8C16
	Offset: 0x1D0
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::register_powerup("double_points", &grab_double_points);
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("double_points", "p7_zm_power_up_double_points", #"hash_774207d74b355a8a", &zm_powerups::func_should_always_drop, 0, 0, 0, undefined, "powerup_double_points", "zombie_powerup_double_points_time", "zombie_powerup_double_points_on");
	}
}

/*
	Name: grab_double_points
	Namespace: zm_powerup_double_points
	Checksum: 0x63C4AD0A
	Offset: 0x278
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function grab_double_points(player)
{
	if(zm_powerups::function_cfd04802(#"double_points"))
	{
		level thread function_6fd6ae61(self, player);
	}
	else
	{
		level thread double_points_powerup(self, player);
	}
	player thread zm_powerups::powerup_vo("double_points");
}

/*
	Name: function_6fd6ae61
	Namespace: zm_powerup_double_points
	Checksum: 0x2D079997
	Offset: 0x310
	Size: 0x14C
	Parameters: 2
	Flags: Linked
*/
function function_6fd6ae61(var_7d81025, player)
{
	player notify(#"hash_682647779288cf68");
	player endon(#"hash_682647779288cf68", #"disconnect");
	player thread zm_powerups::function_5091b029("double_points");
	player zombie_utility::function_826f5e98(#"zombie_point_scalar", 2);
	player clientfield::set_player_uimodel("hudItems.doublePointsActive", 1);
	if(player bgb::is_enabled(#"zm_bgb_temporal_gift"))
	{
		n_wait_time = 60;
	}
	else
	{
		n_wait_time = 30;
	}
	level waittill_timeout(n_wait_time, #"end_game");
	player zombie_utility::function_826f5e98(#"zombie_point_scalar", undefined);
	player clientfield::set_player_uimodel("hudItems.doublePointsActive", 0);
}

/*
	Name: double_points_powerup
	Namespace: zm_powerup_double_points
	Checksum: 0xF0B81B38
	Offset: 0x468
	Size: 0x28E
	Parameters: 2
	Flags: Linked
*/
function double_points_powerup(drop_item, player)
{
	level notify("powerup points scaled_" + player.team);
	level endon("powerup points scaled_" + player.team);
	team = player.team;
	level thread zm_powerups::show_on_hud(team, "double_points");
	if(isdefined(level.current_game_module) && level.current_game_module == 2)
	{
		if(isdefined(player._race_team))
		{
			if(player._race_team == 1)
			{
				level._race_team_double_points = 1;
			}
			else
			{
				level._race_team_double_points = 2;
			}
		}
	}
	zombie_utility::function_c7ab6cbc(#"zombie_point_scalar", team, 2);
	players = getplayers();
	for(player_index = 0; player_index < players.size; player_index++)
	{
		if(team == players[player_index].team)
		{
			players[player_index] clientfield::set_player_uimodel("hudItems.doublePointsActive", 1);
		}
	}
	n_wait = 30;
	if(bgb::is_team_enabled(#"zm_bgb_temporal_gift"))
	{
		n_wait = n_wait + 30;
	}
	wait(n_wait);
	zombie_utility::function_c7ab6cbc(#"zombie_point_scalar", team, 1);
	level._race_team_double_points = undefined;
	players = getplayers();
	for(player_index = 0; player_index < players.size; player_index++)
	{
		if(team == players[player_index].team)
		{
			players[player_index] clientfield::set_player_uimodel("hudItems.doublePointsActive", 0);
		}
	}
}

