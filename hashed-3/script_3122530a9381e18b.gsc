// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_10956a741a7e186e;
#using script_174ce72cc0f850;
#using script_1c72973fb240f263;
#using script_3510d12b63a575c3;
#using script_52c6c2d1a2ef1b46;
#using script_5bb072c3abf4652c;
#using script_6a3f43063dfd1bdc;
#using script_724752ab26bff81b;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_ca03bbb4;

/*
	Name: preload
	Namespace: namespace_ca03bbb4
	Checksum: 0x6A52AA4C
	Offset: 0x408
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	namespace_bd74bbd2::register(#"sc_mk2v", 20000, "sc_mk2v", &function_a66f0de2, &function_17f3e9e2);
	clientfield::register("scriptmover", "" + #"hash_7b37fadc13d402a3", 20000, 1, "int");
}

/*
	Name: init
	Namespace: namespace_ca03bbb4
	Checksum: 0x6EB1922
	Offset: 0x4A0
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.var_9eccff99 = spawnstruct();
	level.var_9eccff99.var_10630268 = getweapon("ray_gun_mk2v");
	level.var_9eccff99.var_d58b0729 = getweapon("ray_gun_mk2v_upgraded");
	level.var_9eccff99.n_step = 0;
	callback::on_disconnect(&on_disconnect);
}

/*
	Name: function_1c530e2d
	Namespace: namespace_ca03bbb4
	Checksum: 0x2F0CF2F6
	Offset: 0x548
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function function_1c530e2d()
{
	/#
		level endon(#"game_ended");
		level waittill(#"open_sesame");
		namespace_5c160465::function_6acd363d(1);
	#/
}

/*
	Name: function_18a1849f
	Namespace: namespace_ca03bbb4
	Checksum: 0xC2A0237A
	Offset: 0x5A0
	Size: 0x40
	Parameters: 1
	Flags: Linked, Private
*/
function private function_18a1849f(e_player)
{
	if(!isdefined(level.var_9eccff99.e_player))
	{
		return 0;
	}
	return e_player === level.var_9eccff99.e_player;
}

/*
	Name: function_f6048ee
	Namespace: namespace_ca03bbb4
	Checksum: 0xEBCB8668
	Offset: 0x5E8
	Size: 0xF4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f6048ee(e_player)
{
	if(isdefined(e_player))
	{
		if(!isdefined(level.var_9eccff99.e_player))
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
			if(level.var_9eccff99.e_player == e_player)
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
	Namespace: namespace_ca03bbb4
	Checksum: 0x8F64345F
	Offset: 0x6E8
	Size: 0x76
	Parameters: 1
	Flags: Linked, Private
*/
function private function_5b4f9f76(e_player)
{
	var_2fff5cb5 = level.var_9eccff99.e_player === e_player;
	var_24441d81 = !isdefined(level.var_9eccff99.e_player) && !isdefined(e_player.var_9c20e2c9);
	return var_2fff5cb5 || var_24441d81;
}

/*
	Name: function_a8e75297
	Namespace: namespace_ca03bbb4
	Checksum: 0x5DF31BEB
	Offset: 0x768
	Size: 0x4C
	Parameters: 1
	Flags: Private
*/
function private function_a8e75297(w_weapon)
{
	return isdefined(w_weapon) && (w_weapon == level.var_9eccff99.var_10630268 || w_weapon == level.var_9eccff99.var_d58b0729);
}

