// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2595527427ea71eb;
#using script_742a29771db74d6f;
#using scripts\zm_common\util.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_utility;

/*
	Name: open_door
	Namespace: zm_utility
	Checksum: 0xE8F9A021
	Offset: 0x2F8
	Size: 0x41E
	Parameters: 4
	Flags: Linked
*/
function open_door(a_str_door_names, var_47eb646a = 0, var_91ccb2d7, b_play_audio = 0)
{
	if(!isdefined(a_str_door_names))
	{
		a_str_door_names = [];
	}
	else if(!isarray(a_str_door_names))
	{
		a_str_door_names = array(a_str_door_names);
	}
	if(var_47eb646a)
	{
		if(!function_5f8f4d1b())
		{
			level waittill(#"player_grabbed_key");
		}
	}
	if(isstring(var_91ccb2d7) || ishash(var_91ccb2d7))
	{
		self waittill(var_91ccb2d7);
	}
	else if(isdefined(var_91ccb2d7))
	{
		wait(var_91ccb2d7);
	}
	if(b_play_audio)
	{
		util::playsoundonplayers(#"hash_5eca7fc11b300dd1");
	}
	var_6e4ed9cd = 0;
	var_37cb3654 = 0;
	foreach(str_door_name in a_str_door_names)
	{
		a_e_zombie_doors = getentarray(str_door_name, "target");
		if(!var_6e4ed9cd && b_play_audio)
		{
			if(a_str_door_names.size > 1 || a_e_zombie_doors.size > 1)
			{
				level thread function_7a35b1d7(#"hash_3b522b4b62050e3c");
				level thread zm_audio::sndannouncerplayvox(#"hash_79b3b9e8ed3f0631", undefined, undefined, undefined, 1);
			}
			else
			{
				level thread function_7a35b1d7(#"hash_7203281c0385cddd");
				level thread zm_audio::sndannouncerplayvox(#"hash_77e06980e2fc1567", undefined, undefined, undefined, 1);
			}
			var_6e4ed9cd = 1;
		}
		foreach(zombie_door in a_e_zombie_doors)
		{
			if(isdefined(zombie_door.b_opened) && zombie_door.b_opened)
			{
				continue;
			}
			zombie_door notify(#"trigger", {#is_forced:1, #activator:zombie_door});
			zombie_door.script_flag_wait = undefined;
			zombie_door notify(#"power_on");
			zombie_door.b_opened = 1;
			playsoundatposition(#"hash_27dc220231c7b8b3", zombie_door.origin);
		}
		if(var_47eb646a)
		{
			level notify(#"hash_4ffec9c5f552e6fc", {#e_door:zombie_door});
			if(function_5f8f4d1b())
			{
				function_1409b164();
			}
			waitframe(1);
		}
	}
}

/*
	Name: function_26a5066b
	Namespace: zm_utility
	Checksum: 0xC3FFB421
	Offset: 0x720
	Size: 0x11E
	Parameters: 2
	Flags: Linked
*/
function function_26a5066b(n_round_number, var_232e4ebc = 1)
{
	if(!isdefined(level.var_26a5066b))
	{
		level.var_26a5066b = [];
	}
	if(isdefined(level.var_26a5066b[n_round_number]) && (!(isdefined(level.var_26a5066b[n_round_number].var_6faa5e34) && level.var_26a5066b[n_round_number].var_6faa5e34)) && isdefined(level.var_26a5066b[n_round_number].var_232e4ebc))
	{
		level.var_26a5066b[n_round_number].var_232e4ebc = level.var_26a5066b[n_round_number].var_232e4ebc + var_232e4ebc;
	}
	else
	{
		level.var_26a5066b[n_round_number] = {#hash_232e4ebc:var_232e4ebc, #hash_6faa5e34:0};
	}
}

/*
	Name: function_31e9c9c6
	Namespace: zm_utility
	Checksum: 0xCACB8C0E
	Offset: 0x848
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function function_31e9c9c6(n_round_number)
{
	if(!isdefined(level.var_26a5066b))
	{
		level.var_26a5066b = [];
	}
	if(isdefined(level.var_26a5066b[n_round_number]) && (!(isdefined(level.var_26a5066b[n_round_number].var_6faa5e34) && level.var_26a5066b[n_round_number].var_6faa5e34)))
	{
		arrayremoveindex(level.var_26a5066b, n_round_number, 1);
	}
}

/*
	Name: function_e12de7f5
	Namespace: zm_utility
	Checksum: 0x7434A17D
	Offset: 0x8F0
	Size: 0x2A
	Parameters: 1
	Flags: None
*/
function function_e12de7f5(n_round_number)
{
	if(isdefined(level.var_26a5066b[n_round_number]))
	{
		return true;
	}
	return false;
}

/*
	Name: function_e37823df
	Namespace: zm_utility
	Checksum: 0x79CF1F80
	Offset: 0x928
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function function_e37823df()
{
	if(getdvarint(#"hash_4d13a1555fce5382", 1) || level flag::exists("doorbuy_key_active"))
	{
		return true;
	}
	return false;
}

/*
	Name: function_5f8f4d1b
	Namespace: zm_utility
	Checksum: 0x8F0D31A1
	Offset: 0x988
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function function_5f8f4d1b(e_door)
{
	if(level flag::exists("doorbuy_key_active") && level flag::get("doorbuy_key_active"))
	{
		if(function_ea30ebf3() && isdefined(e_door))
		{
			if(e_door.script_flag === function_e9661a10())
			{
				return true;
			}
			return false;
		}
		return true;
	}
	return false;
}

/*
	Name: function_22e48b1b
	Namespace: zm_utility
	Checksum: 0x1F54A71E
	Offset: 0xA40
	Size: 0x15A
	Parameters: 1
	Flags: None
*/
function function_22e48b1b(var_9b0e82f2)
{
	if(!isdefined(level.var_44dcd588))
	{
		level.var_44dcd588 = spawnstruct();
	}
	if(!isdefined(level.var_44dcd588.var_a3a36198))
	{
		level.var_44dcd588.var_a3a36198 = 0;
	}
	if(!isdefined(level.var_44dcd588.var_be5c8c37))
	{
		level.var_44dcd588.var_be5c8c37 = [];
	}
	if(!isdefined(level.var_44dcd588.var_be5c8c37))
	{
		level.var_44dcd588.var_be5c8c37 = [];
	}
	else if(!isarray(level.var_44dcd588.var_be5c8c37))
	{
		level.var_44dcd588.var_be5c8c37 = array(level.var_44dcd588.var_be5c8c37);
	}
	if(!isinarray(level.var_44dcd588.var_be5c8c37, var_9b0e82f2))
	{
		level.var_44dcd588.var_be5c8c37[level.var_44dcd588.var_be5c8c37.size] = var_9b0e82f2;
	}
}

/*
	Name: function_ea30ebf3
	Namespace: zm_utility
	Checksum: 0xEAFDA913
	Offset: 0xBA8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_ea30ebf3()
{
	if(isdefined(level.var_44dcd588))
	{
		return true;
	}
	return false;
}

/*
	Name: function_e77b7028
	Namespace: zm_utility
	Checksum: 0xFAA9C735
	Offset: 0xBD0
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function function_e77b7028()
{
	level.var_44dcd588.var_a3a36198++;
}

/*
	Name: function_e9661a10
	Namespace: zm_utility
	Checksum: 0x29FCF023
	Offset: 0xBF0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_e9661a10()
{
	if(!isdefined(level.var_44dcd588))
	{
		return undefined;
	}
	n_index = level.var_44dcd588.var_a3a36198;
	var_9b0e82f2 = level.var_44dcd588.var_be5c8c37[n_index];
	return var_9b0e82f2;
}

/*
	Name: function_72c90d95
	Namespace: zm_utility
	Checksum: 0x2F341F9A
	Offset: 0xC58
	Size: 0x2A
	Parameters: 1
	Flags: None
*/
function function_72c90d95(var_232e4ebc)
{
	level.var_92b13539 = var_232e4ebc;
	level.var_9cec6237 = var_232e4ebc;
}

/*
	Name: function_880bd896
	Namespace: zm_utility
	Checksum: 0xCA506F4A
	Offset: 0xC90
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_880bd896()
{
	if(isdefined(level.var_9cec6237) && level.var_9cec6237 > 0)
	{
		return true;
	}
	if(!isdefined(level.var_9cec6237))
	{
		return true;
	}
	return false;
}

/*
	Name: function_73a5fc84
	Namespace: zm_utility
	Checksum: 0xD76EA885
	Offset: 0xCE0
	Size: 0x72
	Parameters: 0
	Flags: Linked
*/
function function_73a5fc84()
{
	level flag::increment("doorbuy_key_active");
	var_3aae086c = gettime() - level.var_4498cb25;
	level.var_4498cb25 = gettime();
}

/*
	Name: function_1409b164
	Namespace: zm_utility
	Checksum: 0x2A52FA4B
	Offset: 0xD60
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_1409b164()
{
	level flag::decrement("doorbuy_key_active");
	if(level flag::get("doorbuy_key_active") && function_ea30ebf3())
	{
		level util::delay(1, "end_game", &function_511ee23e, 1);
	}
	else if(!level flag::get("doorbuy_key_active"))
	{
		level thread function_511ee23e(0);
	}
	if(function_ea30ebf3())
	{
		function_e77b7028();
	}
}

/*
	Name: function_f4c60360
	Namespace: zm_utility
	Checksum: 0x708A7E49
	Offset: 0xE60
	Size: 0x42
	Parameters: 0
	Flags: None
*/
function function_f4c60360()
{
	return true;
}

/*
	Name: function_6df718d
	Namespace: zm_utility
	Checksum: 0xB43B324D
	Offset: 0xEB0
	Size: 0x64
	Parameters: 3
	Flags: Linked
*/
function function_6df718d(var_d147b93a, var_5cd8902e = 0, var_70516a9d = &function_9dc9326c)
{
	level thread function_9ac7ed7d(var_d147b93a, var_5cd8902e, var_70516a9d);
}

/*
	Name: function_9ac7ed7d
	Namespace: zm_utility
	Checksum: 0x40F17CB9
	Offset: 0xF20
	Size: 0x14C
	Parameters: 3
	Flags: Linked
*/
function function_9ac7ed7d(var_d147b93a, var_5cd8902e, var_70516a9d)
{
	level flag::init("doorbuy_key_active");
	level.var_4ffadb4c = int(var_5cd8902e * 100);
	callback::on_ai_killed(&function_279ca150);
	zm_powerups::register_powerup("zmarcade_key", var_70516a9d);
	zm_powerups::add_zombie_powerup("zmarcade_key", var_d147b93a, #"hash_776da083d1ecf583", &zm_powerups::func_should_never_drop, 0, 0, 0);
	zm_powerups::powerup_set_statless_powerup("zmarcade_key");
	/#
		adddebugcommand("");
	#/
	/#
		adddebugcommand("");
	#/
	wait(0.5);
	function_511ee23e(0);
}

/*
	Name: function_be2022f8
	Namespace: zm_utility
	Checksum: 0x1BF850ED
	Offset: 0x1078
	Size: 0x82
	Parameters: 0
	Flags: Linked
*/
function function_be2022f8()
{
	a_zombie_doors = getentarray("zombie_door", "targetname");
	a_zombie_debris = getentarray("zombie_debris", "targetname");
	a_e_zombie_doors = arraycombine(a_zombie_doors, a_zombie_debris, 0, 0);
	return a_e_zombie_doors;
}

/*
	Name: function_511ee23e
	Namespace: zm_utility
	Checksum: 0xA0E4B777
	Offset: 0x1108
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_511ee23e(var_35200797 = 1)
{
	level thread function_27b4c2be(var_35200797);
}

/*
	Name: function_27b4c2be
	Namespace: zm_utility
	Checksum: 0x9A8656EA
	Offset: 0x1148
	Size: 0x232
	Parameters: 1
	Flags: Linked
*/
function function_27b4c2be(var_35200797 = 1)
{
	level flag::wait_till("start_zombie_round_logic");
	a_e_zombie_doors = function_be2022f8();
	foreach(e_door in a_e_zombie_doors)
	{
		if(!isdefined(e_door))
		{
			continue;
		}
		if(var_35200797 && function_ea30ebf3() && e_door.script_flag !== function_e9661a10())
		{
			continue;
		}
		var_ba3135be = getentarray(e_door.target, "targetname");
		foreach(var_6c61edec in var_ba3135be)
		{
			if(isdefined(var_6c61edec.objectid))
			{
				switch(var_6c61edec.objectid)
				{
					case "symbol_back_debris":
					case "symbol_back":
					case "symbol_front":
					case "symbol_front_debris":
					{
						var_6c61edec thread function_214563e(var_35200797, var_6c61edec.objectid);
						break;
					}
					default:
					{
						break;
					}
				}
			}
		}
	}
}

/*
	Name: function_214563e
	Namespace: zm_utility
	Checksum: 0xA55ED7E
	Offset: 0x1388
	Size: 0x114
	Parameters: 2
	Flags: Linked
*/
function function_214563e(var_35200797 = 1, stop_time_travel_on_)
{
	self endon(#"death");
	if(var_35200797)
	{
		if(stop_time_travel_on_ == "symbol_front" || stop_time_travel_on_ == "symbol_back")
		{
			self clientfield::set("doorbuy_ambient_fx", 1);
		}
		else
		{
			self clientfield::set("debrisbuy_ambient_fx", 1);
		}
	}
	else
	{
		if(stop_time_travel_on_ == "symbol_front" || stop_time_travel_on_ == "symbol_back")
		{
			self clientfield::set("doorbuy_ambient_fx", 0);
		}
		else
		{
			self clientfield::set("debrisbuy_ambient_fx", 0);
		}
	}
}

/*
	Name: function_9dc9326c
	Namespace: zm_utility
	Checksum: 0x2E5EB44
	Offset: 0x14A8
	Size: 0x1FC
	Parameters: 1
	Flags: Linked
*/
function function_9dc9326c(player)
{
	if(!(isdefined(self.var_932d6747) && self.var_932d6747))
	{
		player notify(#"player_grabbed_key");
	}
	level notify(#"player_grabbed_key", {#e_player:player});
	function_73a5fc84();
	if(isdefined(self.var_428d1cb1) && self.var_428d1cb1)
	{
		level util::delay(1.5, "end_game", &zm_audio::sndannouncerplayvox, #"hash_6f8668b64fa3cfaf");
	}
	if(isarray(level.var_eaaa1d75) && level.var_eaaa1d75.size)
	{
		arrayremoveindex(level.var_eaaa1d75, 0);
	}
	function_511ee23e(1);
	player playsound(#"zmb_key_pickup");
	if(!(isdefined(level.var_77f262b9) && level.var_77f262b9) && get_story() === 2)
	{
		level.var_77f262b9 = 1;
		level util::delay(3, "end_game", &array::thread_all, getplayers(), &zm_equipment::show_hint_text, #"hash_68e088397871d66a");
	}
}

/*
	Name: function_279ca150
	Namespace: zm_utility
	Checksum: 0x196BD60C
	Offset: 0x16B0
	Size: 0x3EA
	Parameters: 0
	Flags: Linked
*/
function function_279ca150()
{
	var_f1e10d43 = level.round_number;
	a_ai_zombies = zombie_utility::get_round_enemy_array();
	n_chance = randomint(100);
	var_ebcac3c2 = 0;
	if(!(isdefined(self.ignore_enemy_count) && self.ignore_enemy_count) && a_ai_zombies.size == 1 && level.zombie_total <= 0 && !level flag::get("infinite_round_spawning"))
	{
		v_start = self.origin;
		foreach(var_b30c192b, s_key in level.var_26a5066b)
		{
			if(s_key.var_6faa5e34)
			{
				continue;
			}
			if(var_b30c192b <= var_f1e10d43 || n_chance < level.var_4ffadb4c)
			{
				s_key.var_6faa5e34 = 1;
				if(!var_ebcac3c2 && (isdefined(self.var_c39323b5) && self.var_c39323b5 || (!(check_point_in_playable_area(v_start) && check_point_in_enabled_zone(v_start))) || (isdefined(self.nuked) && self.nuked)))
				{
					e_player = arraygetclosest(v_start, level.activeplayers);
					v_start = e_player.origin;
					s_result = positionquery_source_navigation(v_start, 96, 512, 64, 64, 1);
					if(isdefined(s_result) && isarray(s_result.data))
					{
						var_d3dd963d = array::randomize(s_result.data);
						foreach(var_c310df8c in var_d3dd963d)
						{
							if(check_point_in_playable_area(var_c310df8c.origin) && check_point_in_enabled_zone(var_c310df8c.origin) && e_player util::is_player_looking_at(var_c310df8c.origin, 0.6, 0))
							{
								v_start = var_c310df8c.origin;
								break;
							}
						}
					}
				}
				for(i = 0; i < s_key.var_232e4ebc; i++)
				{
					level thread drop_key(v_start, var_ebcac3c2);
					var_ebcac3c2 = 1;
				}
			}
		}
	}
}

/*
	Name: drop_key
	Namespace: zm_utility
	Checksum: 0x2982522D
	Offset: 0x1AA8
	Size: 0x300
	Parameters: 2
	Flags: Linked
*/
function drop_key(v_start_pos, var_b545186e = 0)
{
	if(!function_880bd896())
	{
		/#
			iprintlnbold(("" + level.var_92b13539) + "");
		#/
		return;
	}
	if(var_b545186e)
	{
		e_player = arraygetclosest(v_start_pos, level.activeplayers);
		s_result = positionquery_source_navigation(v_start_pos, 16, 100, 64, 8, 1);
		if(isdefined(s_result) && isarray(s_result.data))
		{
			var_d3dd963d = array::randomize(s_result.data);
			foreach(var_c310df8c in var_d3dd963d)
			{
				if(check_point_in_playable_area(var_c310df8c.origin) && check_point_in_enabled_zone(var_c310df8c.origin))
				{
					v_start_pos = var_c310df8c.origin;
					break;
				}
			}
		}
	}
	level notify(#"key_dropped");
	if(isdefined(level.var_9cec6237))
	{
		level.var_9cec6237--;
	}
	e_key = zm_powerups::specific_powerup_drop("zmarcade_key", v_start_pos, undefined, undefined, undefined, 1);
	if(!isdefined(level.var_eaaa1d75))
	{
		level.var_eaaa1d75 = [];
	}
	else if(!isarray(level.var_eaaa1d75))
	{
		level.var_eaaa1d75 = array(level.var_eaaa1d75);
	}
	level.var_eaaa1d75[level.var_eaaa1d75.size] = e_key;
	if(!var_b545186e)
	{
		e_key playsound(#"hash_5eca7fc11b300dd1");
		e_key.var_428d1cb1 = 1;
	}
	e_key thread function_34bcd465();
	return e_key;
}

/*
	Name: function_34bcd465
	Namespace: zm_utility
	Checksum: 0x583DAD09
	Offset: 0x1DB0
	Size: 0x236
	Parameters: 0
	Flags: Linked
*/
function function_34bcd465()
{
	self endon(#"death", #"powerup_timedout", #"powerup_grabbed", #"hacked");
	level endon(#"end_game");
	n_timer = 15;
	if(n_timer > 0)
	{
		wait(n_timer);
	}
	self.var_932d6747 = 1;
	var_887826bc = [];
	foreach(player in level.players)
	{
		if(isalive(player) && player.sessionstate !== "spectator")
		{
			if(!isdefined(var_887826bc))
			{
				var_887826bc = [];
			}
			else if(!isarray(var_887826bc))
			{
				var_887826bc = array(var_887826bc);
			}
			var_887826bc[var_887826bc.size] = player;
		}
	}
	e_player = arraygetclosest(self.origin, var_887826bc);
	if(isplayer(e_player))
	{
		/#
			if(n_timer > 0)
			{
				iprintlnbold(((("" + e_player.name) + "") + n_timer) + "");
			}
		#/
		self dontinterpolate();
		self.origin = e_player.origin;
	}
}

/*
	Name: function_742f2c18
	Namespace: zm_utility
	Checksum: 0x73604F5
	Offset: 0x1FF0
	Size: 0x186
	Parameters: 7
	Flags: Linked
*/
function function_742f2c18(n_round, archetype, n_count_total, var_4f886dd2, var_37dc6df8, var_d58fab26, var_8857c54d)
{
	if(!isdefined(level.var_f944d22e))
	{
		level.var_f944d22e = [];
	}
	if(!isdefined(level.var_f944d22e[n_round]))
	{
		level.var_f944d22e[n_round] = [];
	}
	var_77760771 = spawnstruct();
	var_77760771.n_count_total = n_count_total;
	var_77760771.var_37dc6df8 = var_37dc6df8;
	var_77760771.var_8857c54d = var_8857c54d;
	var_77760771.var_d58fab26 = var_d58fab26;
	level.var_f944d22e[n_round][archetype] = var_77760771;
	if(archetype == #"zombie")
	{
		if(!isdefined(level.var_ea47b206))
		{
			level.var_ea47b206 = [];
		}
		var_4debc821 = spawnstruct();
		var_4debc821.var_4f886dd2 = var_4f886dd2;
		var_4debc821.n_count_total = n_count_total;
		level.var_ea47b206[n_round] = var_4debc821;
	}
}

/*
	Name: function_601e9653
	Namespace: zm_utility
	Checksum: 0xCDCBC83A
	Offset: 0x2180
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function function_601e9653()
{
	n_wait = randomfloatrange(4, 10);
	wait(n_wait);
}

/*
	Name: function_c492c4d6
	Namespace: zm_utility
	Checksum: 0x1F1E9901
	Offset: 0x21B8
	Size: 0x1CE
	Parameters: 8
	Flags: Linked
*/
function function_c492c4d6(str_index, var_ed1db1a7, a_str_zones, var_cc0c35ca, var_16a34df0, var_39c44288, var_c13f5c4b, var_9fc5eea1)
{
	if(!isdefined(level.a_s_defend_areas))
	{
		level.a_s_defend_areas = [];
	}
	if(!isdefined(level.var_e98284b5))
	{
		level.var_e98284b5 = [];
	}
	if(!isdefined(a_str_zones))
	{
		a_str_zones = [];
	}
	else if(!isarray(a_str_zones))
	{
		a_str_zones = array(a_str_zones);
	}
	if(!isdefined(var_cc0c35ca))
	{
		var_cc0c35ca = [];
	}
	else if(!isarray(var_cc0c35ca))
	{
		var_cc0c35ca = array(var_cc0c35ca);
	}
	/#
		/#
			assert(isdefined(struct::get(var_ed1db1a7)), ("" + var_ed1db1a7) + "");
		#/
	#/
	level.a_s_defend_areas[str_index] = {#hash_9fc5eea1:var_9fc5eea1, #hash_c13f5c4b:var_c13f5c4b, #hash_39c44288:var_39c44288, #hash_16a34df0:var_16a34df0, #hash_cc0c35ca:var_cc0c35ca, #a_str_zones:a_str_zones, #hash_ed1db1a7:var_ed1db1a7};
}

/*
	Name: function_1e856719
	Namespace: zm_utility
	Checksum: 0xF2E2E435
	Offset: 0x2390
	Size: 0x194
	Parameters: 0
	Flags: None
*/
function function_1e856719()
{
	/#
		var_f95f5bc7 = getarraykeys(level.a_s_defend_areas);
		foreach(str_index, s_defend_area in level.a_s_defend_areas)
		{
			/#
				assert(isarray(s_defend_area.var_cc0c35ca), ("" + function_9e72a96(str_index)) + "");
			#/
			foreach(var_f79ff5ec in s_defend_area.var_cc0c35ca)
			{
				/#
					assert(isinarray(var_f95f5bc7, var_f79ff5ec), ("" + function_9e72a96(var_f79ff5ec)) + "");
				#/
			}
		}
	#/
}

/*
	Name: function_fef4b36a
	Namespace: zm_utility
	Checksum: 0x405F39BB
	Offset: 0x2530
	Size: 0xFC
	Parameters: 1
	Flags: Linked
*/
function function_fef4b36a(str_index)
{
	str_index = hash(str_index);
	if(!isdefined(level.var_e98284b5))
	{
		level.var_e98284b5 = [];
	}
	else if(!isarray(level.var_e98284b5))
	{
		level.var_e98284b5 = array(level.var_e98284b5);
	}
	if(!isinarray(level.var_e98284b5, str_index))
	{
		level.var_e98284b5[level.var_e98284b5.size] = str_index;
	}
	if(level.var_e98284b5.size > 3)
	{
		arrayremoveindex(level.var_e98284b5, 0);
	}
}

/*
	Name: function_40ef77ab
	Namespace: zm_utility
	Checksum: 0x981103A8
	Offset: 0x2638
	Size: 0x23A
	Parameters: 2
	Flags: Linked
*/
function function_40ef77ab(var_573c22c3, b_random = 1)
{
	var_9cd8223f = arraycopy(level.a_s_defend_areas[var_573c22c3].var_cc0c35ca);
	var_573c22c3 = hash(var_573c22c3);
	foreach(var_6bef2b0c in var_9cd8223f)
	{
		var_6bef2b0c = hash(var_6bef2b0c);
	}
	function_fef4b36a(var_573c22c3);
	var_3a1a007d = array::exclude(var_9cd8223f, level.var_e98284b5);
	if(b_random)
	{
		var_94bc902 = array::random(var_3a1a007d);
	}
	else
	{
		if(!isdefined(level.a_s_defend_areas[var_573c22c3].var_39c67257))
		{
			level.a_s_defend_areas[var_573c22c3].var_39c67257 = 0;
		}
		var_94bc902 = level.a_s_defend_areas[var_573c22c3].var_cc0c35ca[level.a_s_defend_areas[var_573c22c3].var_39c67257];
		level.a_s_defend_areas[var_573c22c3].var_39c67257++;
		if(level.a_s_defend_areas[var_573c22c3].var_39c67257 >= level.a_s_defend_areas[var_573c22c3].var_cc0c35ca.size)
		{
			level.a_s_defend_areas[var_573c22c3].var_39c67257 = 0;
		}
	}
	if(isdefined(var_94bc902))
	{
		return var_94bc902;
	}
	return array::random(var_9cd8223f);
}

/*
	Name: function_defc6586
	Namespace: zm_utility
	Checksum: 0xB0C7D595
	Offset: 0x2880
	Size: 0x6A
	Parameters: 2
	Flags: None
*/
function function_defc6586(var_3d15828d, b_random = 1)
{
	str_index = function_40ef77ab(var_3d15828d, b_random);
	s_defend_area = function_a877cd10(str_index);
	return s_defend_area;
}

/*
	Name: function_a877cd10
	Namespace: zm_utility
	Checksum: 0xED4A8C6
	Offset: 0x28F8
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_a877cd10(str_index)
{
	/#
		/#
			assert(isdefined(level.a_s_defend_areas[str_index]), ("" + function_9e72a96(str_index)) + "");
		#/
	#/
	return level.a_s_defend_areas[str_index];
}

/*
	Name: function_11101458
	Namespace: zm_utility
	Checksum: 0x79A17C4
	Offset: 0x2970
	Size: 0x380
	Parameters: 3
	Flags: Linked
*/
function function_11101458(var_f79ff5ec, var_6cc77d4e = #"hash_3a35084ee8c333b2", hide_notify = "creating_zone_defend_area")
{
	var_679cd7a8 = function_a877cd10(var_f79ff5ec);
	if(isdefined(var_679cd7a8.var_9fc5eea1) && !isplayer(self))
	{
		n_obj_id = function_d7db256e(var_679cd7a8.var_ed1db1a7, var_6cc77d4e, 0);
		var_e1feb2f6 = function_d7db256e(var_679cd7a8.var_c13f5c4b, var_6cc77d4e, 0);
		objective_setinvisibletoall(n_obj_id);
		objective_setinvisibletoall(var_e1feb2f6);
		foreach(e_player in getplayers())
		{
			e_player thread function_428cfaae(var_679cd7a8, var_6cc77d4e, hide_notify, n_obj_id, var_e1feb2f6);
		}
		level util::delay(hide_notify, "end_game", &function_b1f3be5c, n_obj_id);
		level thread function_9704c82e(var_679cd7a8, var_e1feb2f6);
		return n_obj_id;
	}
	n_obj_id = function_d7db256e(var_679cd7a8.var_ed1db1a7, var_6cc77d4e, 0);
	objective_setinvisibletoall(n_obj_id);
	if(isplayer(self))
	{
		self thread zm_equipment::show_hint_text(var_679cd7a8.var_16a34df0, 10, 1.75, 120);
		objective_setvisibletoplayer(n_obj_id, self);
	}
	else
	{
		objective_setvisibletoall(n_obj_id);
		foreach(e_player in level.players)
		{
			e_player thread zm_equipment::show_hint_text(var_679cd7a8.var_16a34df0, 10, 1.75, 120);
		}
	}
	level util::delay(hide_notify, "end_game", &function_b1f3be5c, n_obj_id);
	return n_obj_id;
}

/*
	Name: function_428cfaae
	Namespace: zm_utility
	Checksum: 0x24AA8E4C
	Offset: 0x2CF8
	Size: 0x12E
	Parameters: 5
	Flags: Linked
*/
function function_428cfaae(var_679cd7a8, var_6cc77d4e, hide_notify, n_obj_id, var_e1feb2f6)
{
	level endon(#"end_game", #"hash_1dabaf25a56177a1");
	self endon(#"disconnect");
	self thread zm_equipment::show_hint_text(var_679cd7a8.var_16a34df0, 10, 1.75, 120);
	while(true)
	{
		if(self [[var_679cd7a8.var_9fc5eea1]]())
		{
			objective_setvisibletoplayer(var_e1feb2f6, self);
			objective_setinvisibletoplayer(n_obj_id, self);
		}
		else
		{
			objective_setvisibletoplayer(n_obj_id, self);
			objective_setinvisibletoplayer(var_e1feb2f6, self);
		}
		wait(1);
	}
}

/*
	Name: function_9704c82e
	Namespace: zm_utility
	Checksum: 0x38FFDD6A
	Offset: 0x2E30
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_9704c82e(s_defend, var_e1feb2f6)
{
	level endon(#"end_game");
	level waittill(#"hash_7a04a7fb98fa4e4d");
	level notify(#"hash_1dabaf25a56177a1");
	wait(0.1);
	gameobjects::release_obj_id(var_e1feb2f6);
}

/*
	Name: function_76321cf4
	Namespace: zm_utility
	Checksum: 0xF53B8C7E
	Offset: 0x2EB0
	Size: 0x42
	Parameters: 1
	Flags: None
*/
function function_76321cf4(b_enable = 1)
{
	if(b_enable)
	{
		level.var_aef7f7d5 = undefined;
	}
	else
	{
		level.var_aef7f7d5 = 1;
	}
}

/*
	Name: function_33798535
	Namespace: zm_utility
	Checksum: 0x87095A7F
	Offset: 0x2F00
	Size: 0x7D4
	Parameters: 8
	Flags: Linked
*/
function function_33798535(var_31721422, a_str_zones, var_ed1db1a7, var_6cc77d4e = #"hash_683cf7d37afcc3ae", var_de0f1997 = 45, var_f7c3c527 = 60, var_232e4ebc = 0, var_b96be97f = undefined)
{
	level notify(#"hash_54000f24a644ad32");
	level endoncallback(&function_a5f4503c, #"end_game", #"hash_54000f24a644ad32");
	if(!isdefined(a_str_zones))
	{
		a_str_zones = [];
	}
	else if(!isarray(a_str_zones))
	{
		a_str_zones = array(a_str_zones);
	}
	level flag::wait_till("start_zombie_round_logic");
	function_1aaa4f63(1, 5);
	var_33747ab1 = level flag::get("disable_special_rounds");
	level flag::set(#"disable_special_rounds");
	level.var_35da2d77 = function_d7db256e(var_ed1db1a7, var_6cc77d4e, undefined, var_b96be97f);
	level notify(#"creating_zone_defend_area", {#n_obj_id:level.var_35da2d77});
	level.var_9149f3ac = var_ed1db1a7;
	level.var_54f329be = undefined;
	foreach(player in level.activeplayers)
	{
		player thread function_766eff6(var_31721422, a_str_zones, var_de0f1997, var_f7c3c527);
		player thread function_f7bb860a();
	}
	level thread function_3b09971f(var_ed1db1a7, var_de0f1997, a_str_zones);
	level thread play_sound_2d("zmb_rush_defend_start");
	level thread zm_audio::sndannouncerplayvox(#"hash_1b1ab77bf244b15b", undefined, undefined, undefined, 1);
	level flag::wait_till("started_defend_area");
	level thread zm_audio::sndannouncerplayvox(#"defend_start", undefined, undefined, undefined, 1, 1);
	level thread function_be8f8c85();
	level thread function_1f9d70f7(var_f7c3c527);
	if(var_232e4ebc > 0)
	{
		waittillframeend();
		function_26a5066b(level.round_number, var_232e4ebc);
	}
	zm_bgb_anywhere_but_here::function_886fce8f(0);
	function_9757d4d2(1);
	callback::on_ai_damage(&function_6ca0c2d9);
	callback::on_ai_killed(&function_d40910b4);
	if(level flag::exists(#"disable_fast_travel") && (!(isdefined(level.var_81c681aa) && level.var_81c681aa)))
	{
		level flag::set(#"disable_fast_travel");
	}
	level waittill(#"hash_7a04a7fb98fa4e4d");
	if(level flag::exists(#"disable_fast_travel"))
	{
		level flag::clear(#"disable_fast_travel");
	}
	level thread play_sound_2d("zmb_rush_defend_end");
	level thread zm_audio::sndannouncerplayvox(#"defend_complete", undefined, undefined, undefined, 1, 1);
	if(!var_33747ab1)
	{
		level flag::clear(#"disable_special_rounds");
	}
	zm_bgb_anywhere_but_here::function_886fce8f(1);
	level flag::clear("started_defend_area");
	foreach(player in level.players)
	{
		player thread zm_equipment::show_hint_text(#"hash_5c4b994618e485b6");
	}
	if(!isdefined(level.var_ae5daa6e))
	{
		s_defend_area = struct::get(var_ed1db1a7);
		level.var_ae5daa6e = s_defend_area.origin;
		playsoundatposition(#"hash_6124e4ccaf068cd0", level.var_ae5daa6e);
		level thread function_4a25b584(level.var_ae5daa6e, 20, 800, 1, 0.25);
		callback::remove_on_ai_killed(&function_6ca0c2d9);
		callback::remove_on_ai_killed(&function_d40910b4);
	}
	level.var_ae5daa6e = undefined;
	function_b1f3be5c(level.var_35da2d77, level.var_9149f3ac);
	level.var_35da2d77 = undefined;
	switch(level.players.size)
	{
		case 1:
		{
			n_wait_time = 8;
			break;
		}
		case 2:
		{
			n_wait_time = 10;
			break;
		}
		default:
		{
			n_wait_time = 12;
		}
	}
	wait(n_wait_time);
	function_9757d4d2();
}

/*
	Name: function_be8f8c85
	Namespace: zm_utility
	Checksum: 0xB0535404
	Offset: 0x36E0
	Size: 0x9A
	Parameters: 0
	Flags: Linked
*/
function function_be8f8c85()
{
	a_ai_enemies = getaiteamarray(level.zombie_team);
	foreach(ai in a_ai_enemies)
	{
		ai.var_3acacb18 = undefined;
		ai.var_d646708c = undefined;
	}
}

/*
	Name: function_3b09971f
	Namespace: zm_utility
	Checksum: 0x9E6BEE1E
	Offset: 0x3788
	Size: 0x370
	Parameters: 3
	Flags: Linked
*/
function function_3b09971f(var_ed1db1a7, var_de0f1997, a_str_zones)
{
	level endon(#"end_game", #"started_defend_area", #"hash_7a04a7fb98fa4e4d");
	if(level.players.size == 1)
	{
		return;
	}
	s_defend_area = struct::get(var_ed1db1a7);
	n_time = var_de0f1997;
	n_time_elapsed = 0;
	var_d2f964c9 = 0;
	var_959457a1 = 0;
	while(var_de0f1997 >= 0)
	{
		b_any_player_in_zone = 0;
		foreach(player in level.activeplayers)
		{
			if(player zm_zonemgr::is_player_in_zone(a_str_zones))
			{
				b_any_player_in_zone = 1;
				break;
			}
		}
		if(b_any_player_in_zone && n_time_elapsed >= 5)
		{
			playsoundatposition(#"hash_5755957467fab7c0", s_defend_area.origin);
			var_d2f964c9++;
			switch(var_d2f964c9)
			{
				case 1:
				{
					var_959457a1 = level.activeplayers.size * 1;
					break;
				}
				case 2:
				{
					var_959457a1 = level.activeplayers.size * 1.5;
					break;
				}
				case 3:
				{
					var_959457a1 = level.activeplayers.size * 1.75;
					break;
				}
				case 4:
				{
					var_959457a1 = level.activeplayers.size * 2;
					break;
				}
				default:
				{
					var_959457a1 = level.activeplayers.size * 3;
					break;
				}
			}
			var_959457a1 = ceil(var_959457a1);
			level thread function_6cb904e2(s_defend_area.origin, var_959457a1, randomintrange(750, 1000), 1, 0.2);
			n_time_elapsed = 0;
		}
		if(b_any_player_in_zone && var_de0f1997 < 10 && (!(isdefined(level.var_54f329be) && level.var_54f329be)))
		{
			function_9757d4d2(1);
			level.var_54f329be = 1;
		}
		wait(1);
		n_time_elapsed++;
		var_de0f1997--;
	}
}

/*
	Name: function_1f9d70f7
	Namespace: zm_utility
	Checksum: 0x16781576
	Offset: 0x3B00
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function function_1f9d70f7(var_57465a1b)
{
	if(!isdefined(level.zombie_powerups[#"nuke"]))
	{
		return;
	}
	var_f67c3dcd = level.zombie_powerups[#"nuke"].func_should_drop_with_regular_powerups;
	zm_powerups::powerup_remove_from_regular_drops(#"nuke");
	n_wait = var_57465a1b * 0.9;
	wait(n_wait);
	level.zombie_powerups[#"nuke"].func_should_drop_with_regular_powerups = var_f67c3dcd;
}

/*
	Name: function_a5f4503c
	Namespace: zm_utility
	Checksum: 0xBDEFB76A
	Offset: 0x3BC0
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function function_a5f4503c(str_notify)
{
	function_b1f3be5c(level.var_35da2d77, level.var_9149f3ac);
	level flag::clear("started_defend_area");
	function_9757d4d2();
	level.var_ae5daa6e = undefined;
}

/*
	Name: function_d40910b4
	Namespace: zm_utility
	Checksum: 0xF6F2926F
	Offset: 0x3C30
	Size: 0x204
	Parameters: 1
	Flags: Linked
*/
function function_d40910b4(params)
{
	a_ai_zombies = zombie_utility::get_round_enemy_array();
	if(!(isdefined(self.ignore_enemy_count) && self.ignore_enemy_count) && a_ai_zombies.size == 1 && level.zombie_total <= 0 && !level flag::get("infinite_round_spawning"))
	{
		v_start = self.origin + vectorscale((0, 0, 1), 8);
		if(isdefined(self.var_c39323b5) && self.var_c39323b5 || (!(check_point_in_playable_area(v_start) && check_point_in_enabled_zone(v_start))) || (isdefined(self.nuked) && self.nuked))
		{
			if(isdefined(level.var_9149f3ac))
			{
				s_defend_area = struct::get(level.var_9149f3ac);
				v_start = s_defend_area.origin;
			}
		}
		level.var_ae5daa6e = v_start;
		playsoundatposition(#"hash_6124e4ccaf068cd0", level.var_ae5daa6e);
		level thread function_4a25b584(level.var_ae5daa6e, 20, 800, 1, 0.25);
		callback::remove_on_ai_killed(&function_6ca0c2d9);
		callback::remove_on_ai_killed(&function_d40910b4);
	}
}

/*
	Name: function_6ca0c2d9
	Namespace: zm_utility
	Checksum: 0x74FC38E5
	Offset: 0x3E40
	Size: 0x16A
	Parameters: 1
	Flags: Linked
*/
function function_6ca0c2d9(params)
{
	if(self.var_6f84b820 !== #"miniboss" && self.var_6f84b820 !== #"heavy")
	{
		return;
	}
	a_ai_enemies = getaiteamarray(level.zombie_team);
	var_5d4b3bca = 0;
	foreach(ai in a_ai_enemies)
	{
		if(ai.var_6f84b820 === #"miniboss" || ai.var_6f84b820 === #"heavy")
		{
			var_5d4b3bca++;
		}
	}
	if(isplayer(params.eattacker) && var_5d4b3bca == a_ai_enemies.size)
	{
		n_damage = params.idamage * 2;
		return n_damage;
	}
}

/*
	Name: function_f7bb860a
	Namespace: zm_utility
	Checksum: 0xB64ACD3B
	Offset: 0x3FB8
	Size: 0x29E
	Parameters: 0
	Flags: Linked
*/
function function_f7bb860a()
{
	self endon(#"disconnect");
	s_defend_area = struct::get(level.var_9149f3ac);
	var_88febab4 = generatenavmeshpath(self.origin, s_defend_area.origin);
	if(isdefined(var_88febab4) && isarray(var_88febab4.pathpoints) && var_88febab4.status === "succeeded")
	{
		var_7819779 = arraysortclosest(var_88febab4.pathpoints, self.origin, undefined, 400);
		if(isdefined(var_7819779[0]))
		{
			var_db7e2eef = var_7819779[0];
		}
		if(isdefined(var_db7e2eef) && function_25e3484e(var_db7e2eef))
		{
			function_ce46d95e(var_db7e2eef, 0, 0);
			wait(0.5);
		}
		for(i = 1; i < var_7819779.size; i++)
		{
			var_44863c4e = distance(var_7819779[i], var_db7e2eef);
			var_2ffd5b7f = distance(s_defend_area.origin, var_db7e2eef);
			if(var_2ffd5b7f > 400 && var_44863c4e > 400 && function_25e3484e(var_7819779[i]))
			{
				function_ce46d95e(var_7819779[i], 0, 0);
				var_db7e2eef = var_7819779[i];
				wait(0.5);
			}
		}
		if(function_25e3484e(s_defend_area.origin) && !isdefined(s_defend_area.e_powerup))
		{
			s_defend_area.e_powerup = function_ce46d95e(s_defend_area.origin, 1, 0);
		}
	}
}

/*
	Name: function_766eff6
	Namespace: zm_utility
	Checksum: 0x49EB1133
	Offset: 0x4260
	Size: 0x7B8
	Parameters: 4
	Flags: Linked
*/
function function_766eff6(var_31721422, a_str_zones, var_de0f1997, var_f7c3c527)
{
	self endon(#"disconnect");
	level endon(#"end_game", #"hash_7a04a7fb98fa4e4d");
	self.var_fd3dfced = 0;
	if(level.var_f995ece6 zm_trial_timer::is_open(self))
	{
		level.var_f995ece6 zm_trial_timer::close(self);
	}
	zm_trial_util::stop_timer();
	waitframe(1);
	level.var_f995ece6 zm_trial_timer::open(self);
	level.var_f995ece6 zm_trial_timer::set_timer_text(self, var_31721422);
	self zm_trial_util::start_timer(var_de0f1997);
	s_defend_area = struct::get(level.var_9149f3ac);
	n_time = var_de0f1997;
	while(n_time >= 0)
	{
		if(n_time <= 30 && (n_time % 5) == 0 || n_time <= 10)
		{
			self playsoundtoplayer(#"hash_531658e82d2845f7", self);
		}
		var_cb24ec97 = 1;
		foreach(player in level.activeplayers)
		{
			if(!isalive(player) || player.sessionstate === "spectator")
			{
				continue;
			}
			if(!player zm_zonemgr::is_player_in_zone(a_str_zones))
			{
				var_cb24ec97 = 0;
				break;
			}
		}
		if(var_cb24ec97)
		{
			foreach(player in level.activeplayers)
			{
				if(isalive(player))
				{
					level.var_f995ece6 zm_trial_timer::close(player);
				}
			}
			break;
		}
		else
		{
			foreach(player in level.activeplayers)
			{
				if(isalive(player) && player zm_zonemgr::is_player_in_zone(a_str_zones))
				{
					player notify(#"hash_b696fc900429737");
					if(!(isdefined(player.var_fd3dfced) && player.var_fd3dfced))
					{
						player.var_fd3dfced = 1;
						level.var_f995ece6 zm_trial_timer::set_timer_text(player, #"hash_64e686d0e2a5bfcb");
					}
					continue;
				}
				if(isalive(player) && !player zm_zonemgr::is_player_in_zone(a_str_zones) && (isdefined(player.var_fd3dfced) && player.var_fd3dfced))
				{
					player.var_fd3dfced = 0;
					level.var_f995ece6 zm_trial_timer::set_timer_text(player, var_31721422);
				}
			}
		}
		n_time--;
		if(n_time >= 0)
		{
			wait(1);
		}
	}
	if(level.var_f995ece6 zm_trial_timer::is_open(self))
	{
		level.var_f995ece6 zm_trial_timer::close(self);
	}
	self zm_trial_util::stop_timer();
	waitframe(1);
	if(self zm_zonemgr::is_player_in_zone(a_str_zones))
	{
		self function_ba39d198(level.var_35da2d77, 0);
		self.var_fd3dfced = 1;
		self playsoundtoplayer(#"hash_519872be58d1c467", self);
		self thread zm_equipment::show_hint_text(#"hash_215c2a48351115a1");
	}
	else
	{
		self function_ba39d198(level.var_35da2d77, 1);
		self.var_fd3dfced = 0;
		self thread player_left_zone(a_str_zones, 15, 1);
	}
	level flag::set("started_defend_area");
	waitframe(1);
	var_dd433f03 = 0;
	level.var_a286b947 = undefined;
	level.var_e0b78e03 = undefined;
	self thread function_7042bcf9(a_str_zones);
	while(var_f7c3c527 >= 0 || (!(isdefined(level.var_e0b78e03) && level.var_e0b78e03)))
	{
		if(self.var_fd3dfced)
		{
			var_dd433f03++;
		}
		if(var_f7c3c527 <= 0 && (!(isdefined(level.var_a286b947) && level.var_a286b947)))
		{
			level.var_a286b947 = 1;
			level flag::clear(#"infinite_round_spawning");
			level flag::clear(#"pause_round_timeout");
			level thread function_1aaa4f63(1);
		}
		wait(1);
		var_f7c3c527--;
	}
	if(level.var_f995ece6 zm_trial_timer::is_open(self))
	{
		level.var_f995ece6 zm_trial_timer::close(self);
	}
	self clientfield::set_to_player("zm_zone_out_of_bounds", 0);
	self zm_trial_util::stop_timer();
	level notify(#"hash_7a04a7fb98fa4e4d");
}

/*
	Name: function_7042bcf9
	Namespace: zm_utility
	Checksum: 0x512A2899
	Offset: 0x4A20
	Size: 0x1DE
	Parameters: 1
	Flags: Linked
*/
function function_7042bcf9(a_str_zones)
{
	self endon(#"disconnect");
	level endon(#"end_game", #"hash_7a04a7fb98fa4e4d");
	while(true)
	{
		if(!self.var_fd3dfced && self zm_zonemgr::is_player_in_zone(a_str_zones))
		{
			self function_ba39d198(level.var_35da2d77, 0);
			self.var_fd3dfced = 1;
			self playsoundtoplayer(#"hash_519872be58d1c467", self);
			self clientfield::set_to_player("zm_zone_out_of_bounds", 0);
			self thread zm_equipment::show_hint_text(#"hash_215c2a48351115a1", 1);
			if(level.var_f995ece6 zm_trial_timer::is_open(self))
			{
				level.var_f995ece6 zm_trial_timer::close(self);
			}
			self zm_trial_util::stop_timer();
		}
		else if(self.var_fd3dfced && !self zm_zonemgr::is_player_in_zone(a_str_zones))
		{
			self function_ba39d198(level.var_35da2d77, 1);
			self.var_fd3dfced = 0;
			self thread player_left_zone(a_str_zones);
		}
		waitframe(1);
	}
}

/*
	Name: player_left_zone
	Namespace: zm_utility
	Checksum: 0x83FF83D1
	Offset: 0x4C08
	Size: 0x738
	Parameters: 3
	Flags: Linked
*/
function player_left_zone(a_str_zones, var_8e2567b1, var_9faecc20)
{
	self endon(#"disconnect");
	level endoncallback(&function_4cf5b2e1, #"end_game", #"hash_7a04a7fb98fa4e4d");
	while(true)
	{
		n_time = (isdefined(var_8e2567b1) ? var_8e2567b1 : 5);
		if(!self zm_zonemgr::is_player_in_zone(a_str_zones) && self.sessionstate !== "spectator")
		{
			if(level.var_f995ece6 zm_trial_timer::is_open(self))
			{
				level.var_f995ece6 zm_trial_timer::close(self);
			}
			if(!(isdefined(var_9faecc20) && var_9faecc20))
			{
				waitframe(1);
				if(!level.var_f995ece6 zm_trial_timer::is_open(self))
				{
					level.var_f995ece6 zm_trial_timer::open(self);
					level.var_f995ece6 zm_trial_timer::set_timer_text(self, #"hash_4bef74a6e7f21aa0");
					self zm_trial_util::start_timer(n_time);
				}
			}
			else
			{
				if(level.var_f995ece6 zm_trial_timer::is_open(self))
				{
					level.var_f995ece6 zm_trial_timer::close(self);
				}
				self zm_trial_util::stop_timer();
			}
		}
		else
		{
			if(level.var_f995ece6 zm_trial_timer::is_open(self))
			{
				level.var_f995ece6 zm_trial_timer::close(self);
			}
			self zm_trial_util::stop_timer();
		}
		while(true)
		{
			if(self zm_zonemgr::is_player_in_zone(a_str_zones) && self.sessionstate !== "spectator")
			{
				if(level.var_f995ece6 zm_trial_timer::is_open(self))
				{
					level.var_f995ece6 zm_trial_timer::close(self);
				}
				self zm_trial_util::stop_timer();
				return;
			}
			if(n_time <= 0 || (isdefined(var_9faecc20) && var_9faecc20) && (!(isdefined(self.var_16735873) && self.var_16735873)))
			{
				if(level.var_f995ece6 zm_trial_timer::is_open(self))
				{
					level.var_f995ece6 zm_trial_timer::close(self);
					self zm_trial_util::stop_timer();
				}
			}
			if(isdefined(var_9faecc20) && var_9faecc20)
			{
				var_16e6b8ea = self function_7618c8ef(0.0667);
				if(!(isdefined(self.var_16735873) && self.var_16735873))
				{
					self dodamage(var_16e6b8ea, self.origin);
				}
			}
			else
			{
				if(self clientfield::get_to_player("zm_zone_out_of_bounds") == 0)
				{
					self clientfield::set_to_player("zm_zone_out_of_bounds", 1);
				}
				switch(n_time)
				{
					case 5:
					{
						n_damage = int(self.maxhealth * (10 / self.maxhealth));
						break;
					}
					case 4:
					{
						n_damage = int(self.maxhealth * (20 / self.maxhealth));
						break;
					}
					case 3:
					{
						n_damage = int(self.maxhealth * (30 / self.maxhealth));
						break;
					}
					case 2:
					{
						n_damage = int(self.maxhealth * (40 / self.maxhealth));
						break;
					}
					case 1:
					{
						n_damage = int(self.maxhealth * (45 / self.maxhealth));
						break;
					}
					default:
					{
						n_damage = int(self.maxhealth * (150 / self.maxhealth));
						break;
					}
				}
				if(!(isdefined(self.var_16735873) && self.var_16735873))
				{
					self dodamage(n_damage, self.origin);
				}
			}
			if(!isalive(self) || self laststand::player_is_in_laststand())
			{
				break;
			}
			wait(1);
			n_time--;
		}
		if(isalive(self) && !self laststand::player_is_in_laststand())
		{
			self dodamage(self.health + 666, self.origin);
		}
		if(!isalive(self) || self laststand::player_is_in_laststand())
		{
			self clientfield::set_to_player("zm_zone_out_of_bounds", 0);
			self waittill(#"player_revived", #"hash_387bb170e38042d5");
			self function_ac41a624();
		}
	}
}

/*
	Name: function_4cf5b2e1
	Namespace: zm_utility
	Checksum: 0xE8DCD900
	Offset: 0x5348
	Size: 0xE8
	Parameters: 1
	Flags: Linked
*/
function function_4cf5b2e1(str_notify)
{
	foreach(player in level.players)
	{
		if(level.var_f995ece6 zm_trial_timer::is_open(player))
		{
			level.var_f995ece6 zm_trial_timer::close(player);
		}
		player clientfield::set_to_player("zm_zone_out_of_bounds", 0);
		player zm_trial_util::stop_timer();
	}
}

/*
	Name: function_ac41a624
	Namespace: zm_utility
	Checksum: 0xE3C8E274
	Offset: 0x5438
	Size: 0x274
	Parameters: 0
	Flags: Linked
*/
function function_ac41a624()
{
	self endon(#"disconnect");
	level endon(#"end_game", #"hash_7a04a7fb98fa4e4d");
	if(!isdefined(level.var_9149f3ac))
	{
		return;
	}
	s_objective = struct::get(level.var_9149f3ac);
	v_origin = self.origin;
	v_angles = self.angles;
	if(check_point_in_playable_area(s_objective.origin) && !positionwouldtelefrag(s_objective.origin))
	{
		v_origin = s_objective.origin;
		v_angles = s_objective.angles;
	}
	else
	{
		s_result = positionquery_source_navigation(s_objective.origin, 32, 1024, 64, 64);
		if(isdefined(s_result) && isarray(s_result.data))
		{
			foreach(var_c310df8c in s_result.data)
			{
				if(check_point_in_playable_area(var_c310df8c.origin) && check_point_in_enabled_zone(var_c310df8c.origin) && !positionwouldtelefrag(var_c310df8c.origin))
				{
					v_origin = var_c310df8c.origin;
					v_angles = self.angles;
					break;
				}
			}
		}
	}
	self setorigin(v_origin);
	self setplayerangles(v_angles);
}

/*
	Name: function_1aaa4f63
	Namespace: zm_utility
	Checksum: 0x64092982
	Offset: 0x56B8
	Size: 0x13E
	Parameters: 2
	Flags: Linked
*/
function function_1aaa4f63(var_3534ec82 = 1, var_f24b3f7a = 0)
{
	level.var_e0b78e03 = undefined;
	if(level flag::get("special_round"))
	{
		level waittill(#"end_of_round");
	}
	level flag::clear("spawn_zombies");
	if(var_3534ec82)
	{
		a_ai_enemies = getaiteamarray(level.zombie_team);
		while(a_ai_enemies.size > var_f24b3f7a)
		{
			a_ai_enemies = getaiteamarray(level.zombie_team);
			waitframe(1);
		}
	}
	else
	{
		a_ai_enemies = zombie_utility::get_round_enemy_array();
		while(a_ai_enemies.size > var_f24b3f7a)
		{
			a_ai_enemies = zombie_utility::get_round_enemy_array();
			waitframe(1);
		}
	}
	level.var_e0b78e03 = 1;
}

/*
	Name: function_9757d4d2
	Namespace: zm_utility
	Checksum: 0x85A5A9EE
	Offset: 0x5800
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_9757d4d2(var_35105434 = 0)
{
	level flag::set("spawn_zombies");
	if(var_35105434)
	{
		level flag::set(#"infinite_round_spawning");
		level flag::set(#"pause_round_timeout");
	}
}

/*
	Name: function_2959a3cb
	Namespace: zm_utility
	Checksum: 0x43380A9A
	Offset: 0x5888
	Size: 0x4A
	Parameters: 2
	Flags: None
*/
function function_2959a3cb(str_archetype, var_99dc2928)
{
	if(!isdefined(level.var_f696e6b))
	{
		level.var_f696e6b = [];
	}
	level.var_f696e6b[str_archetype] = var_99dc2928;
}

/*
	Name: function_9b7bc715
	Namespace: zm_utility
	Checksum: 0x49FB141D
	Offset: 0x58E0
	Size: 0x7B2
	Parameters: 2
	Flags: Linked
*/
function function_9b7bc715(str_archetype, var_f6e469ad = 1)
{
	if(!isdefined(level.arena_twist))
	{
		level.arena_twist = [];
	}
	if(!isdefined(level.arena_twist[str_archetype]))
	{
		level.arena_twist[str_archetype] = 0;
	}
	if(var_f6e469ad && level.arena_twist[str_archetype])
	{
		return;
	}
	level thread play_sound_2d("zmb_rush_monster_incoming");
	if(isarray(level.var_f696e6b) && isdefined(level.var_f696e6b[str_archetype]))
	{
		[[level.var_f696e6b[str_archetype]]]();
		level.arena_twist[str_archetype] = 1;
		return;
	}
	switch(str_archetype)
	{
		case "brutus":
		{
			level function_e64ac3b6(9, #"hash_512b6a89a741df7e");
			level thread zm_audio::sndannouncerplayvox(#"warden", undefined, undefined, undefined, 1);
			break;
		}
		case "catalyst":
		{
			level function_e64ac3b6(1, #"hash_451da0cb46417560");
			level thread zm_audio::sndannouncerplayvox(#"catalyst", undefined, undefined, undefined, 1);
			break;
		}
		case "catalyst_corrosive":
		{
			level function_e64ac3b6(1, #"hash_7641ba4524584595");
			level thread zm_audio::sndannouncerplayvox(#"catalyst", undefined, undefined, undefined, 1);
			break;
		}
		case "catalyst_electric":
		{
			level function_e64ac3b6(1, #"hash_70c3cc5975b6ae66");
			level thread zm_audio::sndannouncerplayvox(#"catalyst", undefined, undefined, undefined, 1);
			break;
		}
		case "catalyst_plasma":
		{
			level function_e64ac3b6(1, #"hash_462ab08cca184367");
			level thread zm_audio::sndannouncerplayvox(#"catalyst", undefined, undefined, undefined, 1);
			break;
		}
		case "catalyst_water":
		{
			level function_e64ac3b6(1, #"hash_44038d25e4255a68");
			level thread zm_audio::sndannouncerplayvox(#"catalyst", undefined, undefined, undefined, 1);
			break;
		}
		case "stoker":
		{
			level function_e64ac3b6(2, #"hash_602a33d6118f86cd");
			var_fe5fbf66 = array::random(array(#"stoker", #"incoming_stoker"));
			level thread zm_audio::sndannouncerplayvox(var_fe5fbf66, undefined, undefined, undefined, 1);
			break;
		}
		case "blight_father":
		{
			level function_e64ac3b6(3, #"hash_32d0a8ef63f997f0");
			var_62af6f1 = array::random(array(#"incoming_blight_father", #"blightfather"));
			level thread zm_audio::sndannouncerplayvox(var_62af6f1, undefined, undefined, undefined, 1);
			break;
		}
		case "gladiator":
		{
			level function_e64ac3b6(6, #"hash_5883640bac1406cc");
			level thread zm_audio::sndannouncerplayvox(#"incoming_heavy", undefined, undefined, undefined, 1);
			break;
		}
		case "gladiator_destroyer":
		{
			level function_e64ac3b6(6, #"hash_63690aa1bddde5a");
			level thread zm_audio::sndannouncerplayvox(#"destroyer", undefined, undefined, undefined, 1);
			break;
		}
		case "gladiator_marauder":
		{
			level function_e64ac3b6(5, #"hash_33dd4b2b1f843b78");
			level thread zm_audio::sndannouncerplayvox(#"marauder", undefined, undefined, undefined, 1);
			break;
		}
		case "tiger":
		{
			level function_e64ac3b6(4, #"hash_767128c196a4a356");
			var_68f478a5 = array::random(array(#"zmb_tigers", #"tigers"));
			level thread zm_audio::sndannouncerplayvox(var_68f478a5, undefined, undefined, undefined, 1);
			break;
		}
		case "zombie_dog":
		{
			level function_e64ac3b6(7, #"hash_75a75e4d68452af4");
			level thread zm_audio::sndannouncerplayvox(#"hellhound", undefined, undefined, undefined, 1);
			break;
		}
		case "nova_crawler":
		{
			level function_e64ac3b6(8, #"hash_60c4c04f5603c612");
			level thread zm_audio::sndannouncerplayvox(#"nova_6", undefined, undefined, undefined, 1);
			break;
		}
	}
	level.arena_twist[str_archetype] = 1;
}

/*
	Name: function_6cb904e2
	Namespace: zm_utility
	Checksum: 0xC4134C6C
	Offset: 0x60A0
	Size: 0x84
	Parameters: 5
	Flags: Linked
*/
function function_6cb904e2(v_start_pos, var_487ba56d, n_radius = 512, b_randomize = 1, var_79ced64 = 0.2)
{
	function_4a25b584(v_start_pos, var_487ba56d, n_radius, b_randomize, var_79ced64);
}

/*
	Name: function_92162963
	Namespace: zm_utility
	Checksum: 0x5DCCA4B7
	Offset: 0x6130
	Size: 0xB8
	Parameters: 2
	Flags: None
*/
function function_92162963(var_b9fefaba, b_permanent = 0)
{
	a_s_start_points = struct::get_array(var_b9fefaba);
	foreach(s_start_point in a_s_start_points)
	{
		s_start_point thread function_72725f77(b_permanent);
	}
}

/*
	Name: function_72725f77
	Namespace: zm_utility
	Checksum: 0xC2846615
	Offset: 0x61F0
	Size: 0xF8
	Parameters: 1
	Flags: Linked
*/
function function_72725f77(b_permanent = 0)
{
	if(!isdefined(self.e_powerup))
	{
		self.e_powerup = self function_ce46d95e(self.origin, b_permanent);
	}
	if(isdefined(self.target))
	{
		var_15e1b0e8 = struct::get_array(self.target);
		foreach(var_bf81efe4 in var_15e1b0e8)
		{
			var_bf81efe4 function_72725f77(b_permanent);
		}
	}
}

/*
	Name: enable_power_switch
	Namespace: zm_utility
	Checksum: 0xC831E9EC
	Offset: 0x62F0
	Size: 0x2D0
	Parameters: 5
	Flags: None
*/
function enable_power_switch(b_enable = 0, var_909e9d3d = 0, str_value, str_key, var_34451c07)
{
	if(isdefined(str_value) && isdefined(str_key))
	{
		a_t_power = getentarray(str_value, str_key);
	}
	else
	{
		a_t_power = getentarray("use_elec_switch", "targetname");
	}
	if(b_enable)
	{
		var_c996d382 = 0;
		foreach(t_power in a_t_power)
		{
			t_power.var_b9eb2dbb = undefined;
			t_power setvisibletoall();
			if(var_909e9d3d)
			{
				player = arraygetclosest(t_power.origin, level.activeplayers);
				t_power notify(#"trigger", {#activator:player});
				if(!var_c996d382)
				{
					var_c996d382 = 1;
					level util::delay(4, "end_game", &array::thread_all, getplayers(), &zm_equipment::show_hint_text, #"hash_5bdc1f7024280e4e");
					level thread zm_audio::sndannouncerplayvox(#"power_activated");
				}
			}
		}
	}
	else
	{
		foreach(t_power in a_t_power)
		{
			if(isdefined(var_34451c07))
			{
				t_power.var_b9eb2dbb = 1;
				t_power sethintstring(var_34451c07);
				continue;
			}
			t_power setinvisibletoall();
		}
	}
}

