// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\weapons\zm_weap_flamethrower.gsc;
#using scripts\zm\weapons\zm_weap_gravityspikes.gsc;
#using scripts\zm\weapons\zm_weap_katana.gsc;
#using scripts\zm\weapons\zm_weap_minigun.gsc;
#using scripts\zm\zm_white_devgui.gsc;
#using scripts\zm\zm_white_trials.gsc;
#using scripts\zm\zm_white_trophies.gsc;
#using script_34b02db2817b42f;
#using script_5f9141e04e4e94a2;
#using script_74608ad5d25450b1;
#using script_3122530a9381e18b;
#using scripts\zm\zm_white_ww_quest_modkit.gsc;
#using script_724752ab26bff81b;
#using scripts\zm\zm_white_lighting.gsc;
#using scripts\zm\zm_white_special_rounds.gsc;
#using scripts\zm\zm_white_mee.gsc;
#using scripts\zm\zm_white_fx.gsc;
#using scripts\zm\zm_white_portals.gsc;
#using scripts\zm\zm_white_toast.gsc;
#using script_621434df66e97145;
#using script_1c1d447ddbce2c00;
#using script_25b8e6a85a7f8635;
#using scripts\zm\zm_white_insanity_mode.gsc;
#using script_48dd035d23bf8844;
#using scripts\zm\zm_white_doomsday_clock.gsc;
#using script_78e9e286015f2ec;
#using script_2da1a66a13e2bbe1;
#using script_2f877a0752174fc1;
#using scripts\zm\zm_white_zones.gsc;
#using scripts\zm\zm_white_util.gsc;
#using scripts\zm\zm_white_zstandard.gsc;
#using scripts\zm\zm_white_gamemodes.gsc;
#using scripts\zm\zm_hms_util.gsc;
#using script_ab862743b3070a;
#using scripts\zm\weapons\zm_weap_claymore.gsc;
#using scripts\zm\weapons\zm_weap_cymbal_monkey.gsc;
#using scripts\zm\weapons\zm_weap_riotshield.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_characters.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm_common\zm_sq.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_wallbuy.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_ui_inventory.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_round_spawning.gsc;
#using scripts\zm_common\zm_power.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\load.gsc;
#using scripts\zm_common\callbacks.gsc;
#using script_67c9a990c0db216c;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

#namespace zm_white;

/*
	Name: opt_in
	Namespace: zm_white
	Checksum: 0x190C9BAF
	Offset: 0xC68
	Size: 0x62
	Parameters: 0
	Flags: AutoExec
*/
function autoexec opt_in()
{
	level.aat_in_use = 1;
	level.bgb_in_use = 1;
	level.bgb_machine_count = 2;
	level.random_pandora_box_start = 1;
	level.pack_a_punch_camo_index = 345;
	level.pack_a_punch_camo_index_number_variants = 1;
}