/*
	Name: start_quest
	Namespace: namespace_ca03bbb4
	Checksum: 0x9C89994A
	Offset: 0x7C0
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
	Namespace: namespace_ca03bbb4
	Checksum: 0xDAF39163
	Offset: 0x7E0
	Size: 0x21A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_b60df00d()
{
	level thread function_cbeb9a33();
	if(!isdefined(level.var_9eccff99.s_start))
	{
		level.var_9eccff99.s_start = namespace_509a75d1::function_4e7f5b2e("mk2v_start");
	}
	level.var_9eccff99.var_fead3ae9 = util::spawn_model("p8_zm_whi_fuse_pickup_fluid_yellow_half", level.var_9eccff99.s_start.origin, level.var_9eccff99.s_start.angles);
	e_panel = getent(level.var_9eccff99.s_start.target, "targetname");
	if(isdefined(e_panel))
	{
		e_panel setcandamage(1);
		e_panel val::set("quest_mk2v", "allowDeath", 0);
		e_panel thread function_1129876d();
		exploder::exploder("fxexp_quest_raygun_m2_v_stage_1" + level.var_9eccff99.s_start.exploder_id);
	}
	else
	{
		s_unitrigger = level.var_9eccff99.var_fead3ae9 namespace_2e9c09b3::function_f1827cc6(&function_9d66ea6f, &function_f6048ee, &function_5b4f9f76);
		zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
	}
	level.var_9eccff99.n_step = 1;
}

/*
	Name: function_1129876d
	Namespace: namespace_ca03bbb4
	Checksum: 0x9D989930
	Offset: 0xA08
	Size: 0xD4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_1129876d()
{
	self endon(#"death");
	pixbeginevent(#"hash_31bd17db0dd4297d");
	while(true)
	{
		s_notify = undefined;
		s_notify = self waittill(#"damage");
		if(s_notify namespace_509a75d1::function_69320b44("zm_aat_kill_o_watt"))
		{
			self function_d41d20b1();
			break;
		}
	}
	pixendevent();
	self delete();
}

/*
	Name: function_d41d20b1
	Namespace: namespace_ca03bbb4
	Checksum: 0xA71EF497
	Offset: 0xAE8
	Size: 0x114
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d41d20b1()
{
	v_force = anglestoforward(self.angles);
	v_force = v_force * 0.2;
	createdynentandlaunch(self.dyn, self.origin, self.angles, self.origin, v_force);
	exploder::stop_exploder("fxexp_quest_raygun_m2_v_stage_1" + level.var_9eccff99.s_start.exploder_id);
	s_unitrigger = level.var_9eccff99.var_fead3ae9 namespace_2e9c09b3::function_f1827cc6(&function_9d66ea6f, &function_f6048ee, &function_5b4f9f76);
	zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
}

/*
	Name: function_9d66ea6f
	Namespace: namespace_ca03bbb4
	Checksum: 0xB099EECB
	Offset: 0xC08
	Size: 0x144
	Parameters: 2
	Flags: Linked, Private
*/
function private function_9d66ea6f(var_2e1f34dd, e_player)
{
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold(e_player.name + "");
			println(e_player.name + "");
		}
	#/
	level.var_9eccff99.e_player = e_player;
	namespace_a01a2431::function_605e5c25(e_player);
	e_player.var_9c20e2c9 = 1;
	e_player playsound("evt_canister_pickup");
	namespace_6747c550::function_7df6bb60("zm_white_ww_mod_phase", 0, e_player);
	namespace_6747c550::function_7df6bb60("zm_white_ww_mk2v_ammo", 1, e_player);
	e_player thread function_130ea633();
	function_87e09347();
}

/*
	Name: function_130ea633
	Namespace: namespace_ca03bbb4
	Checksum: 0x80B52965
	Offset: 0xD58
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_130ea633()
{
	if(zm_utility::is_classic())
	{
		self zm_vo::function_57b8cd17();
		self namespace_509a75d1::function_51b752a9("vox_ww_v_ammo_pickup");
		if(!namespace_3e3742fd::function_6cebbce1())
		{
			self zm_audio::do_player_or_npc_playvox("vox_ww_v_elec_hint_rush_0", 1);
		}
	}
}

/*
	Name: function_87e09347
	Namespace: namespace_ca03bbb4
	Checksum: 0x40AE0443
	Offset: 0xDE0
	Size: 0xEA
	Parameters: 0
	Flags: Linked, Private
*/
function private function_87e09347()
{
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
	var_685c8f1e = struct::get_array("mk2v_pole_target");
	level.var_9eccff99.var_685c8f1e = array::randomize(var_685c8f1e);
	level.var_9eccff99.var_f8f50111 = 0;
	level.var_9eccff99.var_685c8f1e[0] function_22b5323d();
	level.var_9eccff99.n_step = 2;
}

