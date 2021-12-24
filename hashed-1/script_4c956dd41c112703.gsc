// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_52c6c2d1a2ef1b46;
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using script_78e9e286015f2ec;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_ba16273b;

/*
	Name: function_89f2df9
	Namespace: namespace_ba16273b
	Checksum: 0xDFF9E1C5
	Offset: 0x3A8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_2a6a60ff4e0bd9d1", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ba16273b
	Checksum: 0x8336A981
	Offset: 0x3F8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("world", "" + #"hash_681de2aa531ffcd0", 20000, 1, "int");
}

/*
	Name: __main__
	Namespace: namespace_ba16273b
	Checksum: 0xB02375FA
	Offset: 0x448
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	if(!zm_utility::function_e51dc2d8())
	{
		delete_entities();
		return;
	}
	init_flags();
	function_88d1bd71();
	init_vo();
}

/*
	Name: init_vo
	Namespace: namespace_ba16273b
	Checksum: 0x7A11D4CC
	Offset: 0x4B8
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function init_vo()
{
	level.var_9acf4bf7 = array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
	level.var_9acf4bf7 = array::randomize(level.var_9acf4bf7);
	level.var_ebab3906 = 0;
	level.var_a73770b4 = array(0, 1, 2, 3, 4);
	level.var_a73770b4 = array::randomize(level.var_a73770b4);
	level.var_1dcefa7 = 0;
	callback::on_connect(&function_e453faa6);
	callback::on_ai_killed(&function_d5faedec);
}

/*
	Name: init_flags
	Namespace: namespace_ba16273b
	Checksum: 0xD7845537
	Offset: 0x5E0
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_3ee874ebee843004");
	level flag::init(#"hash_315d0bf1d50724f0");
	level flag::init(#"hash_359cbec050523f4");
	level flag::init(#"hash_130656ec8ad5480d");
	level flag::init(#"hash_6202f3e00d7008b0");
	level flag::init(#"hash_1b68ccd211cab219");
	level flag::init(#"hash_7524c96c167377ef");
}

/*
	Name: function_88d1bd71
	Namespace: namespace_ba16273b
	Checksum: 0xF04A855F
	Offset: 0x6D0
	Size: 0x2F4
	Parameters: 0
	Flags: Linked
*/
function function_88d1bd71()
{
	var_e3d10631 = getentarray("private_mannequin_parts", "targetname");
	foreach(e_part in var_e3d10631)
	{
		e_part hide();
	}
	level thread function_8527738e();
	s_pernell_key = struct::get("pernell_key");
	s_pernell_drawer = struct::get("pernell_drawer");
	if(isdefined(s_pernell_key) && isdefined(s_pernell_drawer))
	{
		level flag::init("pernell_key_acquired");
		s_pernell_key zm_unitrigger::create("", 64);
		s_pernell_key thread function_eb06b83();
		zm_unitrigger::function_89380dda(s_pernell_key.s_unitrigger, 1);
		s_pernell_drawer zm_unitrigger::create("", 64);
		s_pernell_drawer thread function_65066810();
		zm_unitrigger::function_89380dda(s_pernell_drawer.s_unitrigger, 1);
	}
	level.mannequin_ally_spawner = getent("mannequin_ally_spawner", "targetname");
	level.var_777acf92 = level.mannequin_ally_spawner;
	namespace_ee206246::register(#"hash_5209f17dc73f0224", #"step_1", #"hash_5c83380ff7db3131", &function_cff5f83, &function_aceec77a);
	namespace_ee206246::register(#"hash_5209f17dc73f0224", #"step_2", #"hash_5c83350ff7db2c18", &function_20c4e844, &function_9101a54d);
	namespace_ee206246::start(#"hash_5209f17dc73f0224");
}

/*
	Name: delete_entities
	Namespace: namespace_ba16273b
	Checksum: 0xB4270231
	Offset: 0x9D0
	Size: 0x3AC
	Parameters: 0
	Flags: Linked
*/
function delete_entities()
{
	var_c000b3f5 = getentarray("private_mannequin_program_code", "targetname");
	foreach(var_3984178 in var_c000b3f5)
	{
		var_3984178 delete();
	}
	var_c000b3f5 = getentarray("sawyer_authorization_code", "targetname");
	foreach(var_3984178 in var_c000b3f5)
	{
		var_3984178 delete();
	}
	var_c000b3f5 = getentarray("pernell_authorization_code", "targetname");
	foreach(var_3984178 in var_c000b3f5)
	{
		var_3984178 delete();
	}
	var_c000b3f5 = getentarray("mccain_authorization_code", "targetname");
	foreach(var_3984178 in var_c000b3f5)
	{
		var_3984178 delete();
	}
	var_e3d10631 = getentarray("private_mannequin_parts", "targetname");
	var_f0aefc5c = getent("pernell_key", "targetname");
	var_6e32b553 = getent("pernell_drawer", "targetname");
	mannequin_ally_spawner = getent("mannequin_ally_spawner", "targetname");
	foreach(e_part in var_e3d10631)
	{
		e_part delete();
	}
	var_f0aefc5c delete();
	var_6e32b553 delete();
	mannequin_ally_spawner delete();
}

/*
	Name: function_cff5f83
	Namespace: namespace_ba16273b
	Checksum: 0xAB4778C3
	Offset: 0xD88
	Size: 0x3FC
	Parameters: 1
	Flags: Linked
*/
function function_cff5f83(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		while(!flag::get(#"hash_130656ec8ad5480d"))
		{
			level flag::wait_till(#"hash_3ee874ebee843004");
			/#
				iprintlnbold("");
			#/
			level function_79248781();
			level thread function_2ef7822a();
			level clientfield::set("" + #"hash_681de2aa531ffcd0", 1);
			a_flags = array(#"hash_315d0bf1d50724f0", #"hash_7524c96c167377ef");
			level flag::wait_till_any(a_flags);
			if(flag::get(#"hash_315d0bf1d50724f0"))
			{
				/#
					iprintlnbold("");
				#/
				level flag::set(#"hash_7524c96c167377ef");
				level.countdown_clock namespace_7d8e6ec3::function_9b1511fa();
				level function_d1086c12();
				level thread function_2ef7822a();
			}
			else
			{
				function_7d470210();
				continue;
			}
			a_flags = array(#"hash_359cbec050523f4", #"hash_7524c96c167377ef");
			level flag::wait_till_any(a_flags);
			if(flag::get(#"hash_359cbec050523f4"))
			{
				/#
					iprintlnbold("");
				#/
				level flag::set(#"hash_7524c96c167377ef");
				level.countdown_clock namespace_7d8e6ec3::function_9b1511fa();
				level function_5de15b91();
				level thread function_2ef7822a();
			}
			else
			{
				function_7d470210();
				continue;
			}
			a_flags = array(#"hash_130656ec8ad5480d", #"hash_7524c96c167377ef");
			level flag::wait_till_any(a_flags);
			if(flag::get(#"hash_130656ec8ad5480d"))
			{
				/#
					iprintlnbold("");
				#/
				level flag::set(#"hash_7524c96c167377ef");
				level.countdown_clock namespace_7d8e6ec3::function_9b1511fa();
				level thread visit_prototype_minigun();
			}
			else
			{
				function_7d470210();
				continue;
			}
		}
	}
}

/*
	Name: function_aceec77a
	Namespace: namespace_ba16273b
	Checksum: 0xB5300F80
	Offset: 0x1190
	Size: 0xA4
	Parameters: 2
	Flags: Linked
*/
function function_aceec77a(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_3ee874ebee843004");
		level flag::set(#"hash_315d0bf1d50724f0");
		level flag::set(#"hash_130656ec8ad5480d");
		level flag::set(#"hash_130656ec8ad5480d");
	}
}

/*
	Name: function_2ef7822a
	Namespace: namespace_ba16273b
	Checksum: 0xE3254D02
	Offset: 0x1240
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_2ef7822a()
{
	level flag::clear(#"hash_7524c96c167377ef");
	self endon(#"hash_7524c96c167377ef");
	level.countdown_clock namespace_7d8e6ec3::function_4955480();
	/#
		iprintlnbold("");
	#/
	level flag::set(#"hash_7524c96c167377ef");
}

/*
	Name: function_7d470210
	Namespace: namespace_ba16273b
	Checksum: 0x35B2E841
	Offset: 0x12E0
	Size: 0x166
	Parameters: 0
	Flags: Linked
*/
function function_7d470210()
{
	/#
		iprintlnbold("");
	#/
	level flag::clear(#"hash_3ee874ebee843004");
	level flag::clear(#"hash_315d0bf1d50724f0");
	level flag::clear(#"hash_130656ec8ad5480d");
	level flag::clear(#"hash_130656ec8ad5480d");
	level.var_f13364b4.var_132bd718[level.var_f13364b4.var_8deb4ed2].var_544c05c6 = 1;
	level.var_f13364b4.var_132bd718[level.var_f13364b4.var_a7450be4].var_544c05c6 = 1;
	level.var_f13364b4.var_132bd718[level.var_f13364b4.var_72c3e48c].var_544c05c6 = 1;
	level.var_f13364b4.var_132bd718[level.var_f13364b4.var_98e79e76].var_544c05c6 = 1;
}

/*
	Name: function_eb06b83
	Namespace: namespace_ba16273b
	Checksum: 0x60C5A567
	Offset: 0x1450
	Size: 0x16C
	Parameters: 0
	Flags: Linked
*/
function function_eb06b83()
{
	level endon(#"end_game");
	self endon(#"death");
	var_be17187b = undefined;
	var_be17187b = self waittill(#"trigger_activated");
	e_who = var_be17187b.e_who;
	e_who playsound("zmb_ee_key_pickup");
	e_who thread zm_audio::create_and_play_dialog(#"hash_44b4edd3d705820d", #"generic");
	level flag::set("pernell_key_acquired");
	namespace_6747c550::function_7df6bb60("zm_white_private_mannequin_key_part", 1);
	var_f0aefc5c = getent("pernell_key", "targetname");
	if(isdefined(var_f0aefc5c))
	{
		var_f0aefc5c delete();
	}
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	self struct::delete();
}

/*
	Name: function_65066810
	Namespace: namespace_ba16273b
	Checksum: 0xD10CD870
	Offset: 0x15C8
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function function_65066810()
{
	level flag::wait_till("pernell_key_acquired");
	var_be17187b = undefined;
	var_be17187b = self waittill(#"trigger_activated");
	e_who = var_be17187b.e_who;
	var_6e32b553 = getent("pernell_drawer", "targetname");
	if(isdefined(var_6e32b553))
	{
		var_7b8000e5 = anglestoright(var_6e32b553.angles) * 16;
		var_6e32b553 playsound("zmb_ee_drawer_open");
		var_6e32b553 moveto(var_6e32b553.origin + var_7b8000e5, 0.33);
	}
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	self struct::delete();
}

/*
	Name: function_79248781
	Namespace: namespace_ba16273b
	Checksum: 0x1BB97B23
	Offset: 0x1720
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_79248781()
{
	self endon(#"hash_78e2cadb25129fa2");
	level namespace_509a75d1::function_3c173d37();
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_adam_start", 0, 0, 1);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_adam_start", 1, 0, 1);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_adam_start", 2, 0, 1);
}

/*
	Name: function_d1086c12
	Namespace: namespace_ba16273b
	Checksum: 0xD1012689
	Offset: 0x17D0
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_d1086c12()
{
	self notify(#"hash_78e2cadb25129fa2");
	self endon(#"hash_78e2cadb25129fa2");
	level namespace_509a75d1::function_3c173d37();
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_adam_code_sawyer", 0, 0, 1);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_adam_code_sawyer", 1, 0, 1);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_adam_code_sawyer", 2, 0, 1);
}

/*
	Name: function_5de15b91
	Namespace: namespace_ba16273b
	Checksum: 0x5E4F79F8
	Offset: 0x1890
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_5de15b91()
{
	self notify(#"hash_78e2cadb25129fa2");
	self endon(#"hash_78e2cadb25129fa2");
	level namespace_509a75d1::function_3c173d37();
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_adam_code_mccain", 0, 0, 1);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_adam_code_mccain", 1, 0, 1);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_adam_code_mccain", 2, 0, 1);
}

/*
	Name: visit_prototype_minigun
	Namespace: namespace_ba16273b
	Checksum: 0xF8CF5EE4
	Offset: 0x1950
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function visit_prototype_minigun()
{
	self notify(#"hash_78e2cadb25129fa2");
	self endon(#"hash_78e2cadb25129fa2");
	level namespace_509a75d1::function_3c173d37();
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_adam_code_pernell", 0, 0, 1);
	level.var_5dd0d3ff namespace_509a75d1::function_6a0d675d("vox_adam_code_pernell", 1, 0, 1);
	level.var_f13364b4.var_12633dc5 namespace_509a75d1::function_51b752a9("vox_adam_code_pernell", 2, 0);
}

/*
	Name: function_20c4e844
	Namespace: namespace_ba16273b
	Checksum: 0xD0191F98
	Offset: 0x1A18
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_20c4e844(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level thread function_88265619();
		level flag::wait_till(#"hash_6202f3e00d7008b0");
	}
}

/*
	Name: function_9101a54d
	Namespace: namespace_ba16273b
	Checksum: 0x7D598BE7
	Offset: 0x1A70
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function function_9101a54d(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		if(!isdefined(level.var_f5746584))
		{
			level thread function_88265619();
		}
	}
}

/*
	Name: function_a51b6403
	Namespace: namespace_ba16273b
	Checksum: 0x4B055986
	Offset: 0x1AC8
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_a51b6403(is_opening)
{
	if(!isdefined(self.v_start_pos))
	{
		self.v_start_pos = self.origin;
	}
	if(is_opening)
	{
		self playsound("evt_bunker_door_interior_open");
		self moveto(self.v_start_pos + (vectorscale((0, 0, -1), 128)), 1);
	}
	else
	{
		self playsound("evt_bunker_door_interior_close");
		self moveto(self.v_start_pos, 1);
	}
}

/*
	Name: function_11862a9b
	Namespace: namespace_ba16273b
	Checksum: 0x7AFA9B5A
	Offset: 0x1BA0
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_11862a9b(e_player)
{
	if(level.var_f5746584 == 0)
	{
		self sethintstring(#"hash_5ebbcacfe7506b1b");
	}
	else
	{
		self sethintstring(#"hash_17a473c2067a81f1", 3000);
	}
	return 1;
}

/*
	Name: function_1e88595a
	Namespace: namespace_ba16273b
	Checksum: 0x5E4B7EA
	Offset: 0x1C10
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function function_1e88595a()
{
	level flag::clear(#"hash_6202f3e00d7008b0");
	do
	{
		var_6ba58f5f = 0;
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		e_who = var_be17187b.e_who;
		if(!e_who zm_score::can_player_purchase(self.s_unitrigger.cost))
		{
			zm_utility::play_sound_on_ent("no_purchase");
			e_who zm_audio::create_and_play_dialog(#"general", #"outofmoney");
		}
		else
		{
			e_who zm_score::minus_to_player_score(self.s_unitrigger.cost);
			e_who thread function_e4459089();
			var_6ba58f5f = 1;
		}
	}
	while(!var_6ba58f5f);
	self.var_1a612d42 = e_who;
	level flag::set(#"hash_6202f3e00d7008b0");
}

/*
	Name: function_eaa63f5b
	Namespace: namespace_ba16273b
	Checksum: 0x395DCAC9
	Offset: 0x1D70
	Size: 0x174
	Parameters: 1
	Flags: Linked
*/
function function_eaa63f5b(n_minutes = 1)
{
	/#
		iprintlnbold(("" + n_minutes) + "");
	#/
	n_time_end = gettime() + ((n_minutes * 60) * 1000);
	level flag::set(#"hash_1b68ccd211cab219");
	while(true)
	{
		if(gettime() > n_time_end && (!(isdefined(self) && (isdefined(self.reviving_a_player) && self.reviving_a_player))))
		{
			if(isdefined(self) && isalive(self))
			{
				util::stop_magic_bullet_shield(level.var_8943f7db);
				self kill();
				level.var_8943f7db = undefined;
			}
			level flag::clear(#"hash_1b68ccd211cab219");
			/#
				iprintlnbold("");
			#/
			break;
		}
		wait(10);
	}
}

/*
	Name: function_88265619
	Namespace: namespace_ba16273b
	Checksum: 0x22AB6345
	Offset: 0x1EF0
	Size: 0x470
	Parameters: 0
	Flags: Linked
*/
function function_88265619()
{
	level endon(#"game_ended", #"hash_48039f3a4c1a3248");
	level.var_f5746584 = 0;
	var_e3d10631 = getentarray("private_mannequin_parts", "targetname");
	var_a2c75164 = getent("mannequin_ally_door", "targetname");
	/#
		assert(isdefined(var_a2c75164), "");
	#/
	while(true)
	{
		level flag::wait_till_clear(#"hash_1b68ccd211cab219");
		if(level.var_f5746584 > 0)
		{
			wait(45);
		}
		var_a2c75164 function_a51b6403(1);
		foreach(e_part in var_e3d10631)
		{
			e_part show();
		}
		level clientfield::set("" + #"hash_681de2aa531ffcd0", 0);
		var_e3d10631[0] zm_unitrigger::create(&function_11862a9b, 96, undefined, 1, 1);
		var_e3d10631[0] thread function_1e88595a();
		if(level.var_f5746584 == 0)
		{
			var_e3d10631[0].s_unitrigger.cost = 0;
		}
		else
		{
			var_e3d10631[0].s_unitrigger.cost = 3000;
		}
		level flag::wait_till(#"hash_6202f3e00d7008b0");
		foreach(e_part in var_e3d10631)
		{
			e_part hide();
		}
		zm_unitrigger::unregister_unitrigger(var_e3d10631[0].s_unitrigger);
		level.var_1a612d42 = var_e3d10631[0].var_1a612d42;
		level.var_1a612d42.eligible_leader = 1;
		if(isdefined(level.mannequin_ally_spawner))
		{
			level.var_8943f7db = level.mannequin_ally_spawner spawnfromspawner();
			level.var_8943f7db.name = "adam";
			level.var_8943f7db.isspeaking = 0;
			level.var_8943f7db.var_5b6ebfd0 = 0;
			util::magic_bullet_shield(level.var_8943f7db);
			level.var_8943f7db.aioverridedamage = array(&function_26edbcdc);
			level.var_8943f7db thread function_eaa63f5b(3);
			level.var_f5746584++;
			level.var_8943f7db thread function_e29e2b0b();
		}
		wait(1.5);
		level.var_8943f7db thread namespace_509a75d1::function_6a0d675d("vox_adam_activated");
		var_a2c75164 function_a51b6403(0);
	}
}

/*
	Name: function_e4459089
	Namespace: namespace_ba16273b
	Checksum: 0x2AFC20C1
	Offset: 0x2368
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_e4459089()
{
	self namespace_509a75d1::function_51b752a9("vox_adam_activate");
}

/*
	Name: function_26edbcdc
	Namespace: namespace_ba16273b
	Checksum: 0x2F07EBA8
	Offset: 0x2398
	Size: 0x66
	Parameters: 12
	Flags: Linked
*/
function function_26edbcdc(inflictor, attacker, damage, flags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	return 0;
}

/*
	Name: function_8527738e
	Namespace: namespace_ba16273b
	Checksum: 0x1A2FE3
	Offset: 0x2408
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function function_8527738e()
{
	level._effect[#"hash_fc6d4d4b4df98f8"] = #"hash_4419642343624864";
	level.var_c8b6a556 = getent("pernel_paper_stack", "targetname");
	level.var_c8b6a556 setcandamage(1);
	level.var_c8b6a556 val::set("private_mannequin_quest_paper_stack", "allowDeath", 0);
	s_notify = undefined;
	s_notify = level.var_c8b6a556 waittill(#"damage");
	level.var_c8b6a556.tag = util::spawn_model("tag_origin", level.var_c8b6a556.origin);
	level.var_c8b6a556.tag.angles = level.var_c8b6a556.angles;
	playfxontag(level._effect[#"hash_fc6d4d4b4df98f8"], level.var_c8b6a556.tag, "tag_origin");
	level.var_c8b6a556 hide();
	wait(5);
	level.var_c8b6a556.tag delete();
	level.var_c8b6a556 delete();
}

/*
	Name: function_d5faedec
	Namespace: namespace_ba16273b
	Checksum: 0x601CC04E
	Offset: 0x25E0
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function function_d5faedec(params)
{
	e_attacker = params.eattacker;
	if(isdefined(level.var_8943f7db) && e_attacker === level.var_8943f7db)
	{
		e_attacker notify(#"zom_kill");
	}
}

/*
	Name: function_e29e2b0b
	Namespace: namespace_ba16273b
	Checksum: 0x6EC3DA20
	Offset: 0x2640
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function function_e29e2b0b()
{
	self endon(#"death");
	kills = 4;
	time = 15;
	if(!isdefined(self.timerisrunning))
	{
		self.timerisrunning = 0;
		self.killcounter = 0;
	}
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"zom_kill");
		zomb = waitresult.zombie;
		self.killcounter++;
		if(self.timerisrunning != 1)
		{
			self.timerisrunning = 1;
			self thread timer_actual(kills, time);
		}
	}
}

/*
	Name: timer_actual
	Namespace: namespace_ba16273b
	Checksum: 0xFB117152
	Offset: 0x2728
	Size: 0x20A
	Parameters: 2
	Flags: Linked
*/
function timer_actual(kills, time)
{
	self endon(#"disconnect", #"death");
	timer = gettime() + (time * 1000);
	while(gettime() < timer)
	{
		if(self.killcounter > kills)
		{
			if(isdefined(level.var_8943f7db))
			{
				level.var_8943f7db namespace_509a75d1::function_6a0d675d("vox_adam_multi_kill", function_f20dfe6a(), 0, 1);
			}
			if(math::cointoss())
			{
				players = getplayers();
				foreach(e_player in players)
				{
					if(!isdefined(e_player))
					{
						continue;
					}
					if(sighttracepassed(self.origin + vectorscale((0, 0, 1), 30), e_player.origin + vectorscale((0, 0, 1), 30), 0, undefined))
					{
						e_player zm_audio::create_and_play_dialog(#"kill", #"hash_2d97bed6f4e21bb7");
						continue;
					}
				}
			}
			wait(10);
			self.killcounter = 0;
			timer = -1;
		}
		wait(0.1);
	}
	self.killcounter = 0;
	self.timerisrunning = 0;
}

/*
	Name: function_f20dfe6a
	Namespace: namespace_ba16273b
	Checksum: 0xF1458203
	Offset: 0x2940
	Size: 0x82
	Parameters: 0
	Flags: Linked
*/
function function_f20dfe6a()
{
	n_variant = level.var_9acf4bf7[level.var_ebab3906];
	level.var_ebab3906++;
	if(level.var_ebab3906 >= level.var_9acf4bf7.size)
	{
		level.var_ebab3906 = 0;
		level.var_9acf4bf7 = array::randomize(level.var_9acf4bf7);
	}
	return n_variant;
}

/*
	Name: function_e453faa6
	Namespace: namespace_ba16273b
	Checksum: 0x2396E231
	Offset: 0x29D0
	Size: 0xF0
	Parameters: 1
	Flags: Linked
*/
function function_e453faa6(e_reviver)
{
	self endon(#"death");
	while(true)
	{
		results = undefined;
		results = self waittill(#"player_revived");
		if(isdefined(level.var_8943f7db) && results.reviver === level.var_8943f7db)
		{
			level.var_8943f7db namespace_509a75d1::function_6a0d675d("vox_adam_revive", function_9368a51d(), 0, 1);
			self thread zm_audio::create_and_play_dialog(#"revive", #"adam", undefined, 1);
		}
	}
}

/*
	Name: function_9368a51d
	Namespace: namespace_ba16273b
	Checksum: 0x24D68CDB
	Offset: 0x2AC8
	Size: 0x82
	Parameters: 0
	Flags: Linked
*/
function function_9368a51d()
{
	n_variant = level.var_a73770b4[level.var_1dcefa7];
	level.var_1dcefa7++;
	if(level.var_1dcefa7 >= level.var_a73770b4.size)
	{
		level.var_1dcefa7 = 0;
		level.var_a73770b4 = array::randomize(level.var_a73770b4);
	}
	return n_variant;
}

