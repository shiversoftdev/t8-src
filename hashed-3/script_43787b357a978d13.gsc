// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_5660bae5b402a1eb;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_powerup_insta_kill;

/*
	Name: function_89f2df9
	Namespace: zm_powerup_insta_kill
	Checksum: 0x2F25D861
	Offset: 0x150
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_powerup_insta_kill", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_insta_kill
	Checksum: 0x3A3CFCE0
	Offset: 0x198
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::register_powerup("insta_kill", &grab_insta_kill);
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("insta_kill", "p7_zm_power_up_insta_kill", #"hash_1784640b956f2f85", &zm_powerups::func_should_always_drop, 0, 0, 0, undefined, "powerup_instant_kill", "zombie_powerup_insta_kill_time", "zombie_powerup_insta_kill_on");
	}
}

/*
	Name: grab_insta_kill
	Namespace: zm_powerup_insta_kill
	Checksum: 0xAA13B86B
	Offset: 0x240
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function grab_insta_kill(player)
{
	if(zm_powerups::function_cfd04802(#"insta_kill"))
	{
		level thread function_d7a1e6a8(self, player);
	}
	else
	{
		level thread insta_kill_powerup(self, player);
	}
	player thread zm_powerups::powerup_vo("insta_kill");
}

/*
	Name: function_d7a1e6a8
	Namespace: zm_powerup_insta_kill
	Checksum: 0xF921AEE9
	Offset: 0x2D8
	Size: 0x120
	Parameters: 2
	Flags: Linked
*/
function function_d7a1e6a8(var_7d81025, player)
{
	player notify(#"hash_1fa5ede82a39664c");
	player endon(#"hash_1fa5ede82a39664c", #"disconnect");
	if(player bgb::is_enabled(#"zm_bgb_temporal_gift"))
	{
		n_wait_time = 60;
	}
	else
	{
		n_wait_time = 30;
	}
	player thread zm_powerups::function_5091b029("insta_kill");
	player zombie_utility::function_826f5e98(#"zombie_insta_kill", 1);
	level waittilltimeout(n_wait_time, #"end_game");
	player zombie_utility::function_826f5e98(#"zombie_insta_kill", 0);
	player notify(#"insta_kill_over");
}

/*
	Name: insta_kill_powerup
	Namespace: zm_powerup_insta_kill
	Checksum: 0x1D98AB93
	Offset: 0x400
	Size: 0x1C0
	Parameters: 2
	Flags: Linked
*/
function insta_kill_powerup(drop_item, player)
{
	level notify("powerup instakill_" + player.team);
	level endon("powerup instakill_" + player.team);
	if(isdefined(level.insta_kill_powerup_override))
	{
		level thread [[level.insta_kill_powerup_override]](drop_item, player);
		return;
	}
	team = player.team;
	level thread zm_powerups::show_on_hud(team, "insta_kill");
	zombie_utility::function_c7ab6cbc(#"zombie_insta_kill", team, 1);
	n_wait_time = 30;
	if(bgb::is_team_enabled(#"zm_bgb_temporal_gift"))
	{
		n_wait_time = n_wait_time + 30;
	}
	wait(n_wait_time);
	zombie_utility::function_c7ab6cbc(#"zombie_insta_kill", team, 0);
	players = getplayers(team);
	for(i = 0; i < players.size; i++)
	{
		if(isdefined(players[i]))
		{
			players[i] notify(#"insta_kill_over");
		}
	}
}

