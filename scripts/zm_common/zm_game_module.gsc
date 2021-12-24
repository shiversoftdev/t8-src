// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_6ce38ab036223e6e;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_game_module;

/*
	Name: register_game_module
	Namespace: zm_game_module
	Checksum: 0x81B527A6
	Offset: 0x128
	Size: 0x248
	Parameters: 7
	Flags: None
*/
function register_game_module(index, module_name, pre_init_func, post_init_func, pre_init_zombie_spawn_func, post_init_zombie_spawn_func, hub_start_func)
{
	if(!isdefined(level._game_modules))
	{
		level._game_modules = [];
		level._num_registered_game_modules = 0;
	}
	for(i = 0; i < level._num_registered_game_modules; i++)
	{
		if(!isdefined(level._game_modules[i]))
		{
			continue;
		}
		if(isdefined(level._game_modules[i].index) && level._game_modules[i].index == index)
		{
			/#
				assert(level._game_modules[i].index != index, ("" + index) + "");
			#/
		}
	}
	level._game_modules[level._num_registered_game_modules] = spawnstruct();
	level._game_modules[level._num_registered_game_modules].index = index;
	level._game_modules[level._num_registered_game_modules].module_name = module_name;
	level._game_modules[level._num_registered_game_modules].pre_init_func = pre_init_func;
	level._game_modules[level._num_registered_game_modules].post_init_func = post_init_func;
	level._game_modules[level._num_registered_game_modules].pre_init_zombie_spawn_func = pre_init_zombie_spawn_func;
	level._game_modules[level._num_registered_game_modules].post_init_zombie_spawn_func = post_init_zombie_spawn_func;
	level._game_modules[level._num_registered_game_modules].hub_start_func = hub_start_func;
	level._num_registered_game_modules++;
}

/*
	Name: set_current_game_module
	Namespace: zm_game_module
	Checksum: 0x6E62E61C
	Offset: 0x378
	Size: 0xA6
	Parameters: 1
	Flags: None
*/
function set_current_game_module(game_module_index)
{
	if(!isdefined(game_module_index))
	{
		level.current_game_module = level.game_module_classic_index;
		level.scr_zm_game_module = level.game_module_classic_index;
		return;
	}
	game_module = get_game_module(game_module_index);
	if(!isdefined(game_module))
	{
		/#
			assert(isdefined(game_module), ("" + game_module_index) + "");
		#/
		return;
	}
	level.current_game_module = game_module_index;
}

/*
	Name: get_current_game_module
	Namespace: zm_game_module
	Checksum: 0xD4576C2C
	Offset: 0x428
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function get_current_game_module()
{
	return get_game_module(level.current_game_module);
}

/*
	Name: get_game_module
	Namespace: zm_game_module
	Checksum: 0xA28D75AC
	Offset: 0x450
	Size: 0x76
	Parameters: 1
	Flags: Linked
*/
function get_game_module(game_module_index)
{
	if(!isdefined(game_module_index))
	{
		return undefined;
	}
	for(i = 0; i < level._game_modules.size; i++)
	{
		if(level._game_modules[i].index == game_module_index)
		{
			return level._game_modules[i];
		}
	}
	return undefined;
}

/*
	Name: game_module_pre_zombie_spawn_init
	Namespace: zm_game_module
	Checksum: 0xBE64628B
	Offset: 0x4D0
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function game_module_pre_zombie_spawn_init()
{
	current_module = get_current_game_module();
	if(!isdefined(current_module) || !isdefined(current_module.pre_init_zombie_spawn_func))
	{
		return;
	}
	self [[current_module.pre_init_zombie_spawn_func]]();
}

/*
	Name: game_module_post_zombie_spawn_init
	Namespace: zm_game_module
	Checksum: 0x8AE02847
	Offset: 0x530
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function game_module_post_zombie_spawn_init()
{
	current_module = get_current_game_module();
	if(!isdefined(current_module) || !isdefined(current_module.post_init_zombie_spawn_func))
	{
		return;
	}
	self [[current_module.post_init_zombie_spawn_func]]();
}

/*
	Name: respawn_spectators_and_freeze_players
	Namespace: zm_game_module
	Checksum: 0x684E52CB
	Offset: 0x590
	Size: 0xC0
	Parameters: 0
	Flags: None
*/
function respawn_spectators_and_freeze_players()
{
	foreach(player in getplayers())
	{
		if(player.sessionstate == "spectator")
		{
			player [[level.spawnplayer]]();
		}
		player val::set(#"respawn_spectators_and_freeze_players", "freezecontrols");
	}
}

/*
	Name: damage_callback_no_pvp_damage
	Namespace: zm_game_module
	Checksum: 0x5F101F8F
	Offset: 0x658
	Size: 0xC8
	Parameters: 10
	Flags: None
*/
function damage_callback_no_pvp_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, eapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(isdefined(eattacker) && isplayer(eattacker) && eattacker == self)
	{
		return idamage;
	}
	if(isdefined(eattacker) && !isplayer(eattacker))
	{
		return idamage;
	}
	if(!isdefined(eattacker))
	{
		return idamage;
	}
	return 0;
}