/*
	Name: function_22b5323d
	Namespace: namespace_ca03bbb4
	Checksum: 0x23F622C4
	Offset: 0xED8
	Size: 0xC2
	Parameters: 0
	Flags: Linked, Private
*/
function private function_22b5323d()
{
	exploder::exploder("fxexp_quest_raygun_m2_v_stage_3_xtra_hint_" + self.exploder_id);
	t_damage = spawn("trigger_damage_new", self.origin - vectorscale((0, 0, 1), 12), (1048576 | 2097152) | 8388608, 24, 24);
	t_damage.n_hit_count = 0;
	t_damage.s_target = self;
	t_damage thread function_27766b0b();
	self.t_damage = t_damage;
}

/*
	Name: function_27766b0b
	Namespace: namespace_ca03bbb4
	Checksum: 0xFFFF0CF7
	Offset: 0xFA8
	Size: 0x114
	Parameters: 0
	Flags: Linked, Private
*/
function private function_27766b0b()
{
	self endon(#"death");
	pixbeginevent(#"hash_1d99091c9b9308d1");
	while(true)
	{
		s_notify = undefined;
		s_notify = self waittill(#"damage");
		self playsound("evt_insulator_hit");
		if(s_notify namespace_509a75d1::function_69320b44("zm_aat_kill_o_watt"))
		{
			self.n_hit_count++;
			if(self.n_hit_count >= 3)
			{
				self.s_target function_6d765bb3();
				break;
			}
		}
	}
	pixendevent();
	self delete();
}

/*
	Name: function_6d765bb3
	Namespace: namespace_ca03bbb4
	Checksum: 0xD93B6642
	Offset: 0x10C8
	Size: 0x18C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_6d765bb3()
{
	exploder::stop_exploder("fxexp_quest_raygun_m2_v_stage_3_xtra_hint_" + self.exploder_id);
	exploder::exploder("fxexp_quest_raygun_m2_v_stage_4_complete_" + self.exploder_id);
	level.var_9eccff99.var_f8f50111++;
	if(level.var_9eccff99.var_f8f50111 == level.var_9eccff99.var_685c8f1e.size)
	{
		/#
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				iprintlnbold(level.var_9eccff99.e_player.name + "");
				println(level.var_9eccff99.e_player.name + "");
			}
		#/
		function_b99d76c0();
		level notify(#"hash_141539da9edb11ab");
	}
	else
	{
		level.var_9eccff99.var_685c8f1e[level.var_9eccff99.var_f8f50111] function_22b5323d();
	}
}

/*
	Name: function_f05be4f1
	Namespace: namespace_ca03bbb4
	Checksum: 0x60DC2412
	Offset: 0x1260
	Size: 0x100
	Parameters: 0
	Flags: Linked
*/
function function_f05be4f1()
{
	foreach(var_5c805707 in level.var_9eccff99.var_685c8f1e)
	{
		exploder::stop_exploder("fxexp_quest_raygun_m2_v_stage_3_xtra_hint_" + var_5c805707.exploder_id);
		exploder::stop_exploder("fxexp_quest_raygun_m2_v_stage_4_complete_" + var_5c805707.exploder_id);
		if(isdefined(var_5c805707.t_damage))
		{
			var_5c805707.t_damage delete();
		}
	}
	level notify(#"hash_141539da9edb11ab");
}

/*
	Name: function_b99d76c0
	Namespace: namespace_ca03bbb4
	Checksum: 0xB4BA0E56
	Offset: 0x1368
	Size: 0xA2
	Parameters: 0
	Flags: Linked, Private
*/
function private function_b99d76c0()
{
	s_gen = struct::get("mk2v_gen");
	s_gen zm_unitrigger::create("", 96);
	s_gen thread function_195e54c();
	exploder::exploder("fxexp_quest_raygun_m2_v_stage_5_active");
	exploder::exploder("fxexp_quest_raygun_m2_v_stage_6_active");
	level.var_9eccff99.n_step = 3;
}

/*
	Name: function_195e54c
	Namespace: namespace_ca03bbb4
	Checksum: 0x3D25D16B
	Offset: 0x1418
	Size: 0x14C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_195e54c()
{
	self endon(#"death", #"stop_think");
	while(true)
	{
		s_notify = undefined;
		s_notify = self waittill(#"trigger_activated");
		playsoundatposition("evt_rgun_frame_putback", (553, -134, 1));
		if(function_18a1849f(level.var_9eccff99.e_player))
		{
			level.var_9eccff99.var_fead3ae9 = util::spawn_model("p8_zm_whi_fuse_pickup_fluid_yellow_half", self.origin, self.angles);
			level.var_9eccff99.var_fead3ae9.in_zone = "zone_culdesac_yellow";
			namespace_bd74bbd2::start(#"sc_mk2v");
			level notify(#"hash_2df7109d3c756d8e");
			zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
			break;
		}
	}
}

/*
	Name: function_a66f0de2
	Namespace: namespace_ca03bbb4
	Checksum: 0x55E08517
	Offset: 0x1570
	Size: 0x110
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a66f0de2()
{
	namespace_bd74bbd2::end(#"sc_mk2v");
	s_unitrigger = level.var_9eccff99.var_fead3ae9 namespace_2e9c09b3::function_f1827cc6(&function_e90f6026, &function_f6048ee, &function_5b4f9f76);
	zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
	level.var_9eccff99.var_fead3ae9 setmodel("p8_zm_whi_fuse_pickup_fluid_yellow");
	level.var_9eccff99.var_fead3ae9 clientfield::set("" + #"hash_7b37fadc13d402a3", 1);
	level notify(#"hash_b8dfde4a4e85cd2");
}

/*
	Name: function_e90f6026
	Namespace: namespace_ca03bbb4
	Checksum: 0xDCCDE73
	Offset: 0x1688
	Size: 0x10C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_e90f6026(var_2e1f34dd, e_player)
{
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold(e_player.name + "");
			println(e_player.name + "");
		}
	#/
	namespace_6747c550::function_7df6bb60("zm_white_ww_mk2v_ammo", 2, e_player);
	e_player.var_f7694097 = 0;
	e_player thread function_9d800221();
	e_player playsound("evt_rgun_frame_pickup");
	function_e09a7418();
	function_a36c4a5e();
}

/*
	Name: function_9d800221
	Namespace: namespace_ca03bbb4
	Checksum: 0xEFFCAC7F
	Offset: 0x17A0
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_9d800221()
{
	if(zm_utility::is_classic())
	{
		namespace_509a75d1::function_29fe9a5d();
		self zm_vo::function_57b8cd17();
		self namespace_509a75d1::function_51b752a9("vox_ww_v_pickup");
		if(!namespace_3e3742fd::function_6cebbce1())
		{
			self zm_audio::do_player_or_npc_playvox("vox_ww_v_pickup_rush_1", 1);
		}
	}
}

/*
	Name: function_e09a7418
	Namespace: namespace_ca03bbb4
	Checksum: 0xC69CD4D6
	Offset: 0x1840
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_e09a7418()
{
	exploder::stop_exploder("fxexp_quest_raygun_m2_v_stage_5_active");
	exploder::stop_exploder("fxexp_quest_raygun_m2_v_stage_6_active");
	function_f05be4f1();
}

/*
	Name: function_17f3e9e2
	Namespace: namespace_ca03bbb4
	Checksum: 0xE48674A5
	Offset: 0x1890
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_17f3e9e2()
{
	s_unitrigger = level.var_9eccff99.var_fead3ae9 zm_unitrigger::create(&function_7015dc35);
	zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
	level.var_9eccff99.var_fead3ae9 thread function_2ac1278b();
}

/*
	Name: function_7015dc35
	Namespace: namespace_ca03bbb4
	Checksum: 0xE4B3869B
	Offset: 0x1910
	Size: 0x84
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7015dc35(e_player)
{
	if(isdefined(e_player))
	{
		if(level.var_9eccff99.e_player === e_player)
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
	Namespace: namespace_ca03bbb4
	Checksum: 0xD3DE05E1
	Offset: 0x19A0
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
			namespace_bd74bbd2::start(#"sc_mk2v");
			zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
			break;
		}
	}
}

/*
	Name: function_bafa7a2b
	Namespace: namespace_ca03bbb4
	Checksum: 0x49A69DD
	Offset: 0x1A58
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_bafa7a2b()
{
	function_e09a7418();
	if(isdefined(level.var_9eccff99.var_fead3ae9))
	{
		namespace_bd74bbd2::end(#"sc_mk2v");
		level.var_9eccff99.var_fead3ae9 delete();
	}
	else
	{
		s_gen = struct::get("mk2v_gen");
		s_gen notify(#"stop_think");
		zm_unitrigger::unregister_unitrigger(s_gen.s_unitrigger);
	}
}

/*
	Name: function_a36c4a5e
	Namespace: namespace_ca03bbb4
	Checksum: 0x6F919564
	Offset: 0x1B28
	Size: 0x3A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a36c4a5e()
{
	level.var_9eccff99.e_player thread function_cba90c3c();
	level.var_9eccff99.n_step = 4;
}

/*
	Name: function_cba90c3c
	Namespace: namespace_ca03bbb4
	Checksum: 0x2135D3A1
	Offset: 0x1B70
	Size: 0x4C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_cba90c3c()
{
	self endon(#"death");
	self waittill(#"hash_13f3f231b45420ef");
	self thread function_62ac32b9();
	function_fa74521f();
}

/*
	Name: function_62ac32b9
	Namespace: namespace_ca03bbb4
	Checksum: 0x2D4330BB
	Offset: 0x1BC8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_62ac32b9()
{
	if(zm_utility::is_classic())
	{
		namespace_509a75d1::function_29fe9a5d();
		self zm_vo::function_57b8cd17();
		self namespace_509a75d1::function_51b752a9("vox_ww_v_craft");
		if(!namespace_3e3742fd::function_6cebbce1())
		{
			self zm_audio::do_player_or_npc_playvox("vox_ww_v_craft_rush_1", 1);
		}
	}
}

/*
	Name: function_fa74521f
	Namespace: namespace_ca03bbb4
	Checksum: 0x4C752305
	Offset: 0x1C68
	Size: 0xC2
	Parameters: 0
	Flags: Linked, Private
*/
function private function_fa74521f()
{
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold(level.var_9eccff99.e_player.name + "");
			println(level.var_9eccff99.e_player.name + "");
		}
	#/
	level.var_9eccff99.e_player = undefined;
	level.var_9eccff99.n_step = 5;
}

/*
	Name: on_disconnect
	Namespace: namespace_ca03bbb4
	Checksum: 0x32B0DD06
	Offset: 0x1D38
	Size: 0x34
	Parameters: 0
	Flags: Linked, Private
*/
function private on_disconnect()
{
	if(function_18a1849f(self))
	{
		function_ac5deb51();
	}
}

/*
	Name: function_ac5deb51
	Namespace: namespace_ca03bbb4
	Checksum: 0x7E18A215
	Offset: 0x1D78
	Size: 0xD4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_ac5deb51(var_e19b7aed = 1)
{
	switch(level.var_9eccff99.n_step)
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
	level.var_9eccff99.e_player = undefined;
	if(var_e19b7aed)
	{
		function_b60df00d();
	}
}

/*
	Name: function_cbeb9a33
	Namespace: namespace_ca03bbb4
	Checksum: 0x3C353ED8
	Offset: 0x1E58
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_cbeb9a33()
{
	level waittill(#"insanity_mode_triggered");
	exploder::stop_exploder("fxexp_quest_raygun_m2_v_stage_1" + level.var_9eccff99.s_start.exploder_id);
	if(isdefined(level.var_9eccff99.var_fead3ae9) && isdefined(level.var_9eccff99.var_fead3ae9.s_unitrigger))
	{
		zm_unitrigger::unregister_unitrigger(level.var_9eccff99.var_fead3ae9.s_unitrigger);
		level.var_9eccff99.var_fead3ae9 delete();
	}
	function_ac5deb51(0);
}

