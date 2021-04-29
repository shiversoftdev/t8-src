// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_174ce72cc0f850;
#using script_1c72973fb240f263;
#using script_3510d12b63a575c3;
#using script_52c6c2d1a2ef1b46;
#using script_6a3f43063dfd1bdc;
#using script_724752ab26bff81b;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_white_util.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_90b0490e;

/*
	Name: preload
	Namespace: namespace_90b0490e
	Checksum: 0xEE825535
	Offset: 0x320
	Size: 0x4D4
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	level flag::init(#"hash_12c5d7e1fc876517");
	level.var_74170866 = spawnstruct();
	level.var_74170866.n_step = 0;
	callback::on_disconnect(&on_disconnect);
	var_7494f038 = struct::get_array("cabinet");
	var_7494f038 = array::randomize(var_7494f038);
	level.var_74170866.var_22355173 = array::pop_front(var_7494f038);
	level.var_74170866.var_22355173.a_e_doors = getentarray(level.var_74170866.var_22355173.target, "targetname");
	var_67b37a67 = struct::get_array("fireplace_canister");
	var_67b37a67 = array::randomize(var_67b37a67);
	level.var_74170866.var_1e20c0e5 = array::pop_front(var_67b37a67);
	a_parts = getentarray(level.var_74170866.var_1e20c0e5.target, "targetname");
	foreach(part in a_parts)
	{
		if(part.classname == "trigger_damage_new")
		{
			level.var_74170866.var_1e20c0e5.var_7126b6eb = part;
			continue;
		}
		if(part.classname == "info_volume")
		{
			level.var_74170866.var_1e20c0e5.var_72807128 = part;
		}
	}
	level.var_74170866.var_1e20c0e5.var_b9989e12 = hash(level.var_74170866.var_1e20c0e5.script_noteworthy);
	level.var_74170866.var_1e20c0e5.var_7944be4a = 0;
	level.var_74170866.var_1e20c0e5.var_7126b6eb triggerenable(0);
	foreach(var_1e20c0e5 in var_67b37a67)
	{
		a_parts = getentarray(var_1e20c0e5.target, "targetname");
		array::run_all(a_parts, &delete);
	}
	clientfield::register("scriptmover", "" + #"hash_2184dd4e9090521f", 20000, 1, "int");
	namespace_bd74bbd2::register(#"sc_mk2z_1", 20000, "sc_mk2z_1", &function_a66f0de2, &function_17f3e9e2);
	namespace_bd74bbd2::register(#"sc_mk2z_2", 20000, "sc_mk2z_2", &function_a66f0de2, &function_17f3e9e2);
	namespace_bd74bbd2::register(#"sc_mk2z_3", 20000, "sc_mk2z_3", &function_a66f0de2, &function_17f3e9e2);
}

/*
	Name: function_18a1849f
	Namespace: namespace_90b0490e
	Checksum: 0x46AEADC4
	Offset: 0x800
	Size: 0x40
	Parameters: 1
	Flags: Linked, Private
*/
private function function_18a1849f(e_player)
{
	if(!isdefined(level.var_74170866.e_player))
	{
		return 0;
	}
	return e_player === level.var_74170866.e_player;
}

/*
	Name: function_f6048ee
	Namespace: namespace_90b0490e
	Checksum: 0x2DF7C14B
	Offset: 0x848
	Size: 0xF4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f6048ee(e_player)
{
	if(isdefined(e_player))
	{
		if(!isdefined(level.var_74170866.e_player))
		{
			if(isdefined(e_player.var_9c20e2c9))
			{
				self sethintstring(#"hash_744b68f010abb05");
			}
			else
			{
				self sethintstring(#"hash_12346bdab086516e");
			}
		}
		else if(level.var_74170866.e_player == e_player)
		{
			self sethintstring(#"hash_74fc96e8d58ff646");
		}
		else
		{
			self sethintstring(#"hash_2054e8fdb6521566");
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_5b4f9f76
	Namespace: namespace_90b0490e
	Checksum: 0xBC430469
	Offset: 0x948
	Size: 0x76
	Parameters: 1
	Flags: Linked, Private
*/
private function function_5b4f9f76(e_player)
{
	var_2fff5cb5 = level.var_74170866.e_player === e_player;
	var_24441d81 = !isdefined(level.var_74170866.e_player) && !isdefined(e_player.var_9c20e2c9);
	return var_2fff5cb5 || var_24441d81;
}

