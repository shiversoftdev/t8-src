// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_5660bae5b402a1eb;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_daily_challenges.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_powerup_nuke;

/*
	Name: function_89f2df9
	Namespace: zm_powerup_nuke
	Checksum: 0x5AE70B9E
	Offset: 0x160
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_powerup_nuke", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_nuke
	Checksum: 0xBF575BE
	Offset: 0x1A8
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::register_powerup("nuke", &grab_nuke);
	clientfield::register("actor", "zm_nuked", 1, 1, "int");
	clientfield::register("vehicle", "zm_nuked", 1, 1, "int");
	zm_powerups::add_zombie_powerup("nuke", "p7_zm_power_up_nuke", #"hash_39772b1fab5ee98c", &zm_powerups::func_should_always_drop, 0, 0, 0, "zombie/fx_powerup_nuke_zmb");
	level flag::init(#"hash_21921ed511559aa3");
}

/*
	Name: grab_nuke
	Namespace: zm_powerup_nuke
	Checksum: 0x79C4AB9A
	Offset: 0x2B0
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function grab_nuke(player)
{
	level thread nuke_powerup(self, player.team, player);
	player thread zm_powerups::powerup_vo("nuke");
	zombies = getaiteamarray(level.zombie_team);
	player.zombie_nuked = arraysort(zombies, self.origin);
	player notify(#"nuke_triggered");
}

/*
	Name: nuke_powerup
	Namespace: zm_powerup_nuke
	Checksum: 0xC8F87CB3
	Offset: 0x368
	Size: 0x5E8
	Parameters: 3
	Flags: Linked
*/
function nuke_powerup(drop_item, player_team, var_264cf1f9)
{
	level thread nuke_delay_spawning(3);
	location = drop_item.origin;
	if(isdefined(drop_item.fx))
	{
		playfx(drop_item.fx, location);
	}
	if(!(isdefined(level.var_5f911d8e) && level.var_5f911d8e))
	{
		level thread nuke_flash(player_team);
	}
	foreach(ai_enemy in getaiteamarray(level.zombie_team))
	{
		ai_enemy ai::stun(1.5);
	}
	wait(0.5);
	zombies = getaiteamarray(level.zombie_team);
	zombies = arraysort(zombies, location);
	zombies_nuked = [];
	for(i = 0; i < zombies.size; i++)
	{
		if(isdefined(zombies[i].ignore_nuke) && zombies[i].ignore_nuke)
		{
			continue;
		}
		if(isdefined(zombies[i].marked_for_death) && zombies[i].marked_for_death)
		{
			continue;
		}
		if(isdefined(zombies[i].nuke_damage_func))
		{
			zombies[i] thread [[zombies[i].nuke_damage_func]]();
			continue;
		}
		if(zm_utility::is_magic_bullet_shield_enabled(zombies[i]))
		{
			continue;
		}
		zombies[i].marked_for_death = 1;
		if(!(isdefined(zombies[i].nuked) && zombies[i].nuked) && !zm_utility::is_magic_bullet_shield_enabled(zombies[i]))
		{
			zombies[i].nuked = 1;
			zombies_nuked[zombies_nuked.size] = zombies[i];
			zombies[i] clientfield::set("zm_nuked", 1);
			zombies[i] zombie_utility::set_zombie_run_cycle_override_value("walk");
		}
	}
	for(i = 0; i < zombies_nuked.size; i++)
	{
		wait(randomfloatrange(0.1, 0.3));
		if(!isdefined(zombies_nuked[i]))
		{
			continue;
		}
		if(zm_utility::is_magic_bullet_shield_enabled(zombies_nuked[i]))
		{
			continue;
		}
		if(!(isdefined(zombies_nuked[i].isdog) && zombies_nuked[i].isdog))
		{
			if(!(isdefined(zombies_nuked[i].no_gib) && zombies_nuked[i].no_gib))
			{
				zombies_nuked[i] zombie_utility::zombie_head_gib();
			}
			zombies_nuked[i] playsound(#"evt_nuked");
		}
		zombies_nuked[i] dodamage(zombies_nuked[i].health + 666, zombies_nuked[i].origin);
		level thread zm_daily_challenges::increment_nuked_zombie();
	}
	level notify(#"nuke_complete");
	if(zm_powerups::function_cfd04802(#"nuke") && isplayer(var_264cf1f9))
	{
		var_264cf1f9 zm_score::player_add_points("nuke_powerup", 400, undefined, undefined, undefined, undefined, 1);
	}
	else
	{
		foreach(e_player in level.players)
		{
			e_player zm_score::player_add_points("nuke_powerup", 400, undefined, undefined, undefined, undefined, 1);
		}
	}
}

/*
	Name: nuke_flash
	Namespace: zm_powerup_nuke
	Checksum: 0x8B6DDE0C
	Offset: 0x958
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function nuke_flash(team)
{
	if(isdefined(team))
	{
		getplayers()[0] playsoundtoteam("evt_nuke_flash", team);
	}
	else
	{
		getplayers()[0] playsound(#"evt_nuke_flash");
	}
	lui::screen_flash(0.2, 0.5, 1, 0.8, "white", undefined, 1);
}

/*
	Name: nuke_delay_spawning
	Namespace: zm_powerup_nuke
	Checksum: 0x170CB8CC
	Offset: 0xA20
	Size: 0x17C
	Parameters: 1
	Flags: Linked
*/
function nuke_delay_spawning(n_spawn_delay)
{
	level endoncallback(&function_406d206b, #"disable_nuke_delay_spawning");
	if(isdefined(level.disable_nuke_delay_spawning) && level.disable_nuke_delay_spawning)
	{
		return;
	}
	b_spawn_zombies_before_nuke = level flag::get("spawn_zombies");
	level flag::set(#"hash_21921ed511559aa3");
	level flag::clear("spawn_zombies");
	level waittill(#"nuke_complete");
	if(isdefined(level.disable_nuke_delay_spawning) && level.disable_nuke_delay_spawning)
	{
		level flag::clear(#"hash_21921ed511559aa3");
		return;
	}
	wait(n_spawn_delay);
	if(!(isdefined(level.disable_nuke_delay_spawning) && level.disable_nuke_delay_spawning) && b_spawn_zombies_before_nuke)
	{
		level flag::set("spawn_zombies");
	}
	level flag::clear(#"hash_21921ed511559aa3");
}

/*
	Name: function_406d206b
	Namespace: zm_powerup_nuke
	Checksum: 0x516B6068
	Offset: 0xBA8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_406d206b(var_c34665fc)
{
	level flag::clear(#"hash_21921ed511559aa3");
}

/*
	Name: function_9a79647b
	Namespace: zm_powerup_nuke
	Checksum: 0xBEB23F9E
	Offset: 0xBE0
	Size: 0x2E
	Parameters: 1
	Flags: Linked
*/
function function_9a79647b(var_8de6cf73)
{
	self.nuke_damage_func = &nuke_damage_func;
	self.var_3b6e5508 = var_8de6cf73;
}

/*
	Name: nuke_damage_func
	Namespace: zm_powerup_nuke
	Checksum: 0x4A7A5C75
	Offset: 0xC18
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function nuke_damage_func()
{
	self endon(#"death");
	wait(randomfloatrange(0.1, 0.7));
	self thread zombie_death::flame_death_fx();
	self playsound(#"evt_nuked");
	self dodamage(self.maxhealth * self.var_3b6e5508, self.origin);
}

