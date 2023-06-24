// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_174ce72cc0f850;
#using script_1c72973fb240f263;
#using scripts\zm\zm_white_portals.gsc;
#using scripts\zm\zm_white_main_quest.gsc;
#using scripts\zm_common\zm_ui_inventory.gsc;
#using scripts\zm\zm_hms_util.gsc;
#using script_724752ab26bff81b;
#using scripts\core_common\animation_shared.gsc;
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

#namespace namespace_825eac6b;

/*
	Name: preload
	Namespace: namespace_825eac6b
	Checksum: 0x65D00647
	Offset: 0x248
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	namespace_bd74bbd2::register(#"sc_mk2y", 20000, "sc_mk2y", &function_a66f0de2, &function_17f3e9e2);
	clientfield::register("scriptmover", "" + #"hash_70251001fe8c4abe", 20000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_b0298e980bd8da0", 20000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_1e4555a911a24ab7", 20000, 1, "int");
}

/*
	Name: init
	Namespace: namespace_825eac6b
	Checksum: 0x6ECF6B40
	Offset: 0x360
	Size: 0x1CA
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.var_23674b8f = spawnstruct();
	level.var_23674b8f.n_step = 0;
	callback::on_disconnect(&on_disconnect);
	level flag::init(#"hash_7ae84eb618c9266b");
	level flag::init(#"hash_11513646e875455c");
	level flag::init(#"hash_7a55d8f4bd6917cb");
	var_cf398736 = struct::get_array("mk2y_canister");
	var_cf398736 = array::randomize(var_cf398736);
	level.var_23674b8f.var_5dca8c75 = var_cf398736[0];
	foreach(var_5dca8c75 in var_cf398736)
	{
		var_d77110f1 = struct::get(var_5dca8c75.target);
		var_5dca8c75.var_ceb354bf = util::spawn_model(var_d77110f1.model, var_d77110f1.origin, var_d77110f1.angles);
	}
}

/*
	Name: function_18a1849f
	Namespace: namespace_825eac6b
	Checksum: 0x96BA1654
	Offset: 0x538
	Size: 0x40
	Parameters: 1
	Flags: Linked, Private
*/
function private function_18a1849f(e_player)
{
	if(!isdefined(level.var_23674b8f.e_player))
	{
		return 0;
	}
	return e_player === level.var_23674b8f.e_player;
}

/*
	Name: function_a4ea69bf
	Namespace: namespace_825eac6b
	Checksum: 0x2D828A89
	Offset: 0x580
	Size: 0x4C
	Parameters: 1
	Flags: Private
*/
function private function_a4ea69bf(w_weapon)
{
	return isdefined(w_weapon) && (w_weapon == level.var_23674b8f.var_905d8263 || w_weapon == level.var_23674b8f.var_3b5ae85);
}

/*
	Name: function_f6048ee
	Namespace: namespace_825eac6b
	Checksum: 0xEB9B0D8F
	Offset: 0x5D8
	Size: 0xF4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f6048ee(e_player)
{
	if(isdefined(e_player))
	{
		if(!isdefined(level.var_23674b8f.e_player))
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
		else
		{
			if(level.var_23674b8f.e_player == e_player)
			{
				self sethintstring(#"hash_74fc96e8d58ff646");
			}
			else
			{
				self sethintstring(#"hash_2054e8fdb6521566");
			}
		}
		return true;
	}
	return false;
}

/*
	Name: function_5b4f9f76
	Namespace: namespace_825eac6b
	Checksum: 0x458F0225
	Offset: 0x6D8
	Size: 0x76
	Parameters: 1
	Flags: Linked, Private
*/
function private function_5b4f9f76(e_player)
{
	var_2fff5cb5 = level.var_23674b8f.e_player === e_player;
	var_24441d81 = !isdefined(level.var_23674b8f.e_player) && !isdefined(e_player.var_9c20e2c9);
	return var_2fff5cb5 || var_24441d81;
}

