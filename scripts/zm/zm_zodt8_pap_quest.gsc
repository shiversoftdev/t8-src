// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1254ac024174d9c0;
#using script_3f9e0dc8454d98e1;
#using script_50c040e371c1c35f;
#using script_52c6c2d1a2ef1b46;
#using script_6e3c826b1814cab6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_e80d0291;

/*
	Name: init
	Namespace: namespace_e80d0291
	Checksum: 0xA7924ACA
	Offset: 0x2F0
	Size: 0x3E8
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("zbarrier", "pap_chunk_small_rune", 1, getminbitcountfornum(16), "int");
	clientfield::register("zbarrier", "pap_chunk_big_rune", 1, getminbitcountfornum(5), "int");
	clientfield::register("zbarrier", "pap_machine_rune", 1, getminbitcountfornum(5), "int");
	level flag::init("pap_quest_complete");
	if(namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2") == 0)
	{
		var_7156d2c4 = [];
		var_ce12b8d3 = array("stairs_pap_location", "poop_deck_pap_location", "engine_room_pap_location", "cargo_pap_location");
		foreach(var_d38ae9b1 in var_ce12b8d3)
		{
			var_7156d2c4 = arraycombine(var_7156d2c4, getentarray(var_d38ae9b1, "prefabname"), 0, 0);
		}
		foreach(e_chunk in var_7156d2c4)
		{
			e_chunk hide();
		}
		return;
	}
	level.var_7759c77d = struct::spawn();
	level.var_7759c77d.var_e770eb55 = struct::get_array("pap_quest_interact");
	level.var_7759c77d.var_ac28fc4d = level.var_7759c77d.var_e770eb55.size;
	level.var_7759c77d.var_be6e6f65 = 0;
	foreach(s_loc in level.var_7759c77d.var_e770eb55)
	{
		level thread function_4d55584c(s_loc);
	}
	level.pack_a_punch.custom_power_think = &function_9b917fd5;
	if(!zm_utility::is_standard())
	{
		level thread function_61748fa3();
	}
	if(namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2") == 2)
	{
		level thread function_62933c32();
	}
	/#
	#/
}

/*
	Name: function_62933c32
	Namespace: namespace_e80d0291
	Checksum: 0xD30DC261
	Offset: 0x6E0
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function function_62933c32()
{
	level waittill(#"initial_fade_in_complete");
	array::thread_all(level.var_7759c77d.var_e770eb55, &function_d6076798, 1);
	if(!zm_utility::is_standard())
	{
		level.var_7759c77d.var_4ee2e2ab = randomintrange(0, level.var_7759c77d.var_e770eb55.size);
	}
	level flag::wait_till("start_zombie_round_logic");
	foreach(s_loc in level.var_7759c77d.var_e770eb55)
	{
		s_loc.unitrigger_stub thread function_5c299a0f();
	}
	waitframe(1);
	function_1563bfc3();
}

/*
	Name: function_4d55584c
	Namespace: namespace_e80d0291
	Checksum: 0x86EE4335
	Offset: 0x840
	Size: 0x2C4
	Parameters: 1
	Flags: Linked
*/
function function_4d55584c(s_loc)
{
	s_loc.unitrigger_stub = spawnstruct();
	s_loc.unitrigger_stub.origin = s_loc.origin;
	s_loc.unitrigger_stub.angles = s_loc.angles;
	s_loc.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
	s_loc.unitrigger_stub.cursor_hint = "HINT_NOICON";
	s_loc.unitrigger_stub.script_width = 96;
	s_loc.unitrigger_stub.script_height = 96;
	s_loc.unitrigger_stub.script_length = 96;
	s_loc.unitrigger_stub.require_look_at = 0;
	s_loc.unitrigger_stub.target = s_loc.target;
	s_loc.unitrigger_stub.var_c3b4a85 = 0;
	s_loc.unitrigger_stub.prompt_and_visibility_func = &function_668e3f89;
	var_aa8a2a51 = getentarray(s_loc.prefabname, "prefabname");
	foreach(var_402a204c in var_aa8a2a51)
	{
		if(var_402a204c iszbarrier())
		{
			s_loc.unitrigger_stub.pap_machine = var_402a204c;
			continue;
		}
		s_loc.unitrigger_stub.var_d3a15d55 = var_402a204c;
	}
	s_loc.unitrigger_stub.var_d3a15d55 notsolid();
	hidemiscmodels(s_loc.prefabname);
	while(!level flag::exists("power_on"))
	{
		waitframe(1);
	}
	level flag::wait_till("power_on");
	s_loc thread function_d6076798();
}

