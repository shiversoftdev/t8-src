// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_6021ce59143452c3;
#using script_62a0cb1167067152;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_be6ee171;

/*
	Name: function_89f2df9
	Namespace: namespace_be6ee171
	Checksum: 0x74A3ECF9
	Offset: 0x128
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_4f65023f66a6fed1", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_be6ee171
	Checksum: 0xEE53B2DB
	Offset: 0x170
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!namespace_f551babc::function_b47f6aba())
	{
		return;
	}
	namespace_f551babc::register_challenge(#"hash_4c1b3f603272e5fc", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_be6ee171
	Checksum: 0x2E77DCF0
	Offset: 0x1D8
	Size: 0x5AC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d1de6a85()
{
	spawner = getent("weeping_spawner", "script_noteworthy");
	level.disable_nuke_delay_spawning = 1;
	level flag::clear("spawn_zombies");
	level thread lui::screen_flash(0.2, 1.3, 0.5, 1, "black");
	wait(0.2);
	foreach(player in getplayers())
	{
		player setmovespeedscale(0);
		player thread teleport_player();
	}
	wait(0.1);
	foreach(player in getplayers())
	{
		player.var_5f4eaf85 = zombie_utility::spawn_zombie(spawner, spawner.targetname, undefined, level.round_number);
		var_9d88bc68 = anglestoforward(player.angles);
		var_9d88bc68 = 50 * vectornormalize(var_9d88bc68);
		goal_pos = player.origin + var_9d88bc68;
		goal_pos = getclosestpointonnavmesh(goal_pos, 128, 32);
		player.var_5f4eaf85 forceteleport(goal_pos, player.angles - vectorscale((0, 1, 0), 180), 1);
		player.var_5f4eaf85.var_72411ccf = &function_660c908;
		player.var_5f4eaf85.favoriteenemy = player;
		player.var_5f4eaf85 val::set(#"hash_2c2f52c7b4c42bab", "takedamage", 0);
		player.var_5f4eaf85 val::set(#"hash_2c2f52c7b4c42bab", "ignoreme", 1);
		player.var_5f4eaf85.team = #"team3";
		wait(0.1);
	}
	level.var_5f4eaf85 = zombie_utility::spawn_zombie(spawner, spawner.targetname, undefined, level.round_number);
	level.var_5f4eaf85.var_72411ccf = &function_660c908;
	level.var_5f4eaf85 val::set(#"hash_2c2f52c7b4c42bab", "takedamage", 0);
	level.var_5f4eaf85 val::set(#"hash_2c2f52c7b4c42bab", "ignoreme", 1);
	level.var_5f4eaf85.team = #"team3";
	wait(1.5);
	level.disable_nuke_delay_spawning = 0;
	level flag::set("spawn_zombies");
	foreach(player in getplayers())
	{
		player setmovespeedscale(1);
		player.var_5f4eaf85.var_72411ccf = undefined;
		player.var_5f4eaf85 zombie_utility::set_zombie_run_cycle("super_sprint");
		player callback::on_player_damage(&on_player_damage);
		player.var_5f4eaf85 thread namespace_b9fd696c::function_d10bf985();
	}
	level.var_5f4eaf85.var_72411ccf = undefined;
	level.var_5f4eaf85 zombie_utility::set_zombie_run_cycle("super_sprint");
	level.var_5f4eaf85 thread namespace_b9fd696c::function_d10bf985();
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_be6ee171
	Checksum: 0x9D086FAC
	Offset: 0x790
	Size: 0x244
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	foreach(player in getplayers())
	{
		player callback::remove_on_player_damage(&on_player_damage);
		player.var_5f4eaf85 val::reset(#"hash_2c2f52c7b4c42bab", "takedamage");
		player.var_5f4eaf85 val::reset(#"hash_2c2f52c7b4c42bab", "ignoreme");
		player.var_5f4eaf85.team = #"axis";
		if(isdefined(player.var_5f4eaf85.kill_brush))
		{
			player.var_5f4eaf85.kill_brush delete();
		}
		player.var_5f4eaf85 kill();
	}
	level.var_5f4eaf85 val::reset(#"hash_2c2f52c7b4c42bab", "takedamage");
	level.var_5f4eaf85 val::reset(#"hash_2c2f52c7b4c42bab", "ignoreme");
	level.var_5f4eaf85.team = #"axis";
	if(isdefined(level.var_5f4eaf85.kill_brush))
	{
		level.var_5f4eaf85.kill_brush delete();
	}
	level.var_5f4eaf85 kill();
}

/*
	Name: teleport_player
	Namespace: namespace_be6ee171
	Checksum: 0x3E63CECE
	Offset: 0x9E0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function teleport_player()
{
	if(isalive(self))
	{
		if(self isusingoffhand())
		{
			self forceoffhandend();
		}
		self zm_bgb_anywhere_but_here::activation(0);
	}
}

/*
	Name: on_player_damage
	Namespace: namespace_be6ee171
	Checksum: 0xD28F975C
	Offset: 0xA50
	Size: 0xEC
	Parameters: 1
	Flags: Linked, Private
*/
private function on_player_damage(params)
{
	if(isai(params.eattacker) || isai(params.einflictor) && (params.idamage > 0 || (isdefined(self.armor) && self.armor > 0)) && params.eattacker.archetype === #"hash_777dead372b3a736")
	{
		var_57807cdc = [];
		array::add(var_57807cdc, self, 0);
		namespace_f551babc::fail(#"hash_41122a695bc6065d", var_57807cdc);
	}
}

/*
	Name: function_660c908
	Namespace: namespace_be6ee171
	Checksum: 0xDFEAFB94
	Offset: 0xB48
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_660c908(behaviortreeentity)
{
	behaviortreeentity setgoal(behaviortreeentity.origin);
}

