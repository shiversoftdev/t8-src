// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_245749c1f51c5bd8;
#using script_5bb072c3abf4652c;
#using script_7e59d7bba853fe4b;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm\zm_escape_util.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_efb8c7fe;

/*
	Name: init_alcatraz_zipline
	Namespace: namespace_efb8c7fe
	Checksum: 0x8575F0C7
	Offset: 0x558
	Size: 0x784
	Parameters: 0
	Flags: Linked
*/
function init_alcatraz_zipline()
{
	level thread gondola_hostmigration();
	level.player_intersection_tracker_override = &zombie_alcatraz_player_intersection_tracker_override;
	level.var_fed9dc06 = 0;
	level flag::init("gondola_at_roof");
	level flag::init("gondola_at_docks");
	level flag::init("gondola_doors_moving");
	level flag::init("gondola_in_motion");
	level flag::init("gondola_initialized");
	e_gondola = getent("zipline_gondola", "targetname");
	e_gondola setmovingplatformenabled(1);
	e_gondola.takedamage = 0;
	level.e_gondola = e_gondola;
	e_gondola.location = "roof";
	e_gondola.destination = undefined;
	level.e_gondola.t_ride = getent("gondola_ride_trigger", "targetname");
	level.e_gondola.t_ride enablelinkto();
	level.e_gondola.t_ride linkto(e_gondola);
	var_57ba058f = getentarray("gondola_call_trigger", "targetname");
	foreach(trigger in var_57ba058f)
	{
		trigger sethintstring(#"hash_ebd3d1458a3b46e");
	}
	function_815e3997();
	a_gondola_doors = getentarray("gondola_doors", "targetname");
	foreach(mdl_door in a_gondola_doors)
	{
		mdl_door linkto(e_gondola);
		e_gondola establish_gondola_door_definition(mdl_door);
	}
	a_gondola_gates = getentarray("gondola_gates", "targetname");
	foreach(mdl_gate in a_gondola_gates)
	{
		mdl_gate linkto(e_gondola);
		e_gondola establish_gondola_gate_definition(mdl_gate);
	}
	a_gondola_landing_doors = getentarray("gondola_landing_doors", "targetname");
	foreach(mdl_door in a_gondola_landing_doors)
	{
		e_gondola establish_gondola_landing_door_definition(mdl_door);
	}
	a_gondola_landing_gates = getentarray("gondola_landing_gates", "targetname");
	foreach(mdl_gate in a_gondola_landing_gates)
	{
		e_gondola establish_gondola_landing_gate_definition(mdl_gate);
	}
	gondola_lights_red();
	level flag::wait_till("power_on1");
	level flag::set(#"hash_107c5504e3325022");
	var_ba1d5d90 = getentarray("gondola_powered_on", "script_string");
	foreach(var_751f2904 in var_ba1d5d90)
	{
		var_751f2904 notify(#"hash_6fd7f8e1f00deffe");
	}
	level flag::set("gondola_at_roof");
	e_gondola gondola_doors_move("roof", 1);
	level flag::set("gondola_initialized");
	gondola_lights_green();
	e_gondola clientfield::set("" + #"hash_4fe04b8fa56a05c6", 1);
	level.var_b9656485 = 0;
	level.var_cf10ac23 = 0;
	level.var_b5f05d46 = 0;
	var_9ce0aba1 = getentarray("gondola_move_trigger", "targetname");
	array::thread_all(var_9ce0aba1, &zipline_move_trigger_think);
	array::thread_all(var_57ba058f, &zipline_call_trigger_think);
}

/*
	Name: function_815e3997
	Namespace: namespace_efb8c7fe
	Checksum: 0x65ECF2DB
	Offset: 0xCE8
	Size: 0x140
	Parameters: 0
	Flags: Linked
*/
function function_815e3997()
{
	var_9ce0aba1 = getentarray("gondola_move_trigger", "targetname");
	foreach(trigger in var_9ce0aba1)
	{
		if(zm_utility::is_standard())
		{
			if(function_8b1a219a())
			{
				trigger sethintstring(#"hash_23ae833352769f3a");
			}
			else
			{
				trigger sethintstring(#"hash_675cfe2c548c034e");
			}
		}
		else
		{
			trigger sethintstring(#"hash_c0173e448a7253f", 750);
		}
		trigger setinvisibletoall();
	}
}

/*
	Name: gondola_hostmigration
	Namespace: namespace_efb8c7fe
	Checksum: 0x7DCC3F47
	Offset: 0xE30
	Size: 0x304
	Parameters: 0
	Flags: Linked
*/
function gondola_hostmigration()
{
	level endon(#"end_game");
	self notify("68c71342bd0612a7");
	self endon("68c71342bd0612a7");
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
		wait(0.5);
		if(!(isdefined(level.e_gondola.is_moving) && level.e_gondola.is_moving))
		{
			if(level.e_gondola.location == "roof")
			{
				var_cd3296d7 = getnode("nd_on_top_r", "targetname");
				if(isdefined(var_cd3296d7))
				{
					linktraversal(var_cd3296d7);
				}
			}
			else
			{
				var_fd05c6f4 = getnode("nd_on_bottom_r", "targetname");
				if(isdefined(var_fd05c6f4))
				{
					linktraversal(var_fd05c6f4);
				}
			}
		}
		function_815e3997();
		wait(1);
		player_escaped_gondola_failsafe();
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
	Name: link_player_to_gondola
	Namespace: namespace_efb8c7fe
	Checksum: 0x151887A1
	Offset: 0x1140
	Size: 0xE4
	Parameters: 0
	Flags: None
*/
function link_player_to_gondola()
{
	if(self function_9a8ab327() && isplayer(self))
	{
		self endon(#"disconnect", #"death");
		e_origin = util::spawn_model("tag_origin", self.origin, self.angles);
		level.var_ee9168a2[level.var_ee9168a2.size] = e_origin;
		e_origin linkto(level.e_gondola);
		self playerlinkto(e_origin);
	}
}

/*
	Name: function_9a8ab327
	Namespace: namespace_efb8c7fe
	Checksum: 0xFBEAA0A9
	Offset: 0x1230
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_9a8ab327()
{
	if(isplayer(self) || isactor(self))
	{
		if(isdefined(level.e_gondola) && isdefined(level.e_gondola.t_ride) && self istouching(level.e_gondola.t_ride))
		{
			return 1;
		}
		return 0;
	}
	return 0;
}

/*
	Name: zombie_alcatraz_player_intersection_tracker_override
	Namespace: namespace_efb8c7fe
	Checksum: 0x8484122
	Offset: 0x12D8
	Size: 0xF6
	Parameters: 1
	Flags: Linked
*/
function zombie_alcatraz_player_intersection_tracker_override(other_player)
{
	if(isdefined(self.afterlife_revived) && self.afterlife_revived || (isdefined(other_player.afterlife_revived) && other_player.afterlife_revived))
	{
		return 1;
	}
	if(isdefined(self.is_on_gondola) && self.is_on_gondola && (isdefined(level.e_gondola.is_moving) && level.e_gondola.is_moving))
	{
		return 1;
	}
	if(isdefined(other_player.is_on_gondola) && other_player.is_on_gondola && (isdefined(level.e_gondola.is_moving) && level.e_gondola.is_moving))
	{
		return 1;
	}
	return 0;
}

/*
	Name: establish_gondola_door_definition
	Namespace: namespace_efb8c7fe
	Checksum: 0xCF43FABC
	Offset: 0x13D8
	Size: 0xDA
	Parameters: 1
	Flags: Linked
*/
function establish_gondola_door_definition(mdl_door)
{
	mdl_door setmovingplatformenabled(1, 0);
	str_identifier = mdl_door.script_noteworthy;
	switch(str_identifier)
	{
		case "hash_2955bd4df4740b38":
		{
			self.door_roof_left = mdl_door;
			break;
		}
		case "hash_279077bad833af6d":
		{
			self.door_roof_right = mdl_door;
			break;
		}
		case "hash_2c2583d55b9dbf1c":
		{
			self.door_docks_left = mdl_door;
			break;
		}
		case "hash_45988443f4a6fec9":
		{
			self.door_docks_right = mdl_door;
			break;
		}
	}
}

/*
	Name: establish_gondola_gate_definition
	Namespace: namespace_efb8c7fe
	Checksum: 0xD2E4B78A
	Offset: 0x14C0
	Size: 0xDA
	Parameters: 1
	Flags: Linked
*/
function establish_gondola_gate_definition(mdl_gate)
{
	mdl_gate setmovingplatformenabled(1, 0);
	str_identifier = mdl_gate.script_noteworthy;
	switch(str_identifier)
	{
		case "hash_2955bd4df4740b38":
		{
			self.gate_roof_left = mdl_gate;
			break;
		}
		case "hash_279077bad833af6d":
		{
			self.gate_roof_right = mdl_gate;
			break;
		}
		case "hash_2c2583d55b9dbf1c":
		{
			self.gate_docks_left = mdl_gate;
			break;
		}
		case "hash_45988443f4a6fec9":
		{
			self.gate_docks_right = mdl_gate;
			break;
		}
	}
}

/*
	Name: establish_gondola_landing_door_definition
	Namespace: namespace_efb8c7fe
	Checksum: 0xEBE0F0C5
	Offset: 0x15A8
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function establish_gondola_landing_door_definition(mdl_door)
{
	str_identifier = mdl_door.script_noteworthy;
	switch(str_identifier)
	{
		case "hash_2955bd4df4740b38":
		{
			self.landing_door_roof_left = mdl_door;
			break;
		}
		case "hash_279077bad833af6d":
		{
			self.landing_door_roof_right = mdl_door;
			break;
		}
		case "hash_2c2583d55b9dbf1c":
		{
			self.landing_door_docks_left = mdl_door;
			break;
		}
		case "hash_45988443f4a6fec9":
		{
			self.landing_door_docks_right = mdl_door;
			break;
		}
	}
}

/*
	Name: establish_gondola_landing_gate_definition
	Namespace: namespace_efb8c7fe
	Checksum: 0x5B06DD61
	Offset: 0x1670
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function establish_gondola_landing_gate_definition(mdl_gate)
{
	str_identifier = mdl_gate.script_noteworthy;
	switch(str_identifier)
	{
		case "hash_2955bd4df4740b38":
		{
			self.landing_gate_roof_left = mdl_gate;
			break;
		}
		case "hash_279077bad833af6d":
		{
			self.landing_gate_roof_right = mdl_gate;
			break;
		}
		case "hash_2c2583d55b9dbf1c":
		{
			self.landing_gate_docks_left = mdl_gate;
			break;
		}
		case "hash_45988443f4a6fec9":
		{
			self.landing_gate_docks_right = mdl_gate;
			break;
		}
	}
}

/*
	Name: gondola_doors_move
	Namespace: namespace_efb8c7fe
	Checksum: 0x53216CB
	Offset: 0x1738
	Size: 0x4C8
	Parameters: 2
	Flags: Linked
*/
function gondola_doors_move(str_side, n_state)
{
	if(str_side == "roof")
	{
		mdl_door_left = self.door_roof_left;
		var_d134f0d1 = self.gate_roof_left;
		mdl_door_right = self.door_roof_right;
		var_b82242be = self.gate_roof_right;
		var_b3c73561 = self.landing_door_roof_left;
		var_8bd1eeb0 = self.landing_gate_roof_left;
		var_1c80ffe2 = self.landing_door_roof_right;
		var_b0f06f50 = self.landing_gate_roof_right;
		n_side_modifier = 1;
	}
	else if(str_side == "docks")
	{
		mdl_door_left = self.door_docks_left;
		var_d134f0d1 = self.gate_docks_left;
		mdl_door_right = self.door_docks_right;
		var_b82242be = self.gate_docks_right;
		var_b3c73561 = self.landing_door_docks_left;
		var_8bd1eeb0 = self.landing_gate_docks_left;
		var_1c80ffe2 = self.landing_door_docks_right;
		var_b0f06f50 = self.landing_gate_docks_right;
		n_side_modifier = -1;
	}
	a_doors_and_gates = [];
	a_doors_and_gates[0] = mdl_door_left;
	a_doors_and_gates[1] = var_d134f0d1;
	a_doors_and_gates[2] = mdl_door_right;
	a_doors_and_gates[3] = var_b82242be;
	foreach(mdl_model in a_doors_and_gates)
	{
		mdl_model unlink();
	}
	if(n_state == 1)
	{
		mdl_door_left playsound(#"hash_717283b43ea8d0a4");
		gondola_gate_moves(n_state, n_side_modifier, var_d134f0d1, var_b82242be, var_8bd1eeb0, var_b0f06f50);
		gondola_gate_and_door_moves(n_state, n_side_modifier, var_d134f0d1, mdl_door_left, var_b82242be, mdl_door_right, var_8bd1eeb0, var_b3c73561, var_b0f06f50, var_1c80ffe2);
		if(n_side_modifier == 1)
		{
			var_cd3296d7 = getnode("nd_on_top_r", "targetname");
			if(isdefined(var_cd3296d7))
			{
				linktraversal(var_cd3296d7);
			}
		}
		else
		{
			var_fd05c6f4 = getnode("nd_on_bottom_r", "targetname");
			if(isdefined(var_fd05c6f4))
			{
				linktraversal(var_fd05c6f4);
			}
		}
	}
	else if(n_side_modifier == 1)
	{
		var_cd3296d7 = getnode("nd_on_top_r", "targetname");
		if(isdefined(var_cd3296d7))
		{
			unlinktraversal(var_cd3296d7);
		}
	}
	else
	{
		var_fd05c6f4 = getnode("nd_on_bottom_r", "targetname");
		if(isdefined(var_fd05c6f4))
		{
			unlinktraversal(var_fd05c6f4);
		}
	}
	mdl_door_left playsound(#"hash_ac1fa6f62462ed8");
	gondola_gate_and_door_moves(n_state, n_side_modifier, var_d134f0d1, mdl_door_left, var_b82242be, mdl_door_right, var_8bd1eeb0, var_b3c73561, var_b0f06f50, var_1c80ffe2);
	gondola_gate_moves(n_state, n_side_modifier, var_d134f0d1, var_b82242be, var_8bd1eeb0, var_b0f06f50);
	foreach(mdl_model in a_doors_and_gates)
	{
		mdl_model linkto(self);
	}
}

/*
	Name: gondola_gate_moves
	Namespace: namespace_efb8c7fe
	Checksum: 0xCC30D53C
	Offset: 0x1C08
	Size: 0x1BC
	Parameters: 6
	Flags: Linked
*/
function gondola_gate_moves(n_state, n_side_modifier, var_d134f0d1, var_b82242be, var_8bd1eeb0, var_b0f06f50)
{
	var_d134f0d1 moveto(var_d134f0d1.origin + (22.5 * n_side_modifier * n_state, 0, 0), 0.5, 0.05, 0.05);
	var_b82242be moveto(var_b82242be.origin + (22.5 * n_side_modifier * n_state * -1, 0, 0), 0.5, 0.05, 0.05);
	var_8bd1eeb0 moveto(var_8bd1eeb0.origin + (22.5 * n_side_modifier * n_state, 0, 0), 0.5, 0.05, 0.05);
	var_b0f06f50 moveto(var_b0f06f50.origin + (22.5 * n_side_modifier * n_state * -1, 0, 0), 0.5, 0.05, 0.05);
	var_b82242be waittill(#"movedone");
}

/*
	Name: gondola_gate_and_door_moves
	Namespace: namespace_efb8c7fe
	Checksum: 0x92073941
	Offset: 0x1DD0
	Size: 0x30C
	Parameters: 10
	Flags: Linked
*/
function gondola_gate_and_door_moves(n_state, n_side_modifier, var_d134f0d1, mdl_door_left, var_b82242be, mdl_door_right, var_8bd1eeb0, var_b3c73561, var_b0f06f50, var_1c80ffe2)
{
	mdl_door_left moveto(mdl_door_left.origin + (24 * n_side_modifier * n_state, 0, 0), 0.5, 0.05, 0.05);
	var_d134f0d1 moveto(var_d134f0d1.origin + (24 * n_side_modifier * n_state, 0, 0), 0.5, 0.05, 0.05);
	mdl_door_right moveto(mdl_door_right.origin + (24 * n_side_modifier * n_state * -1, 0, 0), 0.5, 0.05, 0.05);
	var_b82242be moveto(var_b82242be.origin + (24 * n_side_modifier * n_state * -1, 0, 0), 0.5, 0.05, 0.05);
	var_b3c73561 moveto(var_b3c73561.origin + (24 * n_side_modifier * n_state, 0, 0), 0.5, 0.05, 0.05);
	var_8bd1eeb0 moveto(var_8bd1eeb0.origin + (24 * n_side_modifier * n_state, 0, 0), 0.5, 0.05, 0.05);
	var_1c80ffe2 moveto(var_1c80ffe2.origin + (24 * n_side_modifier * n_state * -1, 0, 0), 0.5, 0.05, 0.05);
	var_b0f06f50 moveto(var_b0f06f50.origin + (24 * n_side_modifier * n_state * -1, 0, 0), 0.5, 0.05, 0.05);
	var_b82242be waittill(#"movedone");
}

/*
	Name: zipline_move_trigger_think
	Namespace: namespace_efb8c7fe
	Checksum: 0xF7D50C3D
	Offset: 0x20E8
	Size: 0x3CE
	Parameters: 0
	Flags: Linked
*/
function zipline_move_trigger_think()
{
	level endon("interrupt_gondola_move_trigger_" + self.script_string);
	self.cost = 750;
	self.in_use = 0;
	self.is_available = 1;
	self setcursorhint("HINT_NOICON");
	while(true)
	{
		level flag::wait_till("gondola_at_" + self.script_string);
		self setvisibletoall();
		s_result = undefined;
		s_result = self waittill(#"trigger");
		e_who = s_result.activator;
		b_forced = s_result.b_forced;
		level.var_105462b6 = e_who;
		level thread gondola_moving_vo();
		if(!(isdefined(b_forced) && b_forced) && e_who zm_utility::in_revive_trigger())
		{
			continue;
		}
		if(!isdefined(self.is_available))
		{
			continue;
		}
		if(namespace_6f53a9bb::is_active())
		{
			continue;
		}
		if(isdefined(b_forced) && b_forced || (zm_utility::is_player_valid(e_who) && e_who zm_score::can_player_purchase(self.cost)))
		{
			if(!self.in_use)
			{
				self.in_use = 1;
				self.is_available = undefined;
				self setinvisibletoall();
				if(isdefined(e_who))
				{
					zm_utility::play_sound_at_pos("purchase", e_who.origin);
					e_who zm_score::minus_to_player_score(self.cost);
				}
				if(self.script_string == "roof")
				{
					level notify(#"interrupt_gondola_call_trigger_docks");
					str_loc = "docks";
				}
				else if(self.script_string == "docks")
				{
					level notify(#"interrupt_gondola_call_trigger_roof");
					str_loc = "roof";
				}
				a_t_trig = getentarray("gondola_call_trigger", "targetname");
				foreach(trigger in a_t_trig)
				{
					if(trigger.script_string == str_loc)
					{
						t_opposite_call_trigger = trigger;
						break;
					}
				}
				move_gondola();
				t_opposite_call_trigger thread zipline_call_trigger_think();
				t_opposite_call_trigger playsound(#"zmb_trap_available");
				self.in_use = 0;
				self.is_available = 1;
			}
		}
	}
}

/*
	Name: zipline_call_trigger_think
	Namespace: namespace_efb8c7fe
	Checksum: 0xF04E1415
	Offset: 0x24C0
	Size: 0x43E
	Parameters: 0
	Flags: Linked
*/
function zipline_call_trigger_think()
{
	level endon("interrupt_gondola_call_trigger_" + self.script_string);
	self.cost = 0;
	self.in_use = 0;
	self.is_available = 1;
	self setcursorhint("HINT_NOICON");
	e_gondola = level.e_gondola;
	if(self.script_string == "roof")
	{
		str_gondola_loc = "docks";
	}
	else if(self.script_string == "docks")
	{
		str_gondola_loc = "roof";
	}
	while(true)
	{
		self sethintstring("");
		level flag::wait_till("gondola_at_" + str_gondola_loc);
		self notify(#"available");
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_23dad9a3f61cf052");
		}
		else
		{
			self sethintstring(#"hash_bbb24669638bc76");
		}
		s_result = undefined;
		s_result = self waittill(#"trigger");
		e_who = s_result.activator;
		b_forced = s_result.b_forced;
		level.var_105462b6 = e_who;
		if(!(isdefined(b_forced) && b_forced) && e_who zm_utility::in_revive_trigger())
		{
			continue;
		}
		if(!isdefined(self.is_available))
		{
			continue;
		}
		if(namespace_6f53a9bb::is_active())
		{
			continue;
		}
		if(isdefined(b_forced) && b_forced || zm_utility::is_player_valid(e_who))
		{
			if(!self.in_use)
			{
				self.in_use = 1;
				if(self.script_string == "roof")
				{
					level notify(#"interrupt_gondola_move_trigger_docks");
					str_loc = "docks";
				}
				else if(self.script_string == "docks")
				{
					level notify(#"interrupt_gondola_move_trigger_roof");
					str_loc = "roof";
				}
				a_t_trig = getentarray("gondola_move_trigger", "targetname");
				foreach(trigger in a_t_trig)
				{
					if(trigger.script_string == str_loc)
					{
						t_opposite_move_trigger = trigger;
						t_opposite_move_trigger setinvisibletoall();
						break;
					}
				}
				self playsound(#"zmb_trap_activate");
				move_gondola();
				t_opposite_move_trigger thread zipline_move_trigger_think();
				self.in_use = 0;
				self playsound(#"zmb_trap_available");
				self.is_available = 1;
			}
		}
	}
}

/*
	Name: move_gondola
	Namespace: namespace_efb8c7fe
	Checksum: 0xAC094CF6
	Offset: 0x2908
	Size: 0xC8C
	Parameters: 1
	Flags: Linked
*/
function move_gondola(b_suppress_doors_close = 0)
{
	gondola_lights_red();
	a_t_call = getentarray("gondola_call_trigger", "targetname");
	foreach(trigger in a_t_call)
	{
		trigger sethintstring(#"hash_1923fe59e50dfb0e");
	}
	e_gondola = level.e_gondola;
	t_ride = level.e_gondola.t_ride;
	e_gondola.is_moving = 1;
	if(e_gondola.location == "roof")
	{
		var_d2f6931b = getvehiclenode("roof_gondola_start", "targetname");
		e_gondola.destination = "docks";
		level thread function_c64e4079();
	}
	else if(e_gondola.location == "docks")
	{
		var_d2f6931b = getvehiclenode("docks_gondola_start", "targetname");
		e_gondola.destination = "roof";
		level thread function_565994f0();
	}
	if(level flag::get("gondola_initialized"))
	{
		level flag::set("gondola_roof_to_dock");
		level flag::set("gondola_dock_to_roof");
		level flag::set("gondola_ride_zone_enabled");
		zm_zonemgr::enable_zone("zone_cellblock_west");
		zm_zonemgr::enable_zone("zone_broadway_floor_2");
		zm_zonemgr::enable_zone("zone_cellblock_west_barber");
		zm_zonemgr::enable_zone("zone_cellblock_west_warden");
		zm_zonemgr::enable_zone("zone_cellblock_east");
	}
	level flag::clear("gondola_at_" + e_gondola.location);
	a_players = getplayers();
	foreach(player in a_players)
	{
		if(player function_9a8ab327())
		{
			namespace_e0710ee6::function_991333ce(player);
		}
	}
	if(!(isdefined(b_suppress_doors_close) && b_suppress_doors_close))
	{
		level flag::set("gondola_doors_moving");
		e_gondola gondola_doors_move(e_gondola.location, -1);
	}
	level notify(#"gondola_moving");
	check_when_gondola_moves_if_groundent_is_undefined(e_gondola);
	level flag::clear("gondola_doors_moving");
	a_players = getplayers();
	foreach(player in a_players)
	{
		if(player function_9a8ab327())
		{
			player clientfield::set_to_player("" + #"rumble_gondola", 1);
			player.is_on_gondola = 1;
		}
	}
	var_42c622b6 = getaiarchetypearray(#"brutus");
	foreach(var_de86a1af in var_42c622b6)
	{
		if(var_de86a1af function_9a8ab327())
		{
			var_de86a1af.var_db8b3627 = 1;
			var_de86a1af.var_eebea220 = 1;
			var_ea2a6729 = 1;
		}
	}
	if(isdefined(level.ai[#"axis"]))
	{
		foreach(e_enemy in level.ai[#"axis"])
		{
			if(e_enemy function_9a8ab327())
			{
				e_enemy.no_powerups = 1;
			}
		}
	}
	e_gondola thread create_gondola_poi();
	playsoundatposition(#"hash_7039f3801f51d75e", (878, 5659, 327));
	level util::clientnotify("gondola_cable_wheels");
	e_gondola playsound(#"zmb_gondola_start");
	e_gondola playloopsound(#"hash_7a155b03c4946b88", 1);
	e_gondola thread gondola_physics_explosion(10);
	level flag::set("gondola_in_motion");
	e_gondola thread function_de1be51e();
	exploder::exploder("fxexp_gondola_moving");
	e_gondola vehicle::get_on_and_go_path(var_d2f6931b);
	e_gondola waittill(#"reached_end_node");
	level flag::clear("gondola_in_motion");
	exploder::stop_exploder("fxexp_gondola_moving");
	var_42c622b6 = getaiarchetypearray(#"brutus");
	foreach(var_de86a1af in var_42c622b6)
	{
		if(var_de86a1af function_9a8ab327())
		{
			var_de86a1af.var_db8b3627 = 0;
			var_de86a1af.var_eebea220 = undefined;
			var_c78c773f = 1;
		}
	}
	if(isdefined(var_ea2a6729) && var_ea2a6729 && (isdefined(var_c78c773f) && var_c78c773f))
	{
		foreach(e_player in level.players)
		{
			if(isalive(e_player) && e_player function_9a8ab327())
			{
				e_player notify(#"hash_7af72088379d7ac6");
			}
		}
	}
	e_gondola stoploopsound(0.5);
	level util::clientnotify("gondola_cable_wheels");
	e_gondola thread function_d8e07db3();
	e_gondola playsound(#"zmb_gondola_stop");
	playsoundatposition(#"hash_46431e99e4f9f9e6", (878, 5659, 327));
	player_escaped_gondola_failsafe();
	a_players = getplayers();
	foreach(player in a_players)
	{
		if(isdefined(player.is_on_gondola) && player.is_on_gondola)
		{
			player clientfield::set_to_player("" + #"rumble_gondola", 0);
			player.is_on_gondola = undefined;
		}
	}
	level flag::set("gondola_doors_moving");
	e_gondola gondola_doors_move(e_gondola.destination, 1);
	e_gondola.is_moving = 0;
	e_gondola thread tear_down_gondola_poi();
	level flag::clear("gondola_doors_moving");
	wait(1);
	if(e_gondola.location == "roof")
	{
		e_gondola.location = "docks";
		str_zone = "zone_dock_gondola";
	}
	else if(e_gondola.location == "docks")
	{
		e_gondola.location = "roof";
		str_zone = "zone_cellblock_west_gondola_dock";
	}
	level notify(#"gondola_arrived", str_zone);
	gondola_cooldown();
	level flag::set("gondola_at_" + e_gondola.location);
}

/*
	Name: gondola_lights_red
	Namespace: namespace_efb8c7fe
	Checksum: 0xA5489B2E
	Offset: 0x35A0
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function gondola_lights_red()
{
	var_1d558ef4 = getentarray("gondola_state_light", "targetname");
	foreach(model in var_1d558ef4)
	{
		model setmodel(#"hash_58bd6f9c59c726c5");
		playsoundatposition(#"hash_6e8a64e3abaab719", model.origin);
		waitframe(1);
	}
	exploder::stop_exploder("fxexp_gondola_lights_green");
	exploder::exploder("fxexp_gondola_lights_red");
}

/*
	Name: gondola_lights_green
	Namespace: namespace_efb8c7fe
	Checksum: 0x75BD3D98
	Offset: 0x36B8
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function gondola_lights_green()
{
	var_1d558ef4 = getentarray("gondola_state_light", "targetname");
	foreach(model in var_1d558ef4)
	{
		model setmodel(#"hash_56b462c83d957bf9");
		waitframe(1);
	}
	exploder::exploder("fxexp_gondola_lights_green");
	exploder::stop_exploder("fxexp_gondola_lights_red");
}

/*
	Name: function_c64e4079
	Namespace: namespace_efb8c7fe
	Checksum: 0x7834461C
	Offset: 0x37A8
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function function_c64e4079()
{
	wait(5);
	level.var_fed9dc06 = 1;
}

/*
	Name: function_565994f0
	Namespace: namespace_efb8c7fe
	Checksum: 0x6A9C7493
	Offset: 0x37D0
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function function_565994f0()
{
	wait(5);
	level.var_fed9dc06 = 0;
}

/*
	Name: check_when_gondola_moves_if_groundent_is_undefined
	Namespace: namespace_efb8c7fe
	Checksum: 0xE11E50B8
	Offset: 0x37F8
	Size: 0x11E
	Parameters: 1
	Flags: Linked
*/
function check_when_gondola_moves_if_groundent_is_undefined(e_gondola)
{
	wait(1);
	a_zombies = getaiteamarray(level.zombie_team);
	a_zombies = util::get_array_of_closest(e_gondola.origin, a_zombies);
	for(i = 0; i < a_zombies.size; i++)
	{
		if(distancesquared(e_gondola.origin, a_zombies[i].origin) < 90000)
		{
			ground_ent = a_zombies[i] getgroundent();
			if(!isdefined(ground_ent))
			{
				a_zombies[i] dodamage(a_zombies[i].health + 1000, a_zombies[i].origin);
			}
		}
	}
}

/*
	Name: create_gondola_poi
	Namespace: namespace_efb8c7fe
	Checksum: 0xD82FD1A
	Offset: 0x3920
	Size: 0x218
	Parameters: 0
	Flags: Linked
*/
function create_gondola_poi()
{
	a_players = getplayers();
	foreach(player in a_players)
	{
		if(!(isdefined(player.is_on_gondola) && player.is_on_gondola))
		{
			return;
		}
	}
	s_poi = struct::get("gondola_poi_" + self.destination, "targetname");
	e_poi = spawn("script_origin", s_poi.origin);
	e_poi zm_utility::create_zombie_point_of_interest(1000, 30, 5000, 1);
	e_poi zm_utility::create_zombie_point_of_interest_attractor_positions(undefined, undefined, 128);
	self.poi = e_poi;
	a_ai_zombies = getaiteamarray(level.zombie_team);
	foreach(ai_zombie in a_ai_zombies)
	{
		if(ai_zombie istouching(level.e_gondola.t_ride))
		{
			ai_zombie zm_utility::add_poi_to_ignore_list(e_poi);
		}
	}
}

/*
	Name: tear_down_gondola_poi
	Namespace: namespace_efb8c7fe
	Checksum: 0xAB8F0CD9
	Offset: 0x3B40
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function tear_down_gondola_poi()
{
	if(isdefined(self.poi))
	{
		zm_utility::remove_poi_attractor(self.poi);
		self.poi delete();
	}
}

/*
	Name: gondola_moving_vo
	Namespace: namespace_efb8c7fe
	Checksum: 0xD931CE8F
	Offset: 0x3B90
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function gondola_moving_vo()
{
	if(isdefined(level.custom_gondola_moving_vo_func))
	{
		self thread [[level.custom_gondola_moving_vo_func]]();
		return;
	}
	a_zombies = getaiteamarray(level.zombie_team);
	if(!level function_dc269d0d(a_zombies, level.e_gondola))
	{
		if(isdefined(level.var_105462b6))
		{
			if(level.var_b9656485 < 3)
			{
				level.var_105462b6 zm_audio::create_and_play_dialog(#"gondola", #"active", undefined);
				level.var_b9656485++;
			}
			level thread function_6a4544e();
		}
	}
}

/*
	Name: array_players_on_gondola
	Namespace: namespace_efb8c7fe
	Checksum: 0x157A4633
	Offset: 0x3C98
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function array_players_on_gondola()
{
	a_players_on_gondola = [];
	a_players = getplayers();
	foreach(player in a_players)
	{
		if(player function_9a8ab327())
		{
			a_players_on_gondola[a_players_on_gondola.size] = player;
		}
	}
	return a_players_on_gondola;
}

/*
	Name: function_dc269d0d
	Namespace: namespace_efb8c7fe
	Checksum: 0x8268C8B3
	Offset: 0x3D58
	Size: 0x56
	Parameters: 2
	Flags: Linked
*/
function function_dc269d0d(a_zombies, e_gondola)
{
	a_zombies = util::get_array_of_closest(e_gondola.origin, a_zombies, undefined, 1, 256);
	if(a_zombies.size > 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_6a4544e
	Namespace: namespace_efb8c7fe
	Checksum: 0xF166C488
	Offset: 0x3DB8
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_6a4544e()
{
	wait(7);
	var_1b66809c = array_players_on_gondola();
	if(var_1b66809c.size == 1)
	{
		var_1b66809c[0] zm_audio::create_and_play_dialog(#"gondola", #"hash_32d4a9333251b89f", undefined, 1);
	}
	else if(var_1b66809c.size > 1)
	{
		level zm_vo::play_banter("gondola_banter", undefined, var_1b66809c);
	}
}

/*
	Name: gondola_physics_explosion
	Namespace: namespace_efb8c7fe
	Checksum: 0xBEF5A839
	Offset: 0x3E68
	Size: 0x7A
	Parameters: 1
	Flags: Linked
*/
function gondola_physics_explosion(n_move_time)
{
	self endon(#"movedone");
	for(i = 0; i < 2; i++)
	{
		physicsexplosionsphere(self.origin, 1000, 0.1, 0.1);
		wait(n_move_time / 2);
	}
}

/*
	Name: function_d8e07db3
	Namespace: namespace_efb8c7fe
	Checksum: 0xADFB697B
	Offset: 0x3EF0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_d8e07db3()
{
	self playloopsound(#"zmb_gondola_cooldown_lp", 1);
	wait(10);
	wait(2);
	self stoploopsound(0.5);
	self playsound(#"hash_5ecb872a9078d4bf");
}

/*
	Name: player_escaped_gondola_failsafe
	Namespace: namespace_efb8c7fe
	Checksum: 0x7C883754
	Offset: 0x3F70
	Size: 0x4EE
	Parameters: 0
	Flags: Linked
*/
function player_escaped_gondola_failsafe()
{
	var_ed7230a5 = [];
	foreach(player in util::get_active_players())
	{
		if(isalive(player) && (isdefined(player.is_on_gondola) && player.is_on_gondola) && !player function_9a8ab327())
		{
			a_s_orgs = struct::get_array("gondola_dropped_parts_" + level.e_gondola.destination, "targetname");
			a_s_orgs = arraysortclosest(a_s_orgs, player.origin);
			foreach(s_pos in a_s_orgs)
			{
				if(!isinarray(var_ed7230a5, s_pos) && zm_utility::check_point_in_enabled_zone(s_pos.origin) && zm_utility::check_point_in_playable_area(s_pos.origin))
				{
					player thread function_da48c149(s_pos);
					player.is_on_gondola = undefined;
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
		}
		if(!(isdefined(player zm_utility::in_playable_area()) && player zm_utility::in_playable_area()))
		{
			a_s_pos = struct::get_array("player_respawn_point", "targetname");
			a_s_pos = arraysortclosest(a_s_pos, player.origin);
			foreach(s_pos in a_s_pos)
			{
				a_s_points = struct::get_array(s_pos.target);
				a_s_points = arraysortclosest(a_s_points, player.origin);
				foreach(s_pos in a_s_points)
				{
					if(!isinarray(var_ed7230a5, s_pos) && zm_utility::check_point_in_enabled_zone(s_pos.origin) && zm_utility::check_point_in_playable_area(s_pos.origin))
					{
						player thread function_da48c149(s_pos);
						player.b_teleported = 1;
						player.is_on_gondola = undefined;
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
				if(isdefined(player.b_teleported) && player.b_teleported)
				{
					player.b_teleported = undefined;
					break;
				}
			}
		}
	}
}

/*
	Name: function_da48c149
	Namespace: namespace_efb8c7fe
	Checksum: 0xF55157AE
	Offset: 0x4468
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
	Name: gondola_cooldown
	Namespace: namespace_efb8c7fe
	Checksum: 0x4618227F
	Offset: 0x4540
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function gondola_cooldown()
{
	a_t_call = getentarray("gondola_call_trigger", "targetname");
	foreach(trigger in a_t_call)
	{
		trigger sethintstring(#"hash_72dc5724ddfb88b5");
	}
	wait(10);
	gondola_lights_green();
}

/*
	Name: function_de1be51e
	Namespace: namespace_efb8c7fe
	Checksum: 0x2AEEB0E7
	Offset: 0x4618
	Size: 0x74
	Parameters: 0
	Flags: Linked, Private
*/
private function function_de1be51e()
{
	var_55a82bb2 = struct::get("gondola_wires");
	var_55a82bb2 thread scene::play("Shot 2");
	self waittill(#"reached_end_node");
	var_55a82bb2 thread scene::play("Shot 1");
}

