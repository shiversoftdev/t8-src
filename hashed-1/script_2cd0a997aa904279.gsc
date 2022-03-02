// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_174ebb9642933bf7;
#using script_3f9e0dc8454d98e1;
#using script_58c342edd81589fb;
#using script_59a783d756554a80;
#using script_6ce38ab036223e6e;
#using script_71b31a94cdaeca53;
#using script_ab862743b3070a;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_c71ecd1b;

/*
	Name: init
	Namespace: namespace_c71ecd1b
	Checksum: 0x18BCA6AC
	Offset: 0x140
	Size: 0x334
	Parameters: 0
	Flags: Linked
*/
function init()
{
	if(zm_utility::is_classic())
	{
		namespace_c402654::function_aec3446d(0);
		level.var_2f14be05 = 15;
		level.var_35a23da4 = 25;
		namespace_c3287616::function_376e51ef(#"nova_crawler");
		namespace_c3287616::function_376e51ef(#"zombie_dog", level.var_2f14be05);
		level.var_819e7dfd[#"zombie_dog"].var_87ed2709 = &function_6fa16bd2;
	}
	else
	{
		if(zm_utility::is_trials())
		{
			level.var_2f14be05 = 10;
			level.var_35a23da4 = 11;
			namespace_c3287616::function_376e51ef(#"nova_crawler");
			namespace_c3287616::function_376e51ef(#"zombie_dog", level.var_2f14be05);
			level.dog_round_track_override = &namespace_c402654::function_246a0760;
			namespace_c402654::function_aec3446d(0);
			level.var_807ffa2e = &namespace_df88241c::function_5b0522fa;
			namespace_df88241c::function_c44636f2(0);
			namespace_c3287616::function_df803678(&namespace_c402654::function_ed67c5e7);
		}
		else if(zm_utility::is_standard())
		{
			level.var_2f14be05 = 10;
			level.var_35a23da4 = 15;
		}
	}
	level.var_819e7dfd[#"nova_crawler"].var_ef500cb7 = &crawler_round_spawn;
	level.var_819e7dfd[#"nova_crawler"].var_87ed2709 = &function_dd836251;
	level flag::init(#"nova_crawlers_round");
	level flag::init(#"hash_2a1fc2e349c48462");
	callback::function_189f87c1(&function_5b22eecf);
	if(zm_utility::is_trials())
	{
		namespace_c3287616::function_2876740e(#"nova_crawler", &function_6f502b52);
	}
	else
	{
		namespace_c3287616::function_2876740e(#"nova_crawler", &function_f3f325cb);
	}
}

/*
	Name: function_f3f325cb
	Namespace: namespace_c71ecd1b
	Checksum: 0xE2936ABE
	Offset: 0x480
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_f3f325cb(var_148cc603)
{
	return int(0.3 * level.var_38b15968);
}

/*
	Name: function_6f502b52
	Namespace: namespace_c71ecd1b
	Checksum: 0xA62312FA
	Offset: 0x4C0
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function function_6f502b52(var_148cc603)
{
	if(level.round_number === 12)
	{
		return int(0.75 * level.var_38b15968);
	}
	return int(0.3 * level.var_38b15968);
}

/*
	Name: function_6fa16bd2
	Namespace: namespace_c71ecd1b
	Checksum: 0xAA6A3E02
	Offset: 0x538
	Size: 0x8A
	Parameters: 2
	Flags: Linked
*/
function function_6fa16bd2(b_force_spawn = 0, var_eb3a8721)
{
	if(level flag::get(#"nova_crawlers_round"))
	{
		b_result = function_fe3507a6();
	}
	else
	{
		b_result = namespace_c402654::function_62db7b1c(b_force_spawn, var_eb3a8721);
	}
	return b_result;
}

/*
	Name: function_a409c2a7
	Namespace: namespace_c71ecd1b
	Checksum: 0x928BCC2F
	Offset: 0x5D0
	Size: 0x49E
	Parameters: 1
	Flags: Linked
*/
function function_a409c2a7(e_target)
{
	if(namespace_df88241c::function_4748fb49() >= namespace_df88241c::function_59257d57())
	{
		return undefined;
	}
	if(level.zm_loc_types[#"dog_location"].size > 0)
	{
		zone_tag = e_target zm_zonemgr::get_player_zone();
		if(!isdefined(zone_tag))
		{
			return undefined;
		}
		var_c61e7ea7 = level.zones[zone_tag];
		adj_zone_names = getarraykeys(var_c61e7ea7.adjacent_zones);
		var_2057a8c1 = array(var_c61e7ea7.name);
		foreach(zone_name in adj_zone_names)
		{
			if(var_c61e7ea7.adjacent_zones[zone_name].is_connected)
			{
				if(!isdefined(var_2057a8c1))
				{
					var_2057a8c1 = [];
				}
				else if(!isarray(var_2057a8c1))
				{
					var_2057a8c1 = array(var_2057a8c1);
				}
				var_2057a8c1[var_2057a8c1.size] = level.zones[zone_name].name;
			}
		}
		var_905a9429 = [];
		var_51fb0ec7 = [];
		foreach(loc in level.zm_loc_types[#"dog_location"])
		{
			if(array::contains(var_2057a8c1, loc.zone_name))
			{
				var_e3c2bfe4 = distancesquared(loc.origin, e_target.origin);
				if(var_e3c2bfe4 < 9000000)
				{
					if(var_e3c2bfe4 > 250000)
					{
						if(!isdefined(var_905a9429))
						{
							var_905a9429 = [];
						}
						else if(!isarray(var_905a9429))
						{
							var_905a9429 = array(var_905a9429);
						}
						var_905a9429[var_905a9429.size] = loc;
						continue;
					}
					if(var_e3c2bfe4 > 10000)
					{
						if(!isdefined(var_51fb0ec7))
						{
							var_51fb0ec7 = [];
						}
						else if(!isarray(var_51fb0ec7))
						{
							var_51fb0ec7 = array(var_51fb0ec7);
						}
						var_51fb0ec7[var_51fb0ec7.size] = loc;
					}
				}
			}
		}
		if(var_905a9429.size < 3)
		{
			var_905a9429 = arraycombine(var_905a9429, var_51fb0ec7, 0, 0);
		}
		s_spawn_loc = array::random(var_905a9429);
	}
	if(!isdefined(s_spawn_loc))
	{
		return undefined;
	}
	ai = zombie_utility::spawn_zombie(level.nova_crawler_spawner);
	if(isdefined(ai))
	{
		ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
		ai thread zombie_utility::round_spawn_failsafe();
		ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
		ai ghost();
		s_spawn_loc thread function_13f107c4(ai, s_spawn_loc);
		ai.favoriteenemy = e_target;
	}
	return ai;
}

/*
	Name: function_13f107c4
	Namespace: namespace_c71ecd1b
	Checksum: 0x689410A3
	Offset: 0xA78
	Size: 0x288
	Parameters: 2
	Flags: Linked
*/
function function_13f107c4(ai, ent)
{
	ai endon(#"death");
	ai val::set(#"crawler_spawn", "allowdeath", 0);
	ai setfreecameralockonallowed(0);
	wait(1);
	ai clientfield::increment("crawler_portal_spawn_fx");
	wait(1.5);
	playsoundatposition(#"evt_teleporter_go", ent.origin);
	if(isdefined(ai.favoriteenemy))
	{
		angle = vectortoangles(ai.favoriteenemy.origin - ent.origin);
		angles = (ai.angles[0], angle[1], ai.angles[2]);
	}
	else
	{
		angles = ent.angles;
	}
	ai dontinterpolate();
	ai forceteleport(ent.origin, angles);
	/#
		assert(isdefined(ai), "");
	#/
	/#
		assert(isalive(ai), "");
	#/
	ai val::reset(#"crawler_spawn", "allowdeath");
	wait(0.1);
	ai show();
	ai setfreecameralockonallowed(1);
	ai val::reset(#"crawler_spawn", "ignoreme");
	ai notify(#"spawn_complete");
	ai notify(#"visible");
}

/*
	Name: function_6b3512d
	Namespace: namespace_c71ecd1b
	Checksum: 0xAC08CEEF
	Offset: 0xD08
	Size: 0x29C
	Parameters: 0
	Flags: Linked
*/
function function_6b3512d()
{
	level.var_4b9c09fd = 40;
	level.var_a3e1adc4 = 40;
	level flag::set(#"nova_crawlers_round");
	level flag::set(#"hash_2a1fc2e349c48462");
	level flag::init(#"hash_429b6157c77015a2");
	while(isdefined(level.intermission) && level.intermission)
	{
		wait(1);
	}
	wait(0.1);
	level.zombie_total = level.zombie_total + 40;
	if(isdefined(level.var_e2aef122))
	{
		level.var_e2aef122 = level.var_e2aef122 + 40;
	}
	level.var_dc22f98 = level.fn_custom_round_ai_spawn;
	level.fn_custom_round_ai_spawn = &function_fe02a12f;
	callback::on_ai_killed(&function_9fb978f);
	level thread function_2ce54724();
	callback::on_ai_killed(&function_8c040be2);
	level flag::wait_till_clear(#"nova_crawlers_round");
	level.fn_custom_round_ai_spawn = level.var_dc22f98;
	callback::remove_on_ai_killed(&function_9fb978f);
	if(level.round_number < level.var_35a23da4)
	{
		level flag::clear(#"hash_2a1fc2e349c48462");
	}
	level flag::wait_till(#"hash_429b6157c77015a2");
	callback::remove_on_ai_killed(&function_8c040be2);
	e_player = namespace_8f53e87b::function_d62aaf66();
	if(isdefined(e_player))
	{
		e_player thread zm_audio::create_and_play_dialog(#"generic", #"response_positive");
	}
}

/*
	Name: function_dd836251
	Namespace: namespace_c71ecd1b
	Checksum: 0x201BC9E2
	Offset: 0xFB0
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_dd836251()
{
	e_target = namespace_df88241c::function_a5abd591();
	if(isdefined(e_target) && level flag::get(#"hash_2a1fc2e349c48462"))
	{
		if(namespace_47276bad::function_35babccd(e_target) < 3)
		{
			ai = function_a409c2a7(e_target);
		}
		else
		{
			ai = namespace_df88241c::function_87348a88(e_target);
		}
	}
	else
	{
		ai = namespace_df88241c::spawn_nova_crawler();
	}
	return ai;
}

/*
	Name: crawler_round_spawn
	Namespace: namespace_c71ecd1b
	Checksum: 0x84A871FD
	Offset: 0x1070
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function crawler_round_spawn()
{
	ai = function_dd836251();
	if(isdefined(ai))
	{
		level.zombie_total--;
		return true;
	}
	return false;
}

/*
	Name: function_5b22eecf
	Namespace: namespace_c71ecd1b
	Checksum: 0xA6636E50
	Offset: 0x10B8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_5b22eecf()
{
	if(level.round_number > level.var_35a23da4 - 2)
	{
		level flag::set(#"hash_2a1fc2e349c48462");
		callback::function_ec6dfc37(&function_5b22eecf);
	}
}

/*
	Name: function_fe3507a6
	Namespace: namespace_c71ecd1b
	Checksum: 0xFF50C2ED
	Offset: 0x1128
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_fe3507a6()
{
	ai = function_dd836251();
	if(isdefined(ai))
	{
		ai.var_faab7250 = 1;
		ai._starting_round_number = ai._starting_round_number + 15;
		level.var_4b9c09fd--;
	}
	return ai;
}

/*
	Name: function_fe02a12f
	Namespace: namespace_c71ecd1b
	Checksum: 0x43A0EC37
	Offset: 0x1198
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_fe02a12f()
{
	ai = function_fe3507a6();
	if(isdefined(ai))
	{
		level.zombie_total--;
		return true;
	}
	return false;
}

/*
	Name: function_2ce54724
	Namespace: namespace_c71ecd1b
	Checksum: 0x4D304977
	Offset: 0x11E0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_2ce54724()
{
	while(level.var_4b9c09fd > 0)
	{
		level flag::wait_till_clear(#"hash_26e9fe6561459de3");
		wait(0.1);
	}
	level flag::clear(#"nova_crawlers_round");
}

/*
	Name: function_9fb978f
	Namespace: namespace_c71ecd1b
	Checksum: 0x5E54C865
	Offset: 0x1250
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_9fb978f(s_params)
{
	if(self.var_c39323b5 === 1 && self.archetype === #"nova_crawler" && (isdefined(self.var_faab7250) && self.var_faab7250))
	{
		level.var_4b9c09fd++;
	}
}

/*
	Name: function_8c040be2
	Namespace: namespace_c71ecd1b
	Checksum: 0x8516BD6A
	Offset: 0x12C0
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_8c040be2(s_params)
{
	if(!isdefined(self.var_c39323b5) && self.archetype === #"nova_crawler" && (isdefined(self.var_faab7250) && self.var_faab7250))
	{
		level.var_a3e1adc4--;
		if(level.var_a3e1adc4 <= 0)
		{
			level flag::set(#"hash_429b6157c77015a2");
		}
	}
}