/*
	Name: function_d6076798
	Namespace: namespace_e80d0291
	Checksum: 0x4FAA39C5
	Offset: 0xB10
	Size: 0x204
	Parameters: 1
	Flags: Linked
*/
function function_d6076798(var_c41947a6 = 0)
{
	if(isdefined(self.var_9ebef12e) && self.var_9ebef12e)
	{
		return;
	}
	self.unitrigger_stub.pap_machine clientfield::set("pap_chunk_small_rune", 1);
	if(var_c41947a6)
	{
		level flag::wait_till("start_zombie_round_logic");
	}
	else if(!zm_utility::is_standard())
	{
		level waittill(self.prefabname);
	}
	self.var_9ebef12e = 1;
	self.unitrigger_stub.var_d3a15d55 solid();
	showmiscmodels(self.prefabname);
	self.unitrigger_stub.pap_machine zm_pack_a_punch::set_state_initial();
	if(self.prefabname === "poop_deck_pap_location")
	{
		var_96bd0a5d = getent("poop_deck_PAP_box", "targetname");
		if(isdefined(var_96bd0a5d))
		{
			var_96bd0a5d delete();
		}
	}
	if(!var_c41947a6)
	{
		self.unitrigger_stub.pap_machine function_7362b6bb();
	}
	zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &function_3efad767);
	zm_unitrigger::function_c4a5fdf5(self.unitrigger_stub, 1);
	self thread function_11c3f280();
}

/*
	Name: function_11c3f280
	Namespace: namespace_e80d0291
	Checksum: 0xECEE2901
	Offset: 0xD20
	Size: 0xC8
	Parameters: 0
	Flags: Linked
*/
function function_11c3f280()
{
	while(true)
	{
		level waittill(#"hash_32604d232170b82a");
		if(level.var_7759c77d.var_e770eb55[level.var_7759c77d.var_4ee2e2ab] == self)
		{
			zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
		}
		else if(!(isdefined(self.unitrigger_stub.registered) && self.unitrigger_stub.registered))
		{
			zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &function_3efad767);
		}
	}
}

/*
	Name: function_3efad767
	Namespace: namespace_e80d0291
	Checksum: 0x9BE71180
	Offset: 0xDF0
	Size: 0xD0
	Parameters: 0
	Flags: Linked
*/
function function_3efad767()
{
	while(!(isdefined(self.stub.var_c3b4a85) && self.stub.var_c3b4a85))
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(player zm_utility::in_revive_trigger())
		{
			continue;
		}
		if(player zm_utility::is_drinking())
		{
			continue;
		}
		if(!zm_utility::is_player_valid(player))
		{
			continue;
		}
		self.stub thread function_5c299a0f(player);
	}
}