/*
	Name: main
	Namespace: zm_white
	Checksum: 0x65E1471
	Offset: 0xCD8
	Size: 0xC74
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	setclearanceceiling(17);
	level thread lui::add_luimenu("full_screen_movie", &full_screen_movie::register, "full_screen_movie");
	level thread function_d0f18ffe();
	level.custom_spawner_entry[#"crawl"] = &zm_white_special_rounds::function_45bb11e4;
	level.var_ddcd74c6 = &zm_white_special_rounds::function_f79e10f9;
	level.var_c02e63 = &zm_white_util::function_5d7d0c85;
	level._no_vending_machine_auto_collision = 1;
	level._uses_default_wallbuy_fx = 1;
	level._uses_sticky_grenades = 1;
	level._uses_taser_knuckles = 1;
	level.var_c1013f84 = 1;
	level.registertheater_fxanim_kill_trigger_centerterminatetraverse = 2250000;
	level.var_18d20774 = 1000000;
	level.var_7199d651 = 1;
	level.temporary_power_switch_logic = &zm_power::electric_switch;
	level.var_61afcb81 = 64;
	namespace_9efb8d22::init_fx();
	level.var_ef785c4c = 0;
	level thread init_pap();
	clientfield::register("scriptmover", "" + #"hash_28b770e7e782837", 1, 1, "int");
	clientfield::register("world", "portal_map_magicbox_lights_init", 1, 1, "int");
	clientfield::register("world", "portal_map_start_chest1", 1, 1, "int");
	clientfield::register("world", "portal_map_start_chest2", 1, 1, "int");
	clientfield::register("world", "portal_map_green_backyard_chest", 1, 1, "int");
	clientfield::register("world", "portal_map_yellow_backyard_chest", 1, 1, "int");
	clientfield::register("world", "portal_map_bunker1_chest", 1, 1, "int");
	clientfield::register("world", "portal_map_bunker2_chest", 1, 1, "int");
	clientfield::register("world", "portal_map_cul_de_sac_chest", 1, 1, "int");
	clientfield::register("world", "portal_map_fire_sale", 1, 1, "int");
	clientfield::register("world", "power_pbg_control", 1, 1, "int");
	zm::init_fx();
	clientfield::register("clientuimodel", "player_lives", 1, 2, "int");
	level._effect[#"headshot"] = "_t6/impacts/fx_flesh_hit";
	level._effect[#"headshot_nochunks"] = "_t6/misc/fx_zombie_bloodsplat";
	level._effect[#"bloodspurt"] = "_t6/misc/fx_zombie_bloodspurt";
	level._effect[#"animscript_gib_fx"] = "zombie/fx_blood_torso_explo_zmb";
	level._effect[#"animscript_gibtrail_fx"] = "_t6/trail/fx_trail_blood_streak";
	level._effect[#"switch_sparks"] = "_t6/env/electrical/fx_elec_wire_spark_burst";
	level.default_game_mode = "zclassic";
	level.var_22fda912 = &function_9f50079d;
	level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
	level.var_d0ab70a2 = #"hash_6dcfc619b819ab4f";
	level._allow_melee_weapon_switching = 1;
	level.var_161cb00c = 1;
	level.registerobjective_qzonejukeinit = 0;
	level zm_white_special_rounds::register_clientfields();
	level zm_white_zstandard::register_clientfields();
	level zm_white_portals::init_clientfields();
	level zm_white_mee::preload();
	level zm_white_toast::preload();
	level namespace_a01a2431::preload();
	level namespace_87b5173f::preload();
	level namespace_ca03bbb4::preload();
	level namespace_3b2b9e06::preload();
	level namespace_825eac6b::preload();
	level namespace_90b0490e::preload();
	level namespace_7d8e6ec3::preload();
	level namespace_fddd83bd::init();
	load::main();
	setdvar(#"zombie_unlock_all", 0);
	level.zones = [];
	level.zone_manager_init_func = &zm_white_zones::zone_init;
	init_zones[0] = "zone_security_checkpoint";
	level thread zm_zonemgr::manage_zones(init_zones);
	level.random_pandora_box_start = 1;
	level thread function_785cadc4();
	level thread function_963beb87();
	level thread function_cf100865();
	level.start_chest_name = "start1_chest";
	level.open_chest_location = [];
	level.open_chest_location[0] = "start1_chest";
	level.open_chest_location[1] = "start2_chest";
	level.open_chest_location[3] = "green_backyard_chest";
	level.open_chest_location[4] = "yellow_backyard_chest";
	level.open_chest_location[5] = "bunker1_chest";
	level.open_chest_location[6] = "bunker2_chest";
	level.open_chest_location[7] = "cul_de_sac_chest";
	level._zombiemode_custom_box_move_logic = &function_d5d134ac;
	level thread sndfunctions();
	level thread zm_white_zones::init();
	level thread zm_white_fx::init();
	if(!zm_trial::is_trial_mode())
	{
		level thread zm_white_trophies::init();
	}
	level thread zm_white_util::init();
	flag::wait_till("start_zombie_round_logic");
	level notify(#"players_done_connecting");
	level thread zm_white_zones::function_fb29f7ca();
	level thread zm_white_portals::init();
	level thread zm_white_doomsday_clock::init();
	level thread namespace_a71af4de::init();
	level thread zm_white_special_rounds::init();
	level thread function_d574cfc6();
	level thread namespace_cc08081f::init();
	level thread namespace_7d8e6ec3::init();
	level thread zm_white_mee::init();
	level thread namespace_a01a2431::init();
	level thread namespace_87b5173f::init();
	level thread zm_white_ww_quest_modkit::init();
	level thread namespace_ca03bbb4::init();
	level thread namespace_3b2b9e06::init();
	level thread namespace_825eac6b::init();
	/#
		level thread zm_white_devgui::init();
	#/
	if(!zm_utility::is_standard())
	{
		level thread namespace_456de992::init();
	}
	if(level.round_number == 1 && (isdefined(level.enable_magic) && level.enable_magic) && level.gamedifficulty != 0)
	{
		level thread zm_white_mee::function_c4fbad3();
	}
	if(zm_utility::is_trials())
	{
		level thread zm_white_trials::main();
	}
	zm_ui_inventory::function_7df6bb60(#"zm_white_breakfast_trial", 0);
	zm_custom::function_a00576dd(undefined, undefined, &function_c8ce0a17, &function_e5086229);
	level.var_e120ae98 = &function_e120ae98;
	level thread function_7e6cf034();
	callback::on_grenade_fired(&zm_white_util::function_c05cc102);
	level thread function_814cda18();
	/#
		level thread white_devgui();
	#/
	level thread function_f684d327();
}

/*
	Name: function_f684d327
	Namespace: zm_white
	Checksum: 0x1C242176
	Offset: 0x1958
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_f684d327()
{
	level waittill(#"power_on1");
	if(!sessionmodeisprivate())
	{
		changeadvertisedstatus(0);
	}
}

/*
	Name: function_3a7f44f7
	Namespace: zm_white
	Checksum: 0xEB1CC232
	Offset: 0x19A8
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function function_3a7f44f7()
{
	level waittill(#"game_ended");
	zm_hms_util::function_3c173d37();
}

/*
	Name: function_814cda18
	Namespace: zm_white
	Checksum: 0x7BC41EEF
	Offset: 0x19E0
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_814cda18()
{
	var_d8f4b898 = getent("bread_door", "targetname");
	var_e1177b43 = 0;
	if(var_e1177b43)
	{
		var_d8f4b898 rotateto(var_d8f4b898.angles + (vectorscale((0, -1, 0), 170)), 1);
		var_d8f4b898 waittill(#"movedone");
	}
	var_d8f4b898 disconnectpaths();
	v_blocker = spawn("trigger_box", (-800, -1070, -132), 0, 408, 164, 132);
	v_blocker disconnectpaths();
}

/*
	Name: init_pap
	Namespace: zm_white
	Checksum: 0x8D52B9EC
	Offset: 0x1AF0
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function init_pap()
{
	level flag::init(#"pap_power_ready");
	level flag::init(#"power_on1");
	powered_on = function_98b78151();
	if(!powered_on)
	{
		level.pack_a_punch.custom_power_think = &function_9b917fd5;
		level thread function_ba054e47();
	}
	else
	{
		level.pack_a_punch.custom_power_think = &function_70a36cd8;
		level thread function_fb29042d();
	}
}

/*
	Name: function_98b78151
	Namespace: zm_white
	Checksum: 0xE39AA1D2
	Offset: 0x1BD0
	Size: 0x7E
	Parameters: 0
	Flags: Linked
*/
function function_98b78151()
{
	if(zm_custom::function_901b751c(#"zmpapenabled") == 0)
	{
		return false;
	}
	if(isdefined(level.var_ef785c4c) && level.var_ef785c4c || zm_custom::function_901b751c(#"zmpapenabled") == 2)
	{
		return true;
	}
	return false;
}

/*
	Name: pap_power_on
	Namespace: zm_white
	Checksum: 0x5D78525
	Offset: 0x1C58
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function pap_power_on()
{
	level flag::wait_till("pap_power_ready");
	self zm_pack_a_punch::function_bb629351(1);
	exploder::exploder("fxexp_script_pap_lgt");
	level flag::wait_till_clear("pap_power_ready");
	self pap_power_off();
}

/*
	Name: pap_power_off
	Namespace: zm_white
	Checksum: 0x33421521
	Offset: 0x1CF0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function pap_power_off()
{
	self zm_pack_a_punch::function_bb629351(0);
	exploder::kill_exploder("fxexp_script_pap_lgt");
	self pap_power_on();
}

/*
	Name: function_9b917fd5
	Namespace: zm_white
	Checksum: 0x4BB71D11
	Offset: 0x1D48
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_9b917fd5(is_powered)
{
	self pap_power_on();
}

/*
	Name: function_70a36cd8
	Namespace: zm_white
	Checksum: 0x8879AC0E
	Offset: 0x1D78
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_70a36cd8(is_powered)
{
	self zm_pack_a_punch::function_bb629351(1);
	exploder::exploder("fxexp_script_pap_lgt");
}

/*
	Name: function_ba054e47
	Namespace: zm_white
	Checksum: 0xFA969C91
	Offset: 0x1DC0
	Size: 0x238
	Parameters: 0
	Flags: Linked
*/
function function_ba054e47()
{
	e_pap_door = getent("pap_door", "targetname");
	var_c72d9a7c = getent("pap_door_blocker", "targetname");
	level flag::wait_till(#"power_on1");
	exploder::exploder("fxexp_toxic_gas_pap_tube");
	while(true)
	{
		level flag::wait_till("pap_power_ready");
		exploder::stop_exploder("fxexp_toxic_gas_pap_tube");
		e_pap_door playsound(#"hash_1ca46207f2ed8876");
		e_pap_door rotateyaw(180, 1.5);
		e_pap_door playsound(#"hash_41e4c1b28052a5f3");
		wait(1.5);
		var_c72d9a7c hide();
		var_c72d9a7c notsolid();
		level flag::wait_till_clear("pap_power_ready");
		var_c72d9a7c show();
		var_c72d9a7c solid();
		e_pap_door playsound(#"hash_1ca46207f2ed8876");
		e_pap_door rotateyaw(-180, 1.5);
		e_pap_door playsound(#"hash_41e4c1b28052a5f3");
		exploder::exploder("fxexp_toxic_gas_pap_tube");
	}
}

/*
	Name: function_fb29042d
	Namespace: zm_white
	Checksum: 0x10C64636
	Offset: 0x2000
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_fb29042d()
{
	e_pap_door = getent("pap_door", "targetname");
	var_c72d9a7c = getent("pap_door_blocker", "targetname");
	e_pap_door playsound(#"hash_1ca46207f2ed8876");
	e_pap_door rotateyaw(180, 1.5);
	e_pap_door playsound(#"hash_41e4c1b28052a5f3");
	wait(1.5);
	var_c72d9a7c hide();
	var_c72d9a7c notsolid();
}

/*
	Name: function_b6f53cd2
	Namespace: zm_white
	Checksum: 0x89DCEA85
	Offset: 0x2100
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function function_b6f53cd2()
{
	var_8b613a4f = level.var_bcaf8591 >= 4;
	var_58df03c9 = level flag::get(#"hash_1478cafcd626c361") && !level flag::get(#"circuit_step_complete");
	if(var_8b613a4f && !var_58df03c9)
	{
		return true;
	}
	return false;
}

/*
	Name: function_d0f18ffe
	Namespace: zm_white
	Checksum: 0x65C06919
	Offset: 0x2198
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_d0f18ffe()
{
	if(zm_utility::is_standard())
	{
		var_6811b7e = struct::get_array("perk_vapor_altar");
		foreach(var_5baafbb2 in var_6811b7e)
		{
			var_5baafbb2.var_21c535b = -1;
		}
	}
	level flag::init("power_on3");
}

/*
	Name: function_d5d134ac
	Namespace: zm_white
	Checksum: 0xE263778B
	Offset: 0x2260
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_d5d134ac()
{
	if(level.chest_moves > 1)
	{
		zm_magicbox::default_box_move_logic();
	}
	else
	{
		level.chests = array::randomize(level.chests);
		for(i = 0; i < level.chests.size; i++)
		{
			if(level.chests[i].script_noteworthy == "cul_de_sac_chest" || level.chests[i].script_noteworthy == "green_backyard_chest" || level.chests[i].script_noteworthy == "yellow_backyard_chest")
			{
				level.chest_index = i;
				break;
			}
		}
	}
}

/*
	Name: init_pap_quest
	Namespace: zm_white
	Checksum: 0x3ACC6408
	Offset: 0x2370
	Size: 0x438
	Parameters: 0
	Flags: None
*/
function init_pap_quest()
{
	level.var_74c82857 = 0;
	for(i = 1; i <= 4; i++)
	{
		var_df155a8 = getentarray(("pap_light_" + i) + "_green", "targetname");
		foreach(var_c2147f5e in var_df155a8)
		{
			var_c2147f5e hide();
		}
	}
	for(i = 1; i <= 4; i++)
	{
		var_daf9be5b = getentarray(("pap_light_" + i) + "_red", "targetname");
		foreach(var_c2147f5e in var_daf9be5b)
		{
			var_c2147f5e hide();
		}
	}
	level flag::wait_till(#"power_on3");
	for(i = 1; i <= 4; i++)
	{
		var_daf9be5b = getentarray(("pap_light_" + i) + "_red", "targetname");
		foreach(var_c2147f5e in var_daf9be5b)
		{
			var_c2147f5e show();
		}
	}
	for(i = 1; i <= 4; i++)
	{
		var_650332fe = getentarray(("pap_light_" + i) + "_off", "targetname");
		foreach(var_c2147f5e in var_650332fe)
		{
			var_c2147f5e hide();
		}
	}
	a_s_pap_buttons = struct::get_array("pap_button", "targetname");
	if(a_s_pap_buttons.size > 0)
	{
		foreach(s_pap_button in a_s_pap_buttons)
		{
			s_unitrigger = s_pap_button zm_unitrigger::create("", 64);
			s_unitrigger.is_on = 0;
			s_pap_button thread function_6762e94d();
		}
	}
}

/*
	Name: function_6762e94d
	Namespace: zm_white
	Checksum: 0x759402B9
	Offset: 0x27B0
	Size: 0x218
	Parameters: 0
	Flags: Linked
*/
function function_6762e94d()
{
	while(level flag::get(#"pap_power_ready") == 0)
	{
		e_who = undefined;
		e_who = self waittill(#"trigger_activated");
		if(!self.s_unitrigger.is_on)
		{
			self.s_unitrigger.is_on = 1;
			level.var_74c82857 = level.var_74c82857 + 1;
			var_df155a8 = getentarray(("pap_light_" + self.script_noteworthy) + "_green", "targetname");
			foreach(var_c2147f5e in var_df155a8)
			{
				var_c2147f5e show();
			}
			var_daf9be5b = getentarray(("pap_light_" + self.script_noteworthy) + "_red", "targetname");
			foreach(var_c2147f5e in var_daf9be5b)
			{
				var_c2147f5e hide();
			}
		}
		if(level.var_74c82857 == 4)
		{
			level flag::set(#"pap_power_ready");
		}
	}
}

/*
	Name: function_9f50079d
	Namespace: zm_white
	Checksum: 0x79317323
	Offset: 0x29D0
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_9f50079d()
{
	zm_loadout::register_tactical_grenade_for_level(#"hash_603fdd2e4ae5b2b0", 1);
}

/*
	Name: offhand_weapon_give_override
	Namespace: zm_white
	Checksum: 0xA26CDAFC
	Offset: 0x2A08
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function offhand_weapon_give_override(str_weapon)
{
	self endon(#"death");
	if(zm_loadout::is_tactical_grenade(str_weapon) && isdefined(self zm_loadout::get_player_tactical_grenade()) && !self zm_loadout::is_player_tactical_grenade(str_weapon))
	{
		self setweaponammoclip(self zm_loadout::get_player_tactical_grenade(), 0);
		self takeweapon(self zm_loadout::get_player_tactical_grenade());
	}
	return false;
}

/*
	Name: function_79672a3d
	Namespace: zm_white
	Checksum: 0x51EEC533
	Offset: 0x2AD8
	Size: 0x1A4
	Parameters: 0
	Flags: None
*/
function function_79672a3d()
{
	var_76945247 = getent("green_backyard_bunker_door_front", "targetname");
	if(isdefined(var_76945247))
	{
		var_76945247 sethintstring(#"hash_6048bb3579a34287");
	}
	var_cd681b8a = getent("green_backyard_bunker_door_release", "targetname");
	if(isdefined(var_cd681b8a))
	{
		a_e_zombie_doors = getentarray("zombie_door", "targetname");
		if(isdefined(a_e_zombie_doors))
		{
			foreach(var_6620353d in a_e_zombie_doors)
			{
				if(isdefined(var_6620353d.script_flag) && var_6620353d.script_flag == var_cd681b8a.script_string)
				{
					var_cd681b8a.var_a450cb6a = var_6620353d;
					var_6620353d setinvisibletoall();
					break;
				}
			}
		}
		var_cd681b8a sethintstring(#"hash_3b1888151d4b06b");
		var_cd681b8a thread function_39463122();
	}
}

/*
	Name: function_39463122
	Namespace: zm_white
	Checksum: 0xBD7DBF2A
	Offset: 0x2C88
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function function_39463122()
{
	waitresult = undefined;
	waitresult = self waittill(#"trigger");
	player = waitresult.activator;
	self setinvisibletoall();
	var_76945247 = getent("green_backyard_bunker_door_front", "targetname");
	if(isdefined(var_76945247))
	{
		var_76945247 setinvisibletoall();
	}
	e_switch = getent(self.target, "targetname");
	s_fx_pos = struct::get(self.target, "targetname");
	if(isdefined(e_switch) && isdefined(s_fx_pos))
	{
		zm_power::elec_switch_on(e_switch, s_fx_pos);
	}
	self.var_a450cb6a notify(#"trigger", {#is_forced:1, #activator:player});
}

/*
	Name: function_963beb87
	Namespace: zm_white
	Checksum: 0xC93BC638
	Offset: 0x2DF0
	Size: 0x314
	Parameters: 0
	Flags: Linked
*/
function function_963beb87()
{
	if(!isdefined(level.a_w_ray_guns))
	{
		level.a_w_ray_guns = [];
	}
	else if(!isarray(level.a_w_ray_guns))
	{
		level.a_w_ray_guns = array(level.a_w_ray_guns);
	}
	if(!isdefined(level.a_w_ray_guns))
	{
		level.a_w_ray_guns = [];
	}
	else if(!isarray(level.a_w_ray_guns))
	{
		level.a_w_ray_guns = array(level.a_w_ray_guns);
	}
	level.a_w_ray_guns[level.a_w_ray_guns.size] = getweapon("ray_gun");
	if(!isdefined(level.a_w_ray_guns))
	{
		level.a_w_ray_guns = [];
	}
	else if(!isarray(level.a_w_ray_guns))
	{
		level.a_w_ray_guns = array(level.a_w_ray_guns);
	}
	level.a_w_ray_guns[level.a_w_ray_guns.size] = getweapon("ray_gun_upgraded");
	if(!isdefined(level.a_w_ray_guns))
	{
		level.a_w_ray_guns = [];
	}
	else if(!isarray(level.a_w_ray_guns))
	{
		level.a_w_ray_guns = array(level.a_w_ray_guns);
	}
	level.a_w_ray_guns[level.a_w_ray_guns.size] = getweapon("ray_gun_mk2_base");
	if(!isdefined(level.a_w_ray_guns))
	{
		level.a_w_ray_guns = [];
	}
	else if(!isarray(level.a_w_ray_guns))
	{
		level.a_w_ray_guns = array(level.a_w_ray_guns);
	}
	level.a_w_ray_guns[level.a_w_ray_guns.size] = getweapon("ray_gun_mk2_base_upgraded");
	level.custom_magic_box_selection_logic = &custom_magic_box_selection_logic;
	level.var_2f57e2d2 = &function_2f57e2d2;
	level.chest_joker_model = "c_t8_zmb_dlc3_mannequin_male_damage_head_static";
	level thread function_486119ea();
}

/*
	Name: function_486119ea
	Namespace: zm_white
	Checksum: 0xF657CDB1
	Offset: 0x3110
	Size: 0x208
	Parameters: 0
	Flags: Linked
*/
function function_486119ea()
{
	self endon(#"end_game");
	if(zm_utility::is_standard() || zm_custom::function_901b751c(#"hash_4e0ec3fe56f08b47") == 3)
	{
		level thread function_cf95fbb7();
		return;
	}
	while(true)
	{
		var_75666412 = function_789961d3();
		if(isdefined(var_75666412))
		{
			level clientfield::set("portal_map_magicbox_lights_init", 1);
			break;
		}
		wait(1);
	}
	wait(1);
	clientfield::set("portal_map_" + var_75666412, 1);
	level thread function_1f712bb1();
	level thread function_da0655c7();
	level thread function_e5c88b7b();
	while(true)
	{
		var_469863c6 = function_789961d3();
		if(var_469863c6 != var_75666412)
		{
			clientfield::set("portal_map_" + var_469863c6, 1);
			clientfield::set("portal_map_" + var_75666412, 0);
			level thread function_2336a7c8();
			level thread function_1f712bb1();
			waitframe(1);
			var_75666412 = var_469863c6;
		}
		wait(1);
	}
}

/*
	Name: function_789961d3
	Namespace: zm_white
	Checksum: 0x32B6609C
	Offset: 0x3320
	Size: 0x62
	Parameters: 0
	Flags: Linked
*/
function function_789961d3()
{
	if(isdefined(level.chest_index) && isdefined(level.chests) && isdefined(level.chests[level.chest_index]))
	{
		return level.chests[level.chest_index].script_noteworthy;
	}
	return undefined;
}

/*
	Name: custom_magic_box_selection_logic
	Namespace: zm_white
	Checksum: 0xF751B26D
	Offset: 0x3390
	Size: 0x50
	Parameters: 2
	Flags: Linked
*/
function custom_magic_box_selection_logic(w_weapon, e_player)
{
	if(zm_white_util::is_ray_gun(w_weapon) && e_player zm_white_util::has_ray_gun())
	{
		return false;
	}
	return true;
}

/*
	Name: function_2f57e2d2
	Namespace: zm_white
	Checksum: 0x64F4BE7D
	Offset: 0x33E8
	Size: 0x80
	Parameters: 1
	Flags: Linked
*/
function function_2f57e2d2(e_player)
{
	var_5f6b2789 = self.stub.trigger_target;
	if(var_5f6b2789.weapon_out === 1 && zm_white_util::is_ray_gun(var_5f6b2789.zbarrier.weapon) && e_player zm_white_util::has_ray_gun())
	{
		return false;
	}
	return true;
}

/*
	Name: function_1f712bb1
	Namespace: zm_white
	Checksum: 0xDC113423
	Offset: 0x3470
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function function_1f712bb1()
{
	var_5b117f94 = level.chests[level.chest_index].script_noteworthy;
	if(var_5b117f94 == "bunker1_chest" || var_5b117f94 == "bunker2_chest")
	{
		return undefined;
	}
	wait(3);
	level.var_af3a53b2 = util::spawn_model("tag_origin", level.chests[level.chest_index].origin + (vectorscale((0, 0, -1), 75)));
	level.var_af3a53b2.angles = level.chests[level.chest_index].angles + (vectorscale((-1, 0, -1), 90));
	playfxontag(level._effect[#"hash_572a14944ad27060"], level.var_af3a53b2, "tag_origin");
}

/*
	Name: function_2336a7c8
	Namespace: zm_white
	Checksum: 0x37EFBC2B
	Offset: 0x3590
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_2336a7c8()
{
	if(isdefined(level.var_af3a53b2))
	{
		level.var_af3a53b2 delete();
	}
	else
	{
		return undefined;
	}
}

/*
	Name: function_da0655c7
	Namespace: zm_white
	Checksum: 0x759E4DBB
	Offset: 0x35D0
	Size: 0x25C
	Parameters: 0
	Flags: Linked
*/
function function_da0655c7()
{
	level waittill(#"fire_sale_on");
	level function_2336a7c8();
	level.var_3caf613d = [];
	for(i = 0; i < 7; i++)
	{
		var_5b117f94 = level.chests[i].script_noteworthy;
		if(var_5b117f94 == "bunker1_chest" || var_5b117f94 == "bunker2_chest")
		{
			continue;
		}
		wait(0.1);
		level.var_3caf613d[i] = util::spawn_model("tag_origin", level.chests[i].origin + (vectorscale((0, 0, -1), 75)));
		level.var_3caf613d[i].angles = level.chests[level.chest_index].angles + (vectorscale((-1, 0, -1), 90));
		playfxontag(level._effect[#"hash_572a14944ad27060"], level.var_3caf613d[i], "tag_origin");
	}
	level waittill(#"fire_sale_off");
	if(isdefined(level.var_3caf613d))
	{
		foreach(fx in level.var_3caf613d)
		{
			fx delete();
		}
		level thread function_1f712bb1();
	}
	else
	{
		return undefined;
	}
	level thread function_da0655c7();
}

/*
	Name: function_cf95fbb7
	Namespace: zm_white
	Checksum: 0x935C7D91
	Offset: 0x3838
	Size: 0x176
	Parameters: 0
	Flags: Linked
*/
function function_cf95fbb7()
{
	while(!isdefined(level.chests))
	{
		wait(0.1);
	}
	level.var_3caf613d = [];
	for(i = 0; i < 7; i++)
	{
		var_5b117f94 = level.chests[i].script_noteworthy;
		if(var_5b117f94 == "bunker1_chest" || var_5b117f94 == "bunker2_chest")
		{
			continue;
		}
		wait(0.1);
		level.var_3caf613d[i] = util::spawn_model("tag_origin", level.chests[i].origin + (vectorscale((0, 0, -1), 75)));
		level.var_3caf613d[i].angles = level.chests[level.chest_index].angles + (vectorscale((-1, 0, -1), 90));
		playfxontag(level._effect[#"hash_572a14944ad27060"], level.var_3caf613d[i], "tag_origin");
	}
}

/*
	Name: function_e5c88b7b
	Namespace: zm_white
	Checksum: 0x1A9DDBD7
	Offset: 0x39B8
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_e5c88b7b()
{
	level waittill(#"fire_sale_on");
	level clientfield::set("portal_map_fire_sale", 1);
	level waittill(#"fire_sale_off");
	level clientfield::set("portal_map_fire_sale", 0);
	var_469863c6 = function_789961d3();
	clientfield::set("portal_map_" + var_469863c6, 0);
	wait(1);
	clientfield::set("portal_map_" + var_469863c6, 1);
	level thread function_e5c88b7b();
}

/*
	Name: function_785cadc4
	Namespace: zm_white
	Checksum: 0x53ED8DE0
	Offset: 0x3AC0
	Size: 0x19A
	Parameters: 0
	Flags: Linked
*/
function function_785cadc4()
{
	level.var_678333a6 = #"hash_11347f5077a17dcb";
	level._effect[#"chest_light"] = #"hash_1e8cb303d3103833";
	level._effect[#"chest_light_closed"] = #"hash_602f075818a2fb2e";
	level._effect[#"hash_2ff87d61167ea531"] = #"hash_1eb426cfbfef7486";
	level._effect[#"hash_4048cb4967032c4a"] = #"hash_7e272f1a9f143051";
	level._effect[#"lght_marker"] = #"hash_7dec2fde8393c0f4";
	level._effect[#"lght_marker_flare"] = #"hash_11347f5077a17dcb";
	level._effect[#"poltergeist_magicbox"] = #"hash_11347f5077a17dcb";
	level._effect[#"hash_572a14944ad27060"] = #"zombie/fx_weapon_box_marker_zmb";
}

/*
	Name: function_d574cfc6
	Namespace: zm_white
	Checksum: 0xA4A83031
	Offset: 0x3C68
	Size: 0x1C4
	Parameters: 0
	Flags: Linked
*/
function function_d574cfc6()
{
	level.var_1fff8fd2 = getent("sfx_apd_top", "targetname");
	level flag::wait_till("power_on1");
	exploder::exploder("fxexp_script_power_on");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_lgt_exterior");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_lgt_house_green");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_lgt_house_hammond");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_lgt_house_hoggatt");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_lgt_house_obrien");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_lgt_house_red");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_lgt_house_reinsel");
	level.var_1fff8fd2 playloopsound("evt_apd_loop");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_lgt_house_shed");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_lgt_house_yellow");
	waitframe(1);
	exploder::exploder("fxexp_script_power_on_bunker");
}

/*
	Name: function_cf100865
	Namespace: zm_white
	Checksum: 0xD9BEC773
	Offset: 0x3E38
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_cf100865()
{
	function_4f60590c();
	level flag::wait_till("power_on1");
	var_cfa7dc7e = level flag::get("dog_round");
	while(var_cfa7dc7e == 1)
	{
		var_cfa7dc7e = level flag::get("dog_round");
		wait(1);
	}
	function_1c074340();
}

/*
	Name: function_1c074340
	Namespace: zm_white
	Checksum: 0x76DA4D2A
	Offset: 0x3EF0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_1c074340()
{
	clientfield::set("power_pbg_control", 1);
}

/*
	Name: function_4f60590c
	Namespace: zm_white
	Checksum: 0x8F400411
	Offset: 0x3F20
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_4f60590c()
{
	clientfield::set("power_pbg_control", 0);
}

/*
	Name: sndfunctions
	Namespace: zm_white
	Checksum: 0x3D39BDF1
	Offset: 0x3F48
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function sndfunctions()
{
	if(zm_utility::is_standard())
	{
		level.zmannouncerprefix = "rush";
	}
	else
	{
		level.zmannouncerprefix = "avoa";
	}
	zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
	zm_audio::loadplayervoicecategories(#"hash_41c3d60c9fdc1c1a");
	zm_audio::loadplayervoicecategories(#"hash_6d9aadb58948623b");
	zm_audio::loadplayervoicecategories(#"hash_2a32b98080f6388");
	level thread setup_personality_character_exerts();
	level thread setupmusic();
}

/*
	Name: setupmusic
	Namespace: zm_white
	Checksum: 0x61E5EC57
	Offset: 0x4048
	Size: 0x334
	Parameters: 0
	Flags: Linked
*/
function setupmusic()
{
	zm_audio::musicstate_create("round_start", 3, "nuked_roundstart_1", "nuked_roundstart_2", "nuked_roundstart_3");
	zm_audio::musicstate_create("round_start_first", 3, "nuked_roundstart_1");
	zm_audio::musicstate_create("round_end", 3, "nuked_roundend_1");
	zm_audio::musicstate_create("game_over", 5, "white_death");
	zm_audio::musicstate_create("round_start_special", 3, "round_start_special");
	zm_audio::musicstate_create("round_end_special", 3, "round_end_special");
	zm_audio::musicstate_create("ee_song_main", 4, "ee_song_main");
	zm_audio::musicstate_create("im_1", 4, "im_1");
	zm_audio::musicstate_create("im_2", 4, "im_2");
	zm_audio::musicstate_create("im_3", 4, "im_3");
	zm_audio::musicstate_create("im_4", 4, "im_4");
	zm_audio::musicstate_create("im_5", 4, "im_5");
	zm_audio::musicstate_create("im_6", 4, "im_6");
	zm_audio::musicstate_create("im_7", 4, "im_7");
	zm_audio::musicstate_create("im_8", 4, "im_8");
	zm_audio::musicstate_create("im_9", 4, "im_9");
	zm_audio::musicstate_create("im_10", 4, "im_10");
	zm_audio::musicstate_create("im_11", 4, "im_11");
	zm_audio::musicstate_create("im_12", 4, "im_12");
	zm_audio::musicstate_create("im_13", 4, "im_13");
}

/*
	Name: setup_personality_character_exerts
	Namespace: zm_white
	Checksum: 0x55418BB2
	Offset: 0x4388
	Size: 0x3C8
	Parameters: 0
	Flags: Linked
*/
function setup_personality_character_exerts()
{
	level.exert_sounds[5][#"hitmed"] = "vox_plr_5_exert_pain";
	level.exert_sounds[6][#"hitmed"] = "vox_plr_6_exert_pain";
	level.exert_sounds[7][#"hitmed"] = "vox_plr_7_exert_pain";
	level.exert_sounds[8][#"hitmed"] = "vox_plr_8_exert_pain";
	level.exert_sounds[13][#"hitmed"] = "vox_plr_5_exert_pain";
	level.exert_sounds[14][#"hitmed"] = "vox_plr_6_exert_pain";
	level.exert_sounds[15][#"hitmed"] = "vox_plr_7_exert_pain";
	level.exert_sounds[16][#"hitmed"] = "vox_plr_8_exert_pain";
	level.exert_sounds[5][#"hitlrg"] = "vox_plr_5_exert_pain";
	level.exert_sounds[6][#"hitlrg"] = "vox_plr_6_exert_pain";
	level.exert_sounds[7][#"hitlrg"] = "vox_plr_6_exert_pain";
	level.exert_sounds[8][#"hitlrg"] = "vox_plr_7_exert_pain";
	level.exert_sounds[13][#"hitlrg"] = "vox_plr_5_exert_pain";
	level.exert_sounds[14][#"hitlrg"] = "vox_plr_6_exert_pain";
	level.exert_sounds[15][#"hitlrg"] = "vox_plr_6_exert_pain";
	level.exert_sounds[16][#"hitlrg"] = "vox_plr_7_exert_pain";
	level.exert_sounds[5][#"cough"] = "vox_plr_5_exert_gas_cough";
	level.exert_sounds[6][#"cough"] = "vox_plr_6_exert_gas_cough";
	level.exert_sounds[7][#"cough"] = "vox_plr_7_exert_gas_cough";
	level.exert_sounds[8][#"cough"] = "vox_plr_8_exert_gas_cough";
	level.exert_sounds[13][#"cough"] = "vox_plr_5_exert_gas_cough";
	level.exert_sounds[14][#"cough"] = "vox_plr_6_exert_gas_cough";
	level.exert_sounds[15][#"cough"] = "vox_plr_7_exert_gas_cough";
	level.exert_sounds[16][#"cough"] = "vox_plr_8_exert_gas_cough";
}

/*
	Name: function_e120ae98
	Namespace: zm_white
	Checksum: 0xA4C35D66
	Offset: 0x4758
	Size: 0x1B0
	Parameters: 1
	Flags: Linked
*/
function function_e120ae98(a_s_respawn_points)
{
	if(level flag::get(#"yellow_backyard_to_yellow_house") || level flag::get(#"green_backyard_to_green_house"))
	{
		return a_s_respawn_points;
	}
	a_filter = array("zone_bunker_lounge_entrance", "zone_bunker_lounge", "zone_bunker_diner_entrance", "zone_bunker_diner", "zone_bunker_beds_1", "zone_bunker_beds_2", "zone_yellow_backyard", "zone_green_backyard");
	var_dbc11ffc = [];
	foreach(s_point in a_s_respawn_points)
	{
		if(!array::contains(a_filter, s_point.script_noteworthy))
		{
			if(!isdefined(var_dbc11ffc))
			{
				var_dbc11ffc = [];
			}
			else if(!isarray(var_dbc11ffc))
			{
				var_dbc11ffc = array(var_dbc11ffc);
			}
			if(!isinarray(var_dbc11ffc, s_point))
			{
				var_dbc11ffc[var_dbc11ffc.size] = s_point;
			}
		}
	}
	return var_dbc11ffc;
}

/*
	Name: function_c8ce0a17
	Namespace: zm_white
	Checksum: 0x288720B3
	Offset: 0x4918
	Size: 0x88
	Parameters: 2
	Flags: Linked
*/
function function_c8ce0a17(var_404e4288, var_8dd554ee)
{
	level flag::set(#"disable_special_rounds");
	ai = zm_white_special_rounds::function_dd836251();
	if(!isdefined(ai))
	{
		ai = zm_white_special_rounds::function_75309b09();
	}
	if(isdefined(ai))
	{
		level.zombie_total--;
	}
	return true;
}

/*
	Name: function_e5086229
	Namespace: zm_white
	Checksum: 0xEA56BA8E
	Offset: 0x49A8
	Size: 0x70
	Parameters: 2
	Flags: Linked
*/
function function_e5086229(var_404e4288, var_8dd554ee)
{
	level flag::set(#"disable_special_rounds");
	ai = zombie_dog_util::function_62db7b1c(1);
	if(isdefined(ai))
	{
		level.zombie_total--;
	}
	return true;
}

/*
	Name: function_7e6cf034
	Namespace: zm_white
	Checksum: 0xEC04A7EE
	Offset: 0x4A20
	Size: 0x372
	Parameters: 0
	Flags: Linked
*/
function function_7e6cf034()
{
	switch(zm_custom::function_901b751c(#"zmdoorstate"))
	{
		case 1:
		default:
		{
			break;
		}
		case 2:
		{
			level.var_e120ae98 = &function_cc45705b;
			break;
		}
	}
	wait(5);
	switch(zm_custom::function_901b751c(#"zmpowerdoorstate"))
	{
		case 1:
		default:
		{
			break;
		}
		case 2:
		{
			zm_white_util::function_ca4ee4d1("bunker_door");
			zm_white_util::function_f4a39bc4();
			zm_white_util::function_bf25aeb1("bunker_door_electric");
			var_c39fcc2 = getentarray("lockdown_trigger", "targetname");
			foreach(var_77ccde7f in var_c39fcc2)
			{
				var_77ccde7f delete();
			}
			break;
		}
	}
	switch(zm_custom::function_901b751c(#"zmpowerstate"))
	{
		case 1:
		{
			break;
		}
		case 2:
		{
			level flag::set("power_on1");
			level flag::set("power_on3");
			if(zm_custom::function_901b751c(#"zmpowerdoorstate") == 1)
			{
				zm_white_util::function_ca4ee4d1("bunker_door");
				zm_white_util::function_f4a39bc4();
				zm_white_util::function_bf25aeb1("bunker_door_electric");
				var_c39fcc2 = getentarray("lockdown_trigger", "targetname");
				foreach(var_77ccde7f in var_c39fcc2)
				{
					var_77ccde7f delete();
				}
			}
		}
		case 0:
		{
			break;
		}
		default:
		{
		}
	}
}

/*
	Name: function_cc45705b
	Namespace: zm_white
	Checksum: 0x567DD00D
	Offset: 0x4DA0
	Size: 0x1B0
	Parameters: 1
	Flags: Linked
*/
function function_cc45705b(a_s_respawn_points)
{
	if(level flag::get(#"power_on1") && zm_custom::function_901b751c(#"zmpowerdoorstate") > 0)
	{
		return a_s_respawn_points;
	}
	a_filter = array("zone_bunker_lounge_entrance", "zone_bunker_lounge", "zone_bunker_diner_entrance", "zone_bunker_diner", "zone_bunker_beds_1", "zone_bunker_beds_2", "zone_bunker_power_1", "zone_bunker_power_2");
	var_dbc11ffc = [];
	foreach(s_point in a_s_respawn_points)
	{
		if(!array::contains(a_filter, s_point.script_noteworthy))
		{
			if(!isdefined(var_dbc11ffc))
			{
				var_dbc11ffc = [];
			}
			else if(!isarray(var_dbc11ffc))
			{
				var_dbc11ffc = array(var_dbc11ffc);
			}
			if(!isinarray(var_dbc11ffc, s_point))
			{
				var_dbc11ffc[var_dbc11ffc.size] = s_point;
			}
		}
	}
	return var_dbc11ffc;
}

/*
	Name: white_devgui
	Namespace: zm_white
	Checksum: 0x37A4ED06
	Offset: 0x4F60
	Size: 0x450
	Parameters: 0
	Flags: Private
*/
function private white_devgui()
{
	/#
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		level flag::init(#"soul_fill");
		level thread zm_white_util::function_e95d25();
		while(true)
		{
			waitframe(1);
			str_command = getdvarstring(#"zm_white_devgui_cmd", "");
			switch(str_command)
			{
				case "hash_1535ec651f8ba226":
				{
					level.var_e8d9c0d1 = 1;
					break;
				}
				case "start_lgt_exp":
				{
					level flag::set("");
					break;
				}
				case "hash_121e505482adfe21":
				{
					level flag::set("");
					break;
				}
				case "hash_51413ff43d5ac5eb":
				{
					level flag::set("");
					break;
				}
				case "hash_3a77444633569cdc":
				{
					level flag::clear("");
					break;
				}
				case "hash_75c01ef1f8005214":
				{
					iprintln("");
					level flag::set(#"soul_fill");
					break;
				}
				case "hash_7db70cb23b9d2739":
				{
					iprintln("");
					level flag::clear(#"soul_fill");
					break;
				}
				case "hash_708994ac8f2d6d5":
				{
					if(zm_utility::is_ee_enabled())
					{
						zm_sq::function_87306f8a(#"insanity_mode", #"step_6");
					}
					else
					{
						level thread zm_white_insanity_mode::function_1541f1c9();
					}
					break;
				}
				case "hash_ab401b43ac65b13":
				{
					iprintln("");
					level flag::set(#"keypad_debug");
					break;
				}
				case "hash_310aefbe028b9475":
				{
					iprintln("");
					namespace_a71af4de::function_3134b684();
					break;
				}
				case 0:
				{
				}
			}
			setdvar(#"zm_white_devgui_cmd", "");
		}
	#/
}