/*
	Name: start_quest
	Namespace: namespace_825eac6b
	Checksum: 0xF05BE81B
	Offset: 0x758
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function start_quest()
{
	level thread function_b60df00d();
}

/*
	Name: function_b60df00d
	Namespace: namespace_825eac6b
	Checksum: 0xFA116655
	Offset: 0x780
	Size: 0x23C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_b60df00d()
{
	level endon(#"insanity_mode_triggered");
	level thread function_cbeb9a33();
	var_5dca8c75 = level.var_23674b8f.var_5dca8c75;
	var_5dca8c75.var_5760bda2 = util::spawn_model(var_5dca8c75.model, var_5dca8c75.origin, var_5dca8c75.angles);
	level.var_23674b8f.n_step = 1;
	if(isdefined(level.var_23674b8f.var_5dca8c75.var_ceb354bf))
	{
		exploder::exploder("fxexp_mk2_y_smoke_emit_" + level.var_23674b8f.var_5dca8c75.script_string);
		level flag::set(#"hash_3a183a144032bbf3");
		level flag::wait_till(#"hash_7ae84eb618c9266b");
		level.var_23674b8f.var_5dca8c75.var_ceb354bf delete();
		exploder::stop_exploder("fxexp_mk2_y_smoke_emit_" + level.var_23674b8f.var_5dca8c75.script_string);
		exploder::exploder("fxexp_mk2_y_dirt_reveal_" + level.var_23674b8f.var_5dca8c75.script_string);
	}
	s_unitrigger = var_5dca8c75.var_5760bda2 namespace_2e9c09b3::function_f1827cc6(&function_9d66ea6f, &function_f6048ee, &function_5b4f9f76, 96);
	zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
}

/*
	Name: function_33d9b1f8
	Namespace: namespace_825eac6b
	Checksum: 0x88F5F2F2
	Offset: 0x9C8
	Size: 0xFA
	Parameters: 0
	Flags: Linked
*/
function function_33d9b1f8()
{
	target = level.var_23674b8f.var_5dca8c75.var_ceb354bf;
	if(isdefined(target) && distancesquared(self.origin, target.origin) < 262144)
	{
		target util::function_c596f193();
		self.favoriteenemy = target;
		v_goal = getclosestpointonnavmesh(target.origin);
		self setgoal(v_goal);
		if(self.var_7a9b6c1d !== 1)
		{
			self thread function_1f955544();
			self.var_7a9b6c1d = 1;
		}
		return true;
	}
	return false;
}

