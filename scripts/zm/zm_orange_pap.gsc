// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_orange_pablo.gsc;
#using script_4333a03353e1e13a;
#using script_4b80fc97d8469299;
#using scripts\zm_common\zm_ui_inventory.gsc;
#using scripts\zm_common\zm_vo.gsc;
#using scripts\zm\zm_hms_util.gsc;
#using scripts\zm_common\zm_sq.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm\zm_orange_lighthouse.gsc;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm\zm_orange_zones.gsc;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_orange_pap;

/*
	Name: init
	Namespace: zm_orange_pap
	Checksum: 0x72ED4F63
	Offset: 0x3C0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_clientfields();
}

/*
	Name: init_clientfields
	Namespace: zm_orange_pap
	Checksum: 0xB80F871
	Offset: 0x3E0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("world", "zm_orange_extinguish_fire", 24000, 2, "counter");
	clientfield::register("scriptmover", "zm_orange_pap_rock_glow", 24000, 1, "int");
}

/*
	Name: main
	Namespace: zm_orange_pap
	Checksum: 0x7BDDD23F
	Offset: 0x450
	Size: 0x2FC
	Parameters: 0
	Flags: Linked
*/
function main()
{
	init_flags();
	function_f415e4d5();
	function_5c189332();
	a_t_pap_rock_damage = getentarray("t_pap_rock_damage", "targetname");
	level.t_pap_rock_damage = array::random(a_t_pap_rock_damage);
	arrayremovevalue(a_t_pap_rock_damage, level.t_pap_rock_damage);
	foreach(t_pap_rock_damage in a_t_pap_rock_damage)
	{
		var_5d8f658e = getent(t_pap_rock_damage.target, "targetname");
		var_5d8f658e delete();
		t_pap_rock_damage delete();
	}
	level.t_pap_rock_damage.var_5d8f658e = getent(level.t_pap_rock_damage.target, "targetname");
	zm_sq::register(#"pap_rock", #"step_1", #"hash_57c2f2030917f2e4", &function_f279da41, &function_45f8440b);
	zm_sq::register(#"pap_rock", #"step_2", #"hash_57c2f5030917f7fd", &function_b70e1954, &function_21b093ce);
	zm_sq::start(#"pap_rock", !zm_utility::is_standard());
	zm_orange_pablo::register_drop_off(11, #"hash_1e1bf447950e7c92", #"hash_611a8728e3043a26", &function_f001370f);
	while(!isdefined(level.var_f7c50c66))
	{
		waitframe(1);
	}
	level thread function_80a40c1c();
}

/*
	Name: init_flags
	Namespace: zm_orange_pap
	Checksum: 0x8D888D91
	Offset: 0x758
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_5a3d0402a5557739");
	level flag::init(#"hash_3028604821838259");
	level flag::init(#"hash_78cf83ad057b4f1f", 1);
}

/*
	Name: function_f415e4d5
	Namespace: zm_orange_pap
	Checksum: 0x50FAF66C
	Offset: 0x7D0
	Size: 0x204
	Parameters: 0
	Flags: Linked
*/
function function_f415e4d5()
{
	level.pack_a_punch.custom_power_think = &function_521dc79e;
	level.var_da305272 = 0;
	level.var_6ed7c585 = 0;
	var_4d8e32c8 = getentarray("zm_pack_a_punch", "targetname");
	level.var_4d8e32c8 = function_35a68dea(var_4d8e32c8);
	level.var_9d121dce thread function_5535522e();
	level.var_9f657597 = struct::get_array("pap_ice", "targetname");
	level scene::add_scene_func("p8_fxanim_pap_ice_bundle", &function_c6e61ebb, "init");
	foreach(var_143bf55a in level.var_9f657597)
	{
		if(isdefined(var_143bf55a.target))
		{
			clip_brush = getent(var_143bf55a.target, "targetname");
			clip_brush disconnectpaths();
		}
	}
	if(zm_custom::function_901b751c(#"zmpapenabled") == 2)
	{
		callback::function_74872db6(&function_88228c58);
	}
}

/*
	Name: function_88228c58
	Namespace: zm_orange_pap
	Checksum: 0x2071ED20
	Offset: 0x9E0
	Size: 0xC4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_88228c58()
{
	foreach(var_5e879929 in level.var_4d8e32c8)
	{
		if(var_5e879929.script_noteworthy === "pap_beach")
		{
			var_5e879929 function_e3921120(1, 1);
			break;
		}
	}
	callback::function_50fdac80(&function_88228c58);
}

/*
	Name: function_c6e61ebb
	Namespace: zm_orange_pap
	Checksum: 0xDB89D5A0
	Offset: 0xAB0
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function function_c6e61ebb(a_ents)
{
	self.entity = a_ents[#"prop 1"];
}

/*
	Name: function_521dc79e
	Namespace: zm_orange_pap
	Checksum: 0x80F724D1
	Offset: 0xAE8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_521dc79e()
{
}

/*
	Name: function_35a68dea
	Namespace: zm_orange_pap
	Checksum: 0x7A6C19
	Offset: 0xAF8
	Size: 0x32A
	Parameters: 1
	Flags: Linked
*/
function function_35a68dea(var_4d8e32c8)
{
	var_136c421f = [];
	var_92b2c0d6 = [];
	var_a52265b5 = [];
	var_81591e23 = [];
	foreach(var_5e879929 in var_4d8e32c8)
	{
		if(var_5e879929.script_noteworthy === "pap_boathouse")
		{
			var_136c421f[0] = var_5e879929;
			var_92b2c0d6[1] = var_5e879929;
			var_a52265b5[2] = var_5e879929;
			var_81591e23[3] = var_5e879929;
			var_5e879929 zm_pack_a_punch::set_state_initial();
			waitframe(1);
			continue;
		}
		if(var_5e879929.script_noteworthy === "pap_beach")
		{
			var_136c421f[1] = var_5e879929;
			var_92b2c0d6[2] = var_5e879929;
			var_a52265b5[3] = var_5e879929;
			var_81591e23[0] = var_5e879929;
			var_5e879929 zm_pack_a_punch::set_state_initial();
			waitframe(1);
			continue;
		}
		if(var_5e879929.script_noteworthy === "pap_ship")
		{
			var_136c421f[2] = var_5e879929;
			var_92b2c0d6[3] = var_5e879929;
			var_a52265b5[0] = var_5e879929;
			var_81591e23[1] = var_5e879929;
			var_5e879929 zm_pack_a_punch::set_state_initial();
			waitframe(1);
			continue;
		}
		if(var_5e879929.script_noteworthy === "pap_lagoon")
		{
			var_136c421f[3] = var_5e879929;
			var_92b2c0d6[0] = var_5e879929;
			var_a52265b5[1] = var_5e879929;
			var_81591e23[2] = var_5e879929;
			var_5e879929 zm_pack_a_punch::set_state_initial();
			waitframe(1);
			continue;
		}
		if(var_5e879929.script_noteworthy === "pap_island")
		{
			level.var_9d121dce = var_5e879929;
			var_136c421f[4] = var_5e879929;
			var_92b2c0d6[4] = var_5e879929;
			var_a52265b5[4] = var_5e879929;
			var_81591e23[4] = var_5e879929;
		}
	}
	var_b2c4f3ae = array(var_136c421f, var_92b2c0d6, var_a52265b5, var_81591e23);
	return array::random(var_b2c4f3ae);
}

/*
	Name: function_5c189332
	Namespace: zm_orange_pap
	Checksum: 0x80B5EACE
	Offset: 0xE30
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function function_5c189332()
{
	level.var_20ca9ca3 = 0;
	level.var_680cd28 = getentarray("water_pipe", "targetname");
	level.var_6e6427a9 = getentarray("water_pipe_destroyed", "targetname");
	foreach(var_940bb44a in level.var_6e6427a9)
	{
		var_940bb44a hide();
	}
	exploder::stop_exploder("fxexp_fire_fx_ship_stage_1");
	exploder::stop_exploder("fxexp_fire_fx_ship_stage_2");
	level.var_9cc989a5 = getent("ship_fore_fire_clip", "targetname");
	level.var_a385f14 = getent("water_pipe_damage_trigger", "targetname");
	level.var_a385f14 thread function_3f5218e3();
}

/*
	Name: function_3f5218e3
	Namespace: zm_orange_pap
	Checksum: 0x15A4C72C
	Offset: 0xFC0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_3f5218e3()
{
	self endon(#"death");
	self waittill(#"damage", #"force_extinguisher");
	self thread function_7f6c9513();
}

/*
	Name: function_7f6c9513
	Namespace: zm_orange_pap
	Checksum: 0xAC61E2B0
	Offset: 0x1018
	Size: 0x1AC
	Parameters: 0
	Flags: Linked
*/
function function_7f6c9513()
{
	exploder::exploder("fxexp_water_pipe_gush");
	wait(0.1);
	foreach(var_769eb6a9 in level.var_680cd28)
	{
		var_769eb6a9 hide();
	}
	foreach(var_940bb44a in level.var_6e6427a9)
	{
		var_940bb44a show();
	}
	exploder::exploder("fxexp_water_pipe_gush");
	wait(1);
	exploder::exploder("fxexp_fire_fx_ship_stage_1");
	wait(1);
	exploder::exploder("fxexp_fire_fx_ship_stage_2");
	level flag::set(#"hash_6f7fd3d4d070db87");
	level.var_9cc989a5 delete();
}

/*
	Name: function_56db9cdc
	Namespace: zm_orange_pap
	Checksum: 0xE6CFB799
	Offset: 0x11D0
	Size: 0x44C
	Parameters: 0
	Flags: Linked
*/
function function_56db9cdc()
{
	level endon(#"end_game", #"hash_5266a594b96823e2", #"hash_661044fd7c7faa55");
	if(zm_custom::function_901b751c(#"zmpapenabled") == 2)
	{
		return;
	}
	while(true)
	{
		playsoundatposition("zmb_pap_lightning_2", (0, 0, 0));
		function_1556161f();
		zm_orange_lighthouse::function_da304f6e(2);
		level.var_7d8bf93f function_e3921120(1);
		level flag::clear(#"hash_78cf83ad057b4f1f");
		if(level flag::get(#"hash_4898001eb77cb16f"))
		{
			s_notify = undefined;
			s_notify = level waittill(#"hash_39b6629ce957cce9");
		}
		else
		{
			if(level.var_7d8bf93f == level.var_9d121dce)
			{
				level flag::set(#"hash_3028604821838259");
				level thread function_50779c1f();
				level.var_ab11c23d playsound(#"hash_6a8b750c09391a81");
				playsoundatposition(#"hash_1172b7ba38df5cd4", (-105, -3451, 607));
				s_notify = undefined;
				s_notify = level waittilltimeout(120, #"hash_39b6629ce957cce9");
				if(level flag::get(#"hash_2923f30473421396"))
				{
					level waittill(#"hash_355e5e0bbf3760db");
				}
				if(isdefined(level.var_ab11c23d.b_blue) && level.var_ab11c23d.b_blue)
				{
					exploder::stop_exploder("fxexp_pap_light_icefloe");
				}
				level notify(#"hash_7cbd2282015eb30a");
			}
			else
			{
				s_notify = undefined;
				s_notify = level waittilltimeout(180, #"hash_39b6629ce957cce9");
				if(level.var_7d8bf93f flag::get("Pack_A_Punch_on"))
				{
					level.var_7d8bf93f flag::wait_till("pap_waiting_for_user");
				}
			}
		}
		if(level flag::get(#"hash_3028604821838259"))
		{
			level flag::clear(#"hash_3028604821838259");
		}
		if(isinarray(level.var_4d8e32c8, level.var_7d8bf93f))
		{
			level.var_7d8bf93f function_e3921120(0);
		}
		level flag::set(#"hash_78cf83ad057b4f1f");
		if(level flag::get(#"hash_5a3d0402a5557739"))
		{
			level.var_ab11c23d clientfield::set("lighthouse_on", 2);
		}
		zm_orange_lighthouse::function_da304f6e(0);
		if(s_notify._notify !== #"hash_39b6629ce957cce9")
		{
			level waittilltimeout(30, #"hash_39b6629ce957cce9");
		}
	}
}

/*
	Name: function_e3921120
	Namespace: zm_orange_pap
	Checksum: 0xAB9E11E8
	Offset: 0x1628
	Size: 0x2CC
	Parameters: 2
	Flags: Linked
*/
function function_e3921120(b_show, var_35c3faab = 0)
{
	if(level flag::get(#"hash_5a3d0402a5557739") || var_35c3faab)
	{
		var_611e46b7 = undefined;
		foreach(var_143bf55a in level.var_9f657597)
		{
			if(var_143bf55a.script_noteworthy == (self.script_noteworthy + "_debris"))
			{
				var_611e46b7 = var_143bf55a;
				break;
			}
		}
		if(b_show)
		{
			if(self == level.var_9d121dce)
			{
				exploder::exploder("fxexp_pap_light_icefloe");
			}
			if(isdefined(var_611e46b7))
			{
				var_611e46b7 function_69a4b74b(0);
				if(isdefined(var_611e46b7.target))
				{
					clip_brush = getent(var_611e46b7.target, "targetname");
					clip_brush thread function_4d7320f5(0);
				}
			}
			self zm_pack_a_punch::function_bb629351(1);
			if(level flag::get(#"hash_4898001eb77cb16f"))
			{
				level flag::wait_till(#"hash_11d64d1f93c196cc");
				self namespace_4b68b2b3::function_3177f73c();
			}
		}
		else
		{
			self zm_pack_a_punch::function_bb629351(0, "initial");
			if(self == level.var_9d121dce)
			{
				exploder::exploder_stop("fxexp_pap_light_icefloe");
			}
			if(isdefined(var_611e46b7))
			{
				var_611e46b7 thread function_69a4b74b(1);
				if(isdefined(var_611e46b7.target))
				{
					clip_brush = getent(var_611e46b7.target, "targetname");
					clip_brush thread function_4d7320f5(1);
				}
			}
		}
	}
}

/*
	Name: function_69a4b74b
	Namespace: zm_orange_pap
	Checksum: 0x30E30D99
	Offset: 0x1900
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_69a4b74b(var_16c2b0ed)
{
	if(var_16c2b0ed)
	{
		self.entity playsound(#"hash_6905307107bb03e");
		self scene::play("freeze");
	}
	else
	{
		self.entity playsound(#"hash_4a246aa22a63bedb");
		self scene::play("melt");
	}
}

/*
	Name: function_4d7320f5
	Namespace: zm_orange_pap
	Checksum: 0x867C1053
	Offset: 0x19B8
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_4d7320f5(var_5ba3fe65)
{
	if(var_5ba3fe65)
	{
		self solid();
		self disconnectpaths();
	}
	else
	{
		self notsolid();
		self connectpaths();
	}
}

/*
	Name: function_1556161f
	Namespace: zm_orange_pap
	Checksum: 0xC990A95B
	Offset: 0x1A38
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_1556161f()
{
	level endon(#"hash_5266a594b96823e2");
	if(!isdefined(level.var_f6f7a368) || level.var_f6f7a368 >= (level.var_4d8e32c8.size - 1))
	{
		level.var_f6f7a368 = 0;
	}
	else
	{
		level.var_f6f7a368++;
	}
	level.var_7d8bf93f = level.var_4d8e32c8[level.var_f6f7a368];
	if(!level.var_6ed7c585 && level.var_7d8bf93f == level.var_9d121dce && level.var_4d8e32c8.size > 1)
	{
		wait(1);
		function_1556161f();
	}
}

/*
	Name: function_50779c1f
	Namespace: zm_orange_pap
	Checksum: 0x354D4FBB
	Offset: 0x1B20
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_50779c1f()
{
	level endon(#"hash_7cbd2282015eb30a");
	level flag::wait_till(#"hash_2923f30473421396");
	level thread function_ec4984c3();
}

/*
	Name: function_ec4984c3
	Namespace: zm_orange_pap
	Checksum: 0xFD666C0A
	Offset: 0x1B80
	Size: 0x294
	Parameters: 0
	Flags: Linked
*/
function function_ec4984c3()
{
	level endon(#"end_game");
	level flag::set(#"infinite_round_spawning");
	level flag::set(#"pause_round_timeout");
	zm_bgb_anywhere_but_here::function_886fce8f(0);
	level.var_382a24b0 = 1;
	level.a_func_score_events[#"damage_points"] = &function_ab30f95c;
	level.a_func_score_events[#"death"] = &function_704c6738;
	level thread apc_restart_retreat();
	level waittilltimeout(120, #"hash_7646638df88a3656");
	music::setmusicstate("none");
	level.musicsystemoverride = 0;
	level flag::clear(#"infinite_round_spawning");
	level flag::clear(#"pause_round_timeout");
	level.a_func_score_events[#"damage_points"] = undefined;
	level.a_func_score_events[#"death"] = undefined;
	level.var_382a24b0 = undefined;
	level flag::clear(#"hash_2923f30473421396");
	level notify(#"hash_355e5e0bbf3760db");
	level.var_7d8bf93f flag::wait_till("pap_waiting_for_user");
	level flag::wait_till(#"hash_78cf83ad057b4f1f");
	wait(3);
	zm_bgb_anywhere_but_here::function_886fce8f(1);
	zm_orange_zones::function_3b77181c(0);
	zm_utility::function_9ad5aeb1(1, 0, 1, 0, 0);
}

/*
	Name: function_80a40c1c
	Namespace: zm_orange_pap
	Checksum: 0x1E9F4CC3
	Offset: 0x1E20
	Size: 0x10A
	Parameters: 0
	Flags: Linked
*/
function function_80a40c1c()
{
	level endon(#"end_game", #"hash_1d9afa9be4c10160");
	while(true)
	{
		if(level.zones[#"ice_floe"].is_enabled === 0)
		{
			foreach(e_player in getplayers())
			{
				if(e_player istouching(level.var_f7c50c66))
				{
					e_player namespace_6036de69::fling_player(level.var_f7c50c66);
				}
			}
		}
		wait(1);
	}
}

/*
	Name: function_ab30f95c
	Namespace: zm_orange_pap
	Checksum: 0x2E1E74CA
	Offset: 0x1F38
	Size: 0x2E
	Parameters: 5
	Flags: Linked
*/
function function_ab30f95c(event, mod, hit_location, zombie_team, damage_weapon)
{
	return false;
}

/*
	Name: function_704c6738
	Namespace: zm_orange_pap
	Checksum: 0x50DB60BF
	Offset: 0x1F70
	Size: 0x30
	Parameters: 5
	Flags: Linked
*/
function function_704c6738(event, mod, hit_location, zombie_team, damage_weapon)
{
	return 50;
}

/*
	Name: apc_restart_retreat
	Namespace: zm_orange_pap
	Checksum: 0xCC545280
	Offset: 0x1FA8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function apc_restart_retreat()
{
	wait(4);
	level.musicsystemoverride = 1;
	music::setmusicstate("golden_pap_defend");
	level thread zm_orange_util::function_fd24e47f(#"hash_84fa084a2617bf4", -1, 0, 1);
}

/*
	Name: function_2401694f
	Namespace: zm_orange_pap
	Checksum: 0xCA4E356
	Offset: 0x2010
	Size: 0x28
	Parameters: 0
	Flags: Linked
*/
function function_2401694f()
{
	level.var_f6f7a368 = 3;
	level notify(#"hash_39b6629ce957cce9");
}

/*
	Name: function_f279da41
	Namespace: zm_orange_pap
	Checksum: 0xA84A4E9A
	Offset: 0x2040
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_f279da41(var_5ea5c94d)
{
	/#
		iprintlnbold("");
	#/
	if(!var_5ea5c94d)
	{
		level flag::init(#"hash_3310bb35ce396e49");
		level.t_pap_rock_damage.var_5d8f658e clientfield::set("zm_orange_pap_rock_glow", 1);
		level.t_pap_rock_damage thread function_513d3be1();
		level flag::wait_till(#"hash_3310bb35ce396e49");
	}
}

/*
	Name: function_45f8440b
	Namespace: zm_orange_pap
	Checksum: 0x9570F0C0
	Offset: 0x2108
	Size: 0xE4
	Parameters: 2
	Flags: Linked
*/
function function_45f8440b(var_5ea5c94d, ended_early)
{
	/#
		iprintlnbold("");
	#/
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_3310bb35ce396e49");
	}
	if(isdefined(level.t_pap_rock_damage.var_5d8f658e.s_unitrigger))
	{
		zm_unitrigger::unregister_unitrigger(level.t_pap_rock_damage.var_5d8f658e.s_unitrigger);
	}
	level.t_pap_rock_damage.var_5d8f658e delete();
	level.t_pap_rock_damage delete();
}

/*
	Name: function_b70e1954
	Namespace: zm_orange_pap
	Checksum: 0x8002A736
	Offset: 0x21F8
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_b70e1954(var_5ea5c94d)
{
	/#
		iprintlnbold("");
	#/
	if(!var_5ea5c94d)
	{
		zm_orange_pablo::function_d83490c5(11);
		level flag::wait_till(#"hash_5a3d0402a5557739");
	}
}

/*
	Name: function_21b093ce
	Namespace: zm_orange_pap
	Checksum: 0xE2556767
	Offset: 0x2270
	Size: 0x25C
	Parameters: 2
	Flags: Linked
*/
function function_21b093ce(var_5ea5c94d, ended_early)
{
	/#
		iprintlnbold("");
	#/
	if(ended_early)
	{
		zm_orange_pablo::function_6aaeff92(11);
		level flag::set(#"hash_5a3d0402a5557739");
	}
	s_pap_rock_dropoff = struct::get("s_pap_rock_dropoff");
	if(isdefined(s_pap_rock_dropoff.s_unitrigger))
	{
		zm_unitrigger::unregister_unitrigger(s_pap_rock_dropoff.s_unitrigger);
	}
	if(level.var_98138d6b > 0)
	{
		if(level.var_ab11c23d.var_3931cef9 == 2)
		{
			level.var_ab11c23d clientfield::set("lighthouse_on", 3);
			level.var_7d8bf93f function_e3921120(1);
		}
		else
		{
			level.var_ab11c23d clientfield::set("lighthouse_on", 2);
		}
		zm_orange_lighthouse::function_1f29d511();
	}
	n_variant = function_21a3a673(0, 2);
	if(!(isdefined(level.var_3c9cfd6f) && level.var_3c9cfd6f))
	{
		level.pablo_npc zm_vo::vo_stop();
		level.pablo_npc zm_audio::do_player_or_npc_playvox(#"hash_6ab0c09b3c332af6" + n_variant);
		if(level.var_98138d6b < 3)
		{
			n_variant = 3;
			if(level.var_98138d6b == 2)
			{
				n_variant = 4;
			}
			level.pablo_npc zm_audio::do_player_or_npc_playvox(#"hash_6ab0c09b3c332af6" + n_variant);
		}
	}
}

/*
	Name: function_513d3be1
	Namespace: zm_orange_pap
	Checksum: 0xB15A8512
	Offset: 0x24D8
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_513d3be1()
{
	self endon(#"death");
	self waittill(#"damage");
	level.t_pap_rock_damage.var_5d8f658e thread function_451e442e();
}

/*
	Name: function_451e442e
	Namespace: zm_orange_pap
	Checksum: 0x412D2A20
	Offset: 0x2530
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_451e442e()
{
	self endon(#"death");
	self playsound(#"hash_2dcb0b4d2e7a146f");
	var_a374dafc = struct::get(self.target);
	self moveto(var_a374dafc.origin, 0.2);
	self waittill(#"movedone");
	self zm_unitrigger::create(zm_utility::function_d6046228(#"hash_20aa96975beb9059", #"hash_55802e320dc6f767"), 100);
	self thread function_feee6e66();
}

/*
	Name: function_feee6e66
	Namespace: zm_orange_pap
	Checksum: 0x569E7C55
	Offset: 0x2638
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function function_feee6e66()
{
	self endon(#"death");
	var_adea2587 = undefined;
	var_adea2587 = self waittill(#"trigger_activated");
	zm_ui_inventory::function_7df6bb60("zm_orange_pap_rock", 1);
	self playsound(#"hash_5c0903506e9a705a");
	if(level flag::get(#"hash_641f14d0b2fd57d7"))
	{
		var_adea2587.e_who thread zm_orange_util::function_51b752a9(#"hash_1558be2f4ebc39b5");
	}
	else
	{
		var_adea2587.e_who thread zm_orange_util::function_51b752a9(#"hash_7e030fccc2c5a121");
	}
	level flag::set(#"hash_3310bb35ce396e49");
}

/*
	Name: function_f001370f
	Namespace: zm_orange_pap
	Checksum: 0x1630885E
	Offset: 0x2758
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_f001370f()
{
	level flag::set(#"hash_5a3d0402a5557739");
	zm_ui_inventory::function_7df6bb60("zm_orange_pap_rock", 0);
}

/*
	Name: function_5535522e
	Namespace: zm_orange_pap
	Checksum: 0x769C6B69
	Offset: 0x27A0
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function function_5535522e()
{
	self endon(#"death");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"pap_taken");
		s_result.e_player thread zm_orange_util::function_51b752a9("vox_golden_pap_weapon");
	}
}

/*
	Name: function_80a08789
	Namespace: zm_orange_pap
	Checksum: 0x8D2C6AC7
	Offset: 0x2818
	Size: 0x8
	Parameters: 0
	Flags: None
*/
function function_80a08789()
{
	/#
	#/
}

/*
	Name: function_79946aff
	Namespace: zm_orange_pap
	Checksum: 0xD724EE3B
	Offset: 0x2828
	Size: 0x16
	Parameters: 0
	Flags: None
*/
function function_79946aff()
{
	/#
		level.var_f6f7a368 = 3;
	#/
}

/*
	Name: function_ccc079bc
	Namespace: zm_orange_pap
	Checksum: 0x191ADBD4
	Offset: 0x2848
	Size: 0xB8
	Parameters: 1
	Flags: None
*/
function function_ccc079bc(var_b876e1f5)
{
	/#
		n_index = 0;
		for(i = 0; i < level.var_4d8e32c8.size; i++)
		{
			if(level.var_4d8e32c8[i].script_noteworthy == var_b876e1f5)
			{
				n_index = i - 1;
				if(n_index < 0)
				{
					n_index = n_index + 4;
				}
				break;
			}
		}
		level.var_f6f7a368 = n_index;
		level notify(#"hash_39b6629ce957cce9");
	#/
}

/*
	Name: function_eaaea036
	Namespace: zm_orange_pap
	Checksum: 0x7E3FC40B
	Offset: 0x2908
	Size: 0x88
	Parameters: 0
	Flags: None
*/
function function_eaaea036()
{
	/#
		foreach(var_143bf55a in level.var_9f657597)
		{
			var_143bf55a scene::play("");
		}
	#/
}

/*
	Name: function_96ef31b7
	Namespace: zm_orange_pap
	Checksum: 0x5EEEADFC
	Offset: 0x2998
	Size: 0x88
	Parameters: 0
	Flags: None
*/
function function_96ef31b7()
{
	/#
		foreach(var_143bf55a in level.var_9f657597)
		{
			var_143bf55a scene::play("");
		}
	#/
}

