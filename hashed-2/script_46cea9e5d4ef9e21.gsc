// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5bb072c3abf4652c;
#using script_6e3c826b1814cab6;
#using script_7c62f55ce3a557ff;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_1063645;

/*
	Name: init_clientfields
	Namespace: namespace_1063645
	Checksum: 0xCA5EF457
	Offset: 0x298
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"hash_3e57db9b106dff0a", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_4ccf2ce25e0dc836", 1, 1, "int");
}

/*
	Name: function_fb0bd6b9
	Namespace: namespace_1063645
	Checksum: 0x40A60F52
	Offset: 0x328
	Size: 0x272
	Parameters: 0
	Flags: Linked
*/
function function_fb0bd6b9()
{
	if(zm_utility::is_standard())
	{
		return;
	}
	if(zm_utility::function_e51dc2d8() || zm_utility::is_trials())
	{
		level.var_d8e7f0cf[0] = array(1, 1, 5);
		level.var_d8e7f0cf[1] = array(8, 7, 2);
		level.var_d8e7f0cf[2] = array(6, 6, 6);
	}
	level flag::init(#"hash_6429ffd7bef6f720");
	level flag::init(#"hash_7ebd1255a2e91e3e");
	level flag::init(#"hash_795bde5570f8b67c");
	var_5554a9f4 = getent("nixie_door_trigger", "targetname");
	var_5554a9f4 thread _goodlighting_hangar_a();
	var_679f0ee5 = struct::get_array("nixie_tubes", "script_noteworthy");
	foreach(s_tube in var_679f0ee5)
	{
		var_ba528742 = util::spawn_model(#"hash_2a475dc4752c8b17", s_tube.origin, s_tube.angles);
		var_ba528742.script_noteworthy = "blast_attack_interactables";
		var_ba528742.script_string = "mdl_nixie_tubes";
		s_tube.var_ba528742 = var_ba528742;
	}
}

/*
	Name: _goodlighting_hangar_a
	Namespace: namespace_1063645
	Checksum: 0x4DA3E117
	Offset: 0x5A8
	Size: 0x464
	Parameters: 0
	Flags: Linked
*/
function _goodlighting_hangar_a()
{
	self sethintstring(#"hash_2f5a14e8bf175422");
	self.b_can_open = 0;
	level flag::wait_till(#"hash_7039457b1cc827de");
	if(function_8b1a219a())
	{
		self sethintstring(#"hash_749f3ae6e6a73762");
	}
	else
	{
		self sethintstring(#"hash_7b303154f29d09c6");
	}
	self waittill(#"trigger");
	var_f67ecd64 = getent("masterkey_lock_3", "targetname");
	if(isdefined(var_f67ecd64))
	{
		var_f67ecd64 delete();
	}
	playsoundatposition(#"hash_b0382b7432f8232", self.origin);
	mdl_door_left = getent("nixie_door_left", "targetname");
	mdl_door_right = getent("nixie_door_right", "targetname");
	mdl_door_left notsolid();
	mdl_door_right notsolid();
	mdl_door_left rotateyaw(-94, 1, 0.2, 0.2);
	mdl_door_right rotateyaw(195, 1, 0.2, 0.2);
	level thread function_152c339e();
	self delete();
	level flag::set(#"hash_6429ffd7bef6f720");
	level thread function_89f2ec87();
	wait(1);
	mdl_door_left rotateyaw(8, 1, 0.2, 0.2);
	mdl_door_right rotateyaw(-10, 1, 0.2, 0.2);
	wait(1);
	mdl_door_left rotateyaw(-5, 1, 0.2, 0.2);
	mdl_door_right rotateyaw(7, 1, 0.2, 0.2);
	wait(1);
	mdl_door_left rotateyaw(3, 1, 0.2, 0.2);
	mdl_door_right rotateyaw(-5, 1, 0.2, 0.2);
	wait(1);
	mdl_door_left rotateyaw(-2, 1, 0.2, 0.2);
	mdl_door_right rotateyaw(3, 1, 0.2, 0.2);
}

/*
	Name: function_89f2ec87
	Namespace: namespace_1063645
	Checksum: 0xAF4D805D
	Offset: 0xA18
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_89f2ec87()
{
	while(true)
	{
		var_32823664 = getentarray("mdl_nixie_tubes", "script_string");
		foreach(var_ba528742 in var_32823664)
		{
			var_ba528742 thread function_e5c8fd1d();
		}
		level waittill(#"hash_dfac532bccdb293");
		function_97f8efcd();
		level thread function_ca5612ce(var_32823664);
		level flag::wait_till_clear(#"hash_7ebd1255a2e91e3e");
		function_172e72fa();
		level notify(#"hash_59db65b924f851e4");
	}
}

/*
	Name: function_e5c8fd1d
	Namespace: namespace_1063645
	Checksum: 0x4E1E7B31
	Offset: 0xB50
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function function_e5c8fd1d()
{
	level endon(#"hash_7ebd1255a2e91e3e");
	self waittill(#"hash_6fd7f8e1f00deffe");
	self thread clientfield::set("" + #"hash_4ccf2ce25e0dc836", 1);
	level notify(#"hash_dfac532bccdb293");
}

/*
	Name: function_97f8efcd
	Namespace: namespace_1063645
	Checksum: 0x22A99C7
	Offset: 0xBC8
	Size: 0x1C8
	Parameters: 0
	Flags: Linked
*/
function function_97f8efcd()
{
	var_120c4733 = struct::get_array("nixie_tubes", "script_noteworthy");
	foreach(s_tube in var_120c4733)
	{
		var_ba528742 = s_tube.var_ba528742;
		var_ba528742 setmodel(#"hash_53d213db448a97e1");
		s_tube thread function_ba25a76f(0.75);
		if(s_tube.targetname == "nixie_tube_2")
		{
			s_tube thread function_d6ae109c(1);
		}
		s_target = struct::get(s_tube.target);
		var_68c9a993 = util::spawn_model(#"hash_2a475dc4752c8b17", s_target.origin, s_target.angles);
		s_tube.var_ba528742.var_68c9a993 = var_68c9a993;
		var_68c9a993 ghost();
		var_68c9a993 notsolid();
	}
	wait(0.75);
}

/*
	Name: function_ca5612ce
	Namespace: namespace_1063645
	Checksum: 0x9EF6A012
	Offset: 0xD98
	Size: 0x148
	Parameters: 1
	Flags: Linked
*/
function function_ca5612ce(var_32823664)
{
	level endon(#"hash_59db65b924f851e4", #"hash_795bde5570f8b67c");
	level flag::set(#"hash_7ebd1255a2e91e3e");
	wait(25);
	level flag::wait_till_clear(#"hash_795bde5570f8b67c");
	level flag::clear(#"hash_7ebd1255a2e91e3e");
	var_3c04def5 = array::random(var_32823664);
	e_closest_player = arraygetclosest(var_3c04def5.origin, level.players);
	if(isalive(e_closest_player))
	{
		e_closest_player thread zm_audio::create_and_play_dialog(#"hash_3410b64051803abd", #"generic");
	}
	level notify(#"hash_59db65b924f851e4");
}

/*
	Name: function_172e72fa
	Namespace: namespace_1063645
	Checksum: 0x9948CC46
	Offset: 0xEE8
	Size: 0x1D8
	Parameters: 0
	Flags: Linked
*/
function function_172e72fa()
{
	var_120c4733 = struct::get_array("nixie_tubes", "script_noteworthy");
	foreach(s_tube in var_120c4733)
	{
		s_tube.script_int = 0;
		var_ba528742 = s_tube.var_ba528742;
		var_ba528742 setmodel(#"hash_2a475dc4752c8b17");
		for(i = 0; i < 10; i++)
		{
			var_ba528742 hidepart("tag_nixie_" + i);
		}
		var_ba528742 thread clientfield::set("" + #"hash_4ccf2ce25e0dc836", 0);
		var_ba528742 showpart("tag_nixie_off");
		if(s_tube.targetname == "nixie_tube_2")
		{
			s_tube thread function_d6ae109c(0);
		}
		if(isdefined(s_tube.var_ba528742.var_68c9a993))
		{
			s_tube.var_ba528742.var_68c9a993 delete();
		}
	}
}

/*
	Name: function_ba25a76f
	Namespace: namespace_1063645
	Checksum: 0xBD1BD441
	Offset: 0x10C8
	Size: 0x21E
	Parameters: 2
	Flags: Linked
*/
function function_ba25a76f(n_max_time, var_62002857 = 0)
{
	var_ba528742 = self.var_ba528742;
	var_ba528742 hidepart("tag_nixie_off");
	n_start_time = gettime();
	n_total_time = 0;
	var_cddd0f11 = self.script_int;
	while(n_total_time < n_max_time)
	{
		n_part = randomint(10);
		while(n_part == var_cddd0f11)
		{
			n_part = randomint(10);
		}
		var_ba528742 showpart("tag_nixie_" + n_part);
		if(isdefined(var_cddd0f11))
		{
			var_ba528742 hidepart("tag_nixie_" + var_cddd0f11);
		}
		var_ba528742 playsound(#"hash_12da80f02ef99473");
		var_cddd0f11 = n_part;
		wait(0.1);
		n_current_time = gettime();
		n_total_time = (n_current_time - n_start_time) / 1000;
	}
	for(i = 1; i < 10; i++)
	{
		var_ba528742 hidepart("tag_nixie_" + i);
	}
	var_ba528742 showpart("tag_nixie_" + var_62002857);
	var_ba528742 playsound(#"hash_12da80f02ef99473");
	self.script_int = 0;
}

/*
	Name: function_d6ae109c
	Namespace: namespace_1063645
	Checksum: 0x2BAE6E75
	Offset: 0x12F0
	Size: 0xFC
	Parameters: 1
	Flags: Linked
*/
function function_d6ae109c(b_turn_on)
{
	if(b_turn_on)
	{
		self.e_sound = spawn("script_origin", self.origin);
		playsoundatposition(#"hash_5870f3024077503", self.origin);
		self.e_sound playloopsound(#"hash_589f33024097b46");
	}
	else if(isdefined(self.e_sound))
	{
		playsoundatposition(#"hash_6c0f63cd38c393e7", self.origin);
		self.e_sound stoploopsound();
		wait(0.5);
		self.e_sound delete();
	}
}

/*
	Name: function_152c339e
	Namespace: namespace_1063645
	Checksum: 0xB06C9935
	Offset: 0x13F8
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_152c339e()
{
	var_18b64c03 = struct::get("nixie_tube_2");
	var_18b64c03.unitrigger_stub = var_18b64c03 zm_unitrigger::create(&function_bad2e505, (128, 64, 96), &function_290d172d);
	var_18b64c03.unitrigger_stub.cursor_hint = "HINT_NOICON";
	var_18b64c03.unitrigger_stub.targetname = var_18b64c03.script_string;
	var_18b64c03.unitrigger_stub.s_tube = var_18b64c03;
	v_pos = var_18b64c03.origin + (anglestoright(var_18b64c03.angles) * 24);
	var_18b64c03.unitrigger_stub.origin = v_pos;
	zm_unitrigger::unitrigger_force_per_player_triggers(var_18b64c03.unitrigger_stub, 1);
}

/*
	Name: function_bad2e505
	Namespace: namespace_1063645
	Checksum: 0x3CADFD5F
	Offset: 0x1530
	Size: 0x14E
	Parameters: 1
	Flags: Linked
*/
function function_bad2e505(player)
{
	if(level flag::get(#"hash_7ebd1255a2e91e3e") && !level flag::get(#"hash_795bde5570f8b67c"))
	{
		self setvisibletoplayer(player);
		switch(self.targetname)
		{
			case "nixie_tube_trigger_1":
			{
				self sethintstring(#"");
				break;
			}
			case "nixie_tube_trigger_2":
			{
				self sethintstring(#"");
				break;
			}
			case "nixie_tube_trigger_3":
			{
				self sethintstring(#"");
				break;
			}
		}
		return true;
	}
	self setinvisibletoplayer(player);
	return false;
}

/*
	Name: function_290d172d
	Namespace: namespace_1063645
	Checksum: 0xE90DF998
	Offset: 0x1688
	Size: 0x31E
	Parameters: 0
	Flags: Linked
*/
function function_290d172d()
{
	function_dae4ab9b(self, 0.05);
	var_7a452f77 = struct::get_array("nixie_tubes", "script_noteworthy");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger");
		var_7a452f77 = struct::get_array("nixie_tubes", "script_noteworthy");
		foreach(s_tube in var_7a452f77)
		{
			var_dc40fc85 = s_tube.var_ba528742 sightconetrace(s_result.activator getweaponmuzzlepoint(), s_result.activator, s_result.activator getweaponforwarddir(), 15);
			if(isdefined(s_tube.var_ba528742.var_68c9a993))
			{
				var_6c48173b = s_tube.var_ba528742.var_68c9a993 sightconetrace(s_result.activator getweaponmuzzlepoint(), s_result.activator, s_result.activator getweaponforwarddir(), 20);
			}
			if(isdefined(var_dc40fc85) && var_dc40fc85 || (isdefined(var_6c48173b) && var_6c48173b))
			{
				s_tube.var_ba528742 hidepart("tag_nixie_" + s_tube.script_int);
				s_tube.script_int = (s_tube.script_int + 1) % 10;
				s_tube.var_ba528742 showpart("tag_nixie_" + s_tube.script_int);
				s_tube.var_ba528742 playsound(#"hash_1aead9e7cdebe7d2");
				break;
			}
		}
		if(zm_utility::function_e51dc2d8() || zm_utility::is_trials())
		{
			level thread function_bbca669b(s_result.activator);
		}
		waitframe(1);
	}
}

/*
	Name: function_bbca669b
	Namespace: namespace_1063645
	Checksum: 0xD7352FF2
	Offset: 0x19B0
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_bbca669b(var_64c09f7f)
{
	level notify(#"hash_2f586f8df1e6596d");
	level endon(#"hash_2f586f8df1e6596d", #"hash_59db65b924f851e4", #"hash_f787bd652d7a4b");
	wait(2);
	level thread function_c1cc29be(var_64c09f7f);
}

/*
	Name: function_c1cc29be
	Namespace: namespace_1063645
	Checksum: 0xAC90620D
	Offset: 0x1A30
	Size: 0x5B4
	Parameters: 1
	Flags: Linked
*/
function function_c1cc29be(var_64c09f7f)
{
	level endon(#"hash_59db65b924f851e4");
	level notify(#"hash_f787bd652d7a4b");
	var_4f5b63ea = struct::get("nixie_tube_1");
	var_83aecc80 = struct::get("nixie_tube_2");
	var_31a8a875 = struct::get("nixie_tube_3");
	var_8171dd3a = var_4f5b63ea.script_int;
	var_8dfff656 = var_83aecc80.script_int;
	var_44e1e41b = var_31a8a875.script_int;
	var_bbcf512c = 0;
	var_954ac27a = 0;
	if(var_8171dd3a == var_4f5b63ea.var_825e7054 && var_8dfff656 == var_83aecc80.var_825e7054 && var_44e1e41b == var_31a8a875.var_825e7054)
	{
		var_bbcf512c = 1;
	}
	else
	{
		for(i = 0; i < level.var_d8e7f0cf.size; i++)
		{
			if(var_8171dd3a == level.var_d8e7f0cf[i][0] && var_8dfff656 == level.var_d8e7f0cf[i][1] && var_44e1e41b == level.var_d8e7f0cf[i][2])
			{
				if(var_8171dd3a == 9 && var_8dfff656 == 3 && var_44e1e41b == 5 && (isdefined(level.var_461a9705) && level.var_461a9705))
				{
					var_954ac27a = 0;
					continue;
				}
				if(var_8171dd3a == 6 && var_8dfff656 == 6 && var_44e1e41b == 6 && (isdefined(level.var_19fe84f5) && level.var_19fe84f5))
				{
					var_954ac27a = 1;
					var_b402acf2 = 1;
					continue;
				}
				var_954ac27a = 1;
			}
		}
	}
	if(var_954ac27a || (var_bbcf512c && !level flag::get(#"hash_ed90925c898d1b0")))
	{
		var_3f6f6d2c = 1;
	}
	if(isdefined(var_3f6f6d2c) && var_3f6f6d2c)
	{
		level flag::set(#"hash_795bde5570f8b67c");
		if(isalive(var_64c09f7f) && (!(isdefined(var_b402acf2) && var_b402acf2)))
		{
			var_64c09f7f thread zm_audio::create_and_play_dialog(#"hash_74a0ff3487006243", #"generic");
		}
		var_4f5b63ea thread function_4b17c9f6(1.5);
		var_83aecc80 thread function_4b17c9f6(1.5);
		var_31a8a875 thread function_4b17c9f6(1.5);
		wait(1.5 + 0.25);
		var_62002857 = 0;
		if(var_954ac27a)
		{
			var_d46a1171 = (("" + var_8171dd3a) + var_8dfff656) + var_44e1e41b;
			level thread function_a5d20d9b(var_d46a1171);
			if(var_d46a1171 == "115" && (!(isdefined(level.var_4f8596bf) && level.var_4f8596bf)))
			{
				var_62002857 = 6;
			}
		}
		var_4f5b63ea function_ba25a76f(0.75, var_62002857);
		var_83aecc80 function_ba25a76f(0.75, var_62002857);
		var_31a8a875 function_ba25a76f(0.75, var_62002857);
		wait(2);
		if(var_bbcf512c && level flag::exists(#"hash_ed90925c898d1b0") && !level flag::get(#"hash_ed90925c898d1b0"))
		{
			level flag::set(#"hash_ed90925c898d1b0");
		}
		level flag::clear(#"hash_795bde5570f8b67c");
		level flag::clear(#"hash_7ebd1255a2e91e3e");
	}
}

/*
	Name: function_a5d20d9b
	Namespace: namespace_1063645
	Checksum: 0x4AD3CF4E
	Offset: 0x1FF0
	Size: 0xDA
	Parameters: 1
	Flags: Linked
*/
function function_a5d20d9b(var_d46a1171)
{
	level notify(#"hash_1ba800da972b0558", {#hash_d46a1171:var_d46a1171});
	switch(var_d46a1171)
	{
		case "hash_456c3818181fa486":
		{
			level thread function_74244cfa();
			break;
		}
		case "hash_148ca2184545ba86":
		{
			level thread function_f2f53f97();
			break;
		}
		case "hash_3e1a1e18145b8081":
		{
			level thread function_15aa00e7();
			break;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: function_74244cfa
	Namespace: namespace_1063645
	Checksum: 0x50883539
	Offset: 0x20D8
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_74244cfa()
{
	if(isdefined(level.var_4f8596bf) && level.var_4f8596bf)
	{
		return;
	}
	level.var_4f8596bf = 1;
	level thread zm_audio::sndmusicsystem_stopandflush();
	waitframe(1);
	level thread zm_audio::sndmusicsystem_playstate("ee_song");
}

/*
	Name: function_f2f53f97
	Namespace: namespace_1063645
	Checksum: 0xBA05CA97
	Offset: 0x2150
	Size: 0x204
	Parameters: 0
	Flags: Linked, Private
*/
function private function_f2f53f97()
{
	if(isdefined(level.var_461a9705) && level.var_461a9705)
	{
		return;
	}
	level.var_461a9705 = 1;
	s_spawn_location = struct::get("nixie_tube_zombie_blood_start");
	var_9c0bf2db = util::spawn_model(s_spawn_location.model, s_spawn_location.origin, s_spawn_location.angles);
	var_9c0bf2db clientfield::set("" + #"hash_3e57db9b106dff0a", 1);
	s_target = struct::get(s_spawn_location.target);
	while(isdefined(s_target))
	{
		n_time = distance(var_9c0bf2db.origin, s_target.origin) / 300;
		var_9c0bf2db moveto(s_target.origin, n_time);
		var_9c0bf2db waittill(#"movedone");
		s_target = struct::get(s_target.target);
	}
	var_7d81025 = zm_powerups::specific_powerup_drop("zombie_blood", var_9c0bf2db.origin - vectorscale((0, 0, 1), 40));
	var_9c0bf2db delete();
	level thread function_25aaae40();
	var_7d81025 thread function_f50cec70();
}

/*
	Name: function_25aaae40
	Namespace: namespace_1063645
	Checksum: 0x5AAE5CF8
	Offset: 0x2360
	Size: 0x26
	Parameters: 0
	Flags: Linked, Private
*/
function private function_25aaae40()
{
	level waittill(#"between_round_over");
	level.var_461a9705 = undefined;
}

/*
	Name: function_15aa00e7
	Namespace: namespace_1063645
	Checksum: 0xF7703B25
	Offset: 0x2390
	Size: 0x146
	Parameters: 0
	Flags: Linked, Private
*/
function private function_15aa00e7()
{
	var_43b4f0a = struct::get("nixie_tube_2");
	playsoundatposition(#"hash_1588095b858588d", var_43b4f0a.origin);
	if(!(isdefined(level.var_19fe84f5) && level.var_19fe84f5))
	{
		if(zm_zonemgr::get_players_in_zone("zone_citadel_stairs") > 0)
		{
			level.var_19fe84f5 = namespace_961cf978::attempt_brutus_spawn(1, "zone_citadel_stairs");
		}
		else
		{
			if(zm_zonemgr::get_players_in_zone("zone_citadel_basement") > 0)
			{
				level.var_19fe84f5 = namespace_961cf978::attempt_brutus_spawn(1, "zone_citadel_basement");
			}
			else if(zm_zonemgr::get_players_in_zone("zone_citadel") > 0)
			{
				level.var_19fe84f5 = namespace_961cf978::attempt_brutus_spawn(1, "zone_citadel");
			}
		}
	}
}

/*
	Name: function_f50cec70
	Namespace: namespace_1063645
	Checksum: 0x63D810C3
	Offset: 0x24E0
	Size: 0xEC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_f50cec70()
{
	if(!isdefined(level.var_988ed695))
	{
		level.var_988ed695 = 0;
	}
	s_result = undefined;
	s_result = self waittill(#"powerup_timedout", #"powerup_grabbed");
	if(s_result._notify !== "powerup_grabbed" || level.var_988ed695 > 2)
	{
		return;
	}
	level.var_988ed695++;
	zm_vo::function_3c173d37(s_result.e_grabber.origin, 512);
	s_result.e_grabber zm_vo::function_a2bd5a0c(#"hash_6ae96725c891addc", 0, 1, 9999);
}

/*
	Name: function_4b17c9f6
	Namespace: namespace_1063645
	Checksum: 0x64818CE0
	Offset: 0x25D8
	Size: 0x1EC
	Parameters: 1
	Flags: Linked
*/
function function_4b17c9f6(n_max_time)
{
	var_ba528742 = self.var_ba528742;
	n_start_time = gettime();
	n_total_time = 0;
	var_cddd0f11 = undefined;
	b_hidden = 1;
	var_9229dbba = randomfloat(0.2);
	wait(var_9229dbba);
	n_current_time = gettime();
	n_total_time = (n_current_time - n_start_time) / 1000;
	while(n_total_time < n_max_time)
	{
		if(b_hidden)
		{
			var_ba528742 hidepart("tag_nixie_" + self.script_int);
			var_ba528742 showpart("tag_nixie_off");
			b_hidden = 0;
		}
		else
		{
			var_ba528742 showpart("tag_nixie_" + self.script_int);
			var_ba528742 hidepart("tag_nixie_off");
			b_hidden = 1;
			var_ba528742 playsound(#"hash_12da80f02ef99473");
		}
		wait(0.1);
		n_current_time = gettime();
		n_total_time = (n_current_time - n_start_time) / 1000;
	}
	var_ba528742 showpart("tag_nixie_" + self.script_int);
	var_ba528742 hidepart("tag_nixie_off");
}

/*
	Name: function_a23db4d2
	Namespace: namespace_1063645
	Checksum: 0x58A2FB37
	Offset: 0x27D0
	Size: 0x11E
	Parameters: 0
	Flags: None
*/
function function_a23db4d2()
{
	var_ba528742 = self.var_ba528742;
	for(i = 0; i < 10; i++)
	{
		var_ba528742 hidepart("tag_nixie_" + i);
	}
	var_ba528742 hidepart("tag_nixie_off");
	for(i = 0; i <= self.script_int; i++)
	{
		if(i > 0)
		{
			var_ba528742 hidepart("tag_nixie_" + (i - 1));
		}
		var_ba528742 showpart("tag_nixie_" + i);
		var_ba528742 playsound(#"hash_12da80f02ef99473");
		wait(0.1);
	}
}

/*
	Name: function_aac7105a
	Namespace: namespace_1063645
	Checksum: 0x3C5F07E7
	Offset: 0x28F8
	Size: 0x186
	Parameters: 3
	Flags: Linked
*/
function function_aac7105a(var_8171dd3a, var_8dfff656, var_44e1e41b)
{
	var_f5c4e913 = 1;
	if(var_8171dd3a == 0 || var_8dfff656 == 0 || var_44e1e41b == 0)
	{
		var_f5c4e913 = 0;
	}
	if(var_8171dd3a == 0 && var_8dfff656 == 0 && var_44e1e41b == 0)
	{
		var_f5c4e913 = 0;
	}
	if(var_8171dd3a == 6 && var_8dfff656 == 6 && var_44e1e41b == 6)
	{
		var_f5c4e913 = 0;
	}
	if(var_8171dd3a == 7 && var_8dfff656 == 7 && var_44e1e41b == 7)
	{
		var_f5c4e913 = 0;
	}
	for(i = 0; i < level.var_d8e7f0cf.size; i++)
	{
		if(var_8171dd3a == level.var_d8e7f0cf[i][0] && var_8dfff656 == level.var_d8e7f0cf[i][1] && var_44e1e41b == level.var_d8e7f0cf[i][2])
		{
			var_f5c4e913 = 0;
			break;
		}
	}
	return var_f5c4e913;
}