/*
	Name: function_1f955544
	Namespace: namespace_825eac6b
	Checksum: 0x873038EB
	Offset: 0xAD0
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function function_1f955544()
{
	self endon(#"death");
	while(true)
	{
		if(!isdefined(level.var_23674b8f.var_5dca8c75.var_ceb354bf))
		{
			break;
		}
		if(distancesquared(self.origin, level.var_23674b8f.var_5dca8c75.var_ceb354bf.origin) < 6400)
		{
			self thread function_62970384();
			break;
		}
		else
		{
			wait(0.1);
		}
	}
}

/*
	Name: function_62970384
	Namespace: namespace_825eac6b
	Checksum: 0x3560673E
	Offset: 0xB80
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function function_62970384()
{
	self endon(#"death");
	self thread animation::play("ai_t8_zm_zombie_base_attack_14");
	wait(1);
	level flag::set(#"hash_7ae84eb618c9266b");
	self.var_8b59c468 = undefined;
}

/*
	Name: function_9d66ea6f
	Namespace: namespace_825eac6b
	Checksum: 0x517B50C2
	Offset: 0xBF0
	Size: 0x12C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_9d66ea6f(e_item, e_player)
{
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold(e_player.name + "");
			println(e_player.name + "");
		}
	#/
	level.var_23674b8f.e_player = e_player;
	namespace_a01a2431::function_605e5c25(e_player);
	e_player.var_9c20e2c9 = 1;
	e_player playsound("evt_canister_pickup");
	zm_ui_inventory::function_7df6bb60("zm_white_ww_mod_phase", 2, e_player);
	zm_ui_inventory::function_7df6bb60("zm_white_ww_mk2y_ammo", 1, e_player);
	function_87e09347();
}

/*
	Name: cleanup_step_1
	Namespace: namespace_825eac6b
	Checksum: 0x21C6EA4C
	Offset: 0xD28
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function cleanup_step_1()
{
	exploder::stop_exploder("fxexp_mk2_y_smoke_emit_" + level.var_23674b8f.var_5dca8c75.script_string);
	level flag::clear(#"hash_3a183a144032bbf3");
	if(isdefined(level.var_23674b8f.var_5dca8c75.var_5760bda2) && isdefined(level.var_23674b8f.var_5dca8c75.var_5760bda2.s_unitrigger))
	{
		zm_unitrigger::unregister_unitrigger(level.var_23674b8f.var_5dca8c75.var_5760bda2.s_unitrigger);
		level.var_23674b8f.var_5dca8c75.var_5760bda2 delete();
	}
}

/*
	Name: function_87e09347
	Namespace: namespace_825eac6b
	Checksum: 0x82EC7CB5
	Offset: 0xE38
	Size: 0x4D4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_87e09347()
{
	level endon(#"end_game", #"hash_36fd0ff497e7cb39");
	level.var_23674b8f.n_step = 2;
	a_s_portals = struct::get_array("white_portal");
	var_7ed14c5f = zm_white_portals::function_688df525();
	var_95d7a612 = array::exclude(a_s_portals, var_7ed14c5f);
	var_95d7a612 = array::randomize(var_95d7a612);
	level.var_23674b8f.var_80284ca5 = [];
	for(i = 0; i < 2; i++)
	{
		if(!isdefined(level.var_23674b8f.var_80284ca5))
		{
			level.var_23674b8f.var_80284ca5 = [];
		}
		else if(!isarray(level.var_23674b8f.var_80284ca5))
		{
			level.var_23674b8f.var_80284ca5 = array(level.var_23674b8f.var_80284ca5);
		}
		level.var_23674b8f.var_80284ca5[level.var_23674b8f.var_80284ca5.size] = array::pop_front(var_95d7a612);
	}
	/#
		iprintlnbold((("" + level.var_23674b8f.var_80284ca5[0].script_noteworthy) + "") + level.var_23674b8f.var_80284ca5[1].script_noteworthy);
	#/
	s_canister = level.var_23674b8f.var_5dca8c75;
	level.var_23674b8f.var_ce68e849 = util::spawn_model(#"tag_origin", s_canister.origin - vectorscale((0, 0, 1), 64), s_canister.angles);
	var_ce68e849 = level.var_23674b8f.var_ce68e849;
	var_ce68e849.e_model = util::spawn_model(#"hash_baa35cbefc71b6c", var_ce68e849.origin, var_ce68e849.angles);
	var_ce68e849.e_model linkto(var_ce68e849);
	var_ce68e849.e_model ghost();
	var_ce68e849 clientfield::set("" + #"hash_b0298e980bd8da0", 1);
	var_ce68e849 moveto(s_canister.origin + vectorscale((0, 0, 1), 64), 0.75);
	var_ce68e849 waittill(#"movedone");
	level thread function_eddc2ed3();
	wait(3);
	n_time = distance(var_ce68e849.origin, level.var_23674b8f.var_80284ca5[0].origin) / 400;
	var_ce68e849 moveto(level.var_23674b8f.var_80284ca5[0].origin + vectorscale((0, 0, 1), 64), n_time);
	var_ce68e849 waittill(#"movedone");
	var_ce68e849 thread function_fe82c566();
	level.var_23674b8f.e_player thread function_92344a03();
	level flag::wait_till(#"hash_7a55d8f4bd6917cb");
	level thread function_b99d76c0();
}

/*
	Name: function_eddc2ed3
	Namespace: namespace_825eac6b
	Checksum: 0x7A42457A
	Offset: 0x1318
	Size: 0x8C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_eddc2ed3()
{
	if(zm_utility::is_classic())
	{
		level.var_23674b8f.e_player zm_hms_util::function_51b752a9("vox_ww_y_ammo_pickup", 0);
		wait(1);
		if(!zm_white_main_quest::function_6cebbce1())
		{
			level.var_23674b8f.e_player zm_white_util::function_491673da(#"hash_61ea1c56d8b85109");
		}
	}
}

/*
	Name: function_fe82c566
	Namespace: namespace_825eac6b
	Checksum: 0x236F7247
	Offset: 0x13B0
	Size: 0x3C0
	Parameters: 0
	Flags: Linked, Private
*/
function private function_fe82c566()
{
	self endon(#"death", #"hash_530fc6e3ae75d439");
	level.var_23674b8f.var_c8a6d360 = 0;
	while(true)
	{
		self.e_model setcandamage(1);
		self.e_model val::set("quest_mk2y", "allowDeath", 0);
		s_notify = undefined;
		s_notify = self.e_model waittill(#"damage");
		self.e_model setcandamage(0);
		var_bc569584 = level.var_23674b8f.var_80284ca5[level.var_23674b8f.var_c8a6d360].origin;
		self moveto(var_bc569584, 0.3);
		self waittill(#"movedone");
		playfx(level._effect[#"portal_origin"], var_bc569584, (1, 0, 0), (0, 0, 1));
		playsoundatposition(#"evt_teleporter_out", var_bc569584);
		self clientfield::set("" + #"hash_b0298e980bd8da0", 0);
		level flag::set(#"hash_11513646e875455c");
		wait(10);
		level flag::clear(#"hash_11513646e875455c");
		level.var_23674b8f.var_c8a6d360++;
		if(level.var_23674b8f.var_c8a6d360 > level.var_23674b8f.var_80284ca5.size - 1)
		{
			level.var_23674b8f.var_c8a6d360 = 0;
		}
		self clientfield::set("" + #"hash_b0298e980bd8da0", 1);
		var_838db546 = level.var_23674b8f.var_80284ca5[level.var_23674b8f.var_c8a6d360].origin;
		self.origin = var_838db546 - vectorscale((0, 0, 1), 64);
		self moveto(var_838db546 + vectorscale((0, 0, 1), 64), 1);
		wait(0.5);
		playfx(level._effect[#"portal_dest"], var_838db546, (1, 0, 0), (0, 0, 1));
		playsoundatposition(#"evt_teleporter_go", var_838db546);
		self waittill(#"movedone");
		/#
			iprintlnbold("" + level.var_23674b8f.var_80284ca5[level.var_23674b8f.var_c8a6d360].script_noteworthy);
		#/
	}
}

/*
	Name: function_92344a03
	Namespace: namespace_825eac6b
	Checksum: 0x6E34FE4
	Offset: 0x1778
	Size: 0x3D2
	Parameters: 0
	Flags: Linked, Private
*/
function private function_92344a03()
{
	self endon(#"death", #"hash_376274afc09952fa");
	while(true)
	{
		var_135425aa = 0;
		self waittill(#"teleporting");
		var_8a3d3cf4 = level flag::get(#"hash_11513646e875455c");
		var_86812839 = 1;
		var_7ed14c5f = zm_white_portals::function_688df525();
		foreach(var_e2db3886 in level.var_23674b8f.var_80284ca5)
		{
			if(!isinarray(var_7ed14c5f, var_e2db3886))
			{
				var_86812839 = 0;
				break;
			}
		}
		var_58ab2e2c = self.s_teleport === level.var_23674b8f.var_80284ca5[level.var_23674b8f.var_c8a6d360];
		if(var_8a3d3cf4 && var_86812839 && var_58ab2e2c)
		{
			wait(0.1);
			var_ce68e849 = level.var_23674b8f.var_ce68e849;
			var_59bd625c = self getcentroid() + (20 * vectornormalize(anglestoforward(self.angles)));
			var_59bd625c = var_59bd625c + (2 * vectornormalize(anglestoright(self.angles)));
			var_59bd625c = var_59bd625c + vectorscale((0, 0, 1), 22);
			var_ce68e849.origin = var_59bd625c;
			var_ce68e849.angles = self.angles;
			var_ce68e849 clientfield::set("" + #"hash_1e4555a911a24ab7", 1);
			wait(1.5);
			var_ce68e849 moveto(self getcentroid(), 1);
			var_ce68e849 waittill(#"movedone");
			var_ce68e849 clientfield::set("" + #"hash_1e4555a911a24ab7", 0);
			var_135425aa = 1;
			/#
				iprintlnbold("");
			#/
		}
		self waittill(#"teleporting_done");
		if(var_135425aa)
		{
			level flag::set(#"hash_7a55d8f4bd6917cb");
			level.var_23674b8f.var_ce68e849 notify(#"hash_530fc6e3ae75d439");
			self notify(#"hash_376274afc09952fa");
		}
	}
}

/*
	Name: function_631ca480
	Namespace: namespace_825eac6b
	Checksum: 0xAD662461
	Offset: 0x1B58
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_631ca480()
{
	if(isdefined(level.var_23674b8f.var_ce68e849))
	{
		if(isdefined(level.var_23674b8f.var_ce68e849.e_model))
		{
			level.var_23674b8f.var_ce68e849.e_model delete();
		}
		level.var_23674b8f.var_ce68e849 delete();
	}
}

/*
	Name: cleanup_step_2
	Namespace: namespace_825eac6b
	Checksum: 0xCFC34176
	Offset: 0x1BE8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function cleanup_step_2()
{
	function_631ca480();
}

/*
	Name: function_b99d76c0
	Namespace: namespace_825eac6b
	Checksum: 0xC2098565
	Offset: 0x1C08
	Size: 0x394
	Parameters: 0
	Flags: Linked
*/
function function_b99d76c0()
{
	level endon(#"end_game", #"hash_36fd0ff497e7cb39");
	level.var_23674b8f.n_step = 3;
	wait(0.25);
	var_ce68e849 = level.var_23674b8f.var_ce68e849;
	var_ce68e849 clientfield::set("" + #"hash_b0298e980bd8da0", 1);
	var_ce68e849.origin = level.var_23674b8f.e_player getcentroid();
	var_ce68e849.angles = level.var_23674b8f.e_player.angles;
	var_59bd625c = level.var_23674b8f.e_player getcentroid() + (96 * vectornormalize(anglestoforward(level.var_23674b8f.e_player.angles)));
	var_59bd625c = var_59bd625c + vectorscale((0, 0, 1), 32);
	var_ce68e849 moveto(var_59bd625c, 0.5);
	var_ce68e849 waittill(#"movedone");
	wait(3);
	if(!zm_white_main_quest::function_6cebbce1() && zm_utility::is_classic())
	{
		level.var_23674b8f.e_player thread zm_white_util::function_491673da(#"hash_6942fd3186464801");
	}
	var_3d7dfe05 = struct::get("mk2y_defend");
	n_time = distance(var_ce68e849.origin, var_3d7dfe05.origin) / 400;
	var_ce68e849 moveto(var_3d7dfe05.origin, n_time);
	var_ce68e849 waittill(#"movedone");
	var_3d7dfe05 = struct::get("mk2y_defend");
	var_3d7dfe05 zm_unitrigger::function_fac87205(&function_18a1849f, 96, 0, 1);
	level.var_23674b8f.var_fead3ae9 = util::spawn_model(var_3d7dfe05.model, var_3d7dfe05.origin, var_3d7dfe05.angles);
	level.var_23674b8f.var_fead3ae9 thread function_2b0060b8();
	playsoundatposition("evt_rgun_frame_putback", (1046, -1606, -259));
	namespace_bd74bbd2::start(#"sc_mk2y");
}

/*
	Name: function_2b0060b8
	Namespace: namespace_825eac6b
	Checksum: 0x59DEF1CC
	Offset: 0x1FA8
	Size: 0x130
	Parameters: 0
	Flags: Linked, Private
*/
function private function_2b0060b8()
{
	self endon(#"death");
	var_a28e7c1f = self.origin + (0, 0, 1);
	var_ae661658 = self.origin - (0, 0, 1);
	var_4814cac6 = 1;
	while(true)
	{
		if(var_4814cac6)
		{
			self moveto(var_a28e7c1f, 2, 1, 1);
		}
		else
		{
			self moveto(var_ae661658, 2, 1, 1);
		}
		self rotatevelocity(vectorscale((0, 1, 0), 90), 4);
		self waittill(#"movedone");
		var_4814cac6 = !var_4814cac6;
	}
}

/*
	Name: function_a66f0de2
	Namespace: namespace_825eac6b
	Checksum: 0x8992A87C
	Offset: 0x20E0
	Size: 0x104
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a66f0de2()
{
	namespace_bd74bbd2::end(#"sc_mk2y");
	s_unitrigger = level.var_23674b8f.var_fead3ae9 namespace_2e9c09b3::function_f1827cc6(&function_b9a31cb, &function_f6048ee, &function_5b4f9f76);
	zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
	level.var_23674b8f.var_fead3ae9 setmodel(#"hash_7b9a3cdf5dd8b4d7");
	level.var_23674b8f.var_fead3ae9 clientfield::set("" + #"hash_70251001fe8c4abe", 1);
}

/*
	Name: function_b9a31cb
	Namespace: namespace_825eac6b
	Checksum: 0x69B7CF08
	Offset: 0x21F0
	Size: 0x1C4
	Parameters: 2
	Flags: Linked, Private
*/
function private function_b9a31cb(e_item, e_player)
{
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold(e_player.name + "");
			println(e_player.name + "");
		}
	#/
	zm_ui_inventory::function_7df6bb60("zm_white_ww_mk2y_ammo", 2, e_player);
	e_player.var_f7694097 = 2;
	e_player playsound("evt_canister_pickup");
	level.var_23674b8f.var_ce68e849 clientfield::set("" + #"hash_b0298e980bd8da0", 0);
	level.var_23674b8f.var_ce68e849.e_model delete();
	level.var_23674b8f.var_ce68e849 delete();
	function_a36c4a5e();
	if(!zm_white_main_quest::function_6cebbce1() && zm_utility::is_classic())
	{
		level.var_23674b8f.e_player thread zm_white_util::function_491673da(#"hash_4164610d88a43d16");
	}
}

/*
	Name: function_17f3e9e2
	Namespace: namespace_825eac6b
	Checksum: 0x43FC4183
	Offset: 0x23C0
	Size: 0x7C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_17f3e9e2()
{
	s_unitrigger = level.var_23674b8f.var_fead3ae9 zm_unitrigger::create(&function_7015dc35, 96);
	zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
	level.var_23674b8f.var_fead3ae9 thread function_2ac1278b();
}

/*
	Name: function_7015dc35
	Namespace: namespace_825eac6b
	Checksum: 0x6BB8FF7A
	Offset: 0x2448
	Size: 0x84
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7015dc35(e_player)
{
	if(isdefined(e_player))
	{
		if(level.var_23674b8f.e_player === e_player)
		{
			self sethintstring(#"hash_14eae7c162ebb8d2");
		}
		else
		{
			self sethintstring(#"hash_2054e8fdb6521566");
		}
		return true;
	}
	return false;
}

/*
	Name: function_2ac1278b
	Namespace: namespace_825eac6b
	Checksum: 0x5EE13B
	Offset: 0x24D8
	Size: 0xAC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_2ac1278b()
{
	self endon(#"death");
	while(true)
	{
		s_notify = undefined;
		s_notify = self waittill(#"trigger_activated");
		e_player = s_notify.e_who;
		if(function_18a1849f(e_player))
		{
			namespace_bd74bbd2::start(#"sc_mk2y");
			zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
			break;
		}
	}
}

/*
	Name: cleanup_step_3
	Namespace: namespace_825eac6b
	Checksum: 0x42A6F618
	Offset: 0x2590
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function cleanup_step_3()
{
	function_631ca480();
	if(isdefined(level.var_23674b8f.var_fead3ae9))
	{
		namespace_bd74bbd2::end(#"sc_mk2y");
		level.var_23674b8f.var_fead3ae9 delete();
	}
	else
	{
		s_sc = struct::get("mk2y_defend");
		s_sc notify(#"stop_think");
		zm_unitrigger::unregister_unitrigger(s_sc.s_unitrigger);
	}
}

/*
	Name: function_a36c4a5e
	Namespace: namespace_825eac6b
	Checksum: 0xFC800C1
	Offset: 0x2660
	Size: 0x3A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a36c4a5e()
{
	level.var_23674b8f.e_player thread function_cba90c3c();
	level.var_23674b8f.n_step = 4;
}

/*
	Name: function_cba90c3c
	Namespace: namespace_825eac6b
	Checksum: 0xA84BAEF6
	Offset: 0x26A8
	Size: 0xBC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_cba90c3c()
{
	self endon(#"death");
	self waittill(#"hash_13f3f231b45420ef");
	if(zm_utility::is_classic())
	{
		if(!zm_white_main_quest::function_6cebbce1())
		{
			level.var_23674b8f.e_player zm_white_util::function_491673da(#"hash_4b04746b2f367ca3");
		}
		level.var_23674b8f.e_player zm_hms_util::function_51b752a9("vox_ww_y_craft", 0);
	}
	complete_quest();
}

/*
	Name: complete_quest
	Namespace: namespace_825eac6b
	Checksum: 0x48B4F9D8
	Offset: 0x2770
	Size: 0xC2
	Parameters: 0
	Flags: Linked, Private
*/
function private complete_quest()
{
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold(level.var_23674b8f.e_player.name + "");
			println(level.var_23674b8f.e_player.name + "");
		}
	#/
	level.var_23674b8f.e_player = undefined;
	level.var_23674b8f.n_step = 5;
}

/*
	Name: on_disconnect
	Namespace: namespace_825eac6b
	Checksum: 0xAB38EF5
	Offset: 0x2840
	Size: 0x34
	Parameters: 0
	Flags: Linked, Private
*/
function private on_disconnect()
{
	if(function_18a1849f(self))
	{
		restart_quest();
	}
}

/*
	Name: restart_quest
	Namespace: namespace_825eac6b
	Checksum: 0xB8C3FA9B
	Offset: 0x2880
	Size: 0xFC
	Parameters: 1
	Flags: Linked, Private
*/
function private restart_quest(var_e19b7aed = 1)
{
	level notify(#"hash_36fd0ff497e7cb39");
	switch(level.var_23674b8f.n_step)
	{
		case 1:
		{
			cleanup_step_1();
			var_e19b7aed = 0;
			break;
		}
		case 2:
		{
			cleanup_step_2();
			break;
		}
		case 3:
		{
			cleanup_step_3();
			break;
		}
	}
	level.var_23674b8f.e_player = undefined;
	if(var_e19b7aed)
	{
		function_b60df00d();
	}
}

/*
	Name: function_cbeb9a33
	Namespace: namespace_825eac6b
	Checksum: 0x64CBBFF
	Offset: 0x2988
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_cbeb9a33()
{
	level waittill(#"insanity_mode_triggered");
	restart_quest(0);
}

