// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14e569dd391faf67;
#using script_3f9e0dc8454d98e1;
#using script_63da2325262612ba;
#using script_71b31a94cdaeca53;
#using script_db06eb511bd9b36;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_ccdea9b1;

/*
	Name: init
	Namespace: namespace_ccdea9b1
	Checksum: 0x24EA316C
	Offset: 0x7F0
	Size: 0x594
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level flag::init("defcon_active");
	level flag::init("no_pack_room_spawning");
	level flag::init("open_pack_hideaway");
	level flag::init("labs_enabled");
	level flag::init("bonfire_reset");
	level flag::init("elevator_grounded");
	level flag::init("war_room_start");
	level flag::init("no_warroom_elevator_spawning");
	level flag::init("no_labs_elevator_spawning");
	level flag::init("elevators_initialized");
	level thread function_3d4e24ea();
	level thread function_ec5213ee();
	level thread function_d23ea9aa();
	level thread function_dec13a5b();
	level.var_fc1f5422 = struct::get_array("war_room_zone_elevator_spawns", "targetname");
	level.var_3d9e751c = struct::get_array("labs_elevator_spawns", "targetname");
	elevator1 = getent("elevator1", "targetname");
	elevator2 = getent("elevator2", "targetname");
	elevator1.cost = 500;
	elevator1.station = "elevator1_up";
	elevator1.called = 0;
	elevator1.active = 0;
	elevator1.var_5a3b55a3 = getvehiclenode("elev1_level3_start", "targetname");
	elevator1.var_7237c31e = getvehiclenode("elev1_level2_start", "targetname");
	elevator1.var_243802fa = #"hash_7041e0919c53eb4e";
	elevator1.takedamage = 0;
	elevator1 setmovingplatformenabled(1);
	elevator2.cost = 500;
	elevator2.station = "elevator2_up";
	elevator2.called = 0;
	elevator2.active = 0;
	elevator2.var_5a3b55a3 = getvehiclenode("elev2_level2_start", "targetname");
	elevator2.var_7237c31e = getvehiclenode("elev2_level1_start", "targetname");
	elevator2.var_243802fa = #"hash_5a26031141f5cc33";
	elevator2.takedamage = 0;
	elevator2 setmovingplatformenabled(1);
	elevator1 init_elevator1_doors();
	elevator1 init_buy();
	elevator1 init_call_boxes();
	elevator2 init_elevator2_doors();
	elevator2 init_buy();
	elevator2 init_call_boxes();
	util::wait_network_frame();
	elevator1 enable_callboxes();
	elevator1 block_elev_doors(0);
	elevator1 open_elev_doors();
	elevator2 enable_callboxes();
	elevator2 block_elev_doors(0);
	elevator2 open_elev_doors();
	elevator2 playloopsound("amb_elevator_muzak");
	elevator1 thread elevator1_3d_audio();
	elevator2 thread elevator2_3d_audio();
	level.elevator1 = elevator1;
	level.elevator2 = elevator2;
	level flag::set("elevators_initialized");
}

/*
	Name: function_3d4e24ea
	Namespace: namespace_ccdea9b1
	Checksum: 0xB7602317
	Offset: 0xD90
	Size: 0x1E6
	Parameters: 0
	Flags: Linked
*/
function function_3d4e24ea()
{
	level._effect[#"hash_4a38c13e2040d160"] = #"hash_11e609d597dcebf2";
	level.var_fecdcdc4 = level._effect[#"hash_4a38c13e2040d160"];
	level._effect[#"hash_336249bfea00c9ea"] = #"hash_48ec8658075edc9d";
	level.var_dca712ff = level._effect[#"hash_336249bfea00c9ea"];
	level._effect[#"hash_3718db938f7babf7"] = #"hash_142b1b8f881ae741";
	level.var_715ae9f9 = level._effect[#"hash_3718db938f7babf7"];
	level._effect[#"hash_3b796b3101b76878"] = #"hash_4fc36e212e5b5b8a";
	level.var_e33251c7 = level._effect[#"hash_3b796b3101b76878"];
	level._effect[#"hash_1d090c7817f1e26d"] = #"hash_340a3cade524696d";
	level.var_41a1bc06 = level._effect[#"hash_1d090c7817f1e26d"];
	level._effect[#"hash_7c83294db356d63a"] = #"hash_499e66437fc6ab02";
	level.var_8caf5068 = level._effect[#"hash_7c83294db356d63a"];
}

/*
	Name: function_ec5213ee
	Namespace: namespace_ccdea9b1
	Checksum: 0x69D73AD3
	Offset: 0xF80
	Size: 0x7C0
	Parameters: 0
	Flags: Linked
*/
function function_ec5213ee()
{
	level.var_d8a093b8 = getentarray("elevator2", "targetname");
	level.var_1ce67448 = getentarray("elevator1", "targetname");
	var_844f2ba7 = getent("fx_light_elevator_origin", "targetname");
	var_844f2ba7.fx_ent = util::spawn_model("tag_origin", var_844f2ba7.origin);
	var_844f2ba7.fx_ent.angles = var_844f2ba7.angles;
	var_844f2ba7.var_d54159c9 = playfxontag(level.var_fecdcdc4, var_844f2ba7.fx_ent, "tag_origin");
	var_844f2ba7.var_d54159c9 linkto(level.var_d8a093b8[0]);
	var_428c7836 = getent("fx_light_elevator1_origin", "targetname");
	var_428c7836.fx_ent = util::spawn_model("tag_origin", var_428c7836.origin);
	var_428c7836.fx_ent.angles = var_428c7836.angles;
	var_428c7836.var_286bc7b5 = playfxontag(level.var_41a1bc06, var_428c7836.fx_ent, "tag_origin");
	var_428c7836.var_286bc7b5 linkto(level.var_1ce67448[0]);
	var_71ffef77 = getent("lgt_elevator_panel_illum_origin", "targetname");
	var_71ffef77.fx_ent = util::spawn_model("tag_origin", var_71ffef77.origin);
	var_71ffef77.fx_ent.angles = var_71ffef77.angles;
	var_71ffef77.var_d54159c9 = playfxontag(level.var_e33251c7, var_71ffef77.fx_ent, "tag_origin");
	var_71ffef77.var_d54159c9 linkto(level.var_d8a093b8[0]);
	var_b15265f4 = getent("lgt_elevator_panel_caster_origin", "targetname");
	var_b15265f4.fx_ent = util::spawn_model("tag_origin", var_b15265f4.origin);
	var_b15265f4.fx_ent.angles = var_b15265f4.angles;
	var_b15265f4.var_d54159c9 = playfxontag(level.var_715ae9f9, var_b15265f4.fx_ent, "tag_origin");
	var_b15265f4.var_d54159c9 linkto(level.var_d8a093b8[0]);
	var_30a32007 = getent("lgt_elevator2_panel_illum_origin", "targetname");
	var_30a32007.fx_ent = util::spawn_model("tag_origin", var_30a32007.origin);
	var_30a32007.fx_ent.angles = var_30a32007.angles;
	var_30a32007.var_d54159c9 = playfxontag(level.var_e33251c7, var_30a32007.fx_ent, "tag_origin");
	var_30a32007.var_d54159c9 linkto(level.var_1ce67448[0]);
	var_c95e76a9 = getent("lgt_elevator2_panel_caster_origin", "targetname");
	var_c95e76a9.fx_ent = util::spawn_model("tag_origin", var_c95e76a9.origin);
	var_c95e76a9.fx_ent.angles = var_c95e76a9.angles;
	var_c95e76a9.var_d54159c9 = playfxontag(level.var_715ae9f9, var_c95e76a9.fx_ent, "tag_origin");
	var_c95e76a9.var_d54159c9 linkto(level.var_1ce67448[0]);
	var_844f2f0a = getentarray("fx_light_illum_elevator_origin", "targetname");
	var_6d00692f = getentarray("fx_light_illum_elevator2_origin", "targetname");
	foreach(e_light in var_844f2f0a)
	{
		e_light.fx_ent = util::spawn_model("tag_origin", e_light.origin);
		e_light.fx_ent.angles = e_light.angles;
		e_light.var_d54159c9 = playfxontag(level.var_dca712ff, e_light.fx_ent, "tag_origin");
		e_light.var_d54159c9 linkto(level.var_d8a093b8[0]);
	}
	foreach(e_light in var_6d00692f)
	{
		e_light.fx_ent = util::spawn_model("tag_origin", e_light.origin);
		e_light.fx_ent.angles = e_light.angles;
		e_light.var_d54159c9 = playfxontag(level.var_8caf5068, e_light.fx_ent, "tag_origin");
		e_light.var_d54159c9 linkto(level.var_1ce67448[0]);
	}
}

/*
	Name: function_d23ea9aa
	Namespace: namespace_ccdea9b1
	Checksum: 0x8011DCC8
	Offset: 0x1748
	Size: 0x42C
	Parameters: 0
	Flags: Linked
*/
function function_d23ea9aa()
{
	var_ef2c2035 = getentarray("elevator1_indicator", "script_noteworthy");
	var_5abda158 = getentarray("elevator2_indicator", "script_noteworthy");
	level.var_41d73944 = getentarray("elevator1_indicator_up_on", "targetname");
	level.var_6c224e2c = getentarray("elevator1_indicator_up_off", "targetname");
	level.var_2e236c62 = getentarray("elevator1_indicator_down_on", "targetname");
	level.var_c8358a8 = getentarray("elevator1_indicator_down_off", "targetname");
	level.var_8a312e3b = getentarray("elevator2_indicator_up_on", "targetname");
	level.var_1eea8b4e = getentarray("elevator2_indicator_up_off", "targetname");
	level.var_54345fd6 = getentarray("elevator2_indicator_down_on", "targetname");
	level.var_7e61c2bd = getentarray("elevator2_indicator_down_off", "targetname");
	if(getdvarint(#"splitscreen_playercount", 1) > 2)
	{
		array::delete_all(level.var_41d73944);
		level.var_41d73944 = [];
		array::delete_all(level.var_6c224e2c);
		level.var_6c224e2c = [];
		array::delete_all(level.var_2e236c62);
		level.var_2e236c62 = [];
		array::delete_all(level.var_c8358a8);
		level.var_c8358a8 = [];
		array::delete_all(level.var_8a312e3b);
		level.var_8a312e3b = [];
		array::delete_all(level.var_1eea8b4e);
		level.var_1eea8b4e = [];
		array::delete_all(level.var_54345fd6);
		level.var_54345fd6 = [];
		array::delete_all(level.var_7e61c2bd);
		level.var_7e61c2bd = [];
		var_ef2c2035 = [];
		var_5abda158 = [];
	}
	foreach(var_c788327f in var_ef2c2035)
	{
		var_c788327f linkto(level.var_d8a093b8[0]);
	}
	foreach(var_c788327f in var_5abda158)
	{
		var_c788327f linkto(level.var_1ce67448[0]);
	}
	function_db4ac61a();
	function_4cf5b4dd();
}

/*
	Name: function_db4ac61a
	Namespace: namespace_ccdea9b1
	Checksum: 0xD8E13F00
	Offset: 0x1B80
	Size: 0x1D0
	Parameters: 0
	Flags: Linked
*/
function function_db4ac61a()
{
	foreach(e_light in level.var_6c224e2c)
	{
		e_light show();
	}
	foreach(e_light in level.var_c8358a8)
	{
		e_light show();
	}
	foreach(e_light in level.var_41d73944)
	{
		e_light hide();
	}
	foreach(e_light in level.var_2e236c62)
	{
		e_light hide();
	}
}

/*
	Name: function_cfd40975
	Namespace: namespace_ccdea9b1
	Checksum: 0x81AC8E86
	Offset: 0x1D58
	Size: 0x1D0
	Parameters: 0
	Flags: Linked
*/
function function_cfd40975()
{
	foreach(e_light in level.var_41d73944)
	{
		e_light show();
	}
	foreach(e_light in level.var_c8358a8)
	{
		e_light show();
	}
	foreach(e_light in level.var_6c224e2c)
	{
		e_light hide();
	}
	foreach(e_light in level.var_2e236c62)
	{
		e_light hide();
	}
}

/*
	Name: function_5e62aa83
	Namespace: namespace_ccdea9b1
	Checksum: 0xB208F9C0
	Offset: 0x1F30
	Size: 0x1D0
	Parameters: 0
	Flags: Linked
*/
function function_5e62aa83()
{
	foreach(e_light in level.var_6c224e2c)
	{
		e_light show();
	}
	foreach(e_light in level.var_2e236c62)
	{
		e_light show();
	}
	foreach(e_light in level.var_41d73944)
	{
		e_light hide();
	}
	foreach(e_light in level.var_c8358a8)
	{
		e_light hide();
	}
}

/*
	Name: function_4cf5b4dd
	Namespace: namespace_ccdea9b1
	Checksum: 0x455DA406
	Offset: 0x2108
	Size: 0x1D0
	Parameters: 0
	Flags: Linked
*/
function function_4cf5b4dd()
{
	foreach(e_light in level.var_1eea8b4e)
	{
		e_light show();
	}
	foreach(e_light in level.var_7e61c2bd)
	{
		e_light show();
	}
	foreach(e_light in level.var_8a312e3b)
	{
		e_light hide();
	}
	foreach(e_light in level.var_54345fd6)
	{
		e_light hide();
	}
}

/*
	Name: function_1352fc3c
	Namespace: namespace_ccdea9b1
	Checksum: 0xAC87E2AF
	Offset: 0x22E0
	Size: 0x1D0
	Parameters: 0
	Flags: Linked
*/
function function_1352fc3c()
{
	foreach(e_light in level.var_8a312e3b)
	{
		e_light show();
	}
	foreach(e_light in level.var_7e61c2bd)
	{
		e_light show();
	}
	foreach(e_light in level.var_1eea8b4e)
	{
		e_light hide();
	}
	foreach(e_light in level.var_54345fd6)
	{
		e_light hide();
	}
}

/*
	Name: function_d5410733
	Namespace: namespace_ccdea9b1
	Checksum: 0xE22C4AD7
	Offset: 0x24B8
	Size: 0x1D0
	Parameters: 0
	Flags: Linked
*/
function function_d5410733()
{
	foreach(e_light in level.var_54345fd6)
	{
		e_light show();
	}
	foreach(e_light in level.var_1eea8b4e)
	{
		e_light show();
	}
	foreach(e_light in level.var_8a312e3b)
	{
		e_light hide();
	}
	foreach(e_light in level.var_7e61c2bd)
	{
		e_light hide();
	}
}

/*
	Name: init_call_boxes
	Namespace: namespace_ccdea9b1
	Checksum: 0x3DFE375E
	Offset: 0x2690
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function init_call_boxes()
{
	trigger = getentarray(self.targetname + "_call_box", "targetname");
	for(i = 0; i < trigger.size; i++)
	{
		trigger[i] thread call_box_think(self);
	}
}

/*
	Name: call_box_think
	Namespace: namespace_ccdea9b1
	Checksum: 0xB4F9122B
	Offset: 0x2720
	Size: 0x2A8
	Parameters: 1
	Flags: Linked
*/
function call_box_think(elevator)
{
	self setcursorhint("HINT_NOICON");
	if(function_8b1a219a())
	{
		self sethintstring(#"hash_4e2495c99a50f326");
	}
	else
	{
		self sethintstring(#"hash_2f56b9d8ac49ff92");
	}
	while(true)
	{
		who = undefined;
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		who = waitresult.activator;
		elev_clear = is_elevator_clear(elevator);
		if(!elev_clear)
		{
			zm_utility::play_sound_at_pos("no_purchase", self.origin);
			self sethintstring(#"hash_2af4a28719c51767");
			wait(1);
			if(function_8b1a219a())
			{
				self sethintstring(#"hash_4e2495c99a50f326");
			}
			else
			{
				self sethintstring(#"hash_2f56b9d8ac49ff92");
			}
		}
		else if(elevator.active == 1 || !who can_buy_elevator())
		{
			zm_utility::play_sound_at_pos("no_purchase", self.origin);
		}
		else if(elevator.station != self.script_noteworthy)
		{
			call_destination = self.script_noteworthy;
			elevator.called = 1;
			elevator.active = 1;
			playsoundatposition(elevator.var_243802fa, self.origin);
			elevator disable_callboxes();
			elevator disable_elevator_buys();
			self thread elevator_move_to(elevator);
		}
		wait(0.05);
	}
}

/*
	Name: is_elevator_clear
	Namespace: namespace_ccdea9b1
	Checksum: 0x9959A403
	Offset: 0x29D0
	Size: 0xEA
	Parameters: 1
	Flags: Linked
*/
function is_elevator_clear(elevator)
{
	elevator_door_safety = getentarray(elevator.targetname + "_safety", "script_noteworthy");
	players = getplayers();
	if(isdefined(elevator_door_safety))
	{
		for(i = 0; i < elevator_door_safety.size; i++)
		{
			for(j = 0; j < players.size; j++)
			{
				if(players[j] istouching(elevator_door_safety[i]))
				{
					return 0;
				}
			}
		}
	}
	return 1;
}

/*
	Name: block_elev_doors_internal
	Namespace: namespace_ccdea9b1
	Checksum: 0x4CE15A8C
	Offset: 0x2AC8
	Size: 0xB6
	Parameters: 2
	Flags: Linked
*/
function block_elev_doors_internal(block, suffix)
{
	elevator_door_safety_clip = getentarray(self.targetname + suffix, "script_noteworthy");
	if(isdefined(elevator_door_safety_clip))
	{
		for(i = 0; i < elevator_door_safety_clip.size; i++)
		{
			if(block)
			{
				elevator_door_safety_clip[i] solid();
				continue;
			}
			elevator_door_safety_clip[i] notsolid();
		}
	}
}

/*
	Name: block_elev_doors
	Namespace: namespace_ccdea9b1
	Checksum: 0x314D544
	Offset: 0x2B88
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function block_elev_doors(block)
{
	block_elev_doors_internal(block, "_safety_top");
	block_elev_doors_internal(block, "_safety_bottom");
}

/*
	Name: init_buy
	Namespace: namespace_ccdea9b1
	Checksum: 0x426731A8
	Offset: 0x2BE0
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function init_buy()
{
	trigger = getent(self.targetname + "_buy", "script_noteworthy");
	trigger thread elevator_buy_think(self);
}

/*
	Name: elevator_buy_think
	Namespace: namespace_ccdea9b1
	Checksum: 0xE1695C8D
	Offset: 0x2C40
	Size: 0x410
	Parameters: 1
	Flags: Linked
*/
function elevator_buy_think(elevator)
{
	if(zm_utility::is_standard())
	{
		if(function_8b1a219a())
		{
			level.var_31560d97 = #"hash_3e8b1cb2500ba3a7";
		}
		else
		{
			level.var_31560d97 = #"hash_146622decb4e7399";
		}
	}
	else if(function_8b1a219a())
	{
		level.var_31560d97 = #"hash_65d7c16bd5a94c67";
	}
	else
	{
		level.var_31560d97 = #"hash_6362bcfbec5e8759";
	}
	self setcursorhint("HINT_NOICON");
	self usetriggerrequirelookat();
	self sethintstring(level.var_31560d97, elevator.cost);
	while(true)
	{
		who = undefined;
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		who = waitresult.activator;
		elev_clear = is_elevator_clear(elevator);
		if(!elev_clear)
		{
			zm_utility::play_sound_at_pos("no_purchase", self.origin);
			self sethintstring(#"hash_2af4a28719c51767");
			wait(1);
			self sethintstring(level.var_31560d97, elevator.cost);
		}
		else if(zm_utility::is_player_valid(who) && who zm_score::can_player_purchase(elevator.cost) && who can_buy_elevator())
		{
			elevator.active = 1;
			who zm_score::minus_to_player_score(elevator.cost);
			zm_utility::play_sound_at_pos("purchase", self.origin);
			elevator disable_callboxes();
			elevator disable_elevator_buys();
			call_box_array = getentarray(elevator.station, "script_noteworthy");
			call_box = call_box_array[0];
			if(call_box.script_noteworthy == elevator.targetname + "_up")
			{
				call_box.destination = elevator.targetname + "_down";
			}
			else
			{
				call_box.destination = elevator.targetname + "_up";
			}
			elevator thread redirect_zombies(call_box.destination);
			self elevator_move_to(elevator);
		}
		else
		{
			zm_utility::play_sound_at_pos("no_purchase", self.origin);
			who zm_audio::create_and_play_dialog(#"general", #"outofmoney");
		}
		wait(0.05);
	}
}

/*
	Name: can_buy_elevator
	Namespace: namespace_ccdea9b1
	Checksum: 0x54BC4192
	Offset: 0x3058
	Size: 0x26
	Parameters: 0
	Flags: Linked
*/
function can_buy_elevator()
{
	if(self zm_utility::in_revive_trigger())
	{
		return 0;
	}
	return 1;
}

/*
	Name: disable_callboxes
	Namespace: namespace_ccdea9b1
	Checksum: 0xD86EC0DF
	Offset: 0x3088
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function disable_callboxes()
{
	call_boxes = getentarray(self.targetname + "_call_box", "targetname");
	for(j = 0; j < call_boxes.size; j++)
	{
		call_boxes[j] triggerenable(0);
	}
}

/*
	Name: disable_elevator_buys
	Namespace: namespace_ccdea9b1
	Checksum: 0xCED3E85B
	Offset: 0x3118
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function disable_elevator_buys()
{
	elevator_buy = getent(self.targetname + "_buy", "script_noteworthy");
	elevator_buy setcursorhint("HINT_NOICON");
	elevator_buy sethintstring("");
	elevator_buy triggerenable(0);
}

/*
	Name: enable_elevator_buys
	Namespace: namespace_ccdea9b1
	Checksum: 0x4DDAF449
	Offset: 0x31B8
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function enable_elevator_buys()
{
	elevator_buy = getent(self.targetname + "_buy", "script_noteworthy");
	elevator_buy setcursorhint("HINT_NOICON");
	elevator_buy sethintstring(level.var_31560d97, self.cost);
	elevator_buy triggerenable(1);
}

/*
	Name: enable_callboxes
	Namespace: namespace_ccdea9b1
	Checksum: 0x14454277
	Offset: 0x3260
	Size: 0x12E
	Parameters: 0
	Flags: Linked
*/
function enable_callboxes()
{
	call_boxes = getentarray(self.targetname + "_call_box", "targetname");
	for(j = 0; j < call_boxes.size; j++)
	{
		if(call_boxes[j].script_noteworthy != self.station)
		{
			call_boxes[j] triggerenable(1);
			if(function_8b1a219a())
			{
				call_boxes[j] sethintstring(#"hash_4e2495c99a50f326");
			}
			else
			{
				call_boxes[j] sethintstring(#"hash_2f56b9d8ac49ff92");
			}
			continue;
		}
		call_boxes[j] triggerenable(0);
	}
}

/*
	Name: elevator_move_to
	Namespace: namespace_ccdea9b1
	Checksum: 0xDAB105F1
	Offset: 0x3398
	Size: 0x640
	Parameters: 1
	Flags: Linked
*/
function elevator_move_to(elevator)
{
	players = getplayers();
	elevator close_elev_doors();
	level flag::clear("spawn_zombies");
	elevator waittill(#"doors_finished_moving");
	elevator block_elev_doors(0);
	elevator notify(#"start_3d_audio");
	elevator thread elev_clean_up_corpses();
	if(elevator.station == elevator.targetname + "_up")
	{
		if(elevator.targetname == "elevator1")
		{
			function_d5410733();
			elevator thread zombie_elevator_closets(0);
			elevator.var_a231af57 = 3;
			if(!zm_zonemgr::zone_is_enabled("labs_elevator"))
			{
				zm_zonemgr::enable_zone("labs_elevator");
			}
		}
		else
		{
			elevator.var_a231af57 = 2;
			function_5e62aa83();
			if(!zm_zonemgr::zone_is_enabled("war_room_zone_top"))
			{
				zm_zonemgr::enable_zone("war_room_zone_top");
			}
		}
		elevator vehicle::get_on_and_go_path(elevator.var_7237c31e);
		elevator waittill(#"reached_end_node");
		elevator.station = elevator.targetname + "_down";
		if(elevator.targetname == "elevator1" && !level flag::get("labs_enabled"))
		{
			level flag::set("labs_enabled");
		}
		else if(elevator.targetname == "elevator2" && !level flag::get("war_room_start"))
		{
			level flag::set("war_room_start");
		}
	}
	else if(elevator.targetname == "elevator1")
	{
		function_1352fc3c();
		elevator thread zombie_elevator_closets(1);
		elevator.var_a231af57 = 2;
	}
	else
	{
		function_cfd40975();
		elevator.var_a231af57 = 1;
	}
	elevator vehicle::get_on_and_go_path(elevator.var_5a3b55a3);
	elevator waittill(#"reached_end_node");
	elevator.station = elevator.targetname + "_up";
	if(elevator.targetname == "elevator2")
	{
		util::clientnotify("ele1e");
		if(elevator.station == elevator.targetname + "_up")
		{
			function_db4ac61a();
			elevator playsound(#"hash_6dc5b145a42639b7");
		}
		else if(elevator.station == elevator.targetname + "_down")
		{
			function_db4ac61a();
			elevator playsound(#"hash_3faa2aca94611bdc");
		}
	}
	else if(elevator.targetname == "elevator1")
	{
		util::clientnotify("ele2e");
		if(elevator.station == elevator.targetname + "_up")
		{
			function_4cf5b4dd();
			elevator playsound(#"hash_3faa2aca94611bdc");
		}
		else if(elevator.station == elevator.targetname + "_down")
		{
			function_4cf5b4dd();
			elevator playsound(#"hash_74f5fc759e9f23d5");
		}
	}
	level flag::set("elevator_grounded");
	level flag::set("spawn_zombies");
	elevator.var_a231af57 = undefined;
	elevator open_elev_doors();
	elevator waittill(#"doors_finished_moving");
	elevator.called = 0;
	elevator.active = 0;
	elevator enable_elevator_buys();
	elevator enable_callboxes();
	elevator notify(#"hash_26d932820f7f5373");
}

/*
	Name: zombie_elevator_closets
	Namespace: namespace_ccdea9b1
	Checksum: 0xEDBA6E49
	Offset: 0x39E0
	Size: 0x266
	Parameters: 1
	Flags: Linked
*/
function zombie_elevator_closets(going_up)
{
	if(!isdefined(going_up))
	{
		return;
	}
	if(going_up == 1)
	{
		special_spawn = getentarray("elevator1_down_spawncloset", "targetname");
		foreach(point in level.var_fc1f5422)
		{
			point.is_enabled = 1;
		}
		foreach(point in level.var_3d9e751c)
		{
			point.is_enabled = 0;
		}
	}
	else
	{
		special_spawn = getentarray("elevator1_up_spawncloset", "targetname");
		foreach(point in level.var_fc1f5422)
		{
			point.is_enabled = 0;
		}
		foreach(point in level.var_3d9e751c)
		{
			point.is_enabled = 1;
		}
	}
	if(isdefined(special_spawn))
	{
		for(i = 0; i < special_spawn.size; i++)
		{
			special_spawn[i] thread elevator_closet_cleanup();
		}
	}
}

/*
	Name: elevator_closet_cleanup
	Namespace: namespace_ccdea9b1
	Checksum: 0x91749D17
	Offset: 0x3C50
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function elevator_closet_cleanup()
{
	zombies = getaiarray();
	if(!isdefined(zombies))
	{
		return;
	}
	foreach(zombie in zombies)
	{
		if(zombie istouching(self))
		{
			zombie thread namespace_57ff8cbb::cleanup_zombie();
		}
	}
}

/*
	Name: elev_clean_up_corpses
	Namespace: namespace_ccdea9b1
	Checksum: 0xFC3B062E
	Offset: 0x3D10
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function elev_clean_up_corpses()
{
	corpse_trig = getent(self.targetname + "_zombie_cleanup", "targetname");
	corpses = getcorpsearray();
	if(isdefined(corpses))
	{
		for(i = 0; i < corpses.size; i++)
		{
			if(corpses[i] istouching(corpse_trig))
			{
				corpses[i] thread elev_remove_corpses();
			}
		}
	}
	physicsexplosionsphere(corpse_trig.origin, 400, 0, 0.01, 0, 0);
}

/*
	Name: elev_remove_corpses
	Namespace: namespace_ccdea9b1
	Checksum: 0xCF95D4DA
	Offset: 0x3E18
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function elev_remove_corpses()
{
	playfx(level._effect[#"dog_gib"], self.origin);
	self delete();
}

/*
	Name: init_elevator1_doors
	Namespace: namespace_ccdea9b1
	Checksum: 0x64ECBC3
	Offset: 0x3E70
	Size: 0x232
	Parameters: 0
	Flags: Linked
*/
function init_elevator1_doors()
{
	self.doors_up = getentarray("elevator1_doors_up", "script_noteworthy");
	for(i = 0; i < self.doors_up.size; i++)
	{
		self.doors_up[i].startpos = self.doors_up[i].origin;
	}
	self.doors_down = getentarray("elevator1_doors_down", "script_noteworthy");
	for(j = 0; j < self.doors_down.size; j++)
	{
		self.doors_down[j].startpos = self.doors_down[j].origin;
	}
	self.doors_outer_down = getentarray("elevator1_outerdoors_down", "script_noteworthy");
	for(k = 0; k < self.doors_outer_down.size; k++)
	{
		self.doors_outer_down[k].startpos = self.doors_outer_down[k].origin;
	}
	self.doors_outer_up = getentarray("elevator1_outerdoors_up", "script_noteworthy");
	for(l = 0; l < self.doors_outer_up.size; l++)
	{
		self.doors_outer_up[l].startpos = self.doors_outer_up[l].origin;
	}
	self.var_15a48007 = getent("elev1_level2_crush", "targetname");
	self.var_8e5e8534 = getent("elev1_level3_crush", "targetname");
}

/*
	Name: init_elevator2_doors
	Namespace: namespace_ccdea9b1
	Checksum: 0x510E9362
	Offset: 0x40B0
	Size: 0x1BA
	Parameters: 0
	Flags: Linked
*/
function init_elevator2_doors()
{
	self.doors = getentarray("elevator2_doors", "script_noteworthy");
	for(i = 0; i < self.doors.size; i++)
	{
		self.doors[i].startpos = self.doors[i].origin;
	}
	self.doors_outer_down = getentarray("elevator2_outerdoors_down", "script_noteworthy");
	for(k = 0; k < self.doors_outer_down.size; k++)
	{
		self.doors_outer_down[k].startpos = self.doors_outer_down[k].origin;
	}
	self.doors_outer_up = getentarray("elevator2_outerdoors_up", "script_noteworthy");
	for(l = 0; l < self.doors_outer_up.size; l++)
	{
		self.doors_outer_up[l].startpos = self.doors_outer_up[l].origin;
	}
	self.var_15a48007 = getent("elev2_level1_crush", "targetname");
	self.var_8e5e8534 = getent("elev2_level2_crush", "targetname");
}

/*
	Name: close_elev_doors
	Namespace: namespace_ccdea9b1
	Checksum: 0x486D1B16
	Offset: 0x4278
	Size: 0x56C
	Parameters: 0
	Flags: Linked
*/
function close_elev_doors()
{
	self block_elev_doors(1);
	for(i = 0; i < self.doors_outer_down.size; i++)
	{
		self.doors_outer_down[i] thread relink_elev_doors(self.doors_outer_down[i].startpos, self, 0);
	}
	for(j = 0; j < self.doors_outer_up.size; j++)
	{
		self.doors_outer_up[j] thread relink_elev_doors(self.doors_outer_up[j].startpos, self, 0);
	}
	if(isdefined(self.doors_down))
	{
		for(k = 0; k < self.doors_down.size; k++)
		{
			newpos3 = (self.doors_down[k].startpos[0], self.doors_down[k].startpos[1], self.doors_down[k].origin[2]);
			self.doors_down[k] thread relink_elev_doors(newpos3, self, 1);
			playsoundatposition(#"evt_elevator_freight_door_close", newpos3);
		}
	}
	if(isdefined(self.doors_up))
	{
		for(l = 0; l < self.doors_up.size; l++)
		{
			newpos4 = (self.doors_up[l].startpos[0], self.doors_up[l].startpos[1], self.doors_up[l].origin[2]);
			self.doors_up[l] thread relink_elev_doors(newpos4, self, 1);
			playsoundatposition(#"evt_elevator_freight_door_close", newpos4);
		}
		if(self.station == self.targetname + "_down")
		{
			nd_elev1_in_labs = getnode("nd_elev1_in_labs", "targetname");
			if(isdefined(nd_elev1_in_labs))
			{
				unlinktraversal(nd_elev1_in_labs);
				self thread function_eee9c340(0);
			}
		}
		else
		{
			nd_elev1_in_war_room = getnode("nd_elev1_in_war_room", "targetname");
			if(isdefined(nd_elev1_in_war_room))
			{
				unlinktraversal(nd_elev1_in_war_room);
				self thread function_eee9c340(1);
			}
		}
	}
	if(isdefined(self.doors))
	{
		for(m = 0; m < self.doors.size; m++)
		{
			if(self.station == self.targetname + "_up")
			{
				newpos5 = self.doors[m].startpos;
			}
			else
			{
				newpos5 = (self.doors[m].startpos[0], self.doors[m].startpos[1], self.doors[m].origin[2]);
			}
			self.doors[m] thread relink_elev_doors(newpos5, self, 1);
			playsoundatposition(#"evt_elevator_office_door_close", newpos5);
		}
		if(self.station == self.targetname + "_down")
		{
			nd_elev2_in_war_room = getnode("nd_elev2_in_war_room", "targetname");
			if(isdefined(nd_elev2_in_war_room))
			{
				unlinktraversal(nd_elev2_in_war_room);
				self thread function_eee9c340(0);
			}
		}
		else
		{
			nd_elev2_in_level1 = getnode("nd_elev2_in_level1", "targetname");
			if(isdefined(nd_elev2_in_level1))
			{
				unlinktraversal(nd_elev2_in_level1);
				self thread function_eee9c340(1);
			}
		}
	}
}

/*
	Name: open_elev_doors
	Namespace: namespace_ccdea9b1
	Checksum: 0x32C46526
	Offset: 0x47F0
	Size: 0x7EC
	Parameters: 0
	Flags: Linked
*/
function open_elev_doors()
{
	if(self.station == self.targetname + "_down")
	{
		for(j = 0; j < self.doors_outer_down.size; j++)
		{
			newpos1 = self.doors_outer_down[j].startpos + self.doors_outer_down[j].script_vector;
			self.doors_outer_down[j] thread relink_elev_doors(newpos1, self, 0);
		}
		if(isdefined(self.doors_up))
		{
			for(i = 0; i < self.doors_up.size; i++)
			{
				pos2 = self.doors_up[i].startpos + self.doors_up[i].script_vector;
				newpos2 = (pos2[0], pos2[1], self.doors_up[i].origin[2]);
				self.doors_up[i] thread relink_elev_doors(newpos2, self, 1);
				playsoundatposition(#"evt_elevator_freight_door_open", newpos2);
			}
		}
		if(isdefined(self.doors_down))
		{
			for(i = 0; i < self.doors_down.size; i++)
			{
				pos1 = self.doors_down[i].startpos + self.doors_down[i].script_vector;
				newpos = (pos1[0], pos1[1], self.doors_down[i].origin[2]);
				self.doors_down[i] thread relink_elev_doors(newpos, self, 1);
				playsoundatposition(#"evt_elevator_freight_door_open", newpos);
			}
			nd_elev1_in_labs = getnode("nd_elev1_in_labs", "targetname");
			if(isdefined(nd_elev1_in_labs))
			{
				linktraversal(nd_elev1_in_labs);
			}
		}
		if(isdefined(self.doors))
		{
			for(m = 0; m < self.doors.size; m++)
			{
				pos2 = self.doors[m].startpos + self.doors[m].script_vector;
				if(self.station == self.targetname + "_up")
				{
					newpos2 = (pos2[0], pos2[1], self.doors[m].startpos[2]);
				}
				else
				{
					newpos2 = (pos2[0], pos2[1], self.doors[m].origin[2]);
				}
				self.doors[m] thread relink_elev_doors(newpos2, self, 1);
				playsoundatposition(#"hash_5ef3b0941ea2aa74", newpos2);
			}
			nd_elev2_in_war_room = getnode("nd_elev2_in_war_room", "targetname");
			if(isdefined(nd_elev2_in_war_room))
			{
				linktraversal(nd_elev2_in_war_room);
			}
		}
	}
	else
	{
		for(j = 0; j < self.doors_outer_up.size; j++)
		{
			newpos1 = self.doors_outer_up[j].startpos + self.doors_outer_up[j].script_vector;
			self.doors_outer_up[j] thread relink_elev_doors(newpos1, self, 0);
		}
		if(isdefined(self.doors_up))
		{
			for(i = 0; i < self.doors_up.size; i++)
			{
				pos2 = self.doors_up[i].startpos + self.doors_up[i].script_vector;
				newpos2 = (pos2[0], pos2[1], self.doors_up[i].origin[2]);
				self.doors_up[i] thread relink_elev_doors(newpos2, self, 1);
				playsoundatposition(#"evt_elevator_freight_door_open", newpos2);
			}
		}
		if(isdefined(self.doors_down))
		{
			for(k = 0; k < self.doors_down.size; k++)
			{
				pos4 = self.doors_down[k].startpos + self.doors_down[k].script_vector;
				newpos4 = (pos4[0], pos4[1], self.doors_down[k].origin[2]);
				self.doors_down[k] thread relink_elev_doors(newpos4, self, 1);
				playsoundatposition(#"evt_elevator_freight_door_open", newpos4);
			}
			nd_elev1_in_war_room = getnode("nd_elev1_in_war_room", "targetname");
			if(isdefined(nd_elev1_in_war_room))
			{
				linktraversal(nd_elev1_in_war_room);
			}
		}
		if(isdefined(self.doors))
		{
			for(m = 0; m < self.doors.size; m++)
			{
				pos3 = self.doors[m].startpos + self.doors[m].script_vector;
				newpos3 = (pos3[0], pos3[1], self.doors[m].origin[2]);
				self.doors[m] thread relink_elev_doors(newpos3, self, 1);
				playsoundatposition(#"hash_5ef3b0941ea2aa74", newpos3);
			}
			nd_elev2_in_level1 = getnode("nd_elev2_in_level1", "targetname");
			if(isdefined(nd_elev2_in_level1))
			{
				linktraversal(nd_elev2_in_level1);
			}
		}
	}
}

/*
	Name: relink_elev_doors
	Namespace: namespace_ccdea9b1
	Checksum: 0x22B872C1
	Offset: 0x4FE8
	Size: 0xB6
	Parameters: 3
	Flags: Linked
*/
function relink_elev_doors(pos, elev, linked)
{
	self unlink();
	self moveto(pos, 1);
	self waittill(#"movedone");
	if(linked)
	{
		self linkto(elev);
	}
	elev notify(#"doors_finished_moving");
	if(self.classname == "script_model")
	{
		return;
	}
}

/*
	Name: redirect_zombies
	Namespace: namespace_ccdea9b1
	Checksum: 0x8489203F
	Offset: 0x50A8
	Size: 0x174
	Parameters: 1
	Flags: Linked
*/
function redirect_zombies(destination)
{
	players = getplayers();
	num_players = 0;
	for(i = 0; i < players.size; i++)
	{
		if(players[i] istouching(self))
		{
			num_players++;
		}
	}
	if(!num_players == players.size)
	{
		return;
	}
	wait(2);
	location = getnode(destination, "targetname");
	if(isdefined(location))
	{
		poi = spawn("script_origin", location.origin);
		poi zm_utility::create_zombie_point_of_interest(undefined, 25, 0, 1);
		level flag::wait_till("elevator_grounded");
		poi zm_utility::deactivate_zombie_point_of_interest();
		poi delete();
	}
}

/*
	Name: unlock_players
	Namespace: namespace_ccdea9b1
	Checksum: 0x42972BA2
	Offset: 0x5228
	Size: 0x12E
	Parameters: 0
	Flags: None
*/
function unlock_players()
{
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] unlink();
		players[i] allowcrouch(1);
		players[i] allowprone(1);
		players[i] disableinvulnerability();
		/#
			if(getdvarint(#"zombie_cheat", 0) >= 1 && getdvarint(#"zombie_cheat", 0) <= 3)
			{
				players[i] enableinvulnerability();
			}
		#/
	}
}

/*
	Name: elevator1_3d_audio
	Namespace: namespace_ccdea9b1
	Checksum: 0x68625A87
	Offset: 0x5360
	Size: 0x140
	Parameters: 0
	Flags: Linked
*/
function elevator1_3d_audio()
{
	while(true)
	{
		self waittill(#"start_3d_audio");
		ent = spawn("script_origin", self.origin + vectorscale((0, 0, 1), 30));
		ent linkto(self);
		ent playsound("evt_elevator_freight_start");
		ent playloopsound("evt_elevator_freight_run_3d");
		self waittill(#"reached_end_node");
		ent delete();
		playsoundatposition(#"evt_elevator_freight_stop", self.origin);
		playsoundatposition(#"hash_5bbffe8bd9e541a7", self.origin + vectorscale((0, 0, 1), 120));
	}
}

/*
	Name: elevator2_3d_audio
	Namespace: namespace_ccdea9b1
	Checksum: 0x26BD163
	Offset: 0x54A8
	Size: 0x118
	Parameters: 0
	Flags: Linked
*/
function elevator2_3d_audio()
{
	while(true)
	{
		self waittill(#"start_3d_audio");
		ent = spawn("script_origin", self.origin + vectorscale((0, 0, 1), 30));
		ent linkto(self);
		ent playsound(#"evt_elevator_office_start");
		ent playloopsound(#"hash_3a6fc5051c04a776");
		self waittill(#"reached_end_node");
		ent delete();
		playsoundatposition(#"hash_b696d1d50b35e32", self.origin + vectorscale((0, 0, 1), 120));
	}
}

/*
	Name: function_eee9c340
	Namespace: namespace_ccdea9b1
	Checksum: 0x4D39E7E0
	Offset: 0x55C8
	Size: 0x130
	Parameters: 1
	Flags: Linked
*/
function function_eee9c340(var_73803951)
{
	if(var_73803951)
	{
		var_c5091b30 = self.var_15a48007;
	}
	else
	{
		var_c5091b30 = self.var_8e5e8534;
	}
	wait(0.6);
	foreach(ai in getaiarray())
	{
		if(isdefined(ai.allowdeath) && !ai.allowdeath)
		{
			continue;
		}
		if(ai istouching(var_c5091b30) && ai.missinglegs === 1)
		{
			ai zombie_utility::zombie_head_gib();
			ai kill();
		}
	}
}

/*
	Name: function_dec13a5b
	Namespace: namespace_ccdea9b1
	Checksum: 0xD98F182A
	Offset: 0x5700
	Size: 0x5EC
	Parameters: 0
	Flags: Linked
*/
function function_dec13a5b()
{
	level endon(#"end_game");
	self notify("19e5073d3e85ec91");
	self endon("19e5073d3e85ec91");
	while(true)
	{
		level waittill(#"host_migration_begin");
		a_players = getplayers();
		foreach(player in a_players)
		{
			player val::set("host_migration", "allowdeath", 0);
			player val::set("host_migration", "takedamage", 0);
		}
		level waittill(#"host_migration_end");
		level thread function_1576e092();
		wait(1.5);
		a_players = getplayers();
		var_ed7230a5 = [];
		foreach(e_player in a_players)
		{
			var_fb783f78 = 0;
			if(distance2d(e_player.origin, level.elevator1.origin) < 80 || distance2d(e_player.origin, level.elevator2.origin) < 80)
			{
				var_fb783f78 = 1;
			}
			str_zone = zm_zonemgr::function_49d8d29f(e_player.origin);
			if(!(isdefined(e_player zm_utility::in_playable_area()) && e_player zm_utility::in_playable_area()) || (!isdefined(str_zone) && (isdefined(var_fb783f78) && var_fb783f78)))
			{
				a_s_pos = struct::get_array("player_respawn_point", "targetname");
				a_s_pos = arraysortclosest(a_s_pos, e_player.origin);
				foreach(s_pos in a_s_pos)
				{
					a_s_points = struct::get_array(s_pos.target);
					a_s_points = arraysortclosest(a_s_points, player.origin);
					foreach(s_pos in a_s_points)
					{
						if(!isinarray(var_ed7230a5, s_pos) && zm_utility::check_point_in_enabled_zone(s_pos.origin) && zm_utility::check_point_in_playable_area(s_pos.origin))
						{
							player thread function_da48c149(s_pos);
							player.var_e1e4facc = 1;
							if(!isdefined(var_ed7230a5))
							{
								var_ed7230a5 = [];
							}
							else if(!isarray(var_ed7230a5))
							{
								var_ed7230a5 = array(var_ed7230a5);
							}
							var_ed7230a5[var_ed7230a5.size] = s_pos;
							break;
						}
					}
					if(isdefined(player.var_e1e4facc) && player.var_e1e4facc)
					{
						player.var_e1e4facc = undefined;
						break;
					}
				}
			}
		}
		wait(5);
		a_players = getplayers();
		foreach(player in a_players)
		{
			player val::reset("host_migration", "allowdeath");
			player val::reset("host_migration", "takedamage");
		}
	}
}

/*
	Name: function_da48c149
	Namespace: namespace_ccdea9b1
	Checksum: 0x53C5DB9
	Offset: 0x5CF8
	Size: 0xD0
	Parameters: 1
	Flags: Linked, Private
*/
private function function_da48c149(s_pos)
{
	var_75c89236 = 0;
	self dontinterpolate();
	self setorigin(s_pos.origin);
	do
	{
		wait(1);
		if(!(isdefined(self zm_utility::in_playable_area()) && self zm_utility::in_playable_area()))
		{
			self dontinterpolate();
			self setorigin(s_pos.origin);
		}
		var_75c89236++;
	}
	while(var_75c89236 < 5);
}

/*
	Name: function_1576e092
	Namespace: namespace_ccdea9b1
	Checksum: 0x9B76A638
	Offset: 0x5DD0
	Size: 0x578
	Parameters: 0
	Flags: Linked
*/
function function_1576e092()
{
	var_844f2ba7 = getent("fx_light_elevator_origin", "targetname");
	if(isdefined(var_844f2ba7.fx_ent))
	{
		var_844f2ba7.var_d54159c9 = playfxontag(level.var_fecdcdc4, var_844f2ba7.fx_ent, "tag_origin");
		var_844f2ba7.var_d54159c9 linkto(level.var_d8a093b8[0]);
	}
	var_428c7836 = getent("fx_light_elevator1_origin", "targetname");
	if(isdefined(var_428c7836.fx_ent))
	{
		var_428c7836.var_286bc7b5 = playfxontag(level.var_41a1bc06, var_428c7836.fx_ent, "tag_origin");
		var_428c7836.var_286bc7b5 linkto(level.var_1ce67448[0]);
	}
	var_71ffef77 = getent("lgt_elevator_panel_illum_origin", "targetname");
	if(isdefined(var_71ffef77.fx_ent))
	{
		var_71ffef77.var_d54159c9 = playfxontag(level.var_e33251c7, var_71ffef77.fx_ent, "tag_origin");
		var_71ffef77.var_d54159c9 linkto(level.var_d8a093b8[0]);
	}
	var_b15265f4 = getent("lgt_elevator_panel_caster_origin", "targetname");
	if(isdefined(var_b15265f4.fx_ent))
	{
		var_b15265f4.var_d54159c9 = playfxontag(level.var_715ae9f9, var_b15265f4.fx_ent, "tag_origin");
		var_b15265f4.var_d54159c9 linkto(level.var_d8a093b8[0]);
	}
	var_30a32007 = getent("lgt_elevator2_panel_illum_origin", "targetname");
	if(isdefined(var_30a32007.fx_ent))
	{
		var_30a32007.var_d54159c9 = playfxontag(level.var_e33251c7, var_30a32007.fx_ent, "tag_origin");
		var_30a32007.var_d54159c9 linkto(level.var_1ce67448[0]);
	}
	var_c95e76a9 = getent("lgt_elevator2_panel_caster_origin", "targetname");
	if(isdefined(var_c95e76a9.fx_ent))
	{
		var_c95e76a9.var_d54159c9 = playfxontag(level.var_715ae9f9, var_c95e76a9.fx_ent, "tag_origin");
		var_c95e76a9.var_d54159c9 linkto(level.var_1ce67448[0]);
	}
	var_844f2f0a = getentarray("fx_light_illum_elevator_origin", "targetname");
	var_6d00692f = getentarray("fx_light_illum_elevator2_origin", "targetname");
	foreach(e_light in var_844f2f0a)
	{
		if(isdefined(e_light.fx_ent))
		{
			e_light.var_d54159c9 = playfxontag(level.var_dca712ff, e_light.fx_ent, "tag_origin");
			e_light.var_d54159c9 linkto(level.var_d8a093b8[0]);
		}
	}
	foreach(e_light in var_6d00692f)
	{
		if(isdefined(e_light.fx_ent))
		{
			e_light.var_d54159c9 = playfxontag(level.var_8caf5068, e_light.fx_ent, "tag_origin");
			e_light.var_d54159c9 linkto(level.var_1ce67448[0]);
		}
	}
}