/*
	Name: respawn_players
	Namespace: zm_game_module
	Checksum: 0x7A407FF2
	Offset: 0x728
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function respawn_players()
{
	players = getplayers();
	foreach(player in players)
	{
		player [[level.spawnplayer]]();
	}
}

/*
	Name: zombie_goto_round
	Namespace: zm_game_module
	Checksum: 0xB124C506
	Offset: 0x7C0
	Size: 0x220
	Parameters: 1
	Flags: Linked
*/
function zombie_goto_round(target_round)
{
	level flag::set("round_reset");
	level notify(#"restart_round");
	if(target_round < 1)
	{
		target_round = 1;
	}
	level.zombie_total = 0;
	level.zombie_health = zombie_utility::ai_calculate_health(zombie_utility::function_d2dfacfd(#"zombie_health_start"), target_round);
	namespace_a28acff3::set_round_number(target_round);
	enemies = getaiteamarray(level.zombie_team);
	if(isdefined(enemies))
	{
		for(i = 0; i < enemies.size; i++)
		{
			enemy = enemies[i];
			if(zm_utility::is_magic_bullet_shield_enabled(enemy))
			{
				enemy util::stop_magic_bullet_shield();
			}
			enemy.allowdeath = 1;
			enemy kill(undefined, undefined, undefined, undefined, undefined, 1);
		}
	}
	wait(5);
	corpses = getcorpsearray();
	foreach(corpse in corpses)
	{
		if(isactorcorpse(corpse))
		{
			corpse delete();
		}
	}
}

/*
	Name: make_supersprinter
	Namespace: zm_game_module
	Checksum: 0x583B902B
	Offset: 0x9E8
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function make_supersprinter()
{
	self zombie_utility::set_zombie_run_cycle("super_sprint");
}

/*
	Name: create_fireworks
	Namespace: zm_game_module
	Checksum: 0x3E26F4AB
	Offset: 0xA18
	Size: 0x120
	Parameters: 4
	Flags: None
*/
function create_fireworks(launch_spots, min_wait, max_wait, randomize)
{
	level endon(#"stop_fireworks");
	while(true)
	{
		if(isdefined(randomize) && randomize)
		{
			launch_spots = array::randomize(launch_spots);
		}
		foreach(spot in launch_spots)
		{
			level thread fireworks_launch(spot);
			wait(randomfloatrange(min_wait, max_wait));
		}
		wait(randomfloatrange(min_wait, max_wait));
	}
}

/*
	Name: fireworks_launch
	Namespace: zm_game_module
	Checksum: 0x7B725A1B
	Offset: 0xB40
	Size: 0x2BC
	Parameters: 1
	Flags: Linked
*/
function fireworks_launch(launch_spot)
{
	firework = spawn("script_model", launch_spot.origin + (randomintrange(-60, 60), randomintrange(-60, 60), 0));
	firework setmodel(#"tag_origin");
	util::wait_network_frame();
	playfxontag(level._effect[#"fw_trail_cheap"], firework, "tag_origin");
	firework playloopsound(#"zmb_souls_loop", 0.75);
	dest = launch_spot;
	while(isdefined(dest) && isdefined(dest.target))
	{
		random_offset = (randomintrange(-60, 60), randomintrange(-60, 60), 0);
		new_dests = struct::get_array(dest.target, "targetname");
		new_dest = array::random(new_dests);
		dest = new_dest;
		dist = distance(new_dest.origin + random_offset, firework.origin);
		time = dist / 700;
		firework moveto(new_dest.origin + random_offset, time);
		firework waittill(#"movedone");
	}
	firework playsound(#"zmb_souls_end");
	playfx(level._effect[#"fw_pre_burst"], firework.origin);
	firework delete();
}

