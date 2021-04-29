// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14e569dd391faf67;
#using script_59a783d756554a80;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_office_ww_quest.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_6cd64b2b;

/*
	Name: pentagon_packapunch_init
	Namespace: namespace_6cd64b2b
	Checksum: 0xA25108BB
	Offset: 0x450
	Size: 0x18E
	Parameters: 0
	Flags: Linked
*/
function pentagon_packapunch_init()
{
	level thread pack_hideaway_init();
	level thread pack_door_init();
	level.defcon_level = 1;
	level.defcon_activated = 0;
	level.ignore_spawner_func = &pentagon_ignore_spawner;
	level._effect[#"hash_4ec0caccaa9167d3"] = #"hash_6cd6da1c7e245c1c";
	level.var_5531a118 = level._effect[#"hash_4ec0caccaa9167d3"];
	level._effect[#"hash_415ba37393754417"] = #"hash_35cb5be5a38af07c";
	level.var_2e21f906 = level._effect[#"hash_415ba37393754417"];
	level thread defcon_sign_lights();
	punch_switches = getentarray("punch_switch", "targetname");
	if(isdefined(punch_switches))
	{
		for(i = 0; i < punch_switches.size; i++)
		{
			punch_switches[i] thread defcon_sign_setup();
		}
	}
}

/*
	Name: defcon_sign_setup
	Namespace: namespace_6cd64b2b
	Checksum: 0xD0BA4870
	Offset: 0x5E8
	Size: 0x8F2
	Parameters: 0
	Flags: Linked
*/
function defcon_sign_setup()
{
	self setcursorhint("HINT_NOICON");
	self usetriggerrequirelookat();
	self sethintstring(#"hash_71158766520dc432");
	level waittill(#"hash_2124984d1ece329c");
	self.lights = getentarray(self.target, "targetname");
	if(isdefined(self.lights) && util::function_5df4294() != #"zstandard")
	{
		for(j = 0; j < self.lights.size; j++)
		{
			if(isdefined(self.lights[j].script_noteworthy) && self.lights[j].script_noteworthy == "defcon_bulb")
			{
				self.lights[j] setmodel("p8_zm_off_trap_switch_light_green_on");
				self.var_dd7da790[j] = util::spawn_model("tag_origin", self.lights[j].origin);
				self.var_dd7da790[j].angles = self.lights[j].angles;
				self.var_dd7da790[j].var_fe0165db = playfxontag(level.var_5531a118, self.var_dd7da790[j], "tag_origin");
			}
		}
	}
	while(true)
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_2c6e2897c388e68");
		}
		else
		{
			self sethintstring(#"hash_734fe766ffad1d04");
		}
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		user = waitresult.activator;
		self sethintstring("");
		if(isdefined(self.lights))
		{
			for(j = 0; j < self.lights.size; j++)
			{
				if(isdefined(self.lights[j].script_noteworthy) && self.lights[j].script_noteworthy == "defcon_bulb")
				{
					self.lights[j] setmodel("p8_zm_off_trap_switch_light_red_on");
					self.var_dd7da790[j] delete();
					self.var_dd7da790[j] = util::spawn_model("tag_origin", self.lights[j].origin);
					self.var_dd7da790[j].angles = self.lights[j].angles;
					self.var_dd7da790[j].var_b8a3170a = playfxontag(level.var_2e21f906, self.var_dd7da790[j], "tag_origin");
				}
				if(isdefined(self.lights[j].script_noteworthy) && self.lights[j].script_noteworthy == "defcon_handle")
				{
					self.lights[j] rotatepitch(-180, 0.5);
					self.lights[j] playsound("zmb_defcon_switch");
				}
			}
		}
		namespace_d8d92c8b::function_fec4fc26(self);
		if(level.defcon_level != 4)
		{
			level.defcon_level++;
			if(level.zombie_vars[#"zombie_powerup_bonfire_sale_on"] == 0)
			{
				level thread namespace_8f53e87b::play_pentagon_announcer_vox(#"hash_450f3dd9fe21becd", level.defcon_level);
			}
			level thread defcon_sign_lights();
		}
		else
		{
			level.defcon_level = 5;
			if(level.zombie_vars[#"zombie_powerup_bonfire_sale_on"] == 0 || !level flag::get("bonfire_reset"))
			{
				if(level flag::get(#"hash_38f45c699c5d5d63"))
				{
					level thread namespace_8f53e87b::function_777b7961(user);
				}
				else
				{
					level thread namespace_8f53e87b::play_pentagon_announcer_vox(#"hash_450f3dd9fe21becd", level.defcon_level);
				}
			}
			level thread defcon_sign_lights();
			level flag::set("defcon_active");
			namespace_a701220b::function_c71dfad1(1);
			if(level.zombie_vars[#"zombie_powerup_bonfire_sale_on"] == 0 || !level flag::get("bonfire_reset"))
			{
				level thread play_defcon5_alarms();
			}
		}
		level waittill(#"pack_room_reset");
		if(!level flag::get("bonfire_reset"))
		{
			level thread namespace_8f53e87b::play_pentagon_announcer_vox(#"hash_55967e6191de36d2");
		}
		if(isdefined(self.lights))
		{
			for(j = 0; j < self.lights.size; j++)
			{
				if(isdefined(self.lights[j].script_noteworthy) && self.lights[j].script_noteworthy == "defcon_bulb")
				{
					self.lights[j] setmodel("p8_zm_off_trap_switch_light_green_on");
					self.var_dd7da790[j] delete();
					self.var_dd7da790[j] = util::spawn_model("tag_origin", self.lights[j].origin);
					self.var_dd7da790[j].angles = self.lights[j].angles;
					self.var_dd7da790[j].var_fe0165db = playfxontag(level.var_5531a118, self.var_dd7da790[j], "tag_origin");
				}
				if(isdefined(self.lights[j].script_noteworthy) && self.lights[j].script_noteworthy == "defcon_handle")
				{
					self.lights[j] rotatepitch(180, 0.5);
					self.lights[j] playsound("zmb_defcon_switch");
				}
			}
		}
	}
}

/*
	Name: function_cec9d001
	Namespace: namespace_6cd64b2b
	Checksum: 0x5C8316C9
	Offset: 0xEE8
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_cec9d001()
{
	var_4006a329 = getentarray("punch_switch", "targetname");
	foreach(var_9a560db0 in var_4006a329)
	{
		var_9a560db0 hide();
	}
}

/*
	Name: defcon_sign_lights
	Namespace: namespace_6cd64b2b
	Checksum: 0xB5B86F9E
	Offset: 0xF90
	Size: 0x198
	Parameters: 0
	Flags: Linked
*/
function defcon_sign_lights()
{
	defcon_signs = getentarray("defcon_sign", "targetname");
	defcon[1] = "p8_zm_off_sign_defcon_01";
	defcon[2] = "p8_zm_off_sign_defcon_02";
	defcon[3] = "p8_zm_off_sign_defcon_03";
	defcon[4] = "p8_zm_off_sign_defcon_04";
	defcon[5] = "p8_zm_off_sign_defcon_05";
	if(isdefined(defcon_signs))
	{
		foreach(sign in defcon_signs)
		{
			if(!isdefined(sign))
			{
				continue;
			}
			if(isdefined(level.defcon_level) && level.defcon_level > 0 && level.defcon_level <= defcon.size)
			{
				sign setmodel(defcon[level.defcon_level]);
				continue;
			}
			sign setmodel(defcon[1]);
		}
	}
}

/*
	Name: play_defcon5_alarms
	Namespace: namespace_6cd64b2b
	Checksum: 0xFD23661F
	Offset: 0x1130
	Size: 0x1EC
	Parameters: 0
	Flags: Linked
*/
function play_defcon5_alarms()
{
	var_566c062 = struct::get_array("defcon_alarms");
	var_674c8f1b = [];
	foreach(var_494ac784 in var_566c062)
	{
		var_9844b012 = spawn("script_origin", var_494ac784.origin);
		var_9844b012 playloopsound(var_494ac784.script_sound, 0.25);
		if(!isdefined(var_674c8f1b))
		{
			var_674c8f1b = [];
		}
		else if(!isarray(var_674c8f1b))
		{
			var_674c8f1b = array(var_674c8f1b);
		}
		var_674c8f1b[var_674c8f1b.size] = var_9844b012;
	}
	level waittill(#"defcon_reset");
	foreach(var_745f7c4 in var_674c8f1b)
	{
		var_745f7c4 stoploopsound(0.5);
	}
	wait(1);
	array::delete_all(var_674c8f1b);
}

/*
	Name: start_defcon_countdown
	Namespace: namespace_6cd64b2b
	Checksum: 0x9C88104D
	Offset: 0x1328
	Size: 0x210
	Parameters: 0
	Flags: Linked
*/
function start_defcon_countdown()
{
	if(level.defcon_activated)
	{
		return;
	}
	if(level.zones[#"war_room_zone_south"].is_enabled)
	{
		if(!level flag::get("war_room_entry"))
		{
			level flag::set("war_room_entry");
		}
		else
		{
			level.zones[#"conference_level2"].is_enabled = 1;
		}
	}
	else if(!level flag::get("war_room_special"))
	{
		level flag::set("war_room_special");
	}
	level thread special_pack_time_spawning();
	level flag::set("open_pack_hideaway");
	level.defcon_activated = 1;
	level notify(#"defcon_activated");
	while(level.defcon_level > 1)
	{
		wait(level.defcon_countdown_time / 4);
		level.defcon_level--;
		level thread defcon_sign_lights();
	}
	level.defcon_level = 1;
	level flag::clear("defcon_active");
	level.defcon_activated = 0;
	namespace_a701220b::function_c71dfad1(0);
	level flag::clear("bonfire_reset");
	level notify(#"defcon_reset");
}

/*
	Name: special_pack_time_spawning
	Namespace: namespace_6cd64b2b
	Checksum: 0x5BF0B1BC
	Offset: 0x1540
	Size: 0xFE
	Parameters: 0
	Flags: Linked
*/
function special_pack_time_spawning()
{
	foreach(point in level.var_f0ff37fe)
	{
		point.is_enabled = 0;
	}
	while(level.defcon_level >= 3)
	{
		wait(0.1);
	}
	foreach(point in level.var_f0ff37fe)
	{
		point.is_enabled = 1;
	}
}

/*
	Name: defcon_pack_poi
	Namespace: namespace_6cd64b2b
	Checksum: 0x76AB0B04
	Offset: 0x1648
	Size: 0x194
	Parameters: 0
	Flags: None
*/
function defcon_pack_poi()
{
	zone_name = "conference_level2";
	players = getplayers();
	poi1 = getent("pack_room_poi1", "targetname");
	poi2 = getent("pack_room_poi2", "targetname");
	wait(0.5);
	num_players = zm_zonemgr::get_players_in_zone(zone_name);
	if(num_players == players.size)
	{
		if(level.zones[#"war_room_zone_south"].is_enabled)
		{
			poi1 zm_utility::activate_zombie_point_of_interest();
		}
		else
		{
			poi2 zm_utility::activate_zombie_point_of_interest();
		}
	}
	else
	{
		return;
	}
	while(num_players >= players.size && level flag::get("defcon_active"))
	{
		num_players = zm_zonemgr::get_players_in_zone(zone_name);
		wait(0.1);
	}
	poi1 zm_utility::deactivate_zombie_point_of_interest();
	poi2 zm_utility::deactivate_zombie_point_of_interest();
}

/*
	Name: pentagon_ignore_spawner
	Namespace: namespace_6cd64b2b
	Checksum: 0x64FF6277
	Offset: 0x17E8
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function pentagon_ignore_spawner(spawner)
{
	if(level flag::get("no_pack_room_spawning"))
	{
		if(spawner.targetname == "conference_level2_spawns")
		{
			return 1;
		}
	}
	if(level flag::get("no_warroom_elevator_spawning"))
	{
		if(spawner.targetname == "war_room_zone_elevator_spawns")
		{
			return 1;
		}
	}
	if(level flag::get("no_labs_elevator_spawning"))
	{
		if(spawner.targetname == "labs_elevator_spawns")
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: pack_door_init
	Namespace: namespace_6cd64b2b
	Checksum: 0xD569FDAF
	Offset: 0x18C0
	Size: 0x450
	Parameters: 0
	Flags: Linked
*/
function pack_door_init()
{
	trigger = getent("pack_room_door", "targetname");
	if(util::function_5df4294() === #"zstandard")
	{
		trigger hide();
	}
	doors = getentarray(trigger.target, "targetname");
	pack_door_slam = getent("slam_pack_door", "targetname");
	var_ae0ee842 = 0;
	foreach(door in doors)
	{
		door disconnectpaths();
	}
	while(true)
	{
		trigger setcursorhint("HINT_NOICON");
		trigger sethintstring(#"hash_11b82b0d638f6098");
		level waittill(#"defcon_activated", #"player_in_pack");
		players = getplayers();
		trigger sethintstring("");
		for(i = 0; i < doors.size; i++)
		{
			doors[i].start_angles = doors[i].angles;
			if(isdefined(doors[i].script_angles))
			{
				doors[i] notsolid();
				doors[i] rotateto(doors[i].script_angles, 1);
				playsoundatposition("zmb_office_wood_door", doors[i].origin);
				doors[i] thread pack_door_solid_thread();
			}
		}
		var_ae0ee842 = 1;
		level flag::wait_till_clear("defcon_active");
		wait(0.1);
		while(!is_packroom_clear())
		{
			wait(0.1);
		}
		if(var_ae0ee842 == 1)
		{
			for(i = 0; i < doors.size; i++)
			{
				if(isdefined(doors[i].script_angles))
				{
					doors[i] notsolid();
					doors[i] rotateto(doors[i].start_angles, 0.25);
					playsoundatposition("zmb_office_wood_door_close", doors[i].origin);
					doors[i] thread pack_door_solid_thread();
				}
			}
		}
		level notify(#"pack_room_reset");
		level.zones[#"conference_level2"].is_enabled = 0;
		util::wait_network_frame();
	}
}

/*
	Name: pack_hideaway_init
	Namespace: namespace_6cd64b2b
	Checksum: 0x5E284550
	Offset: 0x1D18
	Size: 0x2B8
	Parameters: 0
	Flags: Linked
*/
function pack_hideaway_init()
{
	hideaway = getent("pack_hideaway", "targetname");
	parts = getentarray("pack_hideaway_part", "targetname");
	var_fe7e64ff = getent("vending_packapunch", "targetname");
	if(isdefined(parts))
	{
		for(i = 0; i < parts.size; i++)
		{
			parts[i] linkto(hideaway);
		}
	}
	while(true)
	{
		level flag::wait_till("open_pack_hideaway");
		hideaway notsolid();
		hideaway movez(116, 2.5);
		hideaway playsound("evt_packapunch_revolve_start");
		hideaway playloopsound("evt_packapunch_revolve_loop");
		hideaway waittill(#"movedone");
		hideaway stoploopsound(1);
		hideaway playsound("evt_packapunch_revolve_end");
		wait(40);
		hideaway movez(116 * -1, 2.5);
		hideaway playsound("evt_packapunch_revolve_start");
		hideaway playloopsound("evt_packapunch_revolve_loop");
		level flag::clear("open_pack_hideaway");
		util::wait_network_frame();
		hideaway waittill(#"movedone");
		hideaway stoploopsound(1);
		hideaway playsound("evt_packapunch_revolve_end");
	}
}

/*
	Name: is_packroom_clear
	Namespace: namespace_6cd64b2b
	Checksum: 0xE674E6AA
	Offset: 0x1FD8
	Size: 0xBE
	Parameters: 0
	Flags: Linked
*/
function is_packroom_clear()
{
	a_e_players = getplayers();
	foreach(e_player in a_e_players)
	{
		if(e_player istouching(level.pack_door_slam))
		{
			return 0;
		}
	}
	if(namespace_a701220b::function_2143dc13())
	{
		return 0;
	}
	return 1;
}

/*
	Name: pack_door_solid_thread
	Namespace: namespace_6cd64b2b
	Checksum: 0x2321F023
	Offset: 0x20A0
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function pack_door_solid_thread()
{
	self waittill(#"rotatedone");
	self.door_moving = undefined;
	while(true)
	{
		players = getplayers();
		player_touching = 0;
		for(i = 0; i < players.size; i++)
		{
			if(players[i] istouching(self))
			{
				player_touching = 1;
				break;
			}
		}
		if(!player_touching)
		{
			self solid();
			if(self.angles != self.start_angles)
			{
				self connectpaths();
			}
			else
			{
				self disconnectpaths();
			}
			return;
		}
		wait(1);
	}
}

/*
	Name: function_cacd3270
	Namespace: namespace_6cd64b2b
	Checksum: 0xC606DA28
	Offset: 0x21B8
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function function_cacd3270()
{
	return self istouching(level.pack_room_trigger);
}

/*
	Name: function_d2f6cecb
	Namespace: namespace_6cd64b2b
	Checksum: 0x7A32274B
	Offset: 0x21E8
	Size: 0x3C6
	Parameters: 0
	Flags: None
*/
function function_d2f6cecb()
{
	/#
		if(!level flag::get(""))
		{
			level flag::set("");
			wait(1);
		}
		level.defcon_level = 5;
		if(level.zombie_vars[#"zombie_powerup_bonfire_sale_on"] == 0 || !level flag::get(""))
		{
			level thread namespace_8f53e87b::play_pentagon_announcer_vox(#"hash_450f3dd9fe21becd", level.defcon_level);
		}
		level thread defcon_sign_lights();
		level flag::set("");
		namespace_a701220b::function_c71dfad1(1);
		if(level.zombie_vars[#"zombie_powerup_bonfire_sale_on"] == 0 || !level flag::get(""))
		{
			level thread play_defcon5_alarms();
		}
		level waittill(#"pack_room_reset");
		if(!level flag::get(""))
		{
			level thread namespace_8f53e87b::play_pentagon_announcer_vox(#"hash_55967e6191de36d2");
		}
		if(isdefined(self.lights))
		{
			for(j = 0; j < self.lights.size; j++)
			{
				if(isdefined(self.lights[j].script_noteworthy) && self.lights[j].script_noteworthy == "")
				{
					self.lights[j] setmodel("");
					self.var_dd7da790[j] delete();
					self.var_dd7da790[j] = util::spawn_model("", self.lights[j].origin);
					self.var_dd7da790[j].angles = self.lights[j].angles;
					self.var_dd7da790[j].var_fe0165db = playfxontag(level.var_5531a118, self.var_dd7da790[j], "");
				}
				if(isdefined(self.lights[j].script_noteworthy) && self.lights[j].script_noteworthy == "")
				{
					self.lights[j] rotatepitch(180, 0.5);
					self.lights[j] playsound("");
				}
			}
		}
	#/
}

