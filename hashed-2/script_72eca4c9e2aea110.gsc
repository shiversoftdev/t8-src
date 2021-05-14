// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1c72973fb240f263;
#using script_35598499769dbb3d;
#using script_3f9e0dc8454d98e1;
#using script_467027ea7017462b;
#using script_4d000493c57bb851;
#using script_52c6c2d1a2ef1b46;
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using script_6e3c826b1814cab6;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_orange_challenges.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_be178848;

/*
	Name: init
	Namespace: namespace_be178848
	Checksum: 0x304168E4
	Offset: 0x3E0
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("scriptmover", "" + #"dynamite_explosion_fx", 24000, 1, "counter");
	clientfield::register("actor", "" + #"hash_6adfdd12c9656e1c", 24000, 1, "int");
	clientfield::register("actor", "" + #"hash_147a734966a62e10", 24000, 1, "counter");
}

/*
	Name: main
	Namespace: namespace_be178848
	Checksum: 0x6053BC63
	Offset: 0x4B0
	Size: 0x4E4
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level flag::init(#"hash_98e32feb5b8ac79");
	level flag::init(#"hash_16c15e4538336bb5");
	level.var_d867b9f3 = array(zm_crafting::function_4c2f8683("zitem_orange_dynamite_bomb_part_1"), zm_crafting::function_4c2f8683("zitem_orange_dynamite_bomb_part_2"), zm_crafting::function_4c2f8683("zitem_orange_dynamite_bomb_part_3"));
	level.var_1daa43ee = 1;
	callback::function_74872db6(&function_74872db6);
	zm_items::function_4d230236(level.var_d867b9f3[0], &function_168f686b);
	zm_items::function_4d230236(level.var_d867b9f3[1], &function_168f686b);
	zm_items::function_4d230236(level.var_d867b9f3[2], &function_168f686b);
	zm_crafting::function_d1f16587(#"hash_2ca3c1e10bdf8cdb", &function_7056aa62);
	zm_crafting::function_d1f16587(#"hash_1255a9a8cf55727d", &function_7056aa62);
	function_e55e2a5e();
	level.var_518d6e34 = 0;
	level.var_37078af7 = 0;
	level.var_b3e4b8b8 = [];
	var_b3e4b8b8 = struct::get_array("dynamite_bomb_place");
	foreach(var_b2ec126b in var_b3e4b8b8)
	{
		if(!isdefined(level.var_b3e4b8b8[var_b2ec126b.script_int]))
		{
			level.var_b3e4b8b8[var_b2ec126b.script_int] = [];
		}
		else if(!isarray(level.var_b3e4b8b8[var_b2ec126b.script_int]))
		{
			level.var_b3e4b8b8[var_b2ec126b.script_int] = array(level.var_b3e4b8b8[var_b2ec126b.script_int]);
		}
		if(!isdefined(level.var_b3e4b8b8[var_b2ec126b.script_int]))
		{
			level.var_b3e4b8b8[var_b2ec126b.script_int] = [];
		}
		else if(!isarray(level.var_b3e4b8b8[var_b2ec126b.script_int]))
		{
			level.var_b3e4b8b8[var_b2ec126b.script_int] = array(level.var_b3e4b8b8[var_b2ec126b.script_int]);
		}
		level.var_b3e4b8b8[var_b2ec126b.script_int][level.var_b3e4b8b8[var_b2ec126b.script_int].size] = var_b2ec126b;
	}
	array::run_all(var_b3e4b8b8, &dynamite_bomb_place_init);
	if(namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") == 2)
	{
		function_70f4c8c3("outer_walkway_blocker");
		function_70f4c8c3("sunken_path_blocker");
		function_70f4c8c3("cove_to_beach_blocker");
	}
	else
	{
		function_86270fbf("outer_walkway_blocker");
		function_86270fbf("sunken_path_blocker");
		function_86270fbf("cove_to_beach_blocker");
	}
}

/*
	Name: function_86270fbf
	Namespace: namespace_be178848
	Checksum: 0xE849D5B0
	Offset: 0x9A0
	Size: 0xC0
	Parameters: 1
	Flags: Linked
*/
function function_86270fbf(str_targetname)
{
	var_dc3827e3 = getentarray(str_targetname, "targetname");
	foreach(e_blocker in var_dc3827e3)
	{
		if(e_blocker.script_noteworthy === "clip")
		{
			e_blocker disconnectpaths();
		}
	}
}

