// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_3f9e0dc8454d98e1;
#using script_460f2e04fb3cff8a;
#using script_6021ce59143452c3;
#using script_6e3c826b1814cab6;
#using script_6ffdcde0fe52cb6f;
#using script_7e59d7bba853fe4b;
#using script_ab890501c40b73c;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\demo_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\bb.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_net.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace zm_powerups;

/*
	Name: init
	Namespace: zm_powerups
	Checksum: 0x38C6D475
	Offset: 0x570
	Size: 0x4A4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	zombie_utility::set_zombie_var(#"zombie_insta_kill", 0, undefined, undefined, 1);
	zombie_utility::set_zombie_var(#"zombie_drop_item", 0);
	zombie_utility::set_zombie_var(#"zombie_timer_offset", 350);
	zombie_utility::set_zombie_var(#"zombie_timer_offset_interval", 30);
	zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_on", 0);
	zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", 30);
	zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_on", 0);
	zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_time", 30);
	zombie_utility::set_zombie_var(#"zombie_powerup_insta_kill_on", 0, undefined, undefined, 1);
	zombie_utility::set_zombie_var(#"zombie_powerup_insta_kill_time", 30, undefined, undefined, 1);
	zombie_utility::set_zombie_var(#"zombie_powerup_double_points_on", 0, undefined, undefined, 1);
	zombie_utility::set_zombie_var(#"zombie_powerup_double_points_time", 30, undefined, undefined, 1);
	if(namespace_59ff1d6c::function_901b751c(#"zmpowerupsislimitedround"))
	{
		zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", namespace_59ff1d6c::function_901b751c(#"hash_d46a4e7a41e005c"));
	}
	else
	{
		zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", 4);
	}
	zombie_utility::set_zombie_var(#"hash_604cac237ec8cd3", 12);
	zombie_utility::set_zombie_var(#"hash_8b7fc80184dc451", 16);
	zombie_utility::set_zombie_var(#"hash_604cbc237ec8e86", 14);
	zombie_utility::set_zombie_var(#"hash_8b7f980184dbf38", 18);
	zombie_utility::set_zombie_var(#"hash_604ccc237ec9039", 17);
	zombie_utility::set_zombie_var(#"hash_8b7fa80184dc0eb", 21);
	zombie_utility::set_zombie_var(#"hash_604cdc237ec91ec", 20);
	zombie_utility::set_zombie_var(#"hash_8b7ff80184dc96a", 24);
	zombie_utility::set_zombie_var(#"hash_4d2cc817490bcca", 4);
	zombie_utility::set_zombie_var(#"hash_4edd68174a79580", 7);
	if(!isdefined(level.zombie_powerups))
	{
		level.zombie_powerups = [];
	}
	level._effect[#"powerup_off"] = #"zombie/fx_powerup_off_green_zmb";
	init_powerups();
	if(!level.enable_magic || !namespace_59ff1d6c::function_901b751c(#"zmpowerupsactive"))
	{
		return;
	}
	thread watch_for_drop();
}

/*
	Name: init_powerups
	Namespace: zm_powerups
	Checksum: 0x9FF73773
	Offset: 0xA20
	Size: 0x29C
	Parameters: 0
	Flags: Linked
*/
function init_powerups()
{
	level flag::init("zombie_drop_powerups");
	if(isdefined(level.enable_magic) && level.enable_magic && (isdefined(namespace_59ff1d6c::function_901b751c(#"zmpowerupsactive")) && namespace_59ff1d6c::function_901b751c(#"zmpowerupsactive")))
	{
		level flag::set("zombie_drop_powerups");
	}
	if(!isdefined(level.active_powerups))
	{
		level.active_powerups = [];
	}
	add_zombie_powerup("insta_kill_ug", "zombie_skull", #"hash_1784640b956f2f85", &func_should_never_drop, 1, 0, 0, undefined, "powerup_instant_kill_ug", "zombie_powerup_insta_kill_ug_time", "zombie_powerup_insta_kill_ug_on", 1);
	if(isdefined(level.level_specific_init_powerups))
	{
		[[level.level_specific_init_powerups]]();
	}
	randomize_powerups();
	level.zombie_powerup_index = 0;
	randomize_powerups();
	level.rare_powerups_active = 0;
	level.zm_genesis_robot_pay_towardsreactswordstart = randomintrange(zombie_utility::function_d2dfacfd(#"hash_4d2cc817490bcca"), zombie_utility::function_d2dfacfd(#"hash_4edd68174a79580"));
	level.firesale_vox_firstime = 0;
	level thread powerup_hud_monitor();
	clientfield::register("scriptmover", "powerup_fx", 1, 3, "int");
	clientfield::register("scriptmover", "powerup_intro_fx", 1, 3, "int");
	clientfield::register("scriptmover", "powerup_grabbed_fx", 1, 3, "int");
}

/*
	Name: set_weapon_ignore_max_ammo
	Namespace: zm_powerups
	Checksum: 0xE59D06F1
	Offset: 0xCC8
	Size: 0x42
	Parameters: 1
	Flags: None
*/
function set_weapon_ignore_max_ammo(weapon)
{
	if(!isdefined(level.zombie_weapons_no_max_ammo))
	{
		level.zombie_weapons_no_max_ammo = [];
	}
	level.zombie_weapons_no_max_ammo[weapon] = 1;
}

/*
	Name: powerup_hud_monitor
	Namespace: zm_powerups
	Checksum: 0xAC6B696F
	Offset: 0xD18
	Size: 0x5D2
	Parameters: 0
	Flags: Linked
*/
function powerup_hud_monitor()
{
	level flag::wait_till("start_zombie_round_logic");
	if(isdefined(level.current_game_module) && level.current_game_module == 2)
	{
		return;
	}
	flashing_timers = [];
	flashing_values = [];
	flashing_timer = 10;
	flashing_delta_time = 0;
	flashing_is_on = 0;
	flashing_value = 3;
	flashing_min_timer = 0.15;
	while(flashing_timer >= flashing_min_timer)
	{
		if(flashing_timer < 5)
		{
			flashing_delta_time = 0.1;
		}
		else
		{
			flashing_delta_time = 0.2;
		}
		if(flashing_is_on)
		{
			flashing_timer = flashing_timer - flashing_delta_time - 0.05;
			flashing_value = 2;
		}
		else
		{
			flashing_timer = flashing_timer - flashing_delta_time;
			flashing_value = 3;
		}
		flashing_timers[flashing_timers.size] = flashing_timer;
		flashing_values[flashing_values.size] = flashing_value;
		flashing_is_on = !flashing_is_on;
	}
	client_fields = [];
	powerup_keys = getarraykeys(level.zombie_powerups);
	for(powerup_key_index = 0; powerup_key_index < powerup_keys.size; powerup_key_index++)
	{
		if(isdefined(level.zombie_powerups[powerup_keys[powerup_key_index]].client_field_name))
		{
			powerup_name = powerup_keys[powerup_key_index];
			client_fields[powerup_name] = spawnstruct();
			client_fields[powerup_name].client_field_name = level.zombie_powerups[powerup_name].client_field_name;
			client_fields[powerup_name].only_affects_grabber = level.zombie_powerups[powerup_name].only_affects_grabber;
			client_fields[powerup_name].time_name = level.zombie_powerups[powerup_name].time_name;
			client_fields[powerup_name].on_name = level.zombie_powerups[powerup_name].on_name;
		}
	}
	client_field_keys = getarraykeys(client_fields);
	while(true)
	{
		waittillframeend();
		players = level.players;
		for(playerindex = 0; playerindex < players.size; playerindex++)
		{
			for(client_field_key_index = 0; client_field_key_index < client_field_keys.size; client_field_key_index++)
			{
				player = players[playerindex];
				/#
					if(isbot(player))
					{
						continue;
					}
				#/
				if(player.team === #"spectator")
				{
					continue;
				}
				if(isdefined(level.powerup_player_valid))
				{
					if(![[level.powerup_player_valid]](player))
					{
						continue;
					}
				}
				client_field_name = client_fields[client_field_keys[client_field_key_index]].client_field_name;
				time_name = client_fields[client_field_keys[client_field_key_index]].time_name;
				on_name = client_fields[client_field_keys[client_field_key_index]].on_name;
				powerup_timer = undefined;
				powerup_on = undefined;
				if(client_fields[client_field_keys[client_field_key_index]].only_affects_grabber && isdefined(player zombie_utility::function_73061b82(time_name)) && isdefined(player zombie_utility::function_73061b82(on_name)))
				{
					powerup_timer = player.zombie_vars[time_name];
					powerup_on = player.zombie_vars[on_name];
				}
				else if(isdefined(zombie_utility::function_6403cf83(time_name, player.team)))
				{
					powerup_timer = zombie_utility::function_6403cf83(time_name, player.team);
					powerup_on = zombie_utility::function_6403cf83(on_name, player.team);
				}
				else if(isdefined(zombie_utility::function_d2dfacfd(time_name)))
				{
					powerup_timer = zombie_utility::function_d2dfacfd(time_name);
					powerup_on = zombie_utility::function_d2dfacfd(on_name);
				}
				if(isdefined(powerup_timer) && isdefined(powerup_on))
				{
					player set_clientfield_powerups(client_field_name, powerup_timer, powerup_on, flashing_timers, flashing_values);
					continue;
				}
				player clientfield::set_player_uimodel(client_field_name, 0);
			}
			waitframe(1);
		}
	}
}

/*
	Name: set_clientfield_powerups
	Namespace: zm_powerups
	Checksum: 0x4A1F762D
	Offset: 0x12F8
	Size: 0x114
	Parameters: 5
	Flags: Linked
*/
function set_clientfield_powerups(clientfield_name, powerup_timer, powerup_on, flashing_timers, flashing_values)
{
	if(powerup_on && (!(isdefined(self.var_9414a188) && self.var_9414a188)))
	{
		if(powerup_timer < 10)
		{
			flashing_value = 3;
			for(i = flashing_timers.size - 1; i > 0; i--)
			{
				if(powerup_timer < flashing_timers[i])
				{
					flashing_value = flashing_values[i];
					break;
				}
			}
			self clientfield::set_player_uimodel(clientfield_name, flashing_value);
		}
		else
		{
			self clientfield::set_player_uimodel(clientfield_name, 1);
		}
	}
	else
	{
		self clientfield::set_player_uimodel(clientfield_name, 0);
	}
}

/*
	Name: randomize_powerups
	Namespace: zm_powerups
	Checksum: 0xEE951AE
	Offset: 0x1418
	Size: 0x4E
	Parameters: 0
	Flags: Linked
*/
function randomize_powerups()
{
	if(!isdefined(level.zombie_powerup_array))
	{
		level.zombie_powerup_array = [];
	}
	else
	{
		level.zombie_powerup_array = array::randomize(level.zombie_powerup_array);
	}
}

/*
	Name: get_next_powerup
	Namespace: zm_powerups
	Checksum: 0x8E12CF6D
	Offset: 0x1470
	Size: 0x128
	Parameters: 0
	Flags: Linked
*/
function get_next_powerup()
{
	if(isdefined(level.var_ab5b85bf))
	{
		powerup = level.var_ab5b85bf;
		level.var_ab5b85bf = undefined;
	}
	else if(level.zm_genesis_robot_pay_towardsreactswordstart == 0 && namespace_59ff1d6c::function_901b751c(#"zmpowerupmaxammo") && isdefined(level.zombie_powerups[#"full_ammo"].func_should_drop_with_regular_powerups) && [[level.zombie_powerups[#"full_ammo"].func_should_drop_with_regular_powerups]]())
	{
		powerup = "full_ammo";
	}
	else
	{
		powerup = level.zombie_powerup_array[level.zombie_powerup_index];
		level.zombie_powerup_index++;
		if(level.zombie_powerup_index >= level.zombie_powerup_array.size)
		{
			level.zombie_powerup_index = 0;
			randomize_powerups();
		}
	}
	return powerup;
}

/*
	Name: get_valid_powerup
	Namespace: zm_powerups
	Checksum: 0x6CB03958
	Offset: 0x15A0
	Size: 0x11A
	Parameters: 0
	Flags: Linked
*/
function get_valid_powerup()
{
	/#
		if(isdefined(level.zombie_devgui_power) && level.zombie_devgui_power == 1)
		{
			level.zombie_devgui_power = 0;
			return level.zombie_powerup_array[level.zombie_powerup_index];
		}
	#/
	if(isdefined(level.zombie_powerup_boss))
	{
		i = level.zombie_powerup_boss;
		level.zombie_powerup_boss = undefined;
		return level.zombie_powerup_array[i];
	}
	if(isdefined(level.zombie_powerup_ape))
	{
		str_powerup = level.zombie_powerup_ape;
		level.zombie_powerup_ape = undefined;
		return str_powerup;
	}
	while(true)
	{
		str_powerup = get_next_powerup();
		if(isdefined(level.zombie_powerups[str_powerup]) && [[level.zombie_powerups[str_powerup].func_should_drop_with_regular_powerups]]())
		{
			return str_powerup;
		}
	}
}

/*
	Name: function_70bd1ec9
	Namespace: zm_powerups
	Checksum: 0xDF551088
	Offset: 0x16C8
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_70bd1ec9()
{
	if(!level.zombie_powerups.size)
	{
		return 0;
	}
	foreach(str_powerup in level.zombie_powerup_array)
	{
		if(isdefined(level.zombie_powerups[str_powerup]) && [[level.zombie_powerups[str_powerup].func_should_drop_with_regular_powerups]]())
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: minigun_no_drop
	Namespace: zm_powerups
	Checksum: 0x9FA8C665
	Offset: 0x1788
	Size: 0xEA
	Parameters: 0
	Flags: None
*/
function minigun_no_drop()
{
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		if(players[i].zombie_vars[#"zombie_powerup_minigun_on"] == 1)
		{
			return 1;
		}
	}
	if(!level flag::get("power_on"))
	{
		if(level flag::get("solo_game"))
		{
			if(!isdefined(level.solo_lives_given) || level.solo_lives_given == 0)
			{
				return 1;
			}
		}
		else
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: watch_for_drop
	Namespace: zm_powerups
	Checksum: 0x763C8FF5
	Offset: 0x1880
	Size: 0x140
	Parameters: 0
	Flags: Linked
*/
function watch_for_drop()
{
	level endon(#"end_game");
	level flag::wait_till("start_zombie_round_logic");
	level flag::wait_till("begin_spawning");
	waitframe(1);
	level.var_1dce56cc = function_2ff352cc();
	if(!isdefined(level.n_total_kills))
	{
		level.n_total_kills = 0;
	}
	while(true)
	{
		level flag::wait_till("zombie_drop_powerups");
		if(level.n_total_kills >= level.var_1dce56cc)
		{
			level function_a7a5570e();
			level.var_1dce56cc = level.n_total_kills + function_2ff352cc();
			zombie_utility::set_zombie_var(#"zombie_drop_item", 1);
		}
		wait(0.5);
	}
}

/*
	Name: function_2ff352cc
	Namespace: zm_powerups
	Checksum: 0xFB6E3BE5
	Offset: 0x19C8
	Size: 0x180
	Parameters: 0
	Flags: Linked
*/
function function_2ff352cc()
{
	a_e_players = getplayers();
	if(!isdefined(a_e_players) || !a_e_players.size)
	{
		n_players = 1;
	}
	else
	{
		n_players = a_e_players.size;
	}
	n_kill_count = function_21a3a673(zombie_utility::function_d2dfacfd(#"hash_434b3261c607850" + n_players), zombie_utility::function_d2dfacfd(#"hash_3f4e6b25f57677da" + n_players));
	if(namespace_59ff1d6c::function_901b751c(#"hash_393fb6bd6c5874aa") == 0)
	{
		n_kill_count = n_kill_count * 2;
	}
	else if(namespace_59ff1d6c::function_901b751c(#"hash_393fb6bd6c5874aa") == 2)
	{
		n_kill_count = floor(n_kill_count / 2);
	}
	if(namespace_e4df2f52::is_active())
	{
		n_kill_count = n_kill_count / namespace_e4df2f52::function_2fc5f13();
	}
	if(n_kill_count < 1)
	{
		n_kill_count = 1;
	}
	return n_kill_count;
}

/*
	Name: function_a7a5570e
	Namespace: zm_powerups
	Checksum: 0x6AC44BD3
	Offset: 0x1B50
	Size: 0x13E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a7a5570e()
{
	for(i = 1; i <= 4; i++)
	{
		zombie_utility::set_zombie_var(#"hash_434b3261c607850" + i, int(min(990, zombie_utility::function_d2dfacfd(#"hash_434b3261c607850" + i) + 1)));
		zombie_utility::set_zombie_var(#"hash_3f4e6b25f57677da" + i, int(min(999, zombie_utility::function_d2dfacfd(#"hash_3f4e6b25f57677da" + i) + 1)));
	}
}

/*
	Name: zombie_can_drop_powerups
	Namespace: zm_powerups
	Checksum: 0xA4202C79
	Offset: 0x1C98
	Size: 0x1E2
	Parameters: 1
	Flags: Linked
*/
function zombie_can_drop_powerups(weapon)
{
	if(namespace_e4df2f52::is_active() && isdefined(weapon) && (isdefined(weapon.isriotshield) && weapon.isriotshield || (isdefined(weapon.isheroweapon) && weapon.isheroweapon)))
	{
		return 1;
	}
	if(zm_loadout::is_tactical_grenade(weapon) || !level flag::get("zombie_drop_powerups"))
	{
		return 0;
	}
	if(isdefined(level.no_powerups) && level.no_powerups || (isdefined(self.no_powerups) && self.no_powerups) || (isdefined(weapon) && (isdefined(weapon.isheroweapon) && weapon.isheroweapon)))
	{
		return 0;
	}
	if(isdefined(level.use_powerup_volumes) && level.use_powerup_volumes)
	{
		volumes = getentarray("no_powerups", "targetname");
		foreach(volume in volumes)
		{
			if(self istouching(volume))
			{
				return 0;
			}
		}
	}
	return 1;
}

/*
	Name: function_b753385f
	Namespace: zm_powerups
	Checksum: 0x39293419
	Offset: 0x1E88
	Size: 0x2A4
	Parameters: 1
	Flags: Linked
*/
function function_b753385f(weapon)
{
	var_385d71c3 = 0;
	if(zombie_utility::function_d2dfacfd(#"zombie_drop_item"))
	{
		var_385d71c3 = 1;
		var_4e31704a = 1;
	}
	else
	{
		var_a45a5982 = randomint(100);
		if(bgb::is_team_enabled(#"zm_bgb_power_vacuum") && var_a45a5982 < 20)
		{
			var_385d71c3 = 1;
			var_4e31704a = 0;
		}
		else if(isdefined(weapon) && weaponhasattachment(weapon, "suppressed") && var_a45a5982 < 1)
		{
			var_385d71c3 = 1;
			var_4e31704a = 0;
		}
	}
	if(var_385d71c3 && self zombie_can_drop_powerups(weapon))
	{
		if(isdefined(self.in_the_ground) && self.in_the_ground)
		{
			trace = bullettrace(self.origin + vectorscale((0, 0, 1), 100), self.origin + vectorscale((0, 0, -1), 100), 0, undefined);
		}
		else
		{
			trace = groundtrace(self.origin + vectorscale((0, 0, 1), 5), self.origin + vectorscale((0, 0, -1), 300), 0, undefined);
		}
		origin = trace[#"position"];
		hit_ent = trace[#"entity"];
		var_d13d4980 = undefined;
		if(isdefined(hit_ent) && hit_ent ismovingplatform())
		{
			var_d13d4980 = spawn("script_model", origin + vectorscale((0, 0, 1), 40));
			var_d13d4980 linkto(hit_ent);
		}
		level thread powerup_drop(origin, var_d13d4980, var_4e31704a);
	}
}

/*
	Name: get_random_powerup_name
	Namespace: zm_powerups
	Checksum: 0x5708FFA0
	Offset: 0x2138
	Size: 0x46
	Parameters: 0
	Flags: None
*/
function get_random_powerup_name()
{
	powerup_keys = getarraykeys(level.zombie_powerups);
	powerup_keys = array::randomize(powerup_keys);
	return powerup_keys[0];
}

/*
	Name: get_regular_random_powerup_name
	Namespace: zm_powerups
	Checksum: 0xB3BB4B16
	Offset: 0x2188
	Size: 0x9C
	Parameters: 0
	Flags: None
*/
function get_regular_random_powerup_name()
{
	powerup_keys = getarraykeys(level.zombie_powerups);
	powerup_keys = array::randomize(powerup_keys);
	for(i = 0; i < powerup_keys.size; i++)
	{
		if([[level.zombie_powerups[powerup_keys[i]].func_should_drop_with_regular_powerups]]())
		{
			return powerup_keys[i];
		}
	}
	return powerup_keys[0];
}

/*
	Name: function_cc33adc8
	Namespace: zm_powerups
	Checksum: 0x8110C7C9
	Offset: 0x2230
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_cc33adc8()
{
	return util::function_5df4294() != "zcleansed";
}

/*
	Name: add_zombie_powerup
	Namespace: zm_powerups
	Checksum: 0xDD1A819F
	Offset: 0x2258
	Size: 0x4AE
	Parameters: 13
	Flags: Linked
*/
function add_zombie_powerup(powerup_name, model_name, hint, func_should_drop_with_regular_powerups, only_affects_grabber, any_team, zombie_grabbable, fx, client_field_name, time_name, on_name, clientfield_version = 1, player_specific = 0)
{
	if(isdefined(level.zombie_include_powerups) && (!(isdefined(level.zombie_include_powerups[powerup_name]) && level.zombie_include_powerups[powerup_name])))
	{
		return;
	}
	switch(powerup_name)
	{
		case "small_ammo":
		case "full_ammo":
		{
			var_f530d747 = "zmPowerupMaxAmmo";
			break;
		}
		case "fire_sale":
		{
			var_f530d747 = "zmPowerupFireSale";
			break;
		}
		case "bonus_points_player_shared":
		case "bonus_points_player":
		case "bonus_points_team":
		{
			var_f530d747 = "zmPowerupChaosPoints";
			break;
		}
		case "free_perk":
		{
			var_f530d747 = "zmPowerupFreePerk";
			break;
		}
		case "nuke":
		{
			var_f530d747 = "zmPowerupNuke";
			break;
		}
		case "hero_weapon_power":
		{
			var_f530d747 = "zmPowerupSpecialWeapon";
			break;
		}
		case "insta_kill":
		{
			var_f530d747 = "zmPowerupInstakill";
			break;
		}
		case "double_points":
		{
			var_f530d747 = "zmPowerupDouble";
			break;
		}
		case "carpenter":
		{
			var_f530d747 = "zmPowerupCarpenter";
			break;
		}
		default:
		{
			var_f530d747 = "";
		}
	}
	if(var_f530d747 != "" && (!(isdefined(namespace_59ff1d6c::function_901b751c(var_f530d747)) && namespace_59ff1d6c::function_901b751c(var_f530d747))))
	{
		return;
	}
	if(!isdefined(level.zombie_powerup_array))
	{
		level.zombie_powerup_array = [];
	}
	struct = spawnstruct();
	struct.powerup_name = powerup_name;
	struct.model_name = model_name;
	struct.weapon_classname = "script_model";
	struct.hint = hint;
	struct.func_should_drop_with_regular_powerups = func_should_drop_with_regular_powerups;
	struct.only_affects_grabber = only_affects_grabber;
	struct.any_team = any_team;
	struct.zombie_grabbable = zombie_grabbable;
	struct.var_33c87f51 = function_129f6487(powerup_name);
	struct.player_specific = player_specific;
	struct.can_pick_up_in_last_stand = 1;
	if(isdefined(fx))
	{
		struct.fx = fx;
	}
	level.zombie_powerups[powerup_name] = struct;
	level.zombie_powerup_array[level.zombie_powerup_array.size] = powerup_name;
	add_zombie_special_drop(powerup_name);
	if(isdefined(client_field_name))
	{
		var_4e6e65fa = "hudItems.zmPowerUps." + client_field_name + ".state";
		clientfield::register("clientuimodel", var_4e6e65fa, clientfield_version, 2, "int");
		struct.client_field_name = var_4e6e65fa;
		struct.time_name = time_name;
		struct.on_name = on_name;
	}
	if(isdefined(powerup_name) && powerup_name == #"full_ammo")
	{
		level.var_aebef29d = gettime() / 1000;
	}
}

/*
	Name: powerup_set_can_pick_up_in_last_stand
	Namespace: zm_powerups
	Checksum: 0xC57D0F59
	Offset: 0x2710
	Size: 0x32
	Parameters: 2
	Flags: None
*/
function powerup_set_can_pick_up_in_last_stand(powerup_name, b_can_pick_up)
{
	level.zombie_powerups[powerup_name].can_pick_up_in_last_stand = b_can_pick_up;
}

/*
	Name: powerup_set_prevent_pick_up_if_drinking
	Namespace: zm_powerups
	Checksum: 0x46FCC563
	Offset: 0x2750
	Size: 0x32
	Parameters: 2
	Flags: None
*/
function powerup_set_prevent_pick_up_if_drinking(powerup_name, b_prevent_pick_up)
{
	level._custom_powerups[powerup_name].prevent_pick_up_if_drinking = b_prevent_pick_up;
}

/*
	Name: powerup_set_player_specific
	Namespace: zm_powerups
	Checksum: 0x4C8B8B7B
	Offset: 0x2790
	Size: 0x42
	Parameters: 2
	Flags: None
*/
function powerup_set_player_specific(powerup_name, b_player_specific = 1)
{
	level.zombie_powerups[powerup_name].player_specific = b_player_specific;
}

/*
	Name: powerup_set_statless_powerup
	Namespace: zm_powerups
	Checksum: 0xC1A45463
	Offset: 0x27E0
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function powerup_set_statless_powerup(powerup_name)
{
	if(!isdefined(level.zombie_statless_powerups))
	{
		level.zombie_statless_powerups = [];
	}
	level.zombie_statless_powerups[powerup_name] = 1;
}

/*
	Name: add_zombie_special_drop
	Namespace: zm_powerups
	Checksum: 0x202950B6
	Offset: 0x2830
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function add_zombie_special_drop(powerup_name)
{
	if(!isdefined(level.zombie_special_drop_array))
	{
		level.zombie_special_drop_array = [];
	}
	level.zombie_special_drop_array[level.zombie_special_drop_array.size] = powerup_name;
}

/*
	Name: include_zombie_powerup
	Namespace: zm_powerups
	Checksum: 0x165B2367
	Offset: 0x2880
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function include_zombie_powerup(powerup_name)
{
	if(!isdefined(level.zombie_include_powerups))
	{
		level.zombie_include_powerups = [];
	}
	level.zombie_include_powerups[powerup_name] = 1;
}

/*
	Name: powerup_remove_from_regular_drops
	Namespace: zm_powerups
	Checksum: 0x958BA175
	Offset: 0x28D0
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function powerup_remove_from_regular_drops(powerup_name)
{
	if(!isdefined(level.zombie_powerups) || !isdefined(level.zombie_powerups[powerup_name]))
	{
		return;
	}
	level.zombie_powerups[powerup_name].func_should_drop_with_regular_powerups = &func_should_never_drop;
}

/*
	Name: function_74b8ec6b
	Namespace: zm_powerups
	Checksum: 0x879904C9
	Offset: 0x2938
	Size: 0xAA
	Parameters: 1
	Flags: None
*/
function function_74b8ec6b(powerup_name)
{
	if(!isdefined(level.zombie_powerups) || !isdefined(level.zombie_powerups[powerup_name]) || isdefined(level.zombie_powerups[powerup_name].var_d92b8001))
	{
		return;
	}
	level.zombie_powerups[powerup_name].var_d92b8001 = level.zombie_powerups[powerup_name].func_should_drop_with_regular_powerups;
	level.zombie_powerups[powerup_name].func_should_drop_with_regular_powerups = &func_should_never_drop;
}

/*
	Name: function_41cedb05
	Namespace: zm_powerups
	Checksum: 0xD39398A7
	Offset: 0x29F0
	Size: 0x9A
	Parameters: 1
	Flags: None
*/
function function_41cedb05(powerup_name)
{
	if(!isdefined(level.zombie_powerups) || !isdefined(level.zombie_powerups[powerup_name]) || !isdefined(level.zombie_powerups[powerup_name].var_d92b8001))
	{
		return;
	}
	level.zombie_powerups[powerup_name].func_should_drop_with_regular_powerups = level.zombie_powerups[powerup_name].var_d92b8001;
	level.zombie_powerups[powerup_name].var_d92b8001 = undefined;
}

/*
	Name: powerup_round_start
	Namespace: zm_powerups
	Checksum: 0x381EC3B
	Offset: 0x2A98
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function powerup_round_start()
{
	level.powerup_drop_count = 0;
}

/*
	Name: function_5326bd06
	Namespace: zm_powerups
	Checksum: 0x1B2DA085
	Offset: 0x2AB8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_5326bd06(var_7d81025)
{
	if(isdefined(var_7d81025))
	{
		var_7d81025 delete();
	}
}

/*
	Name: powerup_drop
	Namespace: zm_powerups
	Checksum: 0x51BF9878
	Offset: 0x2AF0
	Size: 0x418
	Parameters: 3
	Flags: Linked
*/
function powerup_drop(drop_point, powerup, var_4e31704a = 1)
{
	if(namespace_59ff1d6c::function_e1f04ede())
	{
		function_5326bd06(powerup);
		return;
	}
	if(isdefined(level.custom_zombie_powerup_drop))
	{
		b_outcome = [[level.custom_zombie_powerup_drop]](drop_point);
		if(isdefined(b_outcome) && b_outcome)
		{
			return;
		}
	}
	if(level.powerup_drop_count >= zombie_utility::function_d2dfacfd(#"zombie_powerup_drop_max_per_round"))
	{
		/#
			println("");
		#/
		function_5326bd06(powerup);
		return;
	}
	zombie_utility::set_zombie_var(#"zombie_drop_item", 0);
	level.powerup_drop_count++;
	if(!isdefined(powerup))
	{
		powerup = zm_net::network_safe_spawn("powerup", 1, "script_model", drop_point + vectorscale((0, 0, 1), 40));
	}
	powerup setmodel(#"tag_origin");
	if(!isdefined(level.zombie_include_powerups) || level.zombie_include_powerups.size == 0 || !function_70bd1ec9())
	{
		function_5326bd06(powerup);
		level.powerup_drop_count--;
		zombie_utility::set_zombie_var(#"zombie_drop_item", 1);
		return;
	}
	valid_drop = function_37e79fb6(powerup);
	if(var_4e31704a && valid_drop && level.rare_powerups_active)
	{
		pos = (drop_point[0], drop_point[1], drop_point[2] + 42);
		if(check_for_rare_drop_override(pos))
		{
			valid_drop = 0;
		}
	}
	if(!valid_drop)
	{
		level.powerup_drop_count--;
		powerup delete();
		zombie_utility::set_zombie_var(#"zombie_drop_item", 1);
		return;
	}
	powerup powerup_setup(undefined, undefined, drop_point);
	/#
		if(var_4e31704a)
		{
			str_debug = "";
		}
		else
		{
			str_debug = "";
		}
		print_powerup_drop(powerup.powerup_name, str_debug);
	#/
	bb::function_eb9250cd(powerup, undefined, "_dropped");
	powerup thread powerup_timeout();
	powerup thread powerup_wobble();
	powerup util::delay(0.1, "powerup_timedout", &powerup_grab);
	powerup thread powerup_emp();
	level notify(#"powerup_dropped", {#powerup:powerup});
}

/*
	Name: function_37e79fb6
	Namespace: zm_powerups
	Checksum: 0xD2815656
	Offset: 0x2F10
	Size: 0x1FA
	Parameters: 1
	Flags: Linked
*/
function function_37e79fb6(powerup)
{
	if(zm_utility::function_21f4ac36() && !isdefined(level.var_a2a9b2de))
	{
		level.var_a2a9b2de = getnodearray("player_region", "script_noteworthy");
	}
	if(zm_utility::function_c85ebbbc() && !isdefined(level.playable_area))
	{
		level.playable_area = getentarray("player_volume", "script_noteworthy");
	}
	if(namespace_e0710ee6::function_54054394(powerup))
	{
		return 0;
	}
	if(isdefined(level.var_a2a9b2de))
	{
		if(isdefined(level.var_61afcb81))
		{
			node = function_52c1730(powerup.origin, level.var_a2a9b2de, level.var_61afcb81);
		}
		else
		{
			node = function_52c1730(powerup.origin, level.var_a2a9b2de, 500);
		}
		if(isdefined(node))
		{
			return 1;
		}
	}
	if(isdefined(level.playable_area))
	{
		foreach(var_dab4474c in level.playable_area)
		{
			if(powerup istouching(var_dab4474c))
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_27437dae
	Namespace: zm_powerups
	Checksum: 0x2F390BD
	Offset: 0x3118
	Size: 0x234
	Parameters: 0
	Flags: Linked
*/
function function_27437dae()
{
	self endon(#"death", #"powerup_timedout", #"powerup_grabbed");
	if(!zm_utility::function_21f4ac36() || !isdefined(level.var_a2a9b2de))
	{
		return;
	}
	wait(1);
	var_1a7af6f3 = arraysortclosest(level.var_a2a9b2de, self.origin);
	foreach(var_30d9be5a in var_1a7af6f3)
	{
		if(zm_zonemgr::zone_is_enabled(var_30d9be5a.targetname))
		{
			nd_closest = var_30d9be5a;
			break;
		}
	}
	if(!isdefined(nd_closest))
	{
		return;
	}
	var_f55f0704 = nd_closest.origin + vectorscale((0, 0, 1), 40);
	var_8a69f8c0 = distancesquared(var_f55f0704, self.origin);
	n_travel_time = math::linear_map(var_8a69f8c0, 100, 250000, 0.1, 3);
	if(n_travel_time <= 0.25 * 2)
	{
		n_accel = 0;
	}
	else
	{
		n_accel = 0.25;
	}
	self moveto(var_f55f0704, n_travel_time, n_accel, n_accel);
}

/*
	Name: specific_powerup_drop
	Namespace: zm_powerups
	Checksum: 0x49B4CCAD
	Offset: 0x3358
	Size: 0x50A
	Parameters: 10
	Flags: Linked
*/
function specific_powerup_drop(var_5a63971, powerup_location, powerup_team, pickup_delay = 0.1, powerup_player, b_stay_forever, var_6f4cb533 = 0, var_a6d11a96, var_73b4ca3f = 1, var_45eaa114)
{
	if(!var_6f4cb533 && namespace_59ff1d6c::function_e1f04ede() || !namespace_59ff1d6c::function_901b751c(#"zmpowerupsactive"))
	{
		return;
	}
	if(isactor(self) && !level flag::get("zombie_drop_powerups"))
	{
		return;
	}
	if(isarray(var_5a63971))
	{
		var_5a63971 = array::random(var_5a63971);
	}
	switch(var_5a63971)
	{
		case "full_ammo":
		{
			var_f530d747 = "zmPowerupMaxAmmo";
			break;
		}
		case "fire_sale":
		{
			var_f530d747 = "zmPowerupFireSale";
			break;
		}
		case "bonus_points_player_shared":
		case "bonus_points_player":
		case "bonus_points_team":
		{
			var_f530d747 = "zmPowerupChaosPoints";
			break;
		}
		case "free_perk":
		{
			var_f530d747 = "zmPowerupFreePerk";
			break;
		}
		case "nuke":
		{
			var_f530d747 = "zmPowerupNuke";
			break;
		}
		case "hero_weapon_power":
		{
			var_f530d747 = "zmPowerupSpecialWeapon";
			break;
		}
		case "insta_kill":
		{
			var_f530d747 = "zmPowerupInstakill";
			break;
		}
		case "double_points":
		{
			var_f530d747 = "zmPowerupDouble";
			break;
		}
		case "carpenter":
		{
			var_f530d747 = "zmPowerupCarpenter";
			break;
		}
		default:
		{
			var_f530d747 = "";
		}
	}
	if(var_f530d747 != "" && (!(isdefined(namespace_59ff1d6c::function_901b751c(var_f530d747)) && namespace_59ff1d6c::function_901b751c(var_f530d747))))
	{
		return;
	}
	if(!var_73b4ca3f && var_f530d747 != "" && isdefined(level.zombie_powerups[var_5a63971]))
	{
		if(![[level.zombie_powerups[var_5a63971].func_should_drop_with_regular_powerups]]())
		{
			return;
		}
	}
	s_trace = physicstrace(powerup_location + vectorscale((0, 0, 1), 10), powerup_location + vectorscale((0, 0, -1), 100), (0, 0, 0), (0, 0, 0), undefined, 2 | 16);
	hit_ent = s_trace[#"entity"];
	if(isdefined(hit_ent) && hit_ent ismovingplatform())
	{
		powerup = spawn("script_model", powerup_location + vectorscale((0, 0, 1), 40));
		powerup linkto(hit_ent);
	}
	else
	{
		powerup = zm_net::network_safe_spawn("powerup", 1, "script_model", powerup_location + vectorscale((0, 0, 1), 40));
	}
	powerup setmodel(#"tag_origin");
	powerup_location = powerup.origin;
	level notify(#"powerup_dropped", {#powerup:powerup});
	return powerup_init(powerup, var_5a63971, powerup_team, powerup_location, pickup_delay, powerup_player, b_stay_forever, var_a6d11a96, var_45eaa114);
}

/*
	Name: powerup_init
	Namespace: zm_powerups
	Checksum: 0x8EEB9D1E
	Offset: 0x3870
	Size: 0x18A
	Parameters: 9
	Flags: Linked
*/
function powerup_init(powerup, str_powerup, powerup_team, powerup_location, pickup_delay = 0.1, powerup_player, b_stay_forever, var_a6d11a96, var_45eaa114)
{
	if(isdefined(powerup))
	{
		powerup powerup_setup(str_powerup, powerup_team, powerup_location, powerup_player, undefined, var_a6d11a96);
		if(isdefined(var_45eaa114) && var_45eaa114 && !function_37e79fb6(powerup))
		{
			powerup thread function_27437dae();
		}
		if(!(isdefined(b_stay_forever) && b_stay_forever))
		{
			powerup thread powerup_timeout();
		}
		powerup thread powerup_wobble();
		if(isdefined(pickup_delay) && pickup_delay < 0.1)
		{
			pickup_delay = 0.1;
		}
		powerup util::delay(pickup_delay, "powerup_timedout", &powerup_grab, powerup_team);
		powerup thread powerup_emp();
		return powerup;
	}
}

/*
	Name: function_14b7208c
	Namespace: zm_powerups
	Checksum: 0x748103AA
	Offset: 0x3A08
	Size: 0x16C
	Parameters: 4
	Flags: Linked
*/
function function_14b7208c(str_powerup, powerup_team, powerup_location, powerup_player)
{
	var_ce95e926 = 60;
	var_f9f778c1 = 120;
	var_d2057007 = 6;
	if(str_powerup === "nuke")
	{
		name = string(randomint(2147483647));
		origin = self.origin;
		badplace_cylinder(name, 0, origin, var_ce95e926, var_f9f778c1, #"allies");
		while(isdefined(self))
		{
			if(distance2dsquared(origin, self.origin) > var_d2057007 * var_d2057007)
			{
				origin = self.origin;
				badplace_cylinder(name, 0, origin, var_ce95e926, var_f9f778c1, #"allies");
			}
			wait(1);
		}
		badplace_delete(name);
	}
}

/*
	Name: powerup_setup
	Namespace: zm_powerups
	Checksum: 0xFE1DA1A5
	Offset: 0x3B80
	Size: 0x4DC
	Parameters: 6
	Flags: Linked
*/
function powerup_setup(powerup_override, powerup_team, powerup_location, powerup_player, shouldplaysound = 1, var_a6d11a96)
{
	powerup = undefined;
	if(!isdefined(powerup_override))
	{
		powerup = get_valid_powerup();
	}
	else
	{
		powerup = powerup_override;
		if("tesla" == powerup && tesla_powerup_active())
		{
			powerup = "minigun";
		}
	}
	struct = level.zombie_powerups[powerup];
	if(isdefined(powerup_team))
	{
		self.powerup_team = powerup_team;
	}
	if(isdefined(powerup_location))
	{
		self.powerup_location = powerup_location;
	}
	if(isdefined(powerup_player))
	{
		self.powerup_player = powerup_player;
	}
	assert(!(isdefined(struct.player_specific) && struct.player_specific), "");
	self.powerup_name = struct.powerup_name;
	self.hint = struct.hint;
	self.only_affects_grabber = struct.only_affects_grabber;
	self.any_team = struct.any_team;
	self.zombie_grabbable = struct.zombie_grabbable;
	self.func_should_drop_with_regular_powerups = struct.func_should_drop_with_regular_powerups;
	if(isdefined(level._custom_powerups) && isdefined(level._custom_powerups[powerup]) && isdefined(level._custom_powerups[powerup].setup_powerup))
	{
		self [[level._custom_powerups[powerup].setup_powerup]]();
	}
	else
	{
		self function_76678c8d(powerup_location, struct.model_name, var_a6d11a96);
	}
	if(powerup == "full_ammo")
	{
		level.zm_genesis_robot_pay_towardsreactswordstart = randomintrange(zombie_utility::function_d2dfacfd(#"hash_4d2cc817490bcca"), zombie_utility::function_d2dfacfd(#"hash_4edd68174a79580"));
	}
	else if(!isdefined(powerup_override))
	{
		level.zm_genesis_robot_pay_towardsreactswordstart--;
	}
	demo::bookmark(#"zm_powerup_dropped", gettime(), undefined, undefined, 1);
	potm::bookmark(#"zm_powerup_dropped", gettime(), undefined, undefined, 1);
	if(isdefined(struct.fx))
	{
		self.fx = struct.fx;
	}
	if(isdefined(struct.can_pick_up_in_last_stand))
	{
		self.can_pick_up_in_last_stand = struct.can_pick_up_in_last_stand;
	}
	var_b9dc5e9 = (isdefined(struct.var_184f74ef) ? struct.var_184f74ef : 0);
	if(!var_b9dc5e9)
	{
		if(isdefined(level.var_bec5bf67))
		{
			var_b9dc5e9 = self [[level.var_bec5bf67]](self.powerup_name);
		}
	}
	if(!(isdefined(var_b9dc5e9) && var_b9dc5e9))
	{
		if(powerup == "bonus_points_player" || powerup == "bonus_points_player_shared" && zm_utility::is_standard())
		{
			self playsound(#"hash_1229e9d60b3181ef");
			self playloopsound(#"hash_46b9bf1ae523021c");
		}
		else
		{
			self playsound(#"zmb_spawn_powerup");
			self playloopsound(#"zmb_spawn_powerup_loop");
		}
	}
	level.active_powerups[level.active_powerups.size] = self;
	self thread function_14b7208c(powerup, powerup_team, powerup_location, powerup_player);
}

/*
	Name: powerup_zombie_grab_trigger_cleanup
	Namespace: zm_powerups
	Checksum: 0x9662DEC8
	Offset: 0x4068
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function powerup_zombie_grab_trigger_cleanup(trigger)
{
	self waittill(#"powerup_timedout", #"powerup_grabbed", #"hacked");
	trigger delete();
}

/*
	Name: powerup_zombie_grab
	Namespace: zm_powerups
	Checksum: 0x17D393F4
	Offset: 0x40C8
	Size: 0x3C2
	Parameters: 1
	Flags: Linked
*/
function powerup_zombie_grab(powerup_team)
{
	self endon(#"powerup_timedout", #"powerup_grabbed", #"hacked");
	zombie_grab_trigger = spawn("trigger_radius", self.origin - vectorscale((0, 0, 1), 40), 512 | 1 + 8, 32, 72);
	zombie_grab_trigger enablelinkto();
	zombie_grab_trigger linkto(self);
	zombie_grab_trigger setteamfortrigger(level.zombie_team);
	self thread powerup_zombie_grab_trigger_cleanup(zombie_grab_trigger);
	poi_dist = 300;
	if(isdefined(level._zombie_grabbable_poi_distance_override))
	{
		poi_dist = level._zombie_grabbable_poi_distance_override;
	}
	zombie_grab_trigger zm_utility::create_zombie_point_of_interest(poi_dist, 2, 0, 1, undefined, undefined, powerup_team);
	while(isdefined(self))
	{
		waitresult = undefined;
		waitresult = zombie_grab_trigger waittill(#"trigger");
		who = waitresult.activator;
		if(isdefined(level._powerup_grab_check))
		{
			if(!self [[level._powerup_grab_check]](who))
			{
				continue;
			}
		}
		else if(!isdefined(who) || !isai(who))
		{
			continue;
		}
		self clientfield::set("powerup_grabbed_fx", 3);
		if(isdefined(who))
		{
			who playsound(#"zmb_powerup_grabbed");
		}
		self stoploopsound();
		if(isdefined(level._custom_powerups) && isdefined(level._custom_powerups[self.powerup_name]) && isdefined(level._custom_powerups[self.powerup_name].grab_powerup))
		{
			b_continue = self [[level._custom_powerups[self.powerup_name].grab_powerup]]();
			if(isdefined(b_continue) && b_continue)
			{
				continue;
			}
		}
		else if(isdefined(level._zombiemode_powerup_zombie_grab))
		{
			level thread [[level._zombiemode_powerup_zombie_grab]](self);
		}
		if(isdefined(level._game_mode_powerup_zombie_grab))
		{
			level thread [[level._game_mode_powerup_zombie_grab]](self, who);
		}
		println("");
		level thread zm_audio::sndannouncerplayvox(self.powerup_name);
		wait(0.1);
		self thread powerup_delete_delayed();
		self notify(#"powerup_grabbed", {#e_grabber:who});
	}
}

/*
	Name: powerup_grab
	Namespace: zm_powerups
	Checksum: 0xCAFACDD
	Offset: 0x4498
	Size: 0xB6C
	Parameters: 1
	Flags: Linked
*/
function powerup_grab(powerup_team)
{
	if(isdefined(self) && self.zombie_grabbable)
	{
		self thread powerup_zombie_grab(powerup_team);
		return;
	}
	self endon(#"powerup_timedout", #"powerup_grabbed");
	range_squared = 4096;
	while(isdefined(self))
	{
		if(isdefined(self.powerup_player))
		{
			grabbers = [];
			grabbers[0] = self.powerup_player;
		}
		else if(isdefined(level.powerup_grab_get_players_override))
		{
			grabbers = [[level.powerup_grab_get_players_override]]();
		}
		else
		{
			grabbers = getplayers();
		}
		for(i = 0; i < grabbers.size; i++)
		{
			grabber = grabbers[i];
			if(isalive(grabber.owner) && isplayer(grabber.owner))
			{
				player = grabber.owner;
			}
			else if(isplayer(grabber))
			{
				player = grabber;
			}
			if(!isdefined(self))
			{
				break;
			}
			if(self.only_affects_grabber && !isdefined(player))
			{
				continue;
			}
			if(player zm_utility::is_drinking() && isdefined(level._custom_powerups) && isdefined(level._custom_powerups[self.powerup_name]) && (isdefined(level._custom_powerups[self.powerup_name].prevent_pick_up_if_drinking) && level._custom_powerups[self.powerup_name].prevent_pick_up_if_drinking))
			{
				continue;
			}
			if(self.powerup_name == "minigun" || self.powerup_name == "tesla" || self.powerup_name == "random_weapon" || self.powerup_name == "meat_stink" && (!isplayer(grabber) || player laststand::player_is_in_laststand() || (player usebuttonpressed() && player zm_utility::in_revive_trigger()) || player bgb::is_enabled(#"zm_bgb_disorderly_combat")))
			{
				continue;
			}
			if(!(isdefined(self.can_pick_up_in_last_stand) && self.can_pick_up_in_last_stand) && player laststand::player_is_in_laststand())
			{
				continue;
			}
			ignore_range = 0;
			if(grabber.ignore_range_powerup === self)
			{
				grabber.ignore_range_powerup = undefined;
				ignore_range = 1;
			}
			if(isalive(grabber) && (distancesquared(grabber.origin, self.origin) < range_squared || ignore_range))
			{
				if(isdefined(level._powerup_grab_check))
				{
					if(!self [[level._powerup_grab_check]](player))
					{
						continue;
					}
				}
				if(namespace_e4df2f52::is_active())
				{
					var_57807cdc = [];
					array::add(var_57807cdc, player, 0);
					zm_trial::fail(#"hash_2619fd380423798b", var_57807cdc);
					self thread powerup_delete_delayed();
					self notify(#"powerup_grabbed", {#e_grabber:player});
					return;
				}
				if(isdefined(level._custom_powerups) && isdefined(level._custom_powerups[self.powerup_name]) && isdefined(level._custom_powerups[self.powerup_name].grab_powerup))
				{
					b_continue = self [[level._custom_powerups[self.powerup_name].grab_powerup]](player);
					if(isdefined(b_continue) && b_continue)
					{
						continue;
					}
				}
				else
				{
					switch(self.powerup_name)
					{
						case "teller_withdrawl":
						{
							level thread teller_withdrawl(self, player);
							break;
						}
						default:
						{
							if(isdefined(level._zombiemode_powerup_grab))
							{
								level thread [[level._zombiemode_powerup_grab]](self, player);
							}
							println("");
							break;
						}
					}
				}
				demo::bookmark(#"zm_player_powerup_grabbed", gettime(), player);
				potm::bookmark(#"zm_player_powerup_grabbed", gettime(), player);
				bb::function_eb9250cd(self, player, "_grabbed");
				if(isdefined(self.var_33c87f51))
				{
					player recordmapevent(23, gettime(), grabber.origin, level.round_number, self.var_33c87f51);
				}
				if(should_award_stat(self.powerup_name) && isplayer(player))
				{
					player zm_stats::increment_client_stat("drops");
					player zm_stats::increment_player_stat("drops");
					player zm_stats::function_8f10788e("boas_drops");
					player zm_stats::increment_client_stat(self.powerup_name + "_pickedup");
					player zm_stats::increment_player_stat(self.powerup_name + "_pickedup");
					player zm_stats::increment_challenge_stat(#"survivalist_powerup");
					player zm_stats::function_8f10788e("boas_" + self.powerup_name + "_pickedup");
					player contracts::function_5b88297d(#"hash_456b19c561097c1b");
					if(zm_utility::is_standard())
					{
						player zm_stats::increment_challenge_stat(#"hash_35ab7dfe675d26e9");
						player zm_stats::function_c0c6ab19(#"hash_5d17ceae070dc3c1");
					}
				}
				if(isdefined(level.var_50b95271))
				{
					self thread [[level.var_50b95271]]();
				}
				else
				{
					var_f79dc259 = self function_d5b6ce91();
					self clientfield::set("powerup_grabbed_fx", var_f79dc259);
				}
				if(isdefined(self.stolen) && self.stolen)
				{
					level notify(#"monkey_see_monkey_dont_achieved");
				}
				if(isdefined(self.grabbed_level_notify))
				{
					level notify(self.grabbed_level_notify);
				}
				if(self.powerup_name == "bonus_points_player" || self.powerup_name == "bonus_points_player_shared" && zm_utility::is_standard())
				{
					player playsound(#"hash_6c0682a7e4e26b09");
				}
				else
				{
					b_ignore = 0;
					if(isdefined(level.var_bec5bf67))
					{
						b_ignore = self [[level.var_bec5bf67]](self.powerup_name);
					}
					if(!b_ignore)
					{
						player playsound(#"zmb_powerup_grabbed");
					}
				}
				self.claimed = 1;
				self.power_up_grab_player = player;
				wait(0.1);
				if(!isdefined(self))
				{
					break;
				}
				self stoploopsound();
				self hide();
				if(self.powerup_name != "fire_sale")
				{
					if(isdefined(self.power_up_grab_player))
					{
						if(isdefined(level.powerup_intro_vox))
						{
							level thread [[level.powerup_intro_vox]](self);
							return;
						}
						if(isdefined(level.powerup_vo_available))
						{
							can_say_vo = [[level.powerup_vo_available]]();
							if(!can_say_vo)
							{
								self thread powerup_delete_delayed();
								self notify(#"powerup_grabbed", {#e_grabber:player});
								return;
							}
						}
					}
				}
				if(isdefined(self.only_affects_grabber) && self.only_affects_grabber)
				{
					level thread zm_audio::sndannouncerplayvox(self.powerup_name, player);
				}
				else
				{
					level thread zm_audio::sndannouncerplayvox(self.powerup_name);
				}
				self thread powerup_delete_delayed();
				self notify(#"powerup_grabbed", {#e_grabber:player});
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_c1963295
	Namespace: zm_powerups
	Checksum: 0x19BA1319
	Offset: 0x5010
	Size: 0x10A
	Parameters: 2
	Flags: Linked
*/
function function_c1963295(var_4c20edd5, var_a6d11a96)
{
	e_player = zm_utility::get_closest_player(var_4c20edd5);
	if(isdefined(level.var_ec45f213) && level.var_ec45f213 || (isdefined(var_a6d11a96) && var_a6d11a96))
	{
		return 0.1;
	}
	if(!isdefined(e_player))
	{
		return 1.5;
	}
	n_distance = distance(e_player.origin, var_4c20edd5);
	if(n_distance > 128)
	{
		return 0.1;
	}
	if(n_distance < 8)
	{
		return 1.5;
	}
	n_delay = math::linear_map(n_distance, 8, 128, 1.5, 0);
	return n_delay;
}

/*
	Name: function_76678c8d
	Namespace: zm_powerups
	Checksum: 0xECB21E22
	Offset: 0x5128
	Size: 0xD4
	Parameters: 3
	Flags: Linked
*/
function function_76678c8d(var_41c62074, str_model, var_a6d11a96)
{
	self endon(#"powerup_grabbed");
	if(isdefined(level.powerup_intro_fx_func))
	{
		self thread [[level.powerup_intro_fx_func]]();
	}
	else
	{
		var_f79dc259 = self function_d5b6ce91();
		self clientfield::set("powerup_intro_fx", var_f79dc259);
	}
	var_e886efeb = function_c1963295(var_41c62074, var_a6d11a96);
	wait(var_e886efeb);
	self setmodel(str_model);
}

/*
	Name: get_closest_window_repair
	Namespace: zm_powerups
	Checksum: 0x5EFF37D4
	Offset: 0x5208
	Size: 0x11C
	Parameters: 2
	Flags: None
*/
function get_closest_window_repair(windows, origin)
{
	current_window = undefined;
	shortest_distance = undefined;
	for(i = 0; i < windows.size; i++)
	{
		if(zm_utility::all_chunks_intact(windows, windows[i].barrier_chunks))
		{
			continue;
		}
		if(!isdefined(current_window))
		{
			current_window = windows[i];
			shortest_distance = distancesquared(current_window.origin, origin);
			continue;
		}
		if(distancesquared(windows[i].origin, origin) < shortest_distance)
		{
			current_window = windows[i];
			shortest_distance = distancesquared(windows[i].origin, origin);
		}
	}
	return current_window;
}

/*
	Name: powerup_vo
	Namespace: zm_powerups
	Checksum: 0xB0427382
	Offset: 0x5330
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function powerup_vo(type)
{
	self endon(#"disconnect");
	if(!isplayer(self))
	{
		return;
	}
	if(isdefined(level.powerup_vo_available))
	{
		if(![[level.powerup_vo_available]]())
		{
			return;
		}
	}
	if(type == "tesla")
	{
		wait(randomfloatrange(3.5, 4.5));
		self zm_audio::create_and_play_dialog(#"weapon_pickup", type);
	}
	else
	{
		wait(0.5);
		self zm_audio::create_and_play_dialog(#"powerup", type, undefined, 2);
	}
	if(isdefined(level.custom_powerup_vo_response))
	{
		level [[level.custom_powerup_vo_response]](self, type);
	}
}

/*
	Name: function_f0eb47d8
	Namespace: zm_powerups
	Checksum: 0xD9D60EB
	Offset: 0x5448
	Size: 0x56
	Parameters: 2
	Flags: Linked
*/
function function_f0eb47d8(var_f0de9b92, b_disable = 1)
{
	if(isdefined(level.zombie_powerups[var_f0de9b92]))
	{
		level.zombie_powerups[var_f0de9b92].var_cad40b46 = b_disable;
	}
}

/*
	Name: function_80b4c5e0
	Namespace: zm_powerups
	Checksum: 0x4DF9B04B
	Offset: 0x54A8
	Size: 0x56
	Parameters: 2
	Flags: Linked
*/
function function_80b4c5e0(var_f0de9b92, b_disable = 1)
{
	if(isdefined(level.zombie_powerups[var_f0de9b92]))
	{
		level.zombie_powerups[var_f0de9b92].var_184f74ef = b_disable;
	}
}

/*
	Name: powerup_wobble_fx
	Namespace: zm_powerups
	Checksum: 0x614F0D05
	Offset: 0x5508
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function powerup_wobble_fx()
{
	self endon(#"death");
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(level.powerup_fx_func))
	{
		self thread [[level.powerup_fx_func]]();
		return;
	}
	var_f79dc259 = self function_d5b6ce91();
	self clientfield::set("powerup_fx", var_f79dc259);
}

/*
	Name: function_d5b6ce91
	Namespace: zm_powerups
	Checksum: 0xD28975C0
	Offset: 0x5598
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_d5b6ce91()
{
	if(self.only_affects_grabber)
	{
		return 2;
	}
	if(self.any_team)
	{
		return 4;
	}
	if(self.zombie_grabbable)
	{
		return 3;
	}
	return 1;
}

/*
	Name: powerup_wobble
	Namespace: zm_powerups
	Checksum: 0x7AA5F64D
	Offset: 0x55E8
	Size: 0x208
	Parameters: 0
	Flags: Linked
*/
function powerup_wobble()
{
	self endon(#"powerup_grabbed", #"powerup_timedout");
	if(isdefined(level.zombie_powerups[self.powerup_name]) && (isdefined(level.zombie_powerups[self.powerup_name].var_cad40b46) && level.zombie_powerups[self.powerup_name].var_cad40b46))
	{
		return;
	}
	self thread powerup_wobble_fx();
	while(isdefined(self))
	{
		waittime = randomfloatrange(2.5, 5);
		yaw = randomint(360);
		if(yaw > 300)
		{
			yaw = 300;
		}
		else if(yaw < 60)
		{
			yaw = 60;
		}
		yaw = self.angles[1] + yaw;
		new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));
		self rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
		if(isdefined(self.worldgundw))
		{
			self.worldgundw rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
		}
		wait(randomfloat(waittime - 0.1));
	}
}

/*
	Name: function_e3f30b
	Namespace: zm_powerups
	Checksum: 0xBA7C1F9B
	Offset: 0x57F8
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_e3f30b()
{
	if(isdefined(self))
	{
		self ghost();
		if(isdefined(self.worldgundw))
		{
			self.worldgundw ghost();
		}
	}
}

/*
	Name: powerup_show
	Namespace: zm_powerups
	Checksum: 0x8BC6CE7
	Offset: 0x5850
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function powerup_show()
{
	if(isdefined(self))
	{
		self show();
		if(isdefined(self.worldgundw))
		{
			self.worldgundw show();
		}
		if(isdefined(self.powerup_player))
		{
			self setinvisibletoall();
			self setvisibletoplayer(self.powerup_player);
			if(isdefined(self.worldgundw))
			{
				self.worldgundw setinvisibletoall();
				self.worldgundw setvisibletoplayer(self.powerup_player);
			}
		}
	}
}

/*
	Name: powerup_timeout
	Namespace: zm_powerups
	Checksum: 0x310EBF72
	Offset: 0x5930
	Size: 0x18C
	Parameters: 0
	Flags: Linked
*/
function powerup_timeout()
{
	if(isdefined(level._powerup_timeout_override) && !isdefined(self.powerup_team))
	{
		self thread [[level._powerup_timeout_override]]();
		return;
	}
	self endon(#"powerup_grabbed", #"death", #"powerup_reset");
	self powerup_show();
	wait_time = 15;
	if(isdefined(level._powerup_timeout_custom_time))
	{
		time = [[level._powerup_timeout_custom_time]](self);
		if(time == 0)
		{
			return;
		}
		wait_time = time;
	}
	if(bgb::is_team_enabled(#"zm_bgb_temporal_gift"))
	{
		wait_time = wait_time + 30;
	}
	wait(wait_time);
	self hide_and_show(&function_e3f30b, &powerup_show);
	self notify(#"powerup_timedout");
	bb::function_eb9250cd(self, undefined, "_timedout");
	self powerup_delete();
}

/*
	Name: hide_and_show
	Namespace: zm_powerups
	Checksum: 0x8E13F6C9
	Offset: 0x5AC8
	Size: 0x9E
	Parameters: 2
	Flags: Linked
*/
function hide_and_show(hide_func, show_func)
{
	for(i = 0; i < 40; i++)
	{
		if(i % 2)
		{
			self [[hide_func]]();
		}
		else
		{
			self [[show_func]]();
		}
		if(i < 15)
		{
			wait(0.5);
			continue;
		}
		if(i < 25)
		{
			wait(0.25);
			continue;
		}
		wait(0.1);
	}
}

/*
	Name: powerup_delete
	Namespace: zm_powerups
	Checksum: 0x5800F037
	Offset: 0x5B70
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function powerup_delete()
{
	if(isdefined(self))
	{
		arrayremovevalue(level.active_powerups, self, 0);
		if(isdefined(self.worldgundw))
		{
			self.worldgundw delete();
		}
		self delete();
	}
}

/*
	Name: powerup_delete_delayed
	Namespace: zm_powerups
	Checksum: 0x974D77B4
	Offset: 0x5BE8
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function powerup_delete_delayed(time)
{
	if(isdefined(time))
	{
		wait(time);
	}
	else
	{
		wait(0.01);
	}
	self powerup_delete();
}

/*
	Name: function_bcfcc27e
	Namespace: zm_powerups
	Checksum: 0x92764B6E
	Offset: 0x5C30
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_bcfcc27e()
{
	if(zm_utility::function_166646a6() == 1)
	{
		return "zombie_pickup_perk_bottle";
	}
	return "p8_zm_powerup_free_perk_02";
}

/*
	Name: is_insta_kill_active
	Namespace: zm_powerups
	Checksum: 0xA7A5C0A3
	Offset: 0x5C68
	Size: 0xD6
	Parameters: 0
	Flags: Linked
*/
function is_insta_kill_active()
{
	if(isdefined(zombie_utility::function_6403cf83(#"zombie_insta_kill", self.team)) && zombie_utility::function_6403cf83(#"zombie_insta_kill", self.team) || (isdefined(self zombie_utility::function_73061b82(#"zombie_insta_kill")) && self zombie_utility::function_73061b82(#"zombie_insta_kill")) || (isdefined(self.personal_instakill) && self.personal_instakill))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_fe6d6eac
	Namespace: zm_powerups
	Checksum: 0x3E80541E
	Offset: 0x5D48
	Size: 0x24E
	Parameters: 5
	Flags: Linked
*/
function function_fe6d6eac(player, mod, hit_location, weapon, damage)
{
	if(!("head" == hit_location || "helmet" == hit_location || "neck" == hit_location) && (isdefined(level.headshots_only) && level.headshots_only || namespace_25f0796c::is_active()))
	{
		return damage;
	}
	if(isdefined(player) && isalive(player) && isdefined(level.check_for_instakill_override))
	{
		if(!self [[level.check_for_instakill_override]](player))
		{
			return damage;
		}
		if(!(isdefined(self.no_gib) && self.no_gib))
		{
			self zombie_utility::zombie_head_gib();
		}
		self.health = 1;
		return self.health + 666;
	}
	if(isdefined(player) && isalive(player) && player is_insta_kill_active())
	{
		if(zm_utility::is_magic_bullet_shield_enabled(self))
		{
			return damage;
		}
		if(isdefined(self.instakill_func))
		{
			b_result = self thread [[self.instakill_func]](player, mod, hit_location);
			if(isdefined(b_result) && b_result)
			{
				return damage;
			}
		}
		if(!level flag::get("special_round") && (!(isdefined(self.no_gib) && self.no_gib)))
		{
			self zombie_utility::zombie_head_gib();
		}
		self.health = 1;
		return self.health + 666;
	}
	return damage;
}

/*
	Name: function_16c2586a
	Namespace: zm_powerups
	Checksum: 0xD352035B
	Offset: 0x5FA0
	Size: 0x20
	Parameters: 3
	Flags: Linked
*/
function function_16c2586a(player, mod, shitloc)
{
	return 1;
}

/*
	Name: point_doubler_on_hud
	Namespace: zm_powerups
	Checksum: 0xE6066BD
	Offset: 0x5FC8
	Size: 0xB4
	Parameters: 2
	Flags: None
*/
function point_doubler_on_hud(drop_item, player_team)
{
	self endon(#"disconnect");
	if(zombie_utility::function_6403cf83(#"zombie_powerup_double_points_on", player_team))
	{
		zombie_utility::function_c7ab6cbc(#"zombie_powerup_double_points_time", player_team, 30);
		return;
	}
	zombie_utility::function_c7ab6cbc(#"zombie_powerup_double_points_on", player_team, 1);
	level thread time_remaining_on_point_doubler_powerup(player_team);
}

/*
	Name: time_remaining_on_point_doubler_powerup
	Namespace: zm_powerups
	Checksum: 0x9E6C0823
	Offset: 0x6088
	Size: 0x1C4
	Parameters: 1
	Flags: Linked
*/
function time_remaining_on_point_doubler_powerup(player_team)
{
	temp_ent = spawn("script_origin", (0, 0, 0));
	temp_ent playloopsound(#"zmb_double_point_loop");
	while(zombie_utility::function_6403cf83(#"zombie_powerup_double_points_time", player_team) >= 0)
	{
		waitframe(1);
		zombie_utility::function_c7ab6cbc(#"zombie_powerup_double_points_time", player_team, zombie_utility::function_6403cf83(#"zombie_powerup_double_points_time", player_team) - 0.05);
	}
	zombie_utility::function_c7ab6cbc(#"zombie_powerup_double_points_on", player_team, 0);
	players = getplayers(player_team);
	for(i = 0; i < players.size; i++)
	{
		players[i] playsound(#"zmb_points_loop_off");
	}
	temp_ent stoploopsound(2);
	zombie_utility::function_c7ab6cbc(#"zombie_powerup_double_points_time", player_team, 30);
	temp_ent delete();
}

/*
	Name: devil_dialog_delay
	Namespace: zm_powerups
	Checksum: 0xEE480502
	Offset: 0x6258
	Size: 0xC
	Parameters: 0
	Flags: None
*/
function devil_dialog_delay()
{
	wait(1);
}

/*
	Name: check_for_rare_drop_override
	Namespace: zm_powerups
	Checksum: 0x697712AD
	Offset: 0x6270
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function check_for_rare_drop_override(pos)
{
	if(level flagsys::get(#"ape_round"))
	{
		return 0;
	}
	return 0;
}

/*
	Name: tesla_powerup_active
	Namespace: zm_powerups
	Checksum: 0xD5FBE430
	Offset: 0x62B0
	Size: 0x72
	Parameters: 0
	Flags: Linked
*/
function tesla_powerup_active()
{
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		if(players[i].zombie_vars[#"zombie_powerup_tesla_on"])
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: print_powerup_drop
	Namespace: zm_powerups
	Checksum: 0x16504AF3
	Offset: 0x6330
	Size: 0x194
	Parameters: 2
	Flags: None
*/
function print_powerup_drop(powerup, type)
{
	/#
		if(!isdefined(level.powerup_drop_time))
		{
			level.powerup_drop_time = 0;
			level.powerup_random_count = 0;
			level.var_27b063df = 0;
		}
		time = gettime() - level.powerup_drop_time * 0.001;
		level.powerup_drop_time = gettime();
		if(type == "")
		{
			level.powerup_random_count++;
		}
		else
		{
			level.var_27b063df++;
		}
		println("");
		println("" + powerup);
		println("" + type);
		println("");
		println("" + time);
		println("");
		println("" + level.var_27b063df);
		println("");
	#/
}

/*
	Name: register_carpenter_node
	Namespace: zm_powerups
	Checksum: 0xF534B13E
	Offset: 0x64D0
	Size: 0x5E
	Parameters: 2
	Flags: None
*/
function register_carpenter_node(node, callback)
{
	if(!isdefined(level._additional_carpenter_nodes))
	{
		level._additional_carpenter_nodes = [];
	}
	node._post_carpenter_callback = callback;
	level._additional_carpenter_nodes[level._additional_carpenter_nodes.size] = node;
}

/*
	Name: func_should_never_drop
	Namespace: zm_powerups
	Checksum: 0x461E0D7
	Offset: 0x6538
	Size: 0x6
	Parameters: 0
	Flags: Linked
*/
function func_should_never_drop()
{
	return 0;
}

/*
	Name: func_should_always_drop
	Namespace: zm_powerups
	Checksum: 0x2FD6754E
	Offset: 0x6548
	Size: 0x8
	Parameters: 0
	Flags: Linked
*/
function func_should_always_drop()
{
	return 1;
}

/*
	Name: powerup_emp
	Namespace: zm_powerups
	Checksum: 0x90AC393B
	Offset: 0x6558
	Size: 0x112
	Parameters: 0
	Flags: Linked
*/
function powerup_emp()
{
	self endon(#"powerup_timedout", #"powerup_grabbed");
	if(!zm_utility::should_watch_for_emp())
	{
		return;
	}
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"emp_detonate");
		if(distancesquared(waitresult.position, self.origin) < waitresult.radius * waitresult.radius)
		{
			playfx(level._effect[#"powerup_off"], self.origin);
			self thread powerup_delete_delayed();
			self notify(#"powerup_timedout");
		}
	}
}

/*
	Name: get_powerups
	Namespace: zm_powerups
	Checksum: 0xE4F557A2
	Offset: 0x6678
	Size: 0xE6
	Parameters: 2
	Flags: Linked
*/
function get_powerups(origin, radius)
{
	if(isdefined(origin) && isdefined(radius))
	{
		powerups = [];
		foreach(powerup in level.active_powerups)
		{
			if(distancesquared(origin, powerup.origin) < radius * radius)
			{
				powerups[powerups.size] = powerup;
			}
		}
		return powerups;
	}
	return level.active_powerups;
}

/*
	Name: should_award_stat
	Namespace: zm_powerups
	Checksum: 0xF4BB06D8
	Offset: 0x6768
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function should_award_stat(powerup_name)
{
	switch(powerup_name)
	{
		case "blue_monkey":
		case "bonus_points_player_shared":
		case "teller_withdrawl":
		case "wolf_bonus_hero_power":
		case "wolf_bonus_ammo":
		case "wolf_bonus_points":
		{
			return 0;
		}
	}
	if(isdefined(level.zombie_statless_powerups) && isdefined(level.zombie_statless_powerups[powerup_name]) && level.zombie_statless_powerups[powerup_name])
	{
		return 0;
	}
	return 1;
}

/*
	Name: teller_withdrawl
	Namespace: zm_powerups
	Checksum: 0x7370B018
	Offset: 0x6838
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function teller_withdrawl(powerup, player)
{
	player zm_score::add_to_player_score(powerup.value);
}

/*
	Name: function_cfd04802
	Namespace: zm_powerups
	Checksum: 0xB2EB6CAD
	Offset: 0x6878
	Size: 0x62
	Parameters: 1
	Flags: Linked
*/
function function_cfd04802(str_powerup)
{
	if(isdefined(level.zombie_powerups[str_powerup]) && (isdefined(level.zombie_powerups[str_powerup].only_affects_grabber) && level.zombie_powerups[str_powerup].only_affects_grabber))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_5091b029
	Namespace: zm_powerups
	Checksum: 0x3CA934E6
	Offset: 0x68E8
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_5091b029(str_powerup)
{
	self endon(#"disconnect");
	str_index_on = "zombie_powerup_" + str_powerup + "_on";
	str_index_time = "zombie_powerup_" + str_powerup + "_time";
	self zombie_utility::function_826f5e98(str_index_time, 30);
	if(self bgb::is_enabled(#"zm_bgb_temporal_gift"))
	{
		self zombie_utility::function_826f5e98(str_index_time, 60);
	}
	if(isdefined(self zombie_utility::function_73061b82(str_index_on)) && self zombie_utility::function_73061b82(str_index_on))
	{
		return;
	}
	self zombie_utility::function_826f5e98(str_index_on, 1);
	self thread function_de41121d(str_powerup);
}

/*
	Name: function_de41121d
	Namespace: zm_powerups
	Checksum: 0x418E123D
	Offset: 0x6A18
	Size: 0x164
	Parameters: 1
	Flags: Linked
*/
function function_de41121d(str_powerup)
{
	self endon(#"disconnect");
	str_index_on = "zombie_powerup_" + str_powerup + "_on";
	str_index_time = "zombie_powerup_" + str_powerup + "_time";
	str_sound_loop = "zmb_" + str_powerup + "_loop";
	str_sound_off = "zmb_" + str_powerup + "_loop_off";
	while(zombie_utility::function_73061b82(str_index_time) >= 0)
	{
		waitframe(1);
		self zombie_utility::function_826f5e98(str_index_time, zombie_utility::function_73061b82(str_index_time) - float(function_60d95f53()) / 1000);
	}
	self zombie_utility::function_826f5e98(str_index_on, 0);
	self playsoundtoplayer(str_sound_off, self);
	zombie_utility::function_826f5e98(str_index_time, 30);
}

/*
	Name: show_on_hud
	Namespace: zm_powerups
	Checksum: 0xFB5CD029
	Offset: 0x6B88
	Size: 0x144
	Parameters: 2
	Flags: Linked
*/
function show_on_hud(player_team, str_powerup)
{
	self endon(#"disconnect");
	str_index_on = "zombie_powerup_" + str_powerup + "_on";
	str_index_time = "zombie_powerup_" + str_powerup + "_time";
	if(zombie_utility::function_6403cf83(str_index_on, player_team))
	{
		zombie_utility::function_c7ab6cbc(str_index_time, player_team, 30);
		if(bgb::is_team_enabled(#"zm_bgb_temporal_gift"))
		{
			zombie_utility::function_c7ab6cbc(str_index_time, player_team, zombie_utility::function_6403cf83(str_index_time, player_team) + 30);
		}
		return;
	}
	zombie_utility::function_c7ab6cbc(str_index_on, player_team, 1);
	level thread time_remaining_on_powerup(player_team, str_powerup);
}

/*
	Name: time_remaining_on_powerup
	Namespace: zm_powerups
	Checksum: 0x74531A47
	Offset: 0x6CD8
	Size: 0x25C
	Parameters: 2
	Flags: Linked
*/
function time_remaining_on_powerup(player_team, str_powerup)
{
	str_index_on = "zombie_powerup_" + str_powerup + "_on";
	str_index_time = "zombie_powerup_" + str_powerup + "_time";
	str_sound_loop = "zmb_" + str_powerup + "_loop";
	str_sound_off = "zmb_" + str_powerup + "_loop_off";
	temp_ent = spawn("script_origin", (0, 0, 0));
	temp_ent playloopsound(str_sound_loop);
	if(bgb::is_team_enabled(#"zm_bgb_temporal_gift"))
	{
		zombie_utility::function_c7ab6cbc(str_index_time, player_team, zombie_utility::function_6403cf83(str_index_time, player_team) + 30);
	}
	while(zombie_utility::function_6403cf83(str_index_time, player_team) >= 0)
	{
		waitframe(1);
		zombie_utility::function_c7ab6cbc(str_index_time, player_team, zombie_utility::function_6403cf83(str_index_time, player_team) - 0.05);
	}
	zombie_utility::function_c7ab6cbc(str_index_on, player_team, 0);
	e_player = getplayers()[0];
	if(isplayer(e_player))
	{
		e_player playsoundtoteam(str_sound_off, player_team);
	}
	temp_ent stoploopsound(2);
	zombie_utility::function_c7ab6cbc(str_index_time, player_team, 30);
	temp_ent delete();
}

/*
	Name: weapon_powerup
	Namespace: zm_powerups
	Checksum: 0xDC724542
	Offset: 0x6F40
	Size: 0x1DC
	Parameters: 4
	Flags: None
*/
function weapon_powerup(ent_player, time, str_weapon, allow_cycling = 0)
{
	str_weapon_on = "zombie_powerup_" + str_weapon + "_on";
	str_weapon_time_over = str_weapon + "_time_over";
	ent_player notify(#"replace_weapon_powerup");
	ent_player._show_solo_hud = 1;
	ent_player.has_specific_powerup_weapon[str_weapon] = 1;
	ent_player.has_powerup_weapon = 1;
	ent_player zm_utility::increment_is_drinking();
	if(allow_cycling)
	{
		ent_player enableweaponcycling();
	}
	ent_player._zombie_weapon_before_powerup[str_weapon] = ent_player getcurrentweapon();
	ent_player giveweapon(level.zombie_powerup_weapon[str_weapon]);
	ent_player switchtoweapon(level.zombie_powerup_weapon[str_weapon]);
	ent_player.zombie_vars[str_weapon_on] = 1;
	level thread weapon_powerup_countdown(ent_player, str_weapon_time_over, time, str_weapon);
	level thread weapon_powerup_replace(ent_player, str_weapon_time_over, str_weapon);
	level thread weapon_powerup_change(ent_player, str_weapon_time_over, str_weapon);
}

/*
	Name: weapon_powerup_change
	Namespace: zm_powerups
	Checksum: 0x76ABE0C
	Offset: 0x7128
	Size: 0xE4
	Parameters: 3
	Flags: Linked
*/
function weapon_powerup_change(ent_player, str_gun_return_notify, str_weapon)
{
	ent_player endon(#"death", #"player_downed", str_gun_return_notify, #"replace_weapon_powerup");
	while(true)
	{
		waitresult = undefined;
		waitresult = ent_player waittill(#"weapon_change");
		if(waitresult.weapon != level.weaponnone && waitresult.weapon != level.zombie_powerup_weapon[str_weapon])
		{
			break;
		}
	}
	level thread weapon_powerup_remove(ent_player, str_gun_return_notify, str_weapon, 0);
}

/*
	Name: weapon_powerup_countdown
	Namespace: zm_powerups
	Checksum: 0x79F97B93
	Offset: 0x7218
	Size: 0x12C
	Parameters: 4
	Flags: Linked
*/
function weapon_powerup_countdown(ent_player, str_gun_return_notify, time, str_weapon)
{
	ent_player endon(#"death", #"player_downed", str_gun_return_notify, #"replace_weapon_powerup");
	str_weapon_time = "zombie_powerup_" + str_weapon + "_time";
	ent_player.zombie_vars[str_weapon_time] = time;
	if(bgb::is_team_enabled(#"zm_bgb_temporal_gift"))
	{
		ent_player.zombie_vars[str_weapon_time] = ent_player.zombie_vars[str_weapon_time] + 30;
	}
	[[level._custom_powerups[str_weapon].weapon_countdown]](ent_player, str_weapon_time);
	level thread weapon_powerup_remove(ent_player, str_gun_return_notify, str_weapon, 1);
}

/*
	Name: weapon_powerup_replace
	Namespace: zm_powerups
	Checksum: 0x5570FB13
	Offset: 0x7350
	Size: 0xEC
	Parameters: 3
	Flags: Linked
*/
function weapon_powerup_replace(ent_player, str_gun_return_notify, str_weapon)
{
	ent_player endon(#"death", #"player_downed", str_gun_return_notify);
	str_weapon_on = "zombie_powerup_" + str_weapon + "_on";
	ent_player waittill(#"replace_weapon_powerup");
	ent_player takeweapon(level.zombie_powerup_weapon[str_weapon]);
	ent_player.zombie_vars[str_weapon_on] = 0;
	ent_player.has_specific_powerup_weapon[str_weapon] = 0;
	ent_player.has_powerup_weapon = 0;
	ent_player zm_utility::decrement_is_drinking();
}

/*
	Name: weapon_powerup_remove
	Namespace: zm_powerups
	Checksum: 0xBFDABC23
	Offset: 0x7448
	Size: 0x134
	Parameters: 4
	Flags: Linked
*/
function weapon_powerup_remove(ent_player, str_gun_return_notify, str_weapon, b_switch_back_weapon = 1)
{
	ent_player endon(#"death", #"player_downed");
	str_weapon_on = "zombie_powerup_" + str_weapon + "_on";
	ent_player takeweapon(level.zombie_powerup_weapon[str_weapon]);
	ent_player.zombie_vars[str_weapon_on] = 0;
	ent_player._show_solo_hud = 0;
	ent_player.has_specific_powerup_weapon[str_weapon] = 0;
	ent_player.has_powerup_weapon = 0;
	ent_player notify(str_gun_return_notify);
	ent_player zm_utility::decrement_is_drinking();
	if(b_switch_back_weapon)
	{
		ent_player zm_weapons::switch_back_primary_weapon(ent_player._zombie_weapon_before_powerup[str_weapon]);
	}
}

/*
	Name: weapon_watch_gunner_downed
	Namespace: zm_powerups
	Checksum: 0xDA128D3E
	Offset: 0x7588
	Size: 0x152
	Parameters: 1
	Flags: None
*/
function weapon_watch_gunner_downed(str_weapon)
{
	str_notify = str_weapon + "_time_over";
	str_weapon_on = "zombie_powerup_" + str_weapon + "_on";
	if(!isdefined(self.has_specific_powerup_weapon) || (!(isdefined(self.has_specific_powerup_weapon[str_weapon]) && self.has_specific_powerup_weapon[str_weapon])))
	{
		return;
	}
	primaryweapons = self getweaponslistprimaries();
	for(i = 0; i < primaryweapons.size; i++)
	{
		if(primaryweapons[i] == level.zombie_powerup_weapon[str_weapon])
		{
			self takeweapon(level.zombie_powerup_weapon[str_weapon]);
		}
	}
	self notify(str_notify);
	self.zombie_vars[str_weapon_on] = 0;
	self._show_solo_hud = 0;
	waitframe(1);
	self.has_specific_powerup_weapon[str_weapon] = 0;
	self.has_powerup_weapon = 0;
}

/*
	Name: register_powerup
	Namespace: zm_powerups
	Checksum: 0x56AEA89B
	Offset: 0x76E8
	Size: 0xD6
	Parameters: 3
	Flags: Linked
*/
function register_powerup(str_powerup, func_grab_powerup, func_setup)
{
	/#
		assert(isdefined(str_powerup), "");
	#/
	_register_undefined_powerup(str_powerup);
	if(isdefined(func_grab_powerup))
	{
		if(!isdefined(level._custom_powerups[str_powerup].grab_powerup))
		{
			level._custom_powerups[str_powerup].grab_powerup = func_grab_powerup;
		}
	}
	if(isdefined(func_setup))
	{
		if(!isdefined(level._custom_powerups[str_powerup].setup_powerup))
		{
			level._custom_powerups[str_powerup].setup_powerup = func_setup;
		}
	}
}

/*
	Name: _register_undefined_powerup
	Namespace: zm_powerups
	Checksum: 0x7EFFBCFA
	Offset: 0x77C8
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function _register_undefined_powerup(str_powerup)
{
	if(!isdefined(level._custom_powerups))
	{
		level._custom_powerups = [];
	}
	if(!isdefined(level._custom_powerups[str_powerup]))
	{
		level._custom_powerups[str_powerup] = spawnstruct();
		include_zombie_powerup(str_powerup);
	}
}

/*
	Name: register_powerup_weapon
	Namespace: zm_powerups
	Checksum: 0x2439698D
	Offset: 0x7850
	Size: 0x8E
	Parameters: 2
	Flags: None
*/
function register_powerup_weapon(str_powerup, func_countdown)
{
	/#
		assert(isdefined(str_powerup), "");
	#/
	_register_undefined_powerup(str_powerup);
	if(isdefined(func_countdown))
	{
		if(!isdefined(level._custom_powerups[str_powerup].weapon_countdown))
		{
			level._custom_powerups[str_powerup].weapon_countdown = func_countdown;
		}
	}
}

