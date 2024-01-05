// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\weapons\zm_weap_tomahawk.gsc;
#using scripts\zm\weapons\zm_weap_flamethrower.gsc;
#using scripts\zm\weapons\zm_weap_katana.gsc;
#using scripts\zm\weapons\zm_weap_spectral_shield.gsc;
#using script_668c4fbb94671fb4;
#using scripts\zm\zm_escape_util.gsc;
#using scripts\zm_common\ai\zm_ai_utility.gsc;
#using script_ab862743b3070a;
#using scripts\zm_common\zm_zonemgr.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_sq.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm_common\zm_cleanup_mgr.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\ai\zombie_death.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace pebble;

/*
	Name: __init__system__
	Namespace: pebble
	Checksum: 0xEBD52B1
	Offset: 0x638
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_escape_pebble", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: pebble
	Checksum: 0x61F2306D
	Offset: 0x688
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_clientfield();
	init_flags();
	function_ec9e5cf2();
}

/*
	Name: __main__
	Namespace: pebble
	Checksum: 0xE8763638
	Offset: 0x6C8
	Size: 0x22C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level flag::wait_till(#"all_players_spawned");
	level thread function_d74dcf11();
	level thread function_27c26acb();
	if(zm_utility::is_ee_enabled())
	{
		zm_sq::start(#"jump_scare");
		zm_sq::start(#"drawings");
		zm_sq::start(#"narrative_room");
		zm_sq::start(#"laundry_day");
		level thread function_90dac8fa();
	}
	if(zm_utility::is_ee_enabled())
	{
		level thread function_24089629();
	}
	else
	{
		hidemiscmodels("narmod");
		a_s_logs = struct::get_array("s_a_lo");
		foreach(s_log in a_s_logs)
		{
			if(isdefined(s_log.target))
			{
				var_6dd8721 = getentarray(s_log.target, "targetname");
				array::delete_all(var_6dd8721);
			}
		}
	}
	level thread function_f5a3ba79();
}

/*
	Name: init_clientfield
	Namespace: pebble
	Checksum: 0x3C28FAF2
	Offset: 0x900
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function init_clientfield()
{
	clientfield::register("actor", "" + #"hash_7792af358100c735", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_f2d0b920043dbbd", 1, 1, "counter");
	clientfield::register("world", "" + #"narrative_room", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_46dbc12bdc275121", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_59623b8b4fc694c8", 1, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_ce418c45d804842", 1, 1, "counter");
}

/*
	Name: init_flags
	Namespace: pebble
	Checksum: 0x43B92889
	Offset: 0xA90
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_731f4115fe0cbef");
}

/*
	Name: function_ec9e5cf2
	Namespace: pebble
	Checksum: 0xE7E6DEF7
	Offset: 0xAC0
	Size: 0x594
	Parameters: 0
	Flags: Linked
*/
function function_ec9e5cf2()
{
	zm_sq::register(#"jump_scare", #"1", #"hash_3203b932029a4e0b", &jump_scare, &jump_scare_cleanup);
	zm_sq::register(#"drawings", #"1", #"drawings_quest", &function_cb19e12a, &drawings_cleanup);
	zm_sq::register(#"narrative_room", #"1", #"hash_64d6af5ddc324d26", &function_6f55d670, &function_13c87ace);
	zm_sq::register(#"narrative_room", #"2", #"hash_3f567f217222e5b2", &narrative_room, &narrative_room_cleanup);
	zm_sq::register(#"hash_e1a54725ab6e00b", #"hash_66e936afdcdd5d4d", #"hash_574005386f679cf6", &function_21d4e9e9, &function_e7aa5f07);
	zm_sq::register(#"hash_e1a54725ab6e00b", #"hash_385585cb6cbead68", #"hash_574004386f679b43", &function_14154e6a, &function_8d4b5efe);
	zm_sq::register(#"hash_e1a54725ab6e00b", #"hash_42a50f35aa200869", #"hash_574003386f679990", &function_bd0aa04e, &function_13ebfa5e);
	zm_sq::register(#"monkey_bomb", #"hash_438156183f3f5ffa", #"monkey_bomb_step_1", &function_71e9c5c6, &function_6bb97cee);
	zm_sq::register(#"monkey_bomb", #"hash_bf8e42b419290b3", #"monkey_bomb_step_2", &function_63afa952, &function_bec90157);
	zm_sq::register(#"laundry_day", #"1", #"hash_77cae6c10f2939fa", &laundry_day, &laundry_day_cleanup);
	if(zm_custom::function_901b751c(#"zmequipmentisenabled") && !zm_utility::is_standard())
	{
		if(!isdefined(level.a_tomahawk_pickup_funcs))
		{
			level.a_tomahawk_pickup_funcs = [];
		}
		else if(!isarray(level.a_tomahawk_pickup_funcs))
		{
			level.a_tomahawk_pickup_funcs = array(level.a_tomahawk_pickup_funcs);
		}
		level.a_tomahawk_pickup_funcs[level.a_tomahawk_pickup_funcs.size] = &function_1f75f759;
		if(!isdefined(level.a_tomahawk_pickup_funcs))
		{
			level.a_tomahawk_pickup_funcs = [];
		}
		else if(!isarray(level.a_tomahawk_pickup_funcs))
		{
			level.a_tomahawk_pickup_funcs = array(level.a_tomahawk_pickup_funcs);
		}
		level.a_tomahawk_pickup_funcs[level.a_tomahawk_pickup_funcs.size] = &function_68a561a5;
		zm_sq::start(#"hash_e1a54725ab6e00b");
	}
	if(zm_custom::function_901b751c(#"zmequipmentisenabled") && !zm_utility::is_standard())
	{
		zm_sq::start(#"monkey_bomb", 1);
	}
}

/*
	Name: on_player_connect
	Namespace: pebble
	Checksum: 0x31A2B92F
	Offset: 0x1060
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self thread track_player_eyes();
}

/*
	Name: function_6f55d670
	Namespace: pebble
	Checksum: 0xD1DC2457
	Offset: 0x1088
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_6f55d670(var_a276c861)
{
	level waittill(#"fake_waittill");
}

/*
	Name: function_13c87ace
	Namespace: pebble
	Checksum: 0xB08D1864
	Offset: 0x10B8
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_13c87ace(var_a276c861, var_19e802fa)
{
}

/*
	Name: narrative_room
	Namespace: pebble
	Checksum: 0xEBD08455
	Offset: 0x10D8
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function narrative_room(var_a276c861)
{
	level flag::set(#"activate_infirmury");
	mdl_door = getent("cr_door", "targetname");
	mdl_door rotateyaw(90, 1.6);
	var_3400a741 = getentarray("cr_door_bar", "targetname");
	array::run_all(var_3400a741, &delete);
	level clientfield::set("" + #"narrative_room", 1);
}

/*
	Name: narrative_room_cleanup
	Namespace: pebble
	Checksum: 0x4E38EBDF
	Offset: 0x11D8
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function narrative_room_cleanup(var_a276c861, var_19e802fa)
{
}

/*
	Name: function_d74dcf11
	Namespace: pebble
	Checksum: 0x60092BC4
	Offset: 0x11F8
	Size: 0x31E
	Parameters: 0
	Flags: Linked
*/
function function_d74dcf11()
{
	var_d0686fde = array("double_points", "full_ammo", "insta_kill");
	if(!zm_custom::function_901b751c("zmPowerupDouble"))
	{
		arrayremovevalue(var_d0686fde, "double_points");
	}
	if(!zm_custom::function_901b751c("zmPowerupMaxAmmo"))
	{
		arrayremovevalue(var_d0686fde, "full_ammo");
	}
	if(!zm_custom::function_901b751c("zmPowerupInstakill"))
	{
		arrayremovevalue(var_d0686fde, "insta_kill");
	}
	if(var_d0686fde.size == 0 || zm_utility::is_standard())
	{
		return;
	}
	if(var_d0686fde.size == 1)
	{
		str_value = var_d0686fde[0];
		if(!isdefined(var_d0686fde))
		{
			var_d0686fde = [];
		}
		else if(!isarray(var_d0686fde))
		{
			var_d0686fde = array(var_d0686fde);
		}
		var_d0686fde[var_d0686fde.size] = str_value;
	}
	var_d0686fde = array::randomize(var_d0686fde);
	for(i = 1; i <= 2; i++)
	{
		var_5bb38717 = struct::get("powerup_cell_" + i, "targetname");
		var_5bb38717.var_ce471a57 = var_d0686fde[i - 1];
		var_74e47e53 = level.zombie_powerups[var_d0686fde[i - 1]].model_name;
		var_2f217f28 = util::spawn_model(var_74e47e53, var_5bb38717.origin + vectorscale((0, 0, 1), 40), var_5bb38717.angles);
		var_2f217f28 thread function_468c20be();
		var_2f217f28 clientfield::set("powerup_fx", 1);
		var_5bb38717.var_2f217f28 = var_2f217f28;
		var_da5e0bea = getent("cell_shock_box_" + i, "script_string");
		var_da5e0bea thread function_13ee3d14(i, var_5bb38717);
	}
}

/*
	Name: function_13ee3d14
	Namespace: pebble
	Checksum: 0x9B4B127
	Offset: 0x1520
	Size: 0x15E
	Parameters: 2
	Flags: Linked
*/
function function_13ee3d14(n_index, var_5bb38717)
{
	self waittill(#"hash_7e1d78666f0be68b");
	var_5bb38717.var_2f217f28 notify(#"finish_wobble");
	var_5bb38717.var_2f217f28 delete();
	spawn_infinite_powerup_drop(var_5bb38717.origin, var_5bb38717.var_ce471a57);
	mdl_door = getent("powerup_cell_door_" + n_index, "targetname");
	if(n_index == 1)
	{
		mdl_door movex(36, 2, 1);
	}
	else if(n_index == 2)
	{
		mdl_door movex(-34, 2, 1);
	}
	playsoundatposition(#"hash_2903807228236fbc", mdl_door.origin);
	self notify(#"hash_7f8e7011812dff48");
}

/*
	Name: spawn_infinite_powerup_drop
	Namespace: pebble
	Checksum: 0xD72BC4CB
	Offset: 0x1688
	Size: 0x5A
	Parameters: 2
	Flags: Linked
*/
function spawn_infinite_powerup_drop(v_origin, str_type)
{
	level._powerup_timeout_override = &function_dbd6f582;
	e_powerup = zm_powerups::specific_powerup_drop(str_type, v_origin);
	level._powerup_timeout_override = undefined;
}

/*
	Name: function_dbd6f582
	Namespace: pebble
	Checksum: 0x80F724D1
	Offset: 0x16F0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_dbd6f582()
{
}

/*
	Name: function_468c20be
	Namespace: pebble
	Checksum: 0x5A18C99C
	Offset: 0x1700
	Size: 0x38
	Parameters: 0
	Flags: Linked
*/
function function_468c20be()
{
	self endon(#"finish_wobble");
	while(isdefined(self))
	{
		self zm_escape_util::make_wobble();
	}
}

/*
	Name: jump_scare
	Namespace: pebble
	Checksum: 0x42233398
	Offset: 0x1740
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function jump_scare(var_a276c861)
{
	foreach(player in level.players)
	{
		player thread track_player_eyes();
	}
	callback::on_connect(&on_player_connect);
}

/*
	Name: track_player_eyes
	Namespace: pebble
	Checksum: 0x5B800F02
	Offset: 0x17F8
	Size: 0x210
	Parameters: 0
	Flags: Linked
*/
function track_player_eyes()
{
	self notify(#"track_player_eyes");
	self endon(#"disconnect", #"track_player_eyes");
	b_saw_the_wth = 0;
	var_616e76c5 = struct::get("s_sq_wth", "targetname");
	while(!b_saw_the_wth)
	{
		for(n_time = 0; self adsbuttonpressed() && n_time < 25; n_time++)
		{
			waitframe(1);
		}
		if(n_time >= 25 && self adsbuttonpressed() && self zm_zonemgr::entity_in_zone("zone_catwalk_03") && is_weapon_sniper(self getcurrentweapon()) && self zm_utility::is_player_looking_at(var_616e76c5.origin, 0.9975, 0, self))
		{
			self zm_utility::do_player_general_vox("general", "scare_react", undefined, 100);
			self clientfield::increment_to_player("" + #"hash_f2d0b920043dbbd", 1);
			for(j_time = 0; self adsbuttonpressed() && j_time < 5; j_time++)
			{
				waitframe(1);
			}
			b_saw_the_wth = 1;
		}
		waitframe(1);
	}
}

/*
	Name: is_weapon_sniper
	Namespace: pebble
	Checksum: 0x89FA8968
	Offset: 0x1A10
	Size: 0xC0
	Parameters: 1
	Flags: Linked, Private
*/
function private is_weapon_sniper(w_weapon)
{
	if(isdefined(w_weapon.issniperweapon) && w_weapon.issniperweapon)
	{
		if(weaponhasattachment(w_weapon, "elo") || weaponhasattachment(w_weapon, "reflex") || weaponhasattachment(w_weapon, "holo") || weaponhasattachment(w_weapon, "is"))
		{
			return false;
		}
		return true;
	}
	return false;
}

/*
	Name: jump_scare_cleanup
	Namespace: pebble
	Checksum: 0x9E314F9F
	Offset: 0x1AD8
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function jump_scare_cleanup(var_a276c861, var_19e802fa)
{
}

/*
	Name: laundry_day
	Namespace: pebble
	Checksum: 0x3705A367
	Offset: 0x1AF8
	Size: 0x17C
	Parameters: 1
	Flags: Linked
*/
function laundry_day(var_a276c861)
{
	s_dryer = struct::get("s_laundry_day", "targetname");
	s_dryer.t_damage = spawn("trigger_damage", s_dryer.origin, 0, 64, 64);
	var_57724709 = 0;
	while(true)
	{
		s_result = undefined;
		s_result = s_dryer.t_damage waittill(#"damage");
		if(isplayer(s_result.attacker))
		{
			s_dryer.t_damage playsound(#"hash_33b90d54346e57e" + var_57724709);
			var_57724709++;
			wait(8.1);
		}
		if(var_57724709 >= 3)
		{
			break;
		}
	}
	s_dryer.t_damage delete();
	level thread zm_audio::sndmusicsystem_stopandflush();
	waitframe(1);
	level thread zm_audio::sndmusicsystem_playstate("ee_song_2");
}

/*
	Name: laundry_day_cleanup
	Namespace: pebble
	Checksum: 0xFB674D70
	Offset: 0x1C80
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function laundry_day_cleanup(var_a276c861, var_19e802fa)
{
	s_dryer = struct::get("s_laundry_day", "targetname");
	if(isdefined(s_dryer.t_damage))
	{
		s_dryer.t_damage delete();
	}
}

/*
	Name: function_cb19e12a
	Namespace: pebble
	Checksum: 0x6E94F9AA
	Offset: 0x1CF8
	Size: 0x174
	Parameters: 1
	Flags: Linked
*/
function function_cb19e12a(var_a276c861)
{
	if(zm_utility::is_ee_enabled())
	{
		level thread function_35a7187c();
		level thread function_7f53281f();
		level thread function_62878c3d();
		level thread function_83abdd2b();
		level thread function_c7c805fa();
	}
	else
	{
		hidemiscmodels("e_art");
		var_474ede10 = getent("graphic_01", "targetname");
		var_474ede10 delete();
		var_e33915d6 = getent("graphic_04", "targetname");
		var_e33915d6 delete();
		var_ffa14ea6 = getent("graphic_05", "targetname");
		var_ffa14ea6 delete();
	}
}

/*
	Name: drawings_cleanup
	Namespace: pebble
	Checksum: 0x2156C6CA
	Offset: 0x1E78
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function drawings_cleanup(var_a276c861, var_19e802fa)
{
}

/*
	Name: function_35a7187c
	Namespace: pebble
	Checksum: 0x567BA2F2
	Offset: 0x1E98
	Size: 0x1B4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_35a7187c()
{
	var_474ede10 = getent("graphic_01", "targetname");
	var_474ede10 setscale(0.7);
	var_3253d8db = getent("graphic_01_mover", "targetname");
	var_474ede10 linkto(var_3253d8db);
	t_damage = spawn("trigger_damage", var_3253d8db.origin, 0, 64, 64);
	v_end_pos = (-1052.89, 8901.02, 1362);
	while(true)
	{
		s_result = undefined;
		s_result = t_damage waittill(#"damage");
		if(isplayer(s_result.attacker))
		{
			if(zm_weap_flamethrower::is_flamethrower_weapon(s_result.weapon, 3) && isdefined(s_result.attacker.var_be72e7c2))
			{
				break;
			}
		}
	}
	var_3253d8db moveto(v_end_pos, 0.4);
	t_damage delete();
}

/*
	Name: function_7f53281f
	Namespace: pebble
	Checksum: 0x9FF304F3
	Offset: 0x2058
	Size: 0x1B4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_7f53281f()
{
	var_915a9896 = getent("graphic_02_mover", "targetname");
	t_damage = spawn("trigger_damage", var_915a9896.origin, 0, 64, 64);
	while(true)
	{
		s_result = undefined;
		s_result = t_damage waittill(#"damage");
		if(isplayer(s_result.attacker) && s_result.attacker hasperk(#"specialty_electriccherry"))
		{
			if(s_result.weapon == getweapon(#"spoon_alcatraz") || s_result.weapon == getweapon(#"spork_alcatraz") || s_result.weapon == getweapon(#"spknifeork"))
			{
				break;
			}
		}
	}
	var_915a9896 rotateyaw(-65.9, 0.4);
	t_damage delete();
}

/*
	Name: function_62878c3d
	Namespace: pebble
	Checksum: 0x6833419F
	Offset: 0x2218
	Size: 0x1BC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_62878c3d()
{
	var_a6fa1406 = getent("graphic_03_mover", "targetname");
	t_damage = spawn("trigger_damage", var_a6fa1406.origin + (vectorscale((0, 0, -1), 10)), 0, 64, 64);
	v_end_pos = (-432, 9110, 1397);
	v_end_angles = (38, 90, 0);
	while(true)
	{
		s_result = undefined;
		s_result = t_damage waittill(#"damage");
		if(isplayer(s_result.attacker))
		{
			if(s_result.weapon === getweapon(#"spork_alcatraz") || s_result.weapon == getweapon(#"spknifeork"))
			{
				break;
			}
		}
	}
	var_a6fa1406 moveto(v_end_pos, 0.4);
	var_a6fa1406 rotateto(v_end_angles, 0.4);
	t_damage delete();
}

/*
	Name: function_83abdd2b
	Namespace: pebble
	Checksum: 0x509EA2A
	Offset: 0x23E0
	Size: 0x12C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_83abdd2b()
{
	var_e33915d6 = getent("graphic_04", "targetname");
	t_damage = spawn("trigger_damage", var_e33915d6.origin - vectorscale((0, 0, 1), 30), 0, 64, 64);
	while(true)
	{
		s_result = undefined;
		s_result = t_damage waittill(#"damage");
		if(isplayer(s_result.attacker))
		{
			if(zm_weap_katana::function_c740060f(s_result.weapon, 2))
			{
				break;
			}
		}
	}
	var_e33915d6 movex(7.5, 0.4);
	t_damage delete();
}

/*
	Name: function_c7c805fa
	Namespace: pebble
	Checksum: 0x31A3F88A
	Offset: 0x2518
	Size: 0x10C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c7c805fa()
{
	var_ffa14ea6 = getent("graphic_05", "targetname");
	v_end_pos = (139.543, 6704.51, 98.597);
	while(true)
	{
		s_result = undefined;
		s_result = level waittill(#"hero_weapon_activated");
		if(isplayer(s_result.e_player) && distance2d(s_result.e_player.origin, var_ffa14ea6.origin) <= 128)
		{
			break;
		}
	}
	var_ffa14ea6 moveto(v_end_pos, 0.4);
}

/*
	Name: function_bdd1bac8
	Namespace: pebble
	Checksum: 0xD935C358
	Offset: 0x2630
	Size: 0x2EC
	Parameters: 1
	Flags: Linked
*/
function function_bdd1bac8(var_a1a0c2e3)
{
	level notify(#"hash_433df71d489240ab");
	level endon(#"hash_433df71d489240ab");
	level endoncallback(&function_96c2cea0, #"hash_3698278a3a5d8beb");
	self endoncallback(&function_96c2cea0, #"stop_damage", #"hash_6ce63d9afba84f4c");
	var_f67ecd64 = getent("box_lock", "targetname");
	if(!isdefined(var_f67ecd64) || var_f67ecd64 != var_a1a0c2e3)
	{
		return;
	}
	if(!zm_utility::is_ee_enabled())
	{
		return;
	}
	if(isdefined(var_f67ecd64.var_1e4fbc72) && var_f67ecd64.var_1e4fbc72)
	{
		return;
	}
	if(!isdefined(var_f67ecd64.n_start_time))
	{
		var_f67ecd64.n_start_time = gettime();
	}
	if(!isdefined(var_f67ecd64.var_2b6afc3c))
	{
		var_f67ecd64.var_2b6afc3c = 1;
	}
	var_21c1ba1 = self getentitynumber();
	var_f67ecd64 clientfield::set("" + #"hash_1b02e77fdbc51a4d", var_21c1ba1 + 1);
	while(true)
	{
		var_f67ecd64 waittill(#"hash_2afc3e42ad78d30e");
		n_time = gettime();
		if(isdefined(var_f67ecd64) && !isdefined(var_f67ecd64.var_1e4fbc72) && (n_time - var_f67ecd64.n_start_time) > 1000)
		{
			var_f67ecd64.var_1e4fbc72 = 1;
			var_f67ecd64 setmodel(#"hash_2ac3e09056fba532");
			var_f67ecd64 clientfield::set("" + #"hash_1b02e77fdbc51a4d", 0);
			foreach(e_player in level.activeplayers)
			{
				e_player thread function_6272b55b();
			}
		}
	}
}

/*
	Name: function_96c2cea0
	Namespace: pebble
	Checksum: 0x98B70D6E
	Offset: 0x2928
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_96c2cea0(str_notify)
{
	var_f67ecd64 = getent("box_lock", "targetname");
	if(!isdefined(var_f67ecd64))
	{
		return;
	}
	if(!isdefined(var_f67ecd64.var_1e4fbc72) && isdefined(var_f67ecd64.n_start_time))
	{
		var_f67ecd64.n_start_time = undefined;
	}
	if(isdefined(var_f67ecd64.var_2b6afc3c))
	{
		var_f67ecd64.var_2b6afc3c = undefined;
	}
	if(isdefined(var_f67ecd64.var_3d3748c4) && var_f67ecd64.var_3d3748c4)
	{
		var_f67ecd64.var_3d3748c4 = undefined;
	}
	if(isdefined(var_f67ecd64.var_d86e9c27))
	{
		var_f67ecd64.var_d86e9c27 = undefined;
	}
	var_f67ecd64 clientfield::set("" + #"hash_1b02e77fdbc51a4d", 0);
}

/*
	Name: function_6272b55b
	Namespace: pebble
	Checksum: 0x52B0CE39
	Offset: 0x2A40
	Size: 0x1A2
	Parameters: 0
	Flags: Linked
*/
function function_6272b55b()
{
	self endoncallback(&function_96c2cea0, #"disconnect");
	level endon(#"hash_3698278a3a5d8beb", #"hash_23a4d169a87154ff");
	var_f67ecd64 = getent("box_lock", "targetname");
	while(isdefined(var_f67ecd64))
	{
		s_result = undefined;
		s_result = self waittill(#"throwing_tomahawk");
		e_tomahawk = s_result.e_grenade;
		while(isdefined(e_tomahawk))
		{
			if(distancesquared(e_tomahawk.origin, var_f67ecd64.origin) < 10000 && (isdefined(var_f67ecd64.var_1e4fbc72) && var_f67ecd64.var_1e4fbc72) && !isdefined(var_f67ecd64.var_3d3748c4) && !self hasweapon(getweapon(#"zhield_spectral_dw_upgraded")))
			{
				var_f67ecd64.var_3d3748c4 = 1;
				var_f67ecd64.var_d86e9c27 = self;
				level notify(#"hash_23a4d169a87154ff");
			}
			else
			{
				waitframe(1);
			}
		}
	}
}

/*
	Name: function_68a561a5
	Namespace: pebble
	Checksum: 0xC39A48DD
	Offset: 0x2BF0
	Size: 0x1B4
	Parameters: 2
	Flags: Linked
*/
function function_68a561a5(e_grenade, n_grenade_charge_power)
{
	var_f67ecd64 = getent("box_lock", "targetname");
	if(!isdefined(var_f67ecd64))
	{
		return false;
	}
	if(isdefined(var_f67ecd64.var_3d3748c4) && var_f67ecd64.var_3d3748c4 && isplayer(var_f67ecd64.var_d86e9c27))
	{
		var_f67ecd64.var_3d3748c4 = 1;
		var_f67ecd64 ghost();
		level notify(#"hash_5002eab927d4056d");
		level thread zm_audio::sndannouncerplayvox(#"shield_upgrade", undefined, undefined, 2);
		var_6e6ec518 = zm_weap_tomahawk::tomahawk_spawn(e_grenade.origin);
		var_6e6ec518.n_grenade_charge_power = n_grenade_charge_power;
		var_8f83b2f6 = util::spawn_model(level.chest_joker_model, e_grenade.origin, var_f67ecd64.angles);
		var_8f83b2f6 linkto(var_6e6ec518);
		self thread zm_weap_tomahawk::tomahawk_return_player(var_6e6ec518, undefined, 800);
		self thread function_8996bf17(var_6e6ec518, var_8f83b2f6);
		return true;
	}
	return false;
}

/*
	Name: function_8996bf17
	Namespace: pebble
	Checksum: 0xF97726B1
	Offset: 0x2DB0
	Size: 0x174
	Parameters: 2
	Flags: Linked
*/
function function_8996bf17(var_6e6ec518, var_f67ecd64)
{
	self endon(#"disconnect");
	while(isdefined(var_6e6ec518))
	{
		waitframe(1);
	}
	var_f67ecd64 delete();
	if(self hasweapon(getweapon(#"zhield_spectral_dw")))
	{
		self takeweapon(getweapon(#"zhield_spectral_dw"));
	}
	self giveweapon(getweapon(#"zhield_spectral_dw_upgraded"));
	self switchtoweapon(getweapon(#"zhield_spectral_dw_upgraded"));
	self.var_5ba94c1e = 1;
	level thread zm_weap_spectral_shield::function_265e517c(self);
	self thread zm_audio::create_and_play_dialog(#"shield", #"upgrade", undefined, 1);
}

/*
	Name: function_21d4e9e9
	Namespace: pebble
	Checksum: 0x30B9C419
	Offset: 0x2F30
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function function_21d4e9e9(var_a276c861)
{
	if(zm_utility::is_ee_enabled())
	{
		callback::on_connect(&function_626dcd44);
	}
	/#
		level thread function_5bae5249();
	#/
	if(!var_a276c861)
	{
		var_b09af3eb = ("" + #"hash_574005386f679cf6") + "_";
		level waittill(var_b09af3eb + "completed", var_b09af3eb + "skipped_over", var_b09af3eb + "ended_early");
	}
}

/*
	Name: function_e7aa5f07
	Namespace: pebble
	Checksum: 0xFEC34A73
	Offset: 0x2FF0
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function function_e7aa5f07(var_a276c861, var_19e802fa)
{
	if(var_a276c861 || var_19e802fa)
	{
		foreach(e_player in level.activeplayers)
		{
			e_player flag::set(#"hash_18c7b52cebad7171");
		}
		callback::remove_on_ai_killed(&function_cbc49ed2);
	}
}

/*
	Name: function_626dcd44
	Namespace: pebble
	Checksum: 0x15A2FAA
	Offset: 0x30C8
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_626dcd44()
{
	self endon(#"disconnect");
	self.var_65f165e1 = 0;
	self flag::init(#"hash_46915cd7994e2d33");
	self flag::init(#"hash_18c7b52cebad7171");
	self flag::init(#"hash_120fbb364796cd32");
	self flag::init(#"hash_11ab20934759ebc3");
	while(!isdefined(self.var_67e1d531))
	{
		self.var_67e1d531 = self._gadgets_player[1];
		wait(1);
	}
	self flag::wait_till(#"hash_46915cd7994e2d33");
	self thread function_f8c71bba();
	level callback::on_ai_killed(&function_cbc49ed2);
}

/*
	Name: function_f8c71bba
	Namespace: pebble
	Checksum: 0xC8575798
	Offset: 0x3200
	Size: 0x232
	Parameters: 0
	Flags: Linked
*/
function function_f8c71bba()
{
	self endon(#"disconnect", #"hash_18c7b52cebad7171");
	a_s_urns = struct::get_array("mg_fire_urn", "targetname");
	var_1d7104d7 = [];
	foreach(s_urn in a_s_urns)
	{
		if(isdefined(s_urn.var_936d26df) && s_urn.var_936d26df)
		{
			if(!isdefined(var_1d7104d7))
			{
				var_1d7104d7 = [];
			}
			else if(!isarray(var_1d7104d7))
			{
				var_1d7104d7 = array(var_1d7104d7);
			}
			var_1d7104d7[var_1d7104d7.size] = s_urn;
		}
	}
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"throwing_tomahawk");
		e_tomahawk = s_result.e_grenade;
		self thread function_766c869a(e_tomahawk);
		if(!self zm_zonemgr::is_player_in_zone(array("zone_catwalk_03", "zone_catwalk_04")))
		{
			continue;
		}
		while(isdefined(e_tomahawk))
		{
			if(isdefined(self.var_67ea42af))
			{
				e_tomahawk clientfield::set("tomahawk_trail_fx", 2);
				self thread function_1877cfe4();
				break;
			}
			wait(0.1);
		}
	}
	return false;
}

/*
	Name: function_766c869a
	Namespace: pebble
	Checksum: 0x29D6F919
	Offset: 0x3440
	Size: 0xE0
	Parameters: 1
	Flags: Linked
*/
function function_766c869a(e_tomahawk)
{
	self notify(#"hash_381a1d8c3e2bdb50");
	self endon(#"disconnect", #"hash_18c7b52cebad7171", #"hash_381a1d8c3e2bdb50");
	var_e9d35a09 = getent("t_pebble_is_on_fire", "targetname");
	while(true)
	{
		if(self istouching(var_e9d35a09) || (isdefined(e_tomahawk) && e_tomahawk istouching(var_e9d35a09)))
		{
			self thread specimen_storage_orb_();
		}
		wait(0.1);
	}
}

/*
	Name: specimen_storage_orb_
	Namespace: pebble
	Checksum: 0xCCA16757
	Offset: 0x3528
	Size: 0x8E
	Parameters: 0
	Flags: Linked, Private
*/
function private specimen_storage_orb_()
{
	self notify("2b2c70e1dbc33e81" + #"hash_6cd90d6d3f75e742");
	self endon("2b2c70e1dbc33e81" + #"hash_6cd90d6d3f75e742");
	self endon(#"disconnect", #"hash_18c7b52cebad7171", #"hash_7c4e730154e3c002");
	self.var_67ea42af = 1;
	wait(25);
	self.var_67ea42af = undefined;
}

/*
	Name: function_1877cfe4
	Namespace: pebble
	Checksum: 0x90A9E366
	Offset: 0x35C0
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_1877cfe4(e_tomahawk)
{
	self notify(#"hash_67898531e66a70ff");
	self endon(#"disconnect", #"hash_18c7b52cebad7171", #"hash_67898531e66a70ff");
	var_76f21e6b = array("zone_catwalk_03", "zone_catwalk_04");
	while(true)
	{
		str_zone = self zm_zonemgr::get_player_zone();
		if(!isdefined(str_zone) || !array::contains(var_76f21e6b, str_zone))
		{
			/#
				iprintln("");
			#/
			self.var_67ea42af = undefined;
			self notify(#"hash_67898531e66a70ff");
			self notify(#"hash_7c4e730154e3c002");
		}
		wait(0.1);
	}
}

/*
	Name: function_cbc49ed2
	Namespace: pebble
	Checksum: 0x5EC4765A
	Offset: 0x36F0
	Size: 0x29C
	Parameters: 1
	Flags: Linked
*/
function function_cbc49ed2(s_params)
{
	if(self.archetype != #"zombie" && self.archetype != #"zombie_dog")
	{
		return;
	}
	if(!isplayer(s_params.eattacker) || !isdefined(s_params.eattacker.var_67ea42af))
	{
		return;
	}
	if(s_params.weapon != getweapon(#"tomahawk_t8"))
	{
		return;
	}
	str_zone_name = s_params.eattacker zm_zonemgr::get_player_zone();
	if(!issubstr(str_zone_name, "zone_catwalk"))
	{
		return;
	}
	if(isdefined(s_params.eattacker.var_67ea42af) && s_params.eattacker.var_67ea42af && !s_params.eattacker flag::get(#"hash_18c7b52cebad7171") && !isdefined(self.var_300aef34))
	{
		self thread zombie_death::flame_death_fx();
		self.var_300aef34 = 1;
		s_params.eattacker.var_65f165e1++;
		/#
			iprintln("" + s_params.eattacker.var_65f165e1);
		#/
		if(s_params.eattacker.var_65f165e1 >= 30)
		{
			s_params.eattacker flag::set(#"hash_18c7b52cebad7171");
			s_params.eattacker playsoundtoplayer(#"hash_6e048d37333004da", s_params.eattacker);
			s_params.eattacker thread function_dab3dcc3();
			s_params.eattacker.var_67ea42af = undefined;
			/#
				iprintln("");
			#/
		}
	}
}

/*
	Name: function_14154e6a
	Namespace: pebble
	Checksum: 0x7C869B27
	Offset: 0x3998
	Size: 0xE6
	Parameters: 1
	Flags: Linked
*/
function function_14154e6a(var_a276c861)
{
	foreach(e_player in level.activeplayers)
	{
		e_player thread function_dab3dcc3();
	}
	if(!var_a276c861)
	{
		var_b09af3eb = ("" + #"hash_574004386f679b43") + "_";
		level waittill(var_b09af3eb + "completed", var_b09af3eb + "skipped_over", var_b09af3eb + "ended_early");
	}
}

/*
	Name: function_8d4b5efe
	Namespace: pebble
	Checksum: 0x1678F99D
	Offset: 0x3A88
	Size: 0x198
	Parameters: 2
	Flags: Linked
*/
function function_8d4b5efe(var_a276c861, var_19e802fa)
{
	if(var_a276c861 || var_19e802fa)
	{
		foreach(e_player in level.activeplayers)
		{
			e_player flag::set(#"hash_120fbb364796cd32");
			if(isdefined(e_player.var_b4218648))
			{
				e_player.var_b4218648 delete();
			}
			if(isdefined(e_player.var_28a7de1b))
			{
				e_player.var_28a7de1b setvisibletoplayer(e_player);
			}
			if(e_player hasweapon(getweapon(#"tomahawk_t8")))
			{
				e_player takeweapon(getweapon(#"tomahawk_t8"));
				if(isdefined(e_player.var_67e1d531))
				{
					e_player giveweapon(e_player.var_67e1d531);
				}
			}
		}
	}
}

/*
	Name: function_dab3dcc3
	Namespace: pebble
	Checksum: 0xB9D07C07
	Offset: 0x3C28
	Size: 0x17C
	Parameters: 0
	Flags: Linked
*/
function function_dab3dcc3()
{
	self endon(#"disconnect");
	var_64de1b5a = struct::get_array("hr_step_2_glyph");
	var_c6b58daa = array::random(var_64de1b5a);
	while(isdefined(var_c6b58daa.e_owner))
	{
		var_c6b58daa = array::random(var_64de1b5a);
	}
	var_6eb21a54 = util::spawn_model(#"p8_zm_esc_dream_catcher_blue", var_c6b58daa.origin, var_c6b58daa.angles);
	var_c6b58daa.var_6eb21a54 = var_6eb21a54;
	var_c6b58daa.e_owner = self;
	var_c6b58daa.b_visible = 0;
	self.var_c6b58daa = var_c6b58daa;
	var_6eb21a54 setinvisibletoall();
	if(self.currentweapon == level.var_4e845c84 || self.currentweapon == level.var_58e17ce3)
	{
		var_c6b58daa.b_visible = 1;
		var_6eb21a54 setvisibletoplayer(self);
	}
	self thread function_4d6642e9(var_c6b58daa);
}

/*
	Name: function_4d6642e9
	Namespace: pebble
	Checksum: 0xE2C4E71A
	Offset: 0x3DB0
	Size: 0x138
	Parameters: 1
	Flags: Linked
*/
function function_4d6642e9(var_c6b58daa)
{
	self endoncallback(&function_1650b924, #"disconnect", #"hash_120fbb364796cd32");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"weapon_change");
		if(isdefined(var_c6b58daa.var_6eb21a54))
		{
			if(s_result.weapon == level.var_4e845c84 || s_result.weapon == level.var_58e17ce3)
			{
				var_c6b58daa.b_visible = 1;
				var_c6b58daa.var_6eb21a54 setvisibletoplayer(self);
			}
			else if(var_c6b58daa.b_visible)
			{
				wait(0.9);
				if(isdefined(var_c6b58daa.var_6eb21a54))
				{
					var_c6b58daa.b_visible = 0;
					var_c6b58daa.var_6eb21a54 setinvisibletoplayer(self);
				}
			}
		}
	}
}

/*
	Name: function_1650b924
	Namespace: pebble
	Checksum: 0x421A5C1E
	Offset: 0x3EF0
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function function_1650b924(str_notify)
{
	if(str_notify == "disconnect")
	{
		if(isdefined(self.var_c6b58daa))
		{
			if(isdefined(self.var_c6b58daa.var_6eb21a54))
			{
				self.var_c6b58daa.var_6eb21a54 delete();
			}
			self.var_c6b58daa.e_owner = undefined;
		}
	}
}

/*
	Name: function_1f75f759
	Namespace: pebble
	Checksum: 0xC1EF5FC9
	Offset: 0x3F68
	Size: 0x2E0
	Parameters: 2
	Flags: Linked
*/
function function_1f75f759(e_grenade, n_grenade_charge_power)
{
	if(!zm_utility::is_ee_enabled())
	{
		return false;
	}
	if(!self flag::get(#"hash_18c7b52cebad7171") || self flag::get(#"hash_120fbb364796cd32"))
	{
		return false;
	}
	var_e08ff605 = struct::get_array("hr_step_2_glyph");
	foreach(var_3e80eb94 in var_e08ff605)
	{
		if(!isdefined(var_3e80eb94.e_owner) || var_3e80eb94.e_owner != self)
		{
			continue;
		}
		if(distancesquared(e_grenade.origin, var_3e80eb94.var_6eb21a54.origin) < 10000)
		{
			var_3e80eb94 thread function_27ae51c4(self);
			var_3e80eb94.var_6eb21a54 delete();
			var_3e80eb94.var_6eb21a54 = undefined;
			var_3e80eb94.e_owner = undefined;
			self.var_c6b58daa = undefined;
			self notify(#"tomahawk_returned");
			if(isdefined(e_grenade))
			{
				e_grenade delete();
			}
			while(self function_55acff10())
			{
				waitframe(1);
			}
			self takeweapon(getweapon(#"tomahawk_t8"));
			if(isdefined(self.var_67e1d531))
			{
				self giveweapon(self.var_67e1d531);
				self thread zm_audio::create_and_play_dialog(#"ax", #"lost", undefined, 1);
			}
			self playsoundtoplayer(#"hash_6e048d37333004da", self);
			self flag::set(#"hash_120fbb364796cd32");
			return true;
		}
	}
	return false;
}

/*
	Name: function_27ae51c4
	Namespace: pebble
	Checksum: 0xFD30B8E4
	Offset: 0x4250
	Size: 0x184
	Parameters: 1
	Flags: Linked
*/
function function_27ae51c4(e_player)
{
	s_angles = struct::get(self.target);
	if(isdefined(s_angles))
	{
		mdl_fx = util::spawn_model("tag_origin", self.origin, s_angles.angles);
	}
	else
	{
		mdl_fx = util::spawn_model("tag_origin", self.origin, self.angles);
	}
	mdl_fx setinvisibletoall();
	if(isplayer(e_player) && isalive(e_player))
	{
		mdl_fx setvisibletoplayer(e_player);
	}
	playsoundatposition(#"hash_6f61076a871fcbab", mdl_fx.origin);
	mdl_fx clientfield::set("" + #"hash_46dbc12bdc275121", 1);
	wait(5);
	mdl_fx delete();
}

/*
	Name: function_bd0aa04e
	Namespace: pebble
	Checksum: 0x9726105E
	Offset: 0x43E0
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function function_bd0aa04e(var_a276c861)
{
	if(!var_a276c861)
	{
		var_b09af3eb = ("" + #"hash_574003386f679990") + "_";
		level waittill(var_b09af3eb + "completed", var_b09af3eb + "skipped_over", var_b09af3eb + "ended_early");
	}
}

/*
	Name: function_13ebfa5e
	Namespace: pebble
	Checksum: 0xE1CEA3C4
	Offset: 0x4458
	Size: 0xA8
	Parameters: 2
	Flags: Linked
*/
function function_13ebfa5e(var_a276c861, var_19e802fa)
{
	if(var_a276c861 || var_19e802fa)
	{
		foreach(e_player in level.activeplayers)
		{
			e_player flag::set(#"hash_11ab20934759ebc3");
		}
	}
}

/*
	Name: function_90dac8fa
	Namespace: pebble
	Checksum: 0x3E4D7C3E
	Offset: 0x4508
	Size: 0x60A
	Parameters: 0
	Flags: Linked
*/
function function_90dac8fa()
{
	var_b2afb550 = getent("zombie_ghost_dog_spawner", "script_noteworthy");
	while(true)
	{
		if(!zm_custom::function_901b751c(#"hash_4deb3ae7a73c87f3"))
		{
			level waittill(#"start_of_round");
		}
		else
		{
			level flag::wait_till("dog_round");
		}
		var_ba182ddb = [];
		var_e6a69e36 = struct::get_array("hr_dog_spawn");
		foreach(e_player in level.activeplayers)
		{
			if(e_player flag::exists(#"hash_120fbb364796cd32") && e_player flag::get(#"hash_120fbb364796cd32") && !e_player flag::get(#"hash_11ab20934759ebc3"))
			{
				var_3c29eed1 = array::random(var_e6a69e36);
				while(!zm_utility::is_point_inside_enabled_zone(var_3c29eed1.origin))
				{
					var_3c29eed1 = array::random(var_e6a69e36);
				}
				e_dog = zombie_utility::spawn_zombie(var_b2afb550, undefined, var_3c29eed1);
				e_dog setinvisibletoall();
				e_dog setvisibletoplayer(e_player);
				e_dog.e_owner = e_player;
				waitframe(1);
				if(isdefined(e_dog))
				{
					if(!isdefined(var_ba182ddb))
					{
						var_ba182ddb = [];
					}
					else if(!isarray(var_ba182ddb))
					{
						var_ba182ddb = array(var_ba182ddb);
					}
					var_ba182ddb[var_ba182ddb.size] = e_dog;
					e_dog clientfield::set("" + #"hash_7792af358100c735", 1);
					e_dog clientfield::set("" + #"hash_65da20412fcaf97e", 1);
					e_dog thread zm_escape_util::function_7273c33d(var_3c29eed1, 0);
					e_dog setteam(#"allies");
					e_dog.script_noteworthy = "blast_attack_interactables";
					e_dog.var_c95261d = 0;
					e_dog.disable_flame_fx = 1;
					e_dog setcandamage(0);
					e_dog.var_77858b62 = &namespace_a9aa9d72::function_1cda4094;
					e_dog thread function_ef5a3a9d();
					var_6e6ec518 = util::spawn_model(#"hash_2963eae43f30b9ed", var_3c29eed1.origin);
					var_6e6ec518.origin = e_dog gettagorigin("tag_mouth_fx");
					var_6e6ec518.angles = e_dog.angles + vectorscale((1, 0, 1), 90);
					var_6e6ec518 linkto(e_dog, "tag_mouth_fx");
					e_dog.var_6e6ec518 = var_6e6ec518;
					var_6e6ec518 clientfield::set("" + #"hash_504d26c38b96651c", 1);
					var_6e6ec518 clientfield::set("" + #"hash_7327d0447d656234", 1);
					e_dog thread function_3c089853(e_player);
				}
			}
		}
		if(!zm_custom::function_901b751c(#"hash_4deb3ae7a73c87f3"))
		{
			level waittill(#"end_of_round");
		}
		else
		{
			level flag::wait_till_clear("dog_round");
		}
		for(i = 0; i < var_ba182ddb.size; i++)
		{
			if(isalive(var_ba182ddb[i]))
			{
				var_ba182ddb[i] setcandamage(1);
				if(isdefined(var_ba182ddb[i].var_6e6ec518))
				{
					var_ba182ddb[i].var_6e6ec518 delete();
				}
				var_ba182ddb[i] kill();
			}
		}
	}
}

/*
	Name: function_3c089853
	Namespace: pebble
	Checksum: 0x372F388D
	Offset: 0x4B20
	Size: 0x2AE
	Parameters: 1
	Flags: Linked
*/
function function_3c089853(e_player)
{
	self endon(#"death");
	var_8ad4ec11 = struct::get_array("s_pebble_trav", "targetname");
	current_zone = self zm_utility::get_current_zone(1);
	foreach(var_d72f7274 in var_8ad4ec11)
	{
		if(var_d72f7274.script_string == current_zone.name)
		{
			var_8b5ab1b3 = var_d72f7274;
		}
	}
	self setgoal(var_8b5ab1b3.origin, 1);
	self waittill(#"goal");
	while(true)
	{
		current_zone = self zm_utility::get_current_zone(1);
		/#
			iprintln("" + current_zone.name);
		#/
		var_445d5a80 = function_bc827f0d(current_zone, self);
		foreach(var_d72f7274 in var_8ad4ec11)
		{
			if(var_d72f7274.script_string == var_445d5a80)
			{
				var_8ba7b26b = var_d72f7274;
				break;
			}
		}
		if(isdefined(var_8ba7b26b))
		{
			self lookatpos(var_8ba7b26b.origin);
			self thread function_4d8d3da5(e_player);
			self setgoal(var_8ba7b26b.origin, 1);
			self function_ac75d5bf(e_player, var_8ba7b26b);
		}
		waitframe(3);
	}
}

/*
	Name: function_4d8d3da5
	Namespace: pebble
	Checksum: 0x78B4AE02
	Offset: 0x4DD8
	Size: 0x14E
	Parameters: 1
	Flags: Linked
*/
function function_4d8d3da5(e_player)
{
	self endon(#"death");
	for(i = 0; i <= 4; i++)
	{
		var_ae8517dd = util::spawn_model("p7_zm_ctl_wolf_paw_print_escape", self.origin + vectorscale((0, 0, 1), 2), self.angles + (-90, 0, 180));
		if(isdefined(var_ae8517dd))
		{
			var_ae8517dd setscale(0.6);
			var_ae8517dd clientfield::set("" + #"hash_53586aa63ca15286", 1);
			var_ae8517dd thread function_2cadc850();
			var_ae8517dd setinvisibletoall();
			if(isdefined(e_player))
			{
				var_ae8517dd setvisibletoplayer(e_player);
			}
		}
		wait(0.5);
	}
}

/*
	Name: function_2cadc850
	Namespace: pebble
	Checksum: 0x55A25DA4
	Offset: 0x4F30
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_2cadc850()
{
	self endon(#"death");
	wait(12);
	self delete();
}

/*
	Name: function_bc827f0d
	Namespace: pebble
	Checksum: 0x20815A07
	Offset: 0x4F70
	Size: 0x154
	Parameters: 2
	Flags: Linked
*/
function function_bc827f0d(current_zone, e_dog)
{
	var_63751700 = array();
	var_a35ec363 = zm_cleanup::get_adjacencies_to_zone(current_zone.name);
	foreach(zone in var_a35ec363)
	{
		if(zm_zonemgr::zone_is_enabled(zone))
		{
			array::add(var_63751700, zone, 0);
		}
	}
	while(true)
	{
		var_445d5a80 = array::random(var_63751700);
		if(!isdefined(e_dog.var_dc6158cc))
		{
			break;
		}
		else if(e_dog.var_dc6158cc.script_string == var_445d5a80)
		{
			continue;
		}
		break;
	}
	return var_445d5a80;
}

/*
	Name: function_ac75d5bf
	Namespace: pebble
	Checksum: 0x1F0F0009
	Offset: 0x50D0
	Size: 0x8E
	Parameters: 2
	Flags: Linked
*/
function function_ac75d5bf(e_player, var_8ba7b26b)
{
	self endon(#"death");
	self waittill(#"goal");
	self.var_dc6158cc = var_8ba7b26b;
	if(isdefined(e_player))
	{
		self thread function_c6472238(e_player);
		self waittilltimeout(8, #"hash_4607576ad3772956");
	}
	self notify(#"hash_1947ed5f21e90252");
}

/*
	Name: function_c6472238
	Namespace: pebble
	Checksum: 0x4E57F0C8
	Offset: 0x5168
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_c6472238(e_player)
{
	self endon(#"death", #"hash_4607576ad3772956", #"hash_1947ed5f21e90252");
	e_player endon(#"death");
	while(true)
	{
		if(distance2dsquared(self.origin, e_player.origin) < 144400)
		{
			self notify(#"hash_4607576ad3772956");
		}
		wait(0.1);
	}
}

/*
	Name: function_ef5a3a9d
	Namespace: pebble
	Checksum: 0x8E06CBEA
	Offset: 0x5218
	Size: 0x290
	Parameters: 0
	Flags: Linked
*/
function function_ef5a3a9d()
{
	self endon(#"death");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"blast_attack");
		e_attacker = s_result.e_player;
		if(isplayer(e_attacker) && isalive(e_attacker) && e_attacker == self.e_owner && e_attacker flag::get(#"hash_120fbb364796cd32") && !e_attacker flag::get(#"hash_11ab20934759ebc3"))
		{
			e_attacker flag::set(#"hash_11ab20934759ebc3");
			var_fd22f9df = struct::get("tom_pil");
			var_6e6ec518 = var_fd22f9df.scene_ents[#"prop 2"];
			var_6e6ec518 setvisibletoplayer(e_attacker);
			var_e041507a = e_attacker getentitynumber() + 1;
			var_6e6ec518 clientfield::set("" + #"hash_51657261e835ac7c", var_e041507a);
			e_attacker playsoundtoplayer(#"hash_6e048d37333004da", e_attacker);
			e_attacker thread zm_audio::create_and_play_dialog(#"success_resp", #"generic");
			self ghost();
			self setcandamage(1);
			self.var_6e6ec518 delete();
			self.takedamage = 1;
			self.allowdeath = 1;
			self kill();
		}
	}
}

/*
	Name: function_f5a3ba79
	Namespace: pebble
	Checksum: 0x55359942
	Offset: 0x54B0
	Size: 0x404
	Parameters: 0
	Flags: Linked
*/
function function_f5a3ba79()
{
	level flag::wait_till("power_on1");
	a_items = getitemarray();
	while(true)
	{
		a_w_items = getitemarray();
		var_a72ea4cb = undefined;
		foreach(w_item in a_w_items)
		{
			if(w_item.item == getweapon(#"hash_1e5656f6a6f091d6"))
			{
				var_a72ea4cb = w_item;
				break;
			}
		}
		var_20ca90ea = struct::get_array("afterlife_trigger");
		if(isdefined(level.var_6764a35e) && level.var_6764a35e)
		{
			var_97254738 = var_20ca90ea.size;
		}
		else
		{
			var_97254738 = 1;
		}
		var_20ca90ea = array::randomize(var_20ca90ea);
		for(i = 0; i < var_97254738; i++)
		{
			var_4c1425d3 = var_20ca90ea[i];
			if(isdefined(var_a72ea4cb) && (!(isdefined(level.var_6764a35e) && level.var_6764a35e)))
			{
				while(distancesquared(var_a72ea4cb.origin, var_4c1425d3.origin) < 10000)
				{
					var_4c1425d3 = array::random(var_20ca90ea);
				}
			}
			var_a705e738 = util::spawn_model("tag_origin", var_4c1425d3.origin, var_4c1425d3.angles);
			if(!isdefined(var_4c1425d3.s_unitrigger_stub))
			{
				var_4c1425d3.s_unitrigger_stub = var_4c1425d3 zm_unitrigger::create("", 96, &function_442fe4d3);
			}
			else
			{
				zm_unitrigger::register_unitrigger(var_4c1425d3.s_unitrigger_stub, &function_442fe4d3);
			}
			var_4c1425d3.var_a705e738 = var_a705e738;
			var_a705e738 clientfield::set("" + #"hash_4be2ce4248d80d22", 1);
		}
		level waittill(#"between_round_over");
		var_20ca90ea = struct::get_array("afterlife_trigger");
		foreach(var_4c1425d3 in var_20ca90ea)
		{
			if(isdefined(var_4c1425d3.s_unitrigger_stub))
			{
				zm_unitrigger::unregister_unitrigger(var_4c1425d3.s_unitrigger_stub);
			}
			if(isdefined(var_4c1425d3.var_a705e738))
			{
				var_4c1425d3.var_a705e738 delete();
			}
		}
	}
}

/*
	Name: function_442fe4d3
	Namespace: pebble
	Checksum: 0xC7D4C662
	Offset: 0x58C0
	Size: 0x374
	Parameters: 0
	Flags: Linked
*/
function function_442fe4d3()
{
	level endon(#"between_round_over");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger");
		if(isplayer(s_result.activator) && isalive(s_result.activator))
		{
			var_24cc214c = array(getweapon(#"zhield_spectral_dw"), getweapon(#"zhield_spectral_dw_upgraded"), getweapon(#"hash_185abc5c82e9d849"), getweapon(#"hash_158041aab1e14f3a"));
			w_current = s_result.activator.currentweapon;
			if(array::contains(var_24cc214c, w_current))
			{
				s_result.activator.var_9fd623ed = s_result.activator.var_9fd623ed + 12;
				s_result.activator.var_9fd623ed = math::clamp(s_result.activator.var_9fd623ed, 0, s_result.activator.var_f7c822b5 * 3);
				s_result.activator thread zm_weap_spectral_shield::function_804309c();
				s_result.activator notify(#"hash_22a49f7903e394a5");
				s_result.activator playsound(#"hash_19d5ba8ff22edcce");
				break;
			}
			else
			{
				s_result.activator status_effect::status_effect_apply(getstatuseffect(#"hash_19533caf858a9f3b"), undefined, self);
				s_result.activator playrumbleonentity("damage_heavy");
				s_result.activator dodamage(25, self.stub.related_parent.origin);
				s_result.activator playsound(#"hash_7f81f21dc017790d");
				break;
			}
		}
	}
	if(isdefined(self.stub.related_parent.var_a705e738))
	{
		self.stub.related_parent.var_a705e738 delete();
	}
	zm_unitrigger::unregister_unitrigger(self.stub);
}

/*
	Name: function_27c26acb
	Namespace: pebble
	Checksum: 0xA51A83EF
	Offset: 0x5C40
	Size: 0x20E
	Parameters: 0
	Flags: Linked
*/
function function_27c26acb()
{
	level.var_1a50fe78 = 0;
	var_86e0f327 = struct::get("walnut_teleporter_01");
	var_77b254ca = struct::get("walnut_teleporter_02");
	var_3d2317e9 = getent("mdl_walnut_teleporter_1", "targetname");
	var_696ff082 = getent("mdl_walnut_teleporter_2", "targetname");
	var_86e0f327.var_623f6a70 = 1;
	hidemiscmodels("walnut_02");
	level flag::wait_till("start_zombie_round_logic");
	foreach(e_player in level.activeplayers)
	{
		e_player thread function_c8220768();
	}
	level waittill(#"hash_12afa3ad484b2b");
	var_3d2317e9 setmodel("p8_zm_esc_teleporter_device");
	var_86e0f327.s_unitrigger_stub = var_86e0f327 zm_unitrigger::create(&function_ad132260, 64, &function_283deb4);
	var_77b254ca.s_unitrigger_stub = var_77b254ca zm_unitrigger::create(&function_ad132260, 64, &function_283deb4);
}

/*
	Name: function_c8220768
	Namespace: pebble
	Checksum: 0xDC3B3AFF
	Offset: 0x5E58
	Size: 0x60
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c8220768()
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"disconnect");
	level endon(#"hash_12afa3ad484b2b");
	self waittill(#"done_speaking");
	level notify(#"hash_12afa3ad484b2b");
}

/*
	Name: function_ad132260
	Namespace: pebble
	Checksum: 0xE6278B07
	Offset: 0x5EC0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_ad132260(player)
{
	if(isdefined(level.var_b473a73c) && level.var_b473a73c)
	{
		return false;
	}
	return true;
}

/*
	Name: function_283deb4
	Namespace: pebble
	Checksum: 0x193FF03B
	Offset: 0x5F00
	Size: 0x60
	Parameters: 0
	Flags: Linked
*/
function function_283deb4()
{
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger");
		self.stub.related_parent thread function_ed96eb60(s_result.activator);
	}
}

/*
	Name: function_ed96eb60
	Namespace: pebble
	Checksum: 0x429B9BB3
	Offset: 0x5F68
	Size: 0x4EC
	Parameters: 1
	Flags: Linked
*/
function function_ed96eb60(e_activator)
{
	if(isplayer(e_activator) && (isdefined(self.var_623f6a70) && self.var_623f6a70))
	{
		if(level.var_1a50fe78 == 0)
		{
			e_activator thread zm_audio::create_and_play_dialog(#"teleport", #"activate");
		}
		self.var_623f6a70 = undefined;
		if(self.targetname == "walnut_teleporter_01")
		{
			var_3d454522 = struct::get("walnut_teleporter_02");
			var_1da0aee8 = getent("mdl_walnut_teleporter_1", "targetname");
			var_e52414d4 = getent("mdl_walnut_teleporter_2", "targetname");
		}
		else
		{
			var_3d454522 = struct::get("walnut_teleporter_01");
			var_1da0aee8 = getent("mdl_walnut_teleporter_2", "targetname");
			var_e52414d4 = getent("mdl_walnut_teleporter_1", "targetname");
		}
		var_a705e738 = util::spawn_model("tag_origin", self.origin, self.angles);
		playsoundatposition(#"wpn_zmb_electrap_zap", self.origin);
		waitframe(2);
		var_a705e738 clientfield::increment("" + #"hash_ce418c45d804842");
		e_activator playrumbleonentity(#"zm_escape_walnut");
		var_1da0aee8 setmodel(#"p8_zm_esc_teleporter_device_off");
		if(self.targetname == "walnut_teleporter_01")
		{
			hidemiscmodels("walnut_01");
		}
		else if(self.targetname == "walnut_teleporter_02")
		{
			hidemiscmodels("walnut_02");
		}
		level.var_1a50fe78++;
		wait(2);
		var_a705e738 delete();
		if(level.var_1a50fe78 < 3)
		{
			var_a705e738 = util::spawn_model("tag_origin", var_3d454522.origin, var_3d454522.angles);
			playsoundatposition(#"wpn_zmb_electrap_zap", var_3d454522.origin);
			waitframe(2);
			var_a705e738 clientfield::increment("" + #"hash_ce418c45d804842");
			if(self.targetname == "walnut_teleporter_01")
			{
				showmiscmodels("walnut_02");
			}
			else if(self.targetname == "walnut_teleporter_02")
			{
				showmiscmodels("walnut_01");
			}
			wait(5);
			var_a705e738 delete();
			wait(25);
			var_e52414d4 setmodel(#"p8_zm_esc_teleporter_device");
			var_3d454522.var_623f6a70 = 1;
		}
		else
		{
			playsoundatposition(#"wpn_zmb_electrap_zap", var_3d454522.origin);
			playfx(level._effect[#"switch_sparks"], var_3d454522.origin);
			if(isalive(e_activator))
			{
				e_activator thread zm_audio::create_and_play_dialog(#"teleport", #"destroy");
			}
			level thread function_8f243ee0();
		}
	}
}

/*
	Name: function_8f243ee0
	Namespace: pebble
	Checksum: 0xFB6A56C4
	Offset: 0x6460
	Size: 0xD6
	Parameters: 0
	Flags: Linked
*/
function function_8f243ee0()
{
	var_86e0f327 = struct::get("walnut_teleporter_01");
	var_77b254ca = struct::get("walnut_teleporter_02");
	if(isdefined(var_86e0f327.mdl_walnut))
	{
		var_86e0f327.mdl_walnut delete();
	}
	if(isdefined(var_77b254ca.mdl_walnut))
	{
		var_77b254ca.mdl_walnut delete();
	}
	zm_unitrigger::unregister_unitrigger(var_86e0f327.s_unitrigger_stub);
	zm_unitrigger::unregister_unitrigger(var_77b254ca.s_unitrigger_stub);
	level.var_1a50fe78 = undefined;
}

/*
	Name: function_71e9c5c6
	Namespace: pebble
	Checksum: 0xC4EAE733
	Offset: 0x6540
	Size: 0x14A
	Parameters: 1
	Flags: Linked
*/
function function_71e9c5c6(var_a276c861)
{
	var_44ba02ba = struct::get("s_m_b_stat_spawn");
	var_bdd8273d = util::spawn_model(var_44ba02ba.model, var_44ba02ba.origin, var_44ba02ba.angles);
	var_99b181da = getent("e_m_bomb_q_vol", "targetname");
	level.var_a3781eb3 = 0;
	level.var_99b181da = var_99b181da;
	level.var_bdd8273d = var_bdd8273d;
	callback::on_ai_killed(&function_22927328);
	var_b09af3eb = ("" + #"monkey_bomb_step_1") + "_";
	level waittill(var_b09af3eb + "completed", var_b09af3eb + "skipped_over", var_b09af3eb + "ended_early", #"hash_731f4115fe0cbef");
}

/*
	Name: function_6bb97cee
	Namespace: pebble
	Checksum: 0xFD02BD7A
	Offset: 0x6698
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function function_6bb97cee(var_a276c861, var_19e802fa)
{
	callback::remove_on_ai_killed(&function_22927328);
	level.var_a3781eb3 = undefined;
	level.var_99b181da delete();
	level flag::delete(#"hash_731f4115fe0cbef");
}

/*
	Name: function_22927328
	Namespace: pebble
	Checksum: 0xA062D1E0
	Offset: 0x6720
	Size: 0x22C
	Parameters: 1
	Flags: Linked
*/
function function_22927328(s_params)
{
	if(self.archetype != #"zombie" && self.archetype != #"zombie_dog")
	{
		return;
	}
	if(!isplayer(s_params.eattacker))
	{
		return;
	}
	e_player = s_params.eattacker;
	if(!isdefined(level.var_99b181da))
	{
		return;
	}
	if(!e_player istouching(level.var_99b181da))
	{
		return;
	}
	var_5d138a8c = array(level.hero_weapon[#"flamethrower"][1], level.hero_weapon[#"flamethrower"][2], level.hero_weapon[#"gravityspikes"][1], level.hero_weapon[#"gravityspikes"][2], level.hero_weapon[#"katana"][1], level.hero_weapon[#"katana"][2], level.hero_weapon[#"minigun"][1], level.hero_weapon[#"minigun"][2], getweapon(#"hash_492e530f9862f6cc"));
	if(!isinarray(var_5d138a8c, s_params.weapon))
	{
		return;
	}
	level thread function_beab34f9(self gettagorigin("tag_eye"));
}

/*
	Name: function_beab34f9
	Namespace: pebble
	Checksum: 0x7D32802C
	Offset: 0x6958
	Size: 0x234
	Parameters: 1
	Flags: Linked, Private
*/
function private function_beab34f9(v_origin)
{
	mdl_fx = util::spawn_model("tag_origin", v_origin);
	mdl_fx clientfield::set("" + #"hash_7a8b6df890ccc630", 1);
	mdl_fx playsound(#"zmb_sq_souls_release");
	mdl_fx playloopsound(#"zmb_sq_souls_lp");
	var_628578b4 = struct::get("s_m_b_stat_spawn");
	var_628578b4 = struct::get(var_628578b4.target);
	n_time = distance(v_origin, var_628578b4.origin) / 100;
	mdl_fx moveto(var_628578b4.origin, n_time, n_time * 0.25, n_time * 0.25);
	mdl_fx waittill(#"movedone");
	mdl_fx playsound(#"zmb_sq_souls_impact");
	mdl_fx delete();
	if(isdefined(level.var_a3781eb3))
	{
		level.var_a3781eb3++;
	}
	if(isdefined(level.var_a3781eb3) && level.var_a3781eb3 >= 20)
	{
		playsoundatposition(#"hash_21967fb66e85ac4e", var_628578b4.origin);
		level flag::set(#"hash_731f4115fe0cbef");
	}
}

/*
	Name: function_63afa952
	Namespace: pebble
	Checksum: 0x4D5F99EE
	Offset: 0x6B98
	Size: 0x1DC
	Parameters: 1
	Flags: Linked
*/
function function_63afa952(var_a276c861)
{
	if(var_a276c861)
	{
		return;
	}
	level.var_bdd8273d clientfield::set("" + #"hash_59623b8b4fc694c8", 1);
	level.var_bdd8273d thread function_a852bfdc();
	s_result = undefined;
	s_result = level waittill(#"hash_763832898999092c");
	level.var_bdd8273d playsound(#"hash_1588095b858588d");
	wait(0.5);
	level.var_bdd8273d clientfield::set("" + #"hash_59623b8b4fc694c8", 2);
	level.var_bdd8273d movez(60, 1, 0.25, 0.25);
	level.var_bdd8273d playsound(#"hash_4c37b6324bbe1f4b");
	level.var_bdd8273d waittill(#"movedone");
	if(isalive(s_result.e_player))
	{
		s_result.e_player thread zm_audio::create_and_play_dialog(#"success_resp", #"generic");
	}
	level thread function_d2cafe65();
}

/*
	Name: function_bec90157
	Namespace: pebble
	Checksum: 0x45EFA82A
	Offset: 0x6D80
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function function_bec90157(var_a276c861, var_19e802fa)
{
	level notify(#"hash_763832898999092c");
	if(isdefined(level.var_bdd8273d))
	{
		level.var_bdd8273d clientfield::set("" + #"hash_59623b8b4fc694c8", 0);
		waitframe(1);
		level.var_bdd8273d delete();
	}
	if(var_a276c861 || var_19e802fa)
	{
		level thread function_d2cafe65();
	}
}

/*
	Name: function_a852bfdc
	Namespace: pebble
	Checksum: 0x433D1672
	Offset: 0x6E40
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_a852bfdc()
{
	level endon(#"hash_763832898999092c");
	self setcandamage(1);
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"damage");
		if(isplayer(s_result.attacker))
		{
			level notify(#"hash_763832898999092c", {#e_player:s_result.attacker});
		}
	}
}

/*
	Name: function_d2cafe65
	Namespace: pebble
	Checksum: 0x167BD94
	Offset: 0x6F00
	Size: 0x1DE
	Parameters: 0
	Flags: Linked
*/
function function_d2cafe65()
{
	level.var_b473a73c = 1;
	s_spawn = struct::get("s_m_b_pick_spawn");
	s_spawn.var_bdd70f6a = util::spawn_model(s_spawn.model, s_spawn.origin, s_spawn.angles);
	playsoundatposition(#"wpn_zmb_electrap_zap", s_spawn.origin);
	s_spawn.var_bdd70f6a clientfield::set("powerup_grabbed_fx", 2);
	if(function_8b1a219a())
	{
		s_spawn.e_player = s_spawn zm_unitrigger::function_fac87205(#"hash_376185ce7d9eb3c8", 64);
	}
	else
	{
		s_spawn.e_player = s_spawn zm_unitrigger::function_fac87205(#"hash_455b1ae7ea932324", 64);
	}
	if(isplayer(s_spawn.e_player) && isalive(s_spawn.e_player))
	{
		s_spawn.e_player giveweapon(getweapon(#"cymbal_monkey"));
		s_spawn.var_bdd70f6a delete();
	}
	level.var_b473a73c = undefined;
}

/*
	Name: function_24089629
	Namespace: pebble
	Checksum: 0xF2AAF441
	Offset: 0x70E8
	Size: 0x6C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_24089629()
{
	/#
		level thread function_6d6b192();
	#/
	level.var_a0ddc1d0 = 0;
	a_s_logs = struct::get_array("s_a_lo");
	array::thread_all(a_s_logs, &audio_log);
}

/*
	Name: audio_log
	Namespace: pebble
	Checksum: 0xE3FF1908
	Offset: 0x7160
	Size: 0x2A8A
	Parameters: 0
	Flags: Linked, Private
*/
function private audio_log()
{
	self.e_activator = self zm_unitrigger::function_fac87205("", 64);
	if(!isplayer(self.e_activator))
	{
		return;
	}
	if(self.e_activator stats::get_stat_global(#"hash_ad3a508a80a0e6e"))
	{
		level.var_a0ddc1d0 = 1;
	}
	if(isdefined(self.target))
	{
		var_6dd8721 = getentarray(self.target, "targetname");
		var_6dd8721[0] playsound(#"hash_3cca3c060dacc7de");
		var_6dd8721[0] playloopsound(#"hash_14cf26f9ee5a9962");
		foreach(var_3142fd84 in var_6dd8721)
		{
			var_3142fd84.spinning = 1;
			var_3142fd84 thread function_175057ad();
			wait(0.5);
		}
	}
	else if(!isdefined(self.var_d81f2c52))
	{
		self.var_d81f2c52 = spawn("script_origin", self.origin);
		self.var_d81f2c52 playsound(#"hash_30b34f9e7c34a7c7");
		self.var_d81f2c52 playloopsound(#"hash_2e03906cfa1c2389");
	}
	switch(self.script_int)
	{
		case 1:
		{
			playsoundatposition(#"hash_23fe2e98c6c58414", self.origin);
			wait(soundgetplaybacktime(#"hash_23fe2e98c6c58414") * 0.001);
			function_d61f989(#"hash_6453fd4f9c20993d", self.origin);
			playsoundatposition(#"hash_23fe2f98c6c585c7", self.origin);
			wait(soundgetplaybacktime(#"hash_23fe2f98c6c585c7") * 0.001);
			playsoundatposition(#"hash_23fe3098c6c5877a", self.origin);
			wait(soundgetplaybacktime(#"hash_23fe3098c6c5877a") * 0.001);
			function_d61f989(#"hash_6453fb4f9c2095d7", self.origin);
			wait(1);
			function_d61f989(#"hash_6453f84f9c2090be", self.origin);
			playsoundatposition(#"hash_23fe3198c6c5892d", self.origin);
			wait(soundgetplaybacktime(#"hash_23fe3198c6c5892d") * 0.001);
			function_d61f989(#"hash_6453f94f9c209271", self.origin);
			playsoundatposition(#"hash_23fe2a98c6c57d48", self.origin);
			wait(soundgetplaybacktime(#"hash_23fe2a98c6c57d48") * 0.001);
			function_d61f989(#"hash_6453f64f9c208d58", self.origin);
			playsoundatposition(#"hash_23fe2b98c6c57efb", self.origin);
			wait(soundgetplaybacktime(#"hash_23fe2b98c6c57efb") * 0.001);
			playsoundatposition(#"hash_23fe2c98c6c580ae", self.origin);
			wait(soundgetplaybacktime(#"hash_23fe2c98c6c580ae") * 0.001);
			playsoundatposition(#"hash_23fe2d98c6c58261", self.origin);
			wait(soundgetplaybacktime(#"hash_23fe2d98c6c58261") * 0.001);
			break;
		}
		case 2:
		{
			playsoundatposition(#"hash_15768d7058a98edb", self.origin);
			wait(soundgetplaybacktime(#"hash_15768d7058a98edb") * 0.001);
			playsoundatposition(#"hash_15768c7058a98d28", self.origin);
			wait(soundgetplaybacktime(#"hash_15768c7058a98d28") * 0.001);
			playsoundatposition(#"hash_21e2aae6a803dce0", self.origin);
			wait(soundgetplaybacktime(#"hash_21e2aae6a803dce0") * 0.001);
			function_d61f989(#"hash_21c98671572b0a70", self.origin);
			playsoundatposition(#"hash_21e2abe6a803de93", self.origin);
			wait(soundgetplaybacktime(#"hash_21e2abe6a803de93") * 0.001);
			playsoundatposition(#"hash_21e2ace6a803e046", self.origin);
			wait(soundgetplaybacktime(#"hash_21e2ace6a803e046") * 0.001);
			playsoundatposition(#"hash_21e2ade6a803e1f9", self.origin);
			wait(soundgetplaybacktime(#"hash_21e2ade6a803e1f9") * 0.001);
			playsoundatposition(#"hash_21e2aee6a803e3ac", self.origin);
			wait(soundgetplaybacktime(#"hash_21e2aee6a803e3ac") * 0.001);
			break;
		}
		case 3:
		{
			function_d61f989(#"hash_23cc07d5d8b05cdf", self.origin);
			wait(1.8);
			playsoundatposition(#"hash_25bacd9289857a44", self.origin);
			wait(soundgetplaybacktime(#"hash_25bacd9289857a44") * 0.001);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_4f5eef83174e040a", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_4f5eef83174e040a") * 0.001);
			playsoundatposition(#"hash_25bacf9289857daa", self.origin);
			wait(soundgetplaybacktime(#"hash_25bacf9289857daa") * 0.001);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_4f5ee183174dec40", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_4f5ee183174dec40") * 0.001);
			playsoundatposition(#"hash_25bac192898565e0", self.origin);
			wait(soundgetplaybacktime(#"hash_25bac192898565e0") * 0.001);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_4f695b8317571013", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_4f695b8317571013") * 0.001);
			playsoundatposition(#"hash_25b0b992897d03c3", self.origin);
			wait(soundgetplaybacktime(#"hash_25b0b992897d03c3") * 0.001);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_4f695d8317571379", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_4f695d8317571379") * 0.001);
			playsoundatposition(#"hash_25b0bb92897d0729", self.origin);
			wait(soundgetplaybacktime(#"hash_25b0bb92897d0729") * 0.001);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_4f695f83175716df", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_4f695f83175716df") * 0.001);
			function_d61f989(#"hash_23cc08d5d8b05e92", self.origin);
			playsoundatposition(#"hash_25b0bd92897d0a8f", self.origin);
			wait(soundgetplaybacktime(#"hash_25b0bd92897d0a8f") * 0.001);
			playsoundatposition(#"hash_29be819f5341e1dc", self.origin);
			wait(soundgetplaybacktime(#"hash_29be819f5341e1dc") * 0.001);
			playsoundatposition(#"hash_25b0bf92897d0df5", self.origin);
			wait(soundgetplaybacktime(#"hash_25b0bf92897d0df5") * 0.001);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_4f69638317571dab", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_4f69638317571dab") * 0.001);
			playsoundatposition(#"hash_29be889f5341edc1", self.origin);
			wait(soundgetplaybacktime(#"hash_29be889f5341edc1") * 0.001);
			playsoundatposition(#"hash_25b3be92897f4219", self.origin);
			wait(soundgetplaybacktime(#"hash_25b3be92897f4219") * 0.001);
			playsoundatposition(#"hash_29c1849f53441ccc", self.origin);
			wait(soundgetplaybacktime(#"hash_29c1849f53441ccc") * 0.001);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_4f65f38317542984", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_4f65f38317542984") * 0.001);
			playsoundatposition(#"hash_25b3bb92897f3d00", self.origin);
			wait(soundgetplaybacktime(#"hash_25b3bb92897f3d00") * 0.001);
			break;
		}
		case 4:
		{
			playsoundatposition(#"hash_15e36767f47d3f8", self.origin);
			wait(soundgetplaybacktime(#"hash_15e36767f47d3f8") * 0.001);
			playsoundatposition(#"hash_15e37767f47d5ab", self.origin);
			wait(soundgetplaybacktime(#"hash_15e37767f47d5ab") * 0.001);
			playsoundatposition(#"hash_15e38767f47d75e", self.origin);
			wait(soundgetplaybacktime(#"hash_15e38767f47d75e") * 0.001);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_35f3cbfc08f0133e", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_35f3cbfc08f0133e") * 0.001);
			playsoundatposition(#"hash_15e32767f47cd2c", self.origin);
			wait(soundgetplaybacktime(#"hash_15e32767f47cd2c") * 0.001);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_35f3c5fc08f0090c", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_35f3c5fc08f0090c") * 0.001);
			playsoundatposition(#"hash_15ab4767f44c13b", self.origin);
			wait(soundgetplaybacktime(#"hash_15ab4767f44c13b") * 0.001);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_35dc45fc08dc50ab", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_35dc45fc08dc50ab") * 0.001);
			playsoundatposition(#"hash_15ab6767f44c4a1", self.origin);
			wait(soundgetplaybacktime(#"hash_15ab6767f44c4a1") * 0.001);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_35dc47fc08dc5411", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_35dc47fc08dc5411") * 0.001);
			playsoundatposition(#"hash_15ab8767f44c807", self.origin);
			wait(soundgetplaybacktime(#"hash_15ab8767f44c807") * 0.001);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_35dc49fc08dc5777", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_35dc49fc08dc5777") * 0.001);
			playsoundatposition(#"hash_15aba767f44cb6d", self.origin);
			wait(soundgetplaybacktime(#"hash_15aba767f44cb6d") * 0.001);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_35dc4bfc08dc5add", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_35dc4bfc08dc5add") * 0.001);
			playsoundatposition(#"hash_15aac767f44b3a3", self.origin);
			wait(soundgetplaybacktime(#"hash_15aac767f44b3a3") * 0.001);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_35dc3dfc08dc4313", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_35dc3dfc08dc4313") * 0.001);
			playsoundatposition(#"hash_1572e767f41a7b2", self.origin);
			wait(soundgetplaybacktime(#"hash_1572e767f41a7b2") * 0.001);
			break;
		}
		case 5:
		{
			playsoundatposition(#"hash_5bf62e19d6a6a36a", self.origin);
			wait(soundgetplaybacktime(#"hash_5bf62e19d6a6a36a") * 0.001);
			playsoundatposition(#"hash_5bf62d19d6a6a1b7", self.origin);
			wait(soundgetplaybacktime(#"hash_5bf62d19d6a6a1b7") * 0.001);
			function_d61f989(#"hash_466d0b7b0866b5a1", self.origin);
			wait(1.5);
			playsoundatposition(#"hash_3ba33944c02f59c2", self.origin);
			wait(soundgetplaybacktime(#"hash_3ba33944c02f59c2") * 0.001);
			playsoundatposition(#"hash_5bf62b19d6a69e51", self.origin);
			wait(soundgetplaybacktime(#"hash_5bf62b19d6a69e51") * 0.001);
			playsoundatposition(#"hash_3ba33344c02f4f90", self.origin);
			wait(soundgetplaybacktime(#"hash_3ba33344c02f4f90") * 0.001);
			function_d61f989(#"hash_466d087b0866b088", self.origin);
			playsoundatposition(#"hash_5bf62919d6a69aeb", self.origin);
			wait(soundgetplaybacktime(#"hash_5bf62919d6a69aeb") * 0.001);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_4bc8176f7ba9f733", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_4bc8176f7ba9f733") * 0.001);
			playsoundatposition(#"hash_5bf62719d6a69785", self.origin);
			wait(soundgetplaybacktime(#"hash_5bf62719d6a69785") * 0.001);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_4bc8256f7baa0efd", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_4bc8256f7baa0efd") * 0.001);
			playsoundatposition(#"hash_5bf99519d6a98846", self.origin);
			wait(soundgetplaybacktime(#"hash_5bf99519d6a98846") * 0.001);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_4bc5156f7ba7bdf6", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_4bc5156f7ba7bdf6") * 0.001);
			function_d61f989(#"hash_466d097b0866b23b", self.origin);
			playsoundatposition(#"hash_5bf99319d6a984e0", self.origin);
			wait(soundgetplaybacktime(#"hash_5bf99319d6a984e0") * 0.001);
			wait(1);
			function_d61f989(#"hash_466d0e7b0866baba", self.origin);
			playsoundatposition(#"hash_3b98c944c02646ed", self.origin);
			wait(soundgetplaybacktime(#"hash_3b98c944c02646ed") * 0.001);
			wait(1.3);
			function_d61f989(#"hash_466d0f7b0866bc6d", self.origin);
			playsoundatposition(#"hash_3b98c244c0263b08", self.origin);
			wait(soundgetplaybacktime(#"hash_3b98c244c0263b08") * 0.001);
			wait(0.6);
			function_d61f989(#"hash_466d0c7b0866b754", self.origin);
			playsoundatposition(#"hash_5bf99a19d6a990c5", self.origin);
			wait(soundgetplaybacktime(#"hash_5bf99a19d6a990c5") * 0.001);
			wait(0.35);
			playsoundatposition(#"hash_3b98c444c0263e6e", self.origin);
			wait(soundgetplaybacktime(#"hash_3b98c444c0263e6e") * 0.001);
			wait(0.5);
			playsoundatposition(#"hash_5bf99819d6a98d5f", self.origin);
			wait(soundgetplaybacktime(#"hash_5bf99819d6a98d5f") * 0.001);
			wait(0.6);
			if(level.var_a0ddc1d0)
			{
				playsoundatposition(#"hash_4bc51e6f7ba7cd41", self.origin);
			}
			wait(soundgetplaybacktime(#"hash_4bc51e6f7ba7cd41") * 0.001);
			wait(0.5);
			function_d61f989(#"hash_466d0d7b0866b907", self.origin);
			playsoundatposition(#"hash_5bf99e19d6a99791", self.origin);
			wait(soundgetplaybacktime(#"hash_5bf99e19d6a99791") * 0.001);
			wait(3.1);
			playsoundatposition(#"hash_5bfd1b19d6aca1cf", self.origin);
			wait(soundgetplaybacktime(#"hash_5bfd1b19d6aca1cf") * 0.001);
			wait(4.47);
			playsoundatposition(#"hash_3b9c4b44c02959aa", self.origin);
			wait(soundgetplaybacktime(#"hash_3b9c4b44c02959aa") * 0.001);
			break;
		}
		case 6:
		{
			playsoundatposition(#"hash_2d1d88cf90cfcdfa", self.origin);
			wait(soundgetplaybacktime(#"hash_2d1d88cf90cfcdfa") * 0.001);
			playsoundatposition(#"hash_2d1d89cf90cfcfad", self.origin);
			wait(soundgetplaybacktime(#"hash_2d1d89cf90cfcfad") * 0.001);
			playsoundatposition(#"hash_2d1d82cf90cfc3c8", self.origin);
			wait(soundgetplaybacktime(#"hash_2d1d82cf90cfc3c8") * 0.001);
			playsoundatposition(#"hash_2d1d83cf90cfc57b", self.origin);
			wait(soundgetplaybacktime(#"hash_2d1d83cf90cfc57b") * 0.001);
			playsoundatposition(#"hash_2d1d84cf90cfc72e", self.origin);
			wait(soundgetplaybacktime(#"hash_2d1d84cf90cfc72e") * 0.001);
			playsoundatposition(#"hash_2d1d85cf90cfc8e1", self.origin);
			wait(soundgetplaybacktime(#"hash_2d1d85cf90cfc8e1") * 0.001);
			playsoundatposition(#"hash_2d1d7ecf90cfbcfc", self.origin);
			wait(soundgetplaybacktime(#"hash_2d1d7ecf90cfbcfc") * 0.001);
			playsoundatposition(#"hash_2d1d7fcf90cfbeaf", self.origin);
			wait(soundgetplaybacktime(#"hash_2d1d7fcf90cfbeaf") * 0.001);
			break;
		}
		case 7:
		{
			playsoundatposition(#"hash_50c0423d01c93f52", self.origin);
			wait(soundgetplaybacktime(#"hash_50c0423d01c93f52") * 0.001);
			playsoundatposition(#"hash_50c0433d01c94105", self.origin);
			wait(soundgetplaybacktime(#"hash_50c0433d01c94105") * 0.001);
			playsoundatposition(#"hash_50c0403d01c93bec", self.origin);
			wait(soundgetplaybacktime(#"hash_50c0403d01c93bec") * 0.001);
			playsoundatposition(#"hash_50c0413d01c93d9f", self.origin);
			wait(soundgetplaybacktime(#"hash_50c0413d01c93d9f") * 0.001);
			playsoundatposition(#"hash_50c03e3d01c93886", self.origin);
			wait(soundgetplaybacktime(#"hash_50c03e3d01c93886") * 0.001);
			playsoundatposition(#"hash_50c03f3d01c93a39", self.origin);
			wait(soundgetplaybacktime(#"hash_50c03f3d01c93a39") * 0.001);
			playsoundatposition(#"hash_50c03c3d01c93520", self.origin);
			wait(soundgetplaybacktime(#"hash_50c03c3d01c93520") * 0.001);
			playsoundatposition(#"hash_50c03d3d01c936d3", self.origin);
			wait(soundgetplaybacktime(#"hash_50c03d3d01c936d3") * 0.001);
			break;
		}
		case 8:
		{
			playsoundatposition(#"hash_56c3c2f784568cad", self.origin);
			wait(soundgetplaybacktime(#"hash_56c3c2f784568cad") * 0.001);
			playsoundatposition(#"hash_56c3c1f784568afa", self.origin);
			wait(soundgetplaybacktime(#"hash_56c3c1f784568afa") * 0.001);
			playsoundatposition(#"hash_56c034f78453658c", self.origin);
			wait(soundgetplaybacktime(#"hash_56c034f78453658c") * 0.001);
			playsoundatposition(#"hash_56c035f78453673f", self.origin);
			wait(soundgetplaybacktime(#"hash_56c035f78453673f") * 0.001);
			playsoundatposition(#"hash_56c036f7845368f2", self.origin);
			wait(soundgetplaybacktime(#"hash_56c036f7845368f2") * 0.001);
			playsoundatposition(#"hash_56c037f784536aa5", self.origin);
			wait(soundgetplaybacktime(#"hash_56c037f784536aa5") * 0.001);
			playsoundatposition(#"hash_56c030f784535ec0", self.origin);
			wait(soundgetplaybacktime(#"hash_56c030f784535ec0") * 0.001);
			playsoundatposition(#"hash_56c031f784536073", self.origin);
			wait(soundgetplaybacktime(#"hash_56c031f784536073") * 0.001);
			playsoundatposition(#"hash_56c032f784536226", self.origin);
			wait(soundgetplaybacktime(#"hash_56c032f784536226") * 0.001);
			break;
		}
		case 9:
		{
			playsoundatposition(#"hash_42613a08be275478", self.origin);
			wait(soundgetplaybacktime(#"hash_42613a08be275478") * 0.001);
			playsoundatposition(#"hash_42613908be2752c5", self.origin);
			wait(soundgetplaybacktime(#"hash_42613908be2752c5") * 0.001);
			playsoundatposition(#"hash_42613808be275112", self.origin);
			wait(soundgetplaybacktime(#"hash_42613808be275112") * 0.001);
			playsoundatposition(#"hash_371426db436fcdef", self.origin);
			wait(soundgetplaybacktime(#"hash_371426db436fcdef") * 0.001);
			playsoundatposition(#"hash_371425db436fcc3c", self.origin);
			wait(soundgetplaybacktime(#"hash_371425db436fcc3c") * 0.001);
			playsoundatposition(#"hash_371428db436fd155", self.origin);
			wait(soundgetplaybacktime(#"hash_371428db436fd155") * 0.001);
			playsoundatposition(#"hash_371427db436fcfa2", self.origin);
			wait(soundgetplaybacktime(#"hash_371427db436fcfa2") * 0.001);
			break;
		}
		case 10:
		{
			playsoundatposition(#"hash_15968033f07920d6", self.origin);
			wait(soundgetplaybacktime(#"hash_15968033f07920d6") * 0.001);
			playsoundatposition(#"hash_15968133f0792289", self.origin);
			wait(soundgetplaybacktime(#"hash_15968133f0792289") * 0.001);
			playsoundatposition(#"hash_15967e33f0791d70", self.origin);
			wait(soundgetplaybacktime(#"hash_15967e33f0791d70") * 0.001);
			playsoundatposition(#"hash_15967f33f0791f23", self.origin);
			wait(soundgetplaybacktime(#"hash_15967f33f0791f23") * 0.001);
			playsoundatposition(#"hash_15968c33f079353a", self.origin);
			wait(soundgetplaybacktime(#"hash_15968c33f079353a") * 0.001);
			playsoundatposition(#"hash_15968d33f07936ed", self.origin);
			wait(soundgetplaybacktime(#"hash_15968d33f07936ed") * 0.001);
			break;
		}
	}
	if(isdefined(self.var_d81f2c52))
	{
		self.var_d81f2c52 playsound(#"hash_378a275b951b400d");
		self.var_d81f2c52 stoploopsound();
		waitframe(1);
		self.var_d81f2c52 delete();
		self.var_d81f2c52 = undefined;
	}
	if(isdefined(var_6dd8721))
	{
		foreach(var_3142fd84 in var_6dd8721)
		{
			var_3142fd84.spinning = 0;
		}
	}
}

/*
	Name: function_d61f989
	Namespace: pebble
	Checksum: 0x11E24660
	Offset: 0x9BF8
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function function_d61f989(str_alias, a_location)
{
	playsoundatposition(str_alias, a_location);
}

/*
	Name: function_175057ad
	Namespace: pebble
	Checksum: 0x1B7865BF
	Offset: 0x9C30
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_175057ad()
{
	while(self.spinning)
	{
		self rotateroll(360, 5);
		self waittill(#"rotatedone");
	}
	self playsound(#"hash_1f7edbf8f3a60766");
	self stoploopsound();
}

/*
	Name: function_5bae5249
	Namespace: pebble
	Checksum: 0xE62DB4F1
	Offset: 0x9CB8
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function function_5bae5249()
{
	/#
		if(!getdvarint(#"zm_debug_ee", 0))
		{
			return;
		}
		zm_devgui::add_custom_devgui_callback(&function_d71846cd);
		adddebugcommand("");
	#/
}

/*
	Name: function_d71846cd
	Namespace: pebble
	Checksum: 0xCD6C4009
	Offset: 0x9D30
	Size: 0xEA
	Parameters: 1
	Flags: None
*/
function function_d71846cd(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_8a61bbec91098c":
			{
				var_64de1b5a = struct::get_array("");
				foreach(s_glyph in var_64de1b5a)
				{
					util::spawn_model(#"p8_zm_esc_dream_catcher_blue", s_glyph.origin, s_glyph.angles);
				}
				break;
			}
		}
	#/
}

/*
	Name: function_6d6b192
	Namespace: pebble
	Checksum: 0xB69B9C7D
	Offset: 0x9E28
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function function_6d6b192()
{
	/#
		if(!getdvarint(#"zm_debug_ee", 0))
		{
			return;
		}
		zm_devgui::add_custom_devgui_callback(&function_1bab20ac);
		adddebugcommand("");
	#/
}

/*
	Name: function_1bab20ac
	Namespace: pebble
	Checksum: 0x12EDE818
	Offset: 0x9EA0
	Size: 0x6A
	Parameters: 1
	Flags: None
*/
function function_1bab20ac(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_3a594b9ac3dcfcb3":
			{
				if(!isdefined(level.var_a0ddc1d0))
				{
					level.var_a0ddc1d0 = 1;
				}
				else
				{
					level.var_a0ddc1d0 = !level.var_a0ddc1d0;
				}
				break;
			}
		}
	#/
}