/*
	Name: start_quest
	Namespace: namespace_90b0490e
	Checksum: 0x623023BE
	Offset: 0x9C8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function start_quest()
{
	function_b60df00d();
}

/*
	Name: function_b60df00d
	Namespace: namespace_90b0490e
	Checksum: 0xC610916A
	Offset: 0x9E8
	Size: 0x114
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b60df00d()
{
	level thread function_cbeb9a33();
	/#
		iprintlnbold("");
	#/
	/#
		iprintlnbold("" + level.var_74170866.var_22355173.script_string + "");
	#/
	level.var_74170866.n_step = 1;
	var_22355173 = level.var_74170866.var_22355173;
	var_5760bda2 = util::spawn_model(var_22355173.model, var_22355173.origin, var_22355173.angles);
	var_22355173.var_5760bda2 = var_5760bda2;
	level thread function_a36bdf11();
}

/*
	Name: function_a36bdf11
	Namespace: namespace_90b0490e
	Checksum: 0xF0520C83
	Offset: 0xB08
	Size: 0x364
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a36bdf11()
{
	level endon(#"end_game", #"insanity_mode_triggered");
	if(isdefined(level.var_74170866.var_22355173.a_e_doors[0]))
	{
		exploder::exploder("fxexp_mk2_Z_smoke_orange_emit_closet_" + level.var_74170866.var_22355173.script_string);
		pixbeginevent(#"hash_3aea5406d9a5bdcf");
		foreach(e_door in level.var_74170866.var_22355173.a_e_doors)
		{
			e_door setcandamage(1);
			e_door val::set("quest_mk2z", "allowDeath", 0);
			e_door thread function_4b4ede();
		}
		level.var_74170866.var_22355173 waittill(#"hash_33596dea22a78e93");
		pixendevent();
		exploder::stop_exploder("fxexp_mk2_Z_smoke_orange_emit_closet_" + level.var_74170866.var_22355173.script_string);
		exploder::exploder("fxexp_mk2_Z_fire_closet_door_" + level.var_74170866.var_22355173.script_string);
		wait(1);
		array::run_all(level.var_74170866.var_22355173.a_e_doors, &delete);
		wait(0.5);
		exploder::stop_exploder("fxexp_mk2_Z_fire_closet_door_" + level.var_74170866.var_22355173.script_string);
		var_22355173 = level.var_74170866.var_22355173;
	}
	s_unitrigger = level.var_74170866.var_22355173.var_5760bda2 namespace_2e9c09b3::function_f1827cc6(&function_9d66ea6f, &function_f6048ee, &function_5b4f9f76);
	zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
	waitframe(1);
	zm_unitrigger::reregister_unitrigger_as_dynamic(level.var_74170866.var_22355173.var_5760bda2.s_unitrigger);
}

/*
	Name: function_4b4ede
	Namespace: namespace_90b0490e
	Checksum: 0xEDB37C6B
	Offset: 0xE78
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_4b4ede()
{
	self endon(#"death", #"hash_33596dea22a78e93");
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = self waittill(#"damage");
		if(var_385703b7 namespace_509a75d1::function_69320b44("zm_aat_plasmatic_burst"))
		{
			level.var_74170866.var_22355173 notify(#"hash_33596dea22a78e93");
			foreach(e_door in level.var_74170866.var_22355173.a_e_doors)
			{
				e_door setcandamage(0);
				e_door notify(#"hash_33596dea22a78e93");
			}
			break;
		}
	}
}

/*
	Name: function_e08b0124
	Namespace: namespace_90b0490e
	Checksum: 0x65C96CA7
	Offset: 0xFC0
	Size: 0x58
	Parameters: 1
	Flags: None
*/
function function_e08b0124(e_player)
{
	self sethintstringforplayer(e_player, zm_utility::function_d6046228(#"hash_12346bdab086516e", #"hash_184ab2db21c5bc9a"));
	return 1;
}

/*
	Name: function_9d66ea6f
	Namespace: namespace_90b0490e
	Checksum: 0xE5BB9B87
	Offset: 0x1020
	Size: 0x1AC
	Parameters: 2
	Flags: Linked, Private
*/
private function function_9d66ea6f(var_2e1f34dd, e_player)
{
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold(e_player.name + "");
			println(e_player.name + "");
		}
	#/
	level.var_74170866.e_player = e_player;
	namespace_a01a2431::function_605e5c25(e_player);
	e_player.var_9c20e2c9 = 1;
	e_player playsound("evt_canister_pickup");
	namespace_6747c550::function_7df6bb60("zm_white_ww_mod_phase", 3, e_player);
	namespace_6747c550::function_7df6bb60("zm_white_ww_mk2z_ammo", 1, e_player);
	function_87e09347();
	if(zm_utility::is_classic())
	{
		level.var_74170866.e_player namespace_509a75d1::function_51b752a9("vox_ww_z_ammo_pickup", 0);
		if(!namespace_3e3742fd::function_6cebbce1())
		{
			level.var_74170866.e_player namespace_9cf755b::function_491673da(#"hash_571c990866faa511");
		}
	}
}

/*
	Name: function_87e09347
	Namespace: namespace_90b0490e
	Checksum: 0x47B32C8A
	Offset: 0x11D8
	Size: 0xE4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_87e09347()
{
	/#
		iprintlnbold("");
	#/
	if(namespace_3e3742fd::function_6cebbce1())
	{
		/#
			iprintlnbold("");
		#/
	}
	while(namespace_3e3742fd::function_6cebbce1())
	{
		wait(3);
	}
	exploder::exploder("fxexp_mk2_Z_smoke_chimney_" + level.var_74170866.var_1e20c0e5.script_string + "_house");
	level.var_74170866.n_step = 2;
	level thread function_91563ae6();
}

/*
	Name: function_91563ae6
	Namespace: namespace_90b0490e
	Checksum: 0xE6B70604
	Offset: 0x12C8
	Size: 0x23C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_91563ae6()
{
	level endon(#"end_game", #"hash_7456b125dbebe41c");
	pixbeginevent(#"hash_2573979b6db7cb52");
	/#
		iprintlnbold("" + level.var_74170866.var_1e20c0e5.script_string);
	#/
	level.var_74170866.var_1e20c0e5.var_7126b6eb triggerenable(1);
	level thread function_7130498();
	level thread function_20b366ef();
	level flag::wait_till(#"hash_12c5d7e1fc876517");
	if(!namespace_3e3742fd::function_6cebbce1() && zm_utility::is_classic())
	{
		level.var_74170866.e_player thread namespace_9cf755b::function_491673da(#"hash_5dc92cbe0fbe5da");
	}
	exploder::stop_exploder("fxexp_mk2_Z_smoke_chimney_" + level.var_74170866.var_1e20c0e5.script_string + "_house");
	level.var_74170866.var_1e20c0e5.var_7126b6eb triggerenable(0);
	wait(1);
	exploder::exploder("fxexp_mk2_Z_fire_chimney_" + level.var_74170866.var_1e20c0e5.script_string + "_house");
	pixendevent();
	function_b99d76c0();
}

/*
	Name: function_f05be4f1
	Namespace: namespace_90b0490e
	Checksum: 0x3644276E
	Offset: 0x1510
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f05be4f1()
{
	exploder::stop_exploder("fxexp_mk2_Z_smoke_chimney_" + level.var_74170866.var_1e20c0e5.script_string + "_house");
}

/*
	Name: function_7130498
	Namespace: namespace_90b0490e
	Checksum: 0x106F26DF
	Offset: 0x1560
	Size: 0xF8
	Parameters: 0
	Flags: Linked
*/
function function_7130498()
{
	level endon(#"end_game");
	while(!level flag::get(#"hash_12c5d7e1fc876517"))
	{
		waitresult = undefined;
		waitresult = level.var_74170866.var_1e20c0e5.var_7126b6eb waittill(#"damage");
		if(istouching(waitresult.position, level.var_74170866.var_1e20c0e5.var_7126b6eb))
		{
			/#
				iprintlnbold("");
			#/
			level flag::set(#"hash_12c5d7e1fc876517");
		}
	}
}

/*
	Name: function_20b366ef
	Namespace: namespace_90b0490e
	Checksum: 0x71102220
	Offset: 0x1660
	Size: 0xF0
	Parameters: 0
	Flags: Linked
*/
function function_20b366ef()
{
	level endon(#"end_game");
	while(!level flag::get(#"hash_12c5d7e1fc876517"))
	{
		var_be17187b = undefined;
		var_be17187b = level waittill(#"hash_3042a9bf2f57ea0a");
		v_origin = var_be17187b.var_814c9389;
		if(istouching(v_origin, level.var_74170866.var_1e20c0e5.var_7126b6eb))
		{
			/#
				iprintlnbold("");
			#/
			level flag::set(#"hash_12c5d7e1fc876517");
		}
	}
}

/*
	Name: function_b99d76c0
	Namespace: namespace_90b0490e
	Checksum: 0x22CDC4A6
	Offset: 0x1758
	Size: 0x72
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b99d76c0()
{
	var_3b901e6a = level.var_74170866.var_1e20c0e5;
	var_3b901e6a zm_unitrigger::create("", 96);
	var_3b901e6a thread function_473f437();
	level.var_74170866.n_step = 3;
}

/*
	Name: function_473f437
	Namespace: namespace_90b0490e
	Checksum: 0xFE049786
	Offset: 0x17D8
	Size: 0x144
	Parameters: 0
	Flags: Linked, Private
*/
private function function_473f437()
{
	self endon(#"death", #"stop_think");
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = self waittill(#"trigger_activated");
		playsoundatposition("evt_rgun_frame_putback", (-759, -626, -7));
		if(function_18a1849f(var_385703b7.e_who))
		{
			level.var_74170866.var_fead3ae9 = util::spawn_model("p8_zm_whi_fuse_pickup_fluid_magenta_pink_half", self.origin, self.angles);
			level.var_74170866.var_fead3ae9.var_b9989e12 = hash(self.script_noteworthy);
			namespace_bd74bbd2::start(level.var_74170866.var_fead3ae9.var_b9989e12);
			zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
			break;
		}
	}
}

/*
	Name: function_a66f0de2
	Namespace: namespace_90b0490e
	Checksum: 0xDA87EFB2
	Offset: 0x1928
	Size: 0x124
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a66f0de2()
{
	namespace_bd74bbd2::end(hash(level.var_74170866.var_1e20c0e5.script_noteworthy));
	s_unitrigger = level.var_74170866.var_fead3ae9 namespace_2e9c09b3::function_f1827cc6(&function_b9a31cb, &function_f6048ee, &function_5b4f9f76, 96);
	zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
	level.var_74170866.var_fead3ae9 setmodel("p8_zm_whi_fuse_pickup_fluid_magenta_pink");
	level.var_74170866.var_fead3ae9 clientfield::set("" + #"hash_2184dd4e9090521f", 1);
}

/*
	Name: function_b9a31cb
	Namespace: namespace_90b0490e
	Checksum: 0xEE5AC5FC
	Offset: 0x1A58
	Size: 0x174
	Parameters: 2
	Flags: Linked, Private
*/
private function function_b9a31cb(var_2e1f34dd, e_player)
{
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold(e_player.name + "");
			println(e_player.name + "");
		}
	#/
	exploder::stop_exploder("fxexp_mk2_Z_fire_chimney_" + level.var_74170866.var_1e20c0e5.script_string + "_house");
	namespace_6747c550::function_7df6bb60("zm_white_ww_mk2z_ammo", 2, e_player);
	e_player.var_f7694097 = 3;
	e_player playsound("evt_canister_pickup");
	function_a36c4a5e();
	if(!namespace_3e3742fd::function_6cebbce1() && zm_utility::is_classic())
	{
		e_player namespace_9cf755b::function_491673da(#"hash_3fa02403cbe89e77");
	}
}

/*
	Name: function_17f3e9e2
	Namespace: namespace_90b0490e
	Checksum: 0xA5939D15
	Offset: 0x1BD8
	Size: 0x7C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_17f3e9e2()
{
	s_unitrigger = level.var_74170866.var_fead3ae9 zm_unitrigger::create(&function_7015dc35, 96);
	zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
	level.var_74170866.var_fead3ae9 thread function_2ac1278b();
}

/*
	Name: function_7015dc35
	Namespace: namespace_90b0490e
	Checksum: 0xC9A5CA54
	Offset: 0x1C60
	Size: 0x84
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7015dc35(e_player)
{
	if(isdefined(e_player))
	{
		if(level.var_74170866.e_player === e_player)
		{
			self sethintstring(#"hash_14eae7c162ebb8d2");
		}
		else
		{
			self sethintstring(#"hash_2054e8fdb6521566");
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_2ac1278b
	Namespace: namespace_90b0490e
	Checksum: 0x527E5F74
	Offset: 0x1CF0
	Size: 0xA4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_2ac1278b()
{
	self endon(#"death");
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = self waittill(#"trigger_activated");
		e_player = var_385703b7.e_who;
		if(function_18a1849f(e_player))
		{
			namespace_bd74bbd2::start(self.var_b9989e12);
			zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
			break;
		}
	}
}

/*
	Name: function_bafa7a2b
	Namespace: namespace_90b0490e
	Checksum: 0x934C8ACE
	Offset: 0x1DA0
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function function_bafa7a2b()
{
	exploder::stop_exploder("fxexp_mk2_Z_fire_chimney_" + level.var_74170866.var_1e20c0e5.script_string + "_house");
	if(isdefined(level.var_74170866.var_fead3ae9))
	{
		namespace_bd74bbd2::end(hash(level.var_74170866.var_1e20c0e5.script_noteworthy));
		level.var_74170866.var_fead3ae9 delete();
	}
	else
	{
		var_3b901e6a = level.var_74170866.var_1e20c0e5;
		var_3b901e6a notify(#"stop_think");
		zm_unitrigger::unregister_unitrigger(var_3b901e6a.s_unitrigger);
	}
}

/*
	Name: function_a36c4a5e
	Namespace: namespace_90b0490e
	Checksum: 0x90941F28
	Offset: 0x1EB8
	Size: 0x3A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a36c4a5e()
{
	level.var_74170866.e_player thread function_cba90c3c();
	level.var_74170866.n_step = 4;
}

/*
	Name: function_cba90c3c
	Namespace: namespace_90b0490e
	Checksum: 0x54087F5E
	Offset: 0x1F00
	Size: 0xBC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_cba90c3c()
{
	self endon(#"death");
	self waittill(#"hash_13f3f231b45420ef");
	if(zm_utility::is_classic())
	{
		if(!namespace_3e3742fd::function_6cebbce1())
		{
			level.var_74170866.e_player namespace_9cf755b::function_491673da(#"hash_4107574caf164040");
		}
		level.var_74170866.e_player namespace_509a75d1::function_51b752a9("vox_ww_z_craft", 0);
	}
	function_fa74521f();
}

/*
	Name: function_fa74521f
	Namespace: namespace_90b0490e
	Checksum: 0x22C61DF3
	Offset: 0x1FC8
	Size: 0xC2
	Parameters: 0
	Flags: Linked, Private
*/
private function function_fa74521f()
{
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold(level.var_74170866.e_player.name + "");
			println(level.var_74170866.e_player.name + "");
		}
	#/
	level.var_74170866.e_player = undefined;
	level.var_74170866.n_step = 5;
}

/*
	Name: on_disconnect
	Namespace: namespace_90b0490e
	Checksum: 0x402AEEBC
	Offset: 0x2098
	Size: 0x34
	Parameters: 0
	Flags: Linked, Private
*/
private function on_disconnect()
{
	if(function_18a1849f(self))
	{
		function_ac5deb51();
	}
}

/*
	Name: function_ac5deb51
	Namespace: namespace_90b0490e
	Checksum: 0x5889BE36
	Offset: 0x20D8
	Size: 0xE4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ac5deb51(var_e19b7aed = 1)
{
	level notify(#"hash_7456b125dbebe41c");
	switch(level.var_74170866.n_step)
	{
		case 1:
		{
			var_e19b7aed = 0;
			break;
		}
		case 2:
		{
			function_f05be4f1();
			break;
		}
		case 3:
		{
			function_bafa7a2b();
			break;
		}
	}
	level.var_74170866.e_player = undefined;
	if(var_e19b7aed)
	{
		function_b60df00d();
	}
}

/*
	Name: function_cbeb9a33
	Namespace: namespace_90b0490e
	Checksum: 0x1002C344
	Offset: 0x21C8
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function function_cbeb9a33()
{
	level waittill(#"insanity_mode_triggered");
	exploder::stop_exploder("fxexp_mk2_Z_smoke_orange_emit_closet_" + level.var_74170866.var_22355173.script_string);
	if(isdefined(level.var_74170866.var_22355173.var_5760bda2) && isdefined(level.var_74170866.var_22355173.var_5760bda2.s_unitrigger))
	{
		zm_unitrigger::unregister_unitrigger(level.var_74170866.var_22355173.var_5760bda2.s_unitrigger);
		level.var_74170866.var_22355173.var_5760bda2 delete();
	}
	function_ac5deb51(0);
}