/*
	Name: function_70f4c8c3
	Namespace: namespace_be178848
	Checksum: 0xDA9F1F28
	Offset: 0xA68
	Size: 0xF8
	Parameters: 1
	Flags: Linked
*/
function function_70f4c8c3(str_targetname)
{
	var_dc3827e3 = getentarray(str_targetname, "targetname");
	foreach(e_blocker in var_dc3827e3)
	{
		if(e_blocker.script_noteworthy === "clip")
		{
			e_blocker connectpaths();
			e_blocker delete();
			continue;
		}
		e_blocker setmodel("p8_zm_ora_dynamite_barrier_destroyed");
	}
}

/*
	Name: function_74872db6
	Namespace: namespace_be178848
	Checksum: 0xB6F22AD0
	Offset: 0xB68
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_74872db6()
{
	if(level.round_number > 2)
	{
		callback::on_ai_spawned(&function_e3203a2);
		callback::function_50fdac80(&function_74872db6);
	}
}

/*
	Name: function_e55e2a5e
	Namespace: namespace_be178848
	Checksum: 0x4B8CC761
	Offset: 0xBC8
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function function_e55e2a5e()
{
	level.var_1f17f9bb = array::randomize(level.var_d867b9f3);
	level.var_b4fe6eed = 1;
}

/*
	Name: function_e93a8e82
	Namespace: namespace_be178848
	Checksum: 0x6592C3DA
	Offset: 0xC08
	Size: 0x204
	Parameters: 2
	Flags: Linked
*/
function function_e93a8e82(v_pos, v_angles)
{
	if(isdefined(v_pos) && !zm_utility::is_standard())
	{
		v_drop = namespace_509a75d1::function_6d41bab8(v_pos, 360);
		if(isdefined(v_drop))
		{
			v_ground = groundtrace(v_drop + vectorscale((0, 0, 1), 64) + vectorscale((0, 0, 1), 8), v_drop + vectorscale((0, 0, 1), 64) + vectorscale((0, 0, -1), 100000), 0, self)[#"position"];
			v_ground = v_ground + vectorscale((0, 0, 1), 36);
			var_5ab22b80 = level.var_1f17f9bb[0];
			if(isdefined(var_5ab22b80))
			{
				var_ae79b49 = util::spawn_model(var_5ab22b80.worldmodel, v_ground);
				waitframe(1);
				s_unitrigger = var_ae79b49 namespace_2e9c09b3::function_f1827cc6(&function_ba26ccbb, &function_96b866fc, undefined, 96);
				var_ae79b49.targetname = "dynamite_item_drop";
				var_ae79b49.var_8691c7d4 = 1;
				var_ae79b49.var_5ab22b80 = var_5ab22b80;
				var_ae79b49 playloopsound(#"zmb_spawn_powerup_loop");
				var_ae79b49 thread namespace_86eed980::function_f5f83516();
				zm_unitrigger::reregister_unitrigger_as_dynamic(s_unitrigger);
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_ba26ccbb
	Namespace: namespace_be178848
	Checksum: 0x7B855D8F
	Offset: 0xE18
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function function_ba26ccbb(var_2e1f34dd, e_player)
{
	e_player giveweapon(var_2e1f34dd.var_5ab22b80);
}

/*
	Name: function_168f686b
	Namespace: namespace_be178848
	Checksum: 0xDF1A7611
	Offset: 0xE58
	Size: 0x13C
	Parameters: 2
	Flags: Linked
*/
function function_168f686b(e_holder, var_9c95ad05)
{
	level endon(#"end_game");
	b_silent = 0;
	arrayremoveindex(level.var_1f17f9bb, 0);
	if(level.var_1f17f9bb.size > 0)
	{
		level.var_1daa43ee = 1;
	}
	else
	{
		b_silent = 1;
	}
	wait(1);
	if(b_silent)
	{
		zm_audio::function_6191af93(#"hash_44b4edd3d705820d", #"dynamite", #"hash_44b4edd3d705820d", #"silent", 100);
		zm_audio::function_6191af93(#"hash_44b4edd3d705820d", #"hash_d97792bf058deeb", #"hash_44b4edd3d705820d", #"silent", 100);
	}
}

/*
	Name: function_96b866fc
	Namespace: namespace_be178848
	Checksum: 0x9C0667D7
	Offset: 0xFA0
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function function_96b866fc(e_player)
{
	str_hint = zm_utility::function_d6046228(#"hash_388256f1e5a62d7c", #"hash_7693de01f82d93f0");
	self sethintstring(str_hint);
	return 1;
}

/*
	Name: function_e3203a2
	Namespace: namespace_be178848
	Checksum: 0xC292541E
	Offset: 0x1008
	Size: 0x114
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e3203a2()
{
	self endon(#"death");
	if(level flag::get(#"hash_16c15e4538336bb5"))
	{
		return;
	}
	if(level.var_1daa43ee && self.archetype === #"zombie" && self.var_9fde8624 !== #"zombie_electric" && (math::cointoss(20) || level flag::get(#"hash_98e32feb5b8ac79")))
	{
		while(!isdefined(self.spawn_pos))
		{
			waitframe(1);
		}
		if(self.spawn_pos.zone_name !== "ice_floe")
		{
			self thread function_8427e524();
		}
	}
}

/*
	Name: function_8427e524
	Namespace: namespace_be178848
	Checksum: 0xD1F8B41E
	Offset: 0x1128
	Size: 0x2B6
	Parameters: 0
	Flags: Linked
*/
function function_8427e524()
{
	self notify(#"hash_63017bebd33d7316");
	self thread namespace_3263198e::function_865209df(#"hash_1366f89544cefb99", #"hash_c38f82bacfe540c");
	level.var_1daa43ee = 0;
	level flag::clear(#"hash_98e32feb5b8ac79");
	self.var_f3908ae9 = 1;
	self clientfield::set("" + #"hash_6adfdd12c9656e1c", 1);
	self function_4baeb885();
	self.ignoremelee = 1;
	self playloopsound(#"hash_494dd6f60ab1e3a8");
	self thread function_e58f823f();
	/#
		iprintln("");
	#/
	self waittill(#"death");
	if(isdefined(self))
	{
		self clientfield::set("" + #"hash_6adfdd12c9656e1c", 0);
		if(self.water_damage === 1)
		{
			self.e_killer = (isplayer(self.attacker) ? self.attacker : self.last_closest_player);
			self thread function_8f6cb08();
		}
		else if(self.var_c39323b5 !== 1)
		{
			gibserverutils::annihilate(self);
			self clientfield::increment("" + #"hash_147a734966a62e10", 1);
			level function_d8f300c3(self.origin);
			playsoundatposition(#"hash_7b838586b7ef0d9d", self.origin);
		}
		else
		{
			level flag::set(#"hash_98e32feb5b8ac79");
		}
		level.var_1daa43ee = 1;
	}
	else
	{
		level.var_1daa43ee = 1;
	}
}

/*
	Name: function_4baeb885
	Namespace: namespace_be178848
	Checksum: 0x762BFB56
	Offset: 0x13E8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_4baeb885()
{
	var_70b46d1c = "walk";
	if(self.zombie_move_speed == "sprint")
	{
		var_70b46d1c = "run";
	}
	else if(self.zombie_move_speed == "super_sprint")
	{
		var_70b46d1c = "sprint";
	}
	self zombie_utility::set_zombie_run_cycle_override_value(var_70b46d1c);
}

/*
	Name: function_e58f823f
	Namespace: namespace_be178848
	Checksum: 0xE344FE3D
	Offset: 0x1468
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_e58f823f()
{
	self endon(#"death");
	while(true)
	{
		e_target = self.favoriteenemy;
		if(isdefined(e_target) && distancesquared(e_target.origin, self.origin) <= 64 * 64)
		{
			self thread function_87f8b232();
			break;
		}
		wait(0.1);
	}
}

/*
	Name: function_87f8b232
	Namespace: namespace_be178848
	Checksum: 0x2F9FBA64
	Offset: 0x1508
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_87f8b232()
{
	self endon(#"death");
	self animation::play("ai_t8_zm_base_zombie_dynamite_death");
	self.allowdeath = 1;
	self kill();
}

/*
	Name: function_d8f300c3
	Namespace: namespace_be178848
	Checksum: 0x6FA372C7
	Offset: 0x1568
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function function_d8f300c3(v_pos)
{
	var_2b198109 = namespace_509a75d1::function_795d5b4f(getaiteamarray(level.zombie_team), v_pos, 250);
	array::run_all(var_2b198109, &dodamage, 500, v_pos, undefined, undefined, undefined, "MOD_EXPLOSIVE");
	a_e_players = namespace_509a75d1::function_795d5b4f(getplayers(), v_pos, 250);
	array::run_all(a_e_players, &dodamage, 50, v_pos, undefined, undefined, undefined, "MOD_EXPLOSIVE");
}

/*
	Name: function_8f6cb08
	Namespace: namespace_be178848
	Checksum: 0xB36BF0AE
	Offset: 0x1668
	Size: 0xC2
	Parameters: 0
	Flags: Linked
*/
function function_8f6cb08()
{
	self endon(#"death");
	self waittill(#"cleanup_freezegun_triggers");
	b_spawned = level function_e93a8e82(self.origin, self.angles);
	if(level.var_b4fe6eed && b_spawned && isdefined(self.e_killer))
	{
		self.e_killer thread namespace_3263198e::function_51b752a9(#"hash_4c18ae1377d349ed");
		level.var_b4fe6eed = 0;
	}
	level.var_1daa43ee = !b_spawned;
}

/*
	Name: function_7056aa62
	Namespace: namespace_be178848
	Checksum: 0xAFE5D86D
	Offset: 0x1738
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function function_7056aa62()
{
	if(isdefined(self.stub) && isdefined(self.stub.blueprint))
	{
		var_4b912983 = self.stub;
	}
	else if(isdefined(self.blueprint))
	{
		var_4b912983 = self;
	}
	if(var_4b912983.blueprint.name == #"zblueprint_orange_dynamite_bomb")
	{
		var_f2d24a17 = self.stub.var_4b9b60c7;
		var_f2d24a17 show();
		var_f2d24a17 zm_unitrigger::create(zm_utility::function_d6046228(#"hash_6eced05b46f243a8", #"hash_5402978e2dbb34e4"));
		var_f2d24a17 thread function_4c525901();
		namespace_6747c550::function_7df6bb60("orange_dynamite_bomb_part_1_owned", 0);
		namespace_6747c550::function_7df6bb60("orange_dynamite_bomb_part_2_owned", 0);
		namespace_6747c550::function_7df6bb60("orange_dynamite_bomb_part_3_owned", 0);
		namespace_6747c550::function_7df6bb60("dynamite_bomb_phase", 1);
	}
}

/*
	Name: function_4c525901
	Namespace: namespace_be178848
	Checksum: 0x68238A5E
	Offset: 0x18A8
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_4c525901()
{
	self endon(#"death");
	var_be17187b = undefined;
	var_be17187b = self waittill(#"trigger_activated");
	self playsound(#"hash_55c30dada4e624a2");
	var_be17187b.e_who zm_audio::create_and_play_dialog(#"explosive", #"pickup");
	level.var_518d6e34 = 1;
	namespace_6747c550::function_7df6bb60("orange_dynamite_bomb_complete", 1);
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	self hide();
}

/*
	Name: dynamite_bomb_place_init
	Namespace: namespace_be178848
	Checksum: 0xF6A19F0F
	Offset: 0x19A0
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function dynamite_bomb_place_init()
{
	self zm_unitrigger::create(&function_2a27ccb9);
	self thread function_170afe2c();
}

/*
	Name: function_2a27ccb9
	Namespace: namespace_be178848
	Checksum: 0xD206A0FA
	Offset: 0x19E8
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_2a27ccb9(e_player)
{
	if(level.var_518d6e34)
	{
		str_hint = zm_utility::function_d6046228(#"hash_619666ebfb26ad4", #"hash_cb4301a3d4b0ff8");
		self sethintstring(str_hint);
		return 1;
	}
	return 0;
}

/*
	Name: function_170afe2c
	Namespace: namespace_be178848
	Checksum: 0xFC2D337D
	Offset: 0x1A68
	Size: 0x11E
	Parameters: 1
	Flags: Linked
*/
function function_170afe2c(b_main_quest = 0)
{
	level endon(#"end_game");
	s_result = undefined;
	s_result = self waittill(#"trigger_activated");
	function_6ecfea46();
	if(!b_main_quest)
	{
		self thread function_65026f4d();
		s_result.e_who zm_audio::create_and_play_dialog(#"explosive", #"plant");
	}
	else
	{
		self thread function_2e1427a3();
	}
	level.var_518d6e34 = 0;
	namespace_6747c550::function_7df6bb60("orange_dynamite_bomb_complete", 0);
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	self.s_unitrigger = undefined;
}

/*
	Name: function_2e1427a3
	Namespace: namespace_be178848
	Checksum: 0xD77C584F
	Offset: 0x1B90
	Size: 0x1EC
	Parameters: 0
	Flags: Linked
*/
function function_2e1427a3()
{
	level endon(#"end_game");
	e_bomb = util::spawn_model("p8_zm_ora_dynamite_bundle", self.origin, self.angles);
	playsoundatposition(#"hash_34d44148875755b0", e_bomb.origin);
	e_bomb playloopsound(#"hash_3e8cb0a639b5a355");
	/#
		iprintln("");
	#/
	wait(1);
	/#
		iprintln("");
	#/
	wait(1);
	/#
		iprintln("");
	#/
	wait(1);
	e_bomb clientfield::increment("" + #"dynamite_explosion_fx", 1);
	level function_d8f300c3(self.origin);
	playsoundatposition(#"hash_2b694b905abf1892", e_bomb.origin);
	e_bomb playrumbleonentity("zm_orange_dynamite_bomb_explosion");
	wait(0.1);
	e_bomb hide();
	self notify(#"hash_126c823a82e09010");
	wait(2.5);
	e_bomb delete();
}

/*
	Name: function_65026f4d
	Namespace: namespace_be178848
	Checksum: 0x8BEC2020
	Offset: 0x1D88
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_65026f4d()
{
	self endon(#"death");
	var_b3e4b8b8 = level.var_b3e4b8b8[self.script_int];
	if(self.script_noteworthy === "linked")
	{
		array::thread_all(var_b3e4b8b8, &function_2e1427a3);
	}
	else
	{
		self thread function_2e1427a3();
	}
	array::run_all(var_b3e4b8b8, &namespace_509a75d1::function_7a5ba111);
	self waittill(#"hash_126c823a82e09010");
	level thread function_61511fcf(self.script_int);
}

/*
	Name: function_61511fcf
	Namespace: namespace_be178848
	Checksum: 0x117DF6AE
	Offset: 0x1E68
	Size: 0x10A
	Parameters: 1
	Flags: Linked
*/
function function_61511fcf(n_index)
{
	switch(n_index)
	{
		case 0:
		{
			function_70f4c8c3("outer_walkway_blocker");
			level flag::set(#"hash_52d967f4fc8b12fc");
			break;
		}
		case 1:
		{
			function_70f4c8c3("sunken_path_blocker");
			level flag::set(#"hash_48e7d63b38c5e2da");
			break;
		}
		case 2:
		{
			function_70f4c8c3("cove_to_beach_blocker");
			level flag::set(#"hash_38c97197db36afb7");
			break;
		}
	}
}

/*
	Name: function_6ecfea46
	Namespace: namespace_be178848
	Checksum: 0x37871FF9
	Offset: 0x1F80
	Size: 0x274
	Parameters: 0
	Flags: Linked
*/
function function_6ecfea46()
{
	level.var_37078af7++;
	if(level.var_37078af7 < 4)
	{
		function_e55e2a5e();
		if(isarray(level.var_4fe2f84d[#"hash_1255a9a8cf55727d"]))
		{
			foreach(s_crafting in level.var_4fe2f84d[#"hash_1255a9a8cf55727d"])
			{
				if(isdefined(s_crafting.blueprint) && s_crafting.blueprint.name === "zblueprint_orange_dynamite_bomb" && (!(isdefined(s_crafting.registered) && s_crafting.registered)))
				{
					s_crafting zm_crafting::function_6dccf508();
				}
			}
		}
		else
		{
			foreach(s_crafting in level.var_4fe2f84d[#"hash_2ca3c1e10bdf8cdb"])
			{
				if(isdefined(s_crafting.blueprint) && s_crafting.blueprint.name === "zblueprint_orange_dynamite_bomb" && (!(isdefined(s_crafting.registered) && s_crafting.registered)))
				{
					s_crafting zm_crafting::function_6dccf508();
				}
			}
		}
		level.var_1daa43ee = 1;
		namespace_6747c550::function_7df6bb60("dynamite_bomb_phase", 0);
	}
	else
	{
		callback::remove_on_ai_spawned(&function_e3203a2);
	}
}