/*
	Name: function_5c299a0f
	Namespace: namespace_e80d0291
	Checksum: 0xB8BA61CA
	Offset: 0xEC8
	Size: 0x234
	Parameters: 1
	Flags: Linked
*/
function function_5c299a0f(player)
{
	level.var_7759c77d.var_be6e6f65++;
	self.var_c3b4a85 = 1;
	self.pap_machine.var_4a7b80c6 = 1;
	if(isdefined(player))
	{
		player playrumbleonentity("zm_castle_interact_rumble");
	}
	for(i = 0; i < level.var_7759c77d.var_e770eb55.size; i++)
	{
		if(!zm_utility::is_standard() && level.var_7759c77d.var_e770eb55[i].unitrigger_stub == self)
		{
			level.var_7759c77d.var_4ee2e2ab = i;
		}
	}
	if(level.var_7759c77d.var_be6e6f65 < level.var_7759c77d.var_ac28fc4d)
	{
		if(isalive(player))
		{
			player util::delay(0.5, "death", &zm_audio::create_and_play_dialog, #"altar", #"activate_generic");
		}
	}
	else
	{
		self.pap_machine function_214cd6b3();
		wait(1);
		level flag::set("pap_quest_complete");
		if(isalive(player))
		{
			player util::delay(2.25, "death", &zm_audio::create_and_play_dialog, #"pap", #"activate");
		}
		return;
	}
	self.pap_machine function_214cd6b3();
}

/*
	Name: function_214cd6b3
	Namespace: namespace_e80d0291
	Checksum: 0x5A382261
	Offset: 0x1108
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_214cd6b3()
{
	self clientfield::set("pap_chunk_big_rune", 1);
	wait(1.8);
	function_a48b2870();
}

/*
	Name: function_e19c174f
	Namespace: namespace_e80d0291
	Checksum: 0x512CB498
	Offset: 0x1150
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_e19c174f()
{
	foreach(s_loc in level.var_7759c77d.var_e770eb55)
	{
		s_loc.unitrigger_stub.pap_machine clientfield::set("pap_chunk_small_rune", 1);
	}
}

/*
	Name: function_668e3f89
	Namespace: namespace_e80d0291
	Checksum: 0x32E341AF
	Offset: 0x11F8
	Size: 0x40E
	Parameters: 1
	Flags: Linked
*/
function function_668e3f89(e_player)
{
	if(!level flag::get("pap_quest_complete"))
	{
		var_235457fd = self function_afab6169(e_player);
		if(isdefined(self.hint_string))
		{
			self sethintstring(self.hint_string);
		}
		return var_235457fd;
	}
	var_d679d54f = !isdefined(level.var_7759c77d.var_69e563d);
	var_7cee75e6 = level.var_7759c77d.var_e770eb55[level.var_7759c77d.var_4ee2e2ab].unitrigger_stub === self.stub;
	var_cd46bf62 = isdefined(level.var_7759c77d.var_69e563d) && level.var_7759c77d.var_69e563d.unitrigger_stub === self.stub;
	if(!(isdefined(level.var_efaaea43) && level.var_efaaea43) && var_7cee75e6 || (isdefined(level.var_a5340531) && level.var_a5340531 && var_d679d54f) || (isdefined(level.var_a5340531) && level.var_a5340531 && var_7cee75e6) || (isdefined(level.var_a8626e72) && level.var_a8626e72 && var_cd46bf62) || (isdefined(level.var_fea7bdae) && level.var_fea7bdae) || (level flag::exists(#"hash_598d4e6af1cf4c39") && level flag::get(#"hash_598d4e6af1cf4c39")) || namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2") == 2)
	{
		return 0;
	}
	if(isdefined(level.var_efaaea43) && level.var_efaaea43)
	{
		self sethintstring(#"hash_73bbee9df5d3c2b1");
	}
	else
	{
		switch(level.var_7759c77d.var_e770eb55[level.var_7759c77d.var_4ee2e2ab].prefabname)
		{
			case "stairs_pap_location":
			{
				self sethintstring(#"hash_15783325b3eeefd5");
				break;
			}
			case "poop_deck_pap_location":
			{
				self sethintstring(#"hash_250613266b9a4223");
				break;
			}
			case "engine_room_pap_location":
			{
				self sethintstring(#"hash_4c5f8e23d8258199");
				break;
			}
			case "cargo_pap_location":
			{
				self sethintstring(#"hash_1deb745365a6cfdd");
				break;
			}
			default:
			{
				self sethintstring(#"");
				break;
			}
		}
	}
	return 1;
}

/*
	Name: function_afab6169
	Namespace: namespace_e80d0291
	Checksum: 0xC7D297C2
	Offset: 0x1610
	Size: 0x136
	Parameters: 1
	Flags: Linked
*/
function function_afab6169(e_player)
{
	b_result = 0;
	if(!(isdefined(e_player zombie_utility::is_player_valid(e_player)) && e_player zombie_utility::is_player_valid(e_player)))
	{
		self.hint_string = #"";
	}
	else if(isdefined(self.stub.var_c3b4a85) && self.stub.var_c3b4a85)
	{
		self.hint_string = #"";
	}
	else if(level flag::get("pap_quest_complete"))
	{
		self.hint_string = #"";
	}
	else if(function_8b1a219a())
	{
		self.hint_string = #"hash_36ba40b9e876f572";
	}
	else
	{
		self.hint_string = #"hash_15494c7927282ad6";
	}
	b_result = 1;
	return b_result;
}

/*
	Name: function_9b917fd5
	Namespace: namespace_e80d0291
	Checksum: 0xD619B10E
	Offset: 0x1750
	Size: 0xBE
	Parameters: 1
	Flags: Linked
*/
function function_9b917fd5(var_634ce82e)
{
	self zm_pack_a_punch::set_state_hidden();
	if(!isdefined(level.var_ea3b08d8))
	{
		level.var_ea3b08d8 = [];
	}
	else if(!isarray(level.var_ea3b08d8))
	{
		level.var_ea3b08d8 = array(level.var_ea3b08d8);
	}
	level.var_ea3b08d8[self.prefabname] = self;
	self.var_7c2f9a8b = 1;
	self.var_7e4bc0a2 = 1;
}

/*
	Name: function_61748fa3
	Namespace: namespace_e80d0291
	Checksum: 0xB44089EB
	Offset: 0x1818
	Size: 0x128
	Parameters: 0
	Flags: Linked
*/
function function_61748fa3()
{
	if(namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2") == 2)
	{
		return;
	}
	level flag::wait_till("pap_quest_complete");
	function_306b4f35(1);
	level.var_25e38adf++;
	/#
		iprintlnbold("");
	#/
	while(true)
	{
		level waittill(#"end_of_round");
		if(zm_utility::function_3bff983f() && level flag::get("round_reset"))
		{
			continue;
		}
		if(level.round_number >= level.var_25e38adf && !zm_utility::is_standard())
		{
			function_306b4f35();
		}
	}
}

/*
	Name: function_306b4f35
	Namespace: namespace_e80d0291
	Checksum: 0xC2CFA187
	Offset: 0x1948
	Size: 0x2BE
	Parameters: 1
	Flags: Linked
*/
function function_306b4f35(b_initial = 0)
{
	if(!b_initial)
	{
		level notify(#"hash_14c80c5abb28b07b");
		function_ef3c219a();
		var_3eee8fb4 = level.var_7759c77d.var_4ee2e2ab;
		level.var_7759c77d.var_69e563d = level.var_7759c77d.var_e770eb55[var_3eee8fb4];
		if(!isdefined(level.var_dd2ac1f3))
		{
			level.var_dd2ac1f3 = [];
		}
		if(!level.var_dd2ac1f3.size)
		{
			for(i = 0; i < level.var_7759c77d.var_e770eb55.size; i++)
			{
				level.var_dd2ac1f3[i] = i;
			}
			while(level.var_dd2ac1f3[0] == var_3eee8fb4)
			{
				level.var_dd2ac1f3 = array::randomize(level.var_dd2ac1f3);
			}
		}
		if(!level flag::get(#"hash_452df3df817c57f9") || !isdefined(level.var_7759c77d.var_e9b06709) || level flag::get(#"hash_598d4e6af1cf4c39"))
		{
			level.var_7759c77d.var_4ee2e2ab = level.var_dd2ac1f3[0];
			level.var_dd2ac1f3 = array::exclude(level.var_dd2ac1f3, level.var_dd2ac1f3[0]);
		}
		else
		{
			level.var_7759c77d.var_4ee2e2ab = level.var_7759c77d.var_e9b06709;
			level.var_dd2ac1f3 = array::exclude(level.var_dd2ac1f3, level.var_7759c77d.var_e9b06709);
		}
		level.var_efaaea43 = 1;
	}
	else
	{
		function_e19c174f();
	}
	function_9e015223();
	level.var_efaaea43 = 0;
	level.var_25e38adf = level.round_number + randomintrange(2, 4);
}

/*
	Name: function_ef3c219a
	Namespace: namespace_e80d0291
	Checksum: 0xDEB942D2
	Offset: 0x1C10
	Size: 0x22A
	Parameters: 0
	Flags: Linked
*/
function function_ef3c219a()
{
	if(!isdefined(level.pap_machine))
	{
		return;
	}
	if(isdefined(level.pap_machine.unitrigger_stub.var_a0fc37f6))
	{
		level.pap_machine.unitrigger_stub thread namespace_cb42c6c0::function_61a9bc58();
	}
	level.pap_machine flag::wait_till("pap_waiting_for_user");
	function_e19c174f();
	level.var_a8626e72 = 1;
	playrumbleonposition("zm_castle_pap_tp", level.pap_machine.origin);
	playsoundatposition(#"hash_5944b4f78bf382e8", level.pap_machine.origin);
	var_88aa74e = level.var_7759c77d.var_88aa74e;
	if(!isdefined(var_88aa74e))
	{
		var_88aa74e = level.var_7759c77d.var_e770eb55[level.var_7759c77d.var_4ee2e2ab];
	}
	if(isdefined(var_88aa74e))
	{
		hidemiscmodels(var_88aa74e.prefabname);
	}
	level.pap_machine clientfield::set("pap_machine_rune", 1);
	level.pap_machine thread zm_pack_a_punch::function_bb629351(0, "leaving", "leave_anim_done");
	level.pap_machine waittill(#"leave_anim_done");
	level.var_a8626e72 = 0;
	level.pap_machine zm_pack_a_punch::set_state_initial();
	if(isdefined(var_88aa74e))
	{
		showmiscmodels(var_88aa74e.prefabname);
	}
	level.var_fea7bdae = 1;
}

/*
	Name: function_9e015223
	Namespace: namespace_e80d0291
	Checksum: 0xB4654B71
	Offset: 0x1E48
	Size: 0x1D8
	Parameters: 0
	Flags: Linked
*/
function function_9e015223()
{
	level.var_7759c77d.var_88aa74e = level.var_7759c77d.var_e770eb55[level.var_7759c77d.var_4ee2e2ab];
	s_new_loc = level.var_7759c77d.var_88aa74e;
	level.pap_machine = s_new_loc.unitrigger_stub.pap_machine;
	if(!isdefined(level.pap_machine))
	{
		return;
	}
	level.var_fea7bdae = 0;
	level.var_a5340531 = 1;
	level.pap_machine clientfield::set("pap_machine_rune", 1);
	hidemiscmodels(s_new_loc.prefabname);
	level.pap_machine thread zm_pack_a_punch::function_bb629351(1, "arriving", "arrive_anim_done");
	level.pap_machine waittill(#"arrive_anim_done");
	namespace_cb42c6c0::function_d67bafb5(level.pap_machine.unitrigger_stub, "lockdown_stub_type_pap");
	level.var_a5340531 = 0;
	showmiscmodels(s_new_loc.prefabname);
	level.pap_machine function_93f98123();
	level.pap_machine thread function_f7dc54d8();
	level thread function_a48b2870();
	level notify(#"hash_32604d232170b82a");
}

/*
	Name: function_1563bfc3
	Namespace: namespace_e80d0291
	Checksum: 0x6432F596
	Offset: 0x2028
	Size: 0x118
	Parameters: 0
	Flags: Linked
*/
function function_1563bfc3()
{
	level.var_fea7bdae = 0;
	level.var_a5340531 = 0;
	foreach(s_loc in level.var_7759c77d.var_e770eb55)
	{
		var_56dd89fc = s_loc.unitrigger_stub.pap_machine;
		hidemiscmodels(s_loc.prefabname);
		var_56dd89fc thread zm_pack_a_punch::function_bb629351(1, "arriving", "arrive_anim_done");
		var_56dd89fc waittill(#"arrive_anim_done");
		showmiscmodels(s_loc.prefabname);
	}
}

/*
	Name: function_f7dc54d8
	Namespace: namespace_e80d0291
	Checksum: 0x5E2E20ED
	Offset: 0x2148
	Size: 0xF0
	Parameters: 0
	Flags: Linked
*/
function function_f7dc54d8()
{
	a_ai_enemies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, 40, 100);
	foreach(ai_zombie in a_ai_enemies)
	{
		ai_zombie dodamage(ai_zombie.health + 100, ai_zombie.origin + vectorscale((0, 1, 0), 100));
	}
}

/*
	Name: function_7362b6bb
	Namespace: namespace_e80d0291
	Checksum: 0xEC744142
	Offset: 0x2240
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_7362b6bb()
{
	switch(self.prefabname)
	{
		case "engine_room_pap_location":
		{
			var_81731c8e = 4;
			break;
		}
		case "stairs_pap_location":
		{
			var_81731c8e = 2;
			break;
		}
		case "cargo_pap_location":
		{
			var_81731c8e = 5;
			break;
		}
		case "poop_deck_pap_location":
		{
			var_81731c8e = 3;
			break;
		}
	}
	self clientfield::set("pap_chunk_big_rune", var_81731c8e);
}

/*
	Name: function_a48b2870
	Namespace: namespace_e80d0291
	Checksum: 0xD88D6066
	Offset: 0x2300
	Size: 0x4B8
	Parameters: 0
	Flags: Linked
*/
function function_a48b2870()
{
	if(!level flag::get("pap_quest_complete"))
	{
		foreach(s_loc in level.var_7759c77d.var_e770eb55)
		{
			if(isdefined(s_loc.unitrigger_stub.pap_machine.var_4a7b80c6) && s_loc.unitrigger_stub.pap_machine.var_4a7b80c6)
			{
				switch(s_loc.prefabname)
				{
					case "engine_room_pap_location":
					{
						var_e636ead7 = 1;
						break;
					}
					case "stairs_pap_location":
					{
						var_942e881a = 1;
						break;
					}
					case "cargo_pap_location":
					{
						var_6a69b27 = 1;
						break;
					}
					case "poop_deck_pap_location":
					{
						var_2380391d = 1;
						break;
					}
				}
			}
		}
		if(isdefined(var_942e881a) && var_942e881a)
		{
			var_81731c8e = 2;
			if(isdefined(var_2380391d) && var_2380391d)
			{
				var_81731c8e = 3;
				if(isdefined(var_e636ead7) && var_e636ead7)
				{
					var_81731c8e = 4;
					if(isdefined(var_6a69b27) && var_6a69b27)
					{
						var_81731c8e = 16;
					}
				}
				else if(isdefined(var_6a69b27) && var_6a69b27)
				{
					var_81731c8e = 5;
				}
			}
			else if(isdefined(var_e636ead7) && var_e636ead7)
			{
				var_81731c8e = 6;
				if(isdefined(var_6a69b27) && var_6a69b27)
				{
					var_81731c8e = 7;
				}
			}
			else if(isdefined(var_6a69b27) && var_6a69b27)
			{
				var_81731c8e = 8;
			}
		}
		else if(isdefined(var_2380391d) && var_2380391d)
		{
			var_81731c8e = 9;
			if(isdefined(var_e636ead7) && var_e636ead7)
			{
				var_81731c8e = 10;
				if(isdefined(var_6a69b27) && var_6a69b27)
				{
					var_81731c8e = 11;
				}
			}
			else if(isdefined(var_6a69b27) && var_6a69b27)
			{
				var_81731c8e = 12;
			}
		}
		else if(isdefined(var_e636ead7) && var_e636ead7)
		{
			var_81731c8e = 13;
			if(isdefined(var_6a69b27) && var_6a69b27)
			{
				var_81731c8e = 14;
			}
		}
		else if(isdefined(var_6a69b27) && var_6a69b27)
		{
			var_81731c8e = 15;
		}
		else
		{
			var_81731c8e = 1;
		}
	}
	else if(isdefined(level.pap_machine) && (!(isdefined(level.var_a5340531) && level.var_a5340531)) && (!(isdefined(level.var_a8626e72) && level.var_a8626e72)))
	{
		switch(level.pap_machine.prefabname)
		{
			case "engine_room_pap_location":
			{
				var_81731c8e = 13;
				break;
			}
			case "stairs_pap_location":
			{
				var_81731c8e = 2;
				break;
			}
			case "cargo_pap_location":
			{
				var_81731c8e = 15;
				break;
			}
			case "poop_deck_pap_location":
			{
				var_81731c8e = 9;
				break;
			}
		}
	}
	if(isdefined(var_81731c8e))
	{
		foreach(s_loc in level.var_7759c77d.var_e770eb55)
		{
			s_loc.unitrigger_stub.pap_machine clientfield::set("pap_chunk_small_rune", var_81731c8e);
		}
	}
}

/*
	Name: function_93f98123
	Namespace: namespace_e80d0291
	Checksum: 0xEBEF2E5
	Offset: 0x27C0
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_93f98123()
{
	switch(self.prefabname)
	{
		case "engine_room_pap_location":
		{
			var_81731c8e = 4;
			break;
		}
		case "stairs_pap_location":
		{
			var_81731c8e = 2;
			break;
		}
		case "cargo_pap_location":
		{
			var_81731c8e = 5;
			break;
		}
		case "poop_deck_pap_location":
		{
			var_81731c8e = 3;
			break;
		}
	}
	self clientfield::set("pap_machine_rune", var_81731c8e);
}

/*
	Name: function_765118cf
	Namespace: namespace_e80d0291
	Checksum: 0x4B92E2BF
	Offset: 0x2880
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function function_765118cf()
{
	/#
		level.var_7759c77d.var_4ee2e2ab = 0;
		if(!level flag::get(""))
		{
			level waittill(#"stairs_pap_location");
		}
		wait(0.1);
		level flag::set("");
	#/
}

/*
	Name: function_83d342c7
	Namespace: namespace_e80d0291
	Checksum: 0x68B8A1CB
	Offset: 0x2900
	Size: 0xBA
	Parameters: 0
	Flags: None
*/
function function_83d342c7()
{
	/#
		level flag::wait_till("");
		var_4c043770 = getent("", "");
		if(!isdefined(var_4c043770))
		{
			return;
		}
		var_4c043770 zm_pack_a_punch::set_state_arriving();
		while(true)
		{
			for(i = 2; i <= 5; i++)
			{
				var_4c043770 function_a2a8d76e(i);
			}
		}
	#/
}

/*
	Name: function_d7dc7c3e
	Namespace: namespace_e80d0291
	Checksum: 0x784B4224
	Offset: 0x29C8
	Size: 0x82
	Parameters: 1
	Flags: None
*/
function function_d7dc7c3e(var_c8407ea2)
{
	/#
		self clientfield::set("", var_c8407ea2);
		wait(3);
		self clientfield::set("", var_c8407ea2);
		wait(3);
		self clientfield::set("", 0);
		wait(2);
	#/
}

/*
	Name: function_a2a8d76e
	Namespace: namespace_e80d0291
	Checksum: 0x7FD07BE8
	Offset: 0x2A58
	Size: 0x5A
	Parameters: 1
	Flags: None
*/
function function_a2a8d76e(var_c8407ea2)
{
	/#
		self clientfield::set("", var_c8407ea2);
		wait(3);
		self clientfield::set("", 1);
		wait(2);
	#/
}

/*
	Name: function_4944c76f
	Namespace: namespace_e80d0291
	Checksum: 0x9CA3DACE
	Offset: 0x2AC0
	Size: 0x37E
	Parameters: 0
	Flags: None
*/
function function_4944c76f()
{
	/#
		level endon(#"hash_32604d232170b82a");
		var_710f09a8 = self.origin + vectornormalize(anglestoforward(self.angles)) * 160 + vectorscale((0, 0, 1), 100);
		var_737189c4 = self.origin + vectornormalize(anglestoforward(self.angles)) * 160 + vectorscale((0, 0, 1), 80);
		var_c1f4ccaf = self.origin + vectornormalize(anglestoforward(self.angles)) * 160 + vectorscale((0, 0, 1), 60);
		var_743fd60c = self.origin + vectornormalize(anglestoforward(self.angles)) * 160 + vectorscale((0, 0, 1), 40);
		var_56692417 = self.origin + vectornormalize(anglestoforward(self.angles)) * 160 + vectorscale((0, 0, 1), 20);
		var_1e3527a8 = self.origin + vectornormalize(anglestoforward(self.angles)) * 160 + (0, 0, 0);
		while(true)
		{
			print3d(var_710f09a8, "" + self getzbarrierpiecestate(0));
			print3d(var_737189c4, "" + self getzbarrierpiecestate(1));
			print3d(var_c1f4ccaf, "" + self getzbarrierpiecestate(2));
			print3d(var_743fd60c, "" + self getzbarrierpiecestate(3));
			print3d(var_56692417, "" + self getzbarrierpiecestate(4));
			print3d(var_1e3527a8, "" + self getzbarrierpiecestate(5));
			waitframe(1);
		}
	#/
}

