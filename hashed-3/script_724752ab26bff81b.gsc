// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3122530a9381e18b;
#using script_34b02db2817b42f;
#using script_3510d12b63a575c3;
#using script_3e5ec44cfab7a201;
#using script_52c6c2d1a2ef1b46;
#using script_5bb072c3abf4652c;
#using script_5f9141e04e4e94a2;
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using script_6e3c826b1814cab6;
#using script_74608ad5d25450b1;
#using script_78e9e286015f2ec;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\zm\zm_white_util.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_a01a2431;

/*
	Name: preload
	Namespace: namespace_a01a2431
	Checksum: 0xD1AB30BA
	Offset: 0x428
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	namespace_617a54f4::function_d8383812(#"sc_ww_screen1", 20000, "sc_ww_screen1", &function_8598f0d4, &function_3bdbb583, 1);
	namespace_617a54f4::function_d8383812(#"sc_ww_screen2", 20000, "sc_ww_screen2", &function_8598f0d4, &function_3bdbb583, 1);
	namespace_617a54f4::function_d8383812(#"sc_ww_screen3", 20000, "sc_ww_screen3", &function_8598f0d4, &function_3bdbb583, 1);
	namespace_617a54f4::function_d8383812(#"sc_ww_screen4", 20000, "sc_ww_screen4", &function_8598f0d4, &function_3bdbb583, 1);
}

/*
	Name: init
	Namespace: namespace_a01a2431
	Checksum: 0xFA7E7F18
	Offset: 0x578
	Size: 0x494
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.s_ww_interact = struct::get("ww_interact");
	level.s_ww_interact.var_e76526e8 = [];
	level.s_ww_interact.var_e76526e8[0] = {#hash_2153c223:level.var_2aeeb358[4], #n_state:1};
	level.s_ww_interact.var_e76526e8[1] = {#hash_2153c223:level.var_2aeeb358[6], #n_state:1};
	level.s_ww_interact.var_e76526e8[2] = {#hash_2153c223:level.var_2aeeb358[8], #n_state:1};
	level.s_ww_interact.var_e76526e8[3] = {#hash_2153c223:level.var_2aeeb358[10], #n_state:1};
	var_c13ed74d = struct::get_array("ww_pickup");
	level.var_c13ed74d = array::sort_by_script_int(var_c13ed74d, 1);
	level thread function_dd535733();
	level.var_87b50e64 = array(getweapon("ray_gun"), getweapon("ray_gun_mk2v"), getweapon("ray_gun_mk2x"), getweapon("ray_gun_mk2y"), getweapon("ray_gun_mk2z"));
	var_38d35cb5 = struct::get_array("ww_quest_tv");
	array::run_all(var_38d35cb5, &function_101f9dc0);
	level.var_2fc3a917 = array::sort_by_script_int(var_38d35cb5, 1);
	var_668332c4 = randomint(level.var_2fc3a917.size - 1);
	for(i = 0; i < var_668332c4; i++)
	{
		s_temp = array::pop_front(level.var_2fc3a917, 0);
		if(!isdefined(level.var_2fc3a917))
		{
			level.var_2fc3a917 = [];
		}
		else if(!isarray(level.var_2fc3a917))
		{
			level.var_2fc3a917 = array(level.var_2fc3a917);
		}
		level.var_2fc3a917[level.var_2fc3a917.size] = s_temp;
	}
	namespace_ee206246::register(#"hash_7b3ce20f6b2317db", #"step_1", #"hash_2af54f403e86105d", &function_da84e99e, &function_6d5a79fe);
	level thread function_661dc825();
	if(!zm_utility::is_standard())
	{
		n_code = namespace_7d8e6ec3::function_4696e086(1, &function_256cc56e);
		level.var_276bd207 = namespace_7d8e6ec3::function_da24090c(n_code);
	}
	function_63841688();
}

/*
	Name: function_dd535733
	Namespace: namespace_a01a2431
	Checksum: 0xFF0CF9A5
	Offset: 0xA18
	Size: 0xFE
	Parameters: 0
	Flags: Linked
*/
function function_dd535733()
{
	level.s_ww_printer_compartment = struct::get("ww_printer_compartment", "targetname");
	level.s_ww_printer_compartment scene::play("init");
	level.s_ww_printer_compartment flagsys::wait_till(#"scene_ents_ready");
	level.s_ww_printer_compartment.entity = level.s_ww_printer_compartment.scene_ents[#"hash_7aff0ee60ddd937b"];
	for(i = 0; i < 4; i++)
	{
		level.s_ww_printer_compartment.entity hidepart("tag_gun_full_" + i);
	}
}

/*
	Name: function_6a2c67c2
	Namespace: namespace_a01a2431
	Checksum: 0x30A110AC
	Offset: 0xB20
	Size: 0xF4
	Parameters: 0
	Flags: None
*/
function function_6a2c67c2()
{
	while(true)
	{
		self scene::play("open");
		for(i = 0; i < 4; i++)
		{
			wait(1);
			self.entity hidepart("tag_gun_" + i);
		}
		wait(1);
		self scene::play("init");
		for(i = 0; i < 4; i++)
		{
			self.entity showpart("tag_gun_" + i);
		}
		wait(2);
	}
}

/*
	Name: function_661dc825
	Namespace: namespace_a01a2431
	Checksum: 0xCC3D48EE
	Offset: 0xC20
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_661dc825()
{
	level endon(#"game_ended");
	level flag::wait_till(#"pap_power_ready");
	if(namespace_59ff1d6c::function_901b751c(#"hash_541a4d5c476468f4"))
	{
		namespace_ee206246::start(#"hash_7b3ce20f6b2317db", !zm_utility::is_standard());
	}
}

/*
	Name: function_da84e99e
	Namespace: namespace_a01a2431
	Checksum: 0xC550631D
	Offset: 0xCC0
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_da84e99e(var_5ea5c94d)
{
	level.var_f36ca012 = 0;
	level.var_2fc3a917[level.var_f36ca012] function_46006d68();
	level thread function_cbeb9a33();
	if(!var_5ea5c94d)
	{
		level flag::init(#"hash_6cf22ddb4ddabbaa");
		level flag::wait_till(#"hash_6cf22ddb4ddabbaa");
		if(!zm_utility::function_e51dc2d8())
		{
			namespace_7d8e6ec3::function_4da0eaff();
		}
	}
}

/*
	Name: function_101f9dc0
	Namespace: namespace_a01a2431
	Checksum: 0xA70AC6CE
	Offset: 0xD98
	Size: 0x11A
	Parameters: 0
	Flags: Linked
*/
function function_101f9dc0()
{
	a_e_parts = getentarray(self.target, "targetname");
	foreach(e_part in a_e_parts)
	{
		if(isdefined(e_part.script_int))
		{
			self.e_tv = e_part;
			continue;
		}
		self.var_c5e93537 = e_part;
	}
	if(isdefined(self.e_tv))
	{
		self.e_tv function_6392f719();
	}
	self.var_53d39cb3 = 0;
	self.var_7944be4a = 0;
	self.var_b9989e12 = hash(self.script_noteworthy);
}

/*
	Name: function_dc4f41f7
	Namespace: namespace_a01a2431
	Checksum: 0x64564DCA
	Offset: 0xEC0
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_dc4f41f7()
{
	if(isdefined(self.var_c5e93537))
	{
		self.var_c5e93537 delete();
	}
	if(isdefined(self.e_tv))
	{
		self.e_tv stopsounds();
		self.e_tv function_6392f719();
	}
	self.var_53d39cb3 = 0;
	if(isdefined(self.s_unitrigger))
	{
		zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	}
	namespace_617a54f4::function_2a94055d(self.var_b9989e12);
}

/*
	Name: function_46006d68
	Namespace: namespace_a01a2431
	Checksum: 0xAA2A078E
	Offset: 0xF80
	Size: 0x1DA
	Parameters: 0
	Flags: Linked
*/
function function_46006d68()
{
	switch(self.var_53d39cb3)
	{
		case 0:
		{
			self.e_tv function_bb7d7e2d();
			self.e_tv playloopsound(#"hash_7b7b8618ef1150ac");
			self zm_unitrigger::create("", 96);
			self thread function_582a4879();
			self.var_53d39cb3 = 1;
			break;
		}
		case 1:
		{
			self.e_tv function_8ebc8dcf(100);
			self thread function_41464ab6();
			self.e_tv playloopsound(#"hash_66d823f29bf8f0ce");
			self.var_53d39cb3 = 2;
			namespace_617a54f4::function_3f808d3d(self.var_b9989e12);
			break;
		}
		case 2:
		{
			self.e_tv function_8ebc8dcf(level.var_276bd207[level.var_f36ca012]);
			self.e_tv playloopsound(#"hash_6edda7357adf8cd9");
			self.var_53d39cb3 = 3;
			self thread function_6e0328a9();
			break;
		}
	}
}

/*
	Name: function_41464ab6
	Namespace: namespace_a01a2431
	Checksum: 0xD60F186D
	Offset: 0x1168
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_41464ab6()
{
	self endon(#"death");
	n_wait = float(soundgetplaybacktime(#"hash_60b460e7880bd1c0")) / 1000;
	self.e_tv playsound(#"hash_60b460e7880bd1c0");
	wait(n_wait);
	self.e_tv.name = level.var_8200dc81.name;
	self.e_tv thread namespace_509a75d1::function_6a0d675d(#"hash_661a3ece5f5b3f0b", 0, 0);
}

/*
	Name: function_6e0328a9
	Namespace: namespace_a01a2431
	Checksum: 0x33BA4CFC
	Offset: 0x1250
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_6e0328a9()
{
	level endon(#"end_game");
	self.e_tv.name = level.var_8200dc81.name;
	self.e_tv zm_vo::function_57b8cd17();
	self.e_tv namespace_509a75d1::function_6a0d675d(#"hash_6827b81ddbd26677", 0, 0);
	if(level flag::get(#"hash_6cf22ddb4ddabbaa"))
	{
		wait(1);
		self.e_tv namespace_509a75d1::function_6a0d675d(#"hash_ce23c02d2c80867", 0, 0);
	}
}

/*
	Name: function_582a4879
	Namespace: namespace_a01a2431
	Checksum: 0x308F1779
	Offset: 0x1338
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_582a4879()
{
	self endon(#"death");
	self waittill(#"trigger_activated");
	self function_56d2143b();
}

/*
	Name: function_56d2143b
	Namespace: namespace_a01a2431
	Checksum: 0x9AE7902C
	Offset: 0x1380
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function function_56d2143b()
{
	self function_46006d68();
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	self.s_unitrigger = undefined;
}

/*
	Name: function_8598f0d4
	Namespace: namespace_a01a2431
	Checksum: 0xC80E004
	Offset: 0x13C8
	Size: 0xC0
	Parameters: 2
	Flags: Linked
*/
function function_8598f0d4(var_88206a50, ent)
{
	if(isdefined(ent))
	{
		b_killed_by_player = isdefined(ent.attacker) && isplayer(ent.attacker) || (isdefined(ent.damageinflictor) && isplayer(ent.damageinflictor));
		var_e93788f1 = var_88206a50.var_c5e93537;
		return b_killed_by_player && ent istouching(var_e93788f1);
	}
	return 0;
}

/*
	Name: function_3bdbb583
	Namespace: namespace_a01a2431
	Checksum: 0x7901E519
	Offset: 0x1490
	Size: 0xDC
	Parameters: 2
	Flags: Linked
*/
function function_3bdbb583(var_f0e6c7a2, ent)
{
	n_souls_required = 6;
	if(getplayers().size > 2)
	{
		n_souls_required = 10;
	}
	else if(getplayers().size > 1)
	{
		n_souls_required = 8;
	}
	var_f0e6c7a2.var_7944be4a++;
	/#
		if(level flag::get(#"hash_6dcc421d5fbf8d22"))
		{
			var_f0e6c7a2.var_7944be4a = n_souls_required;
		}
	#/
	if(var_f0e6c7a2.var_7944be4a >= n_souls_required)
	{
		var_f0e6c7a2 function_a66f0de2();
	}
}

/*
	Name: function_a66f0de2
	Namespace: namespace_a01a2431
	Checksum: 0x4E50A913
	Offset: 0x1578
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_a66f0de2()
{
	namespace_617a54f4::function_2a94055d(self.var_b9989e12);
	v_forward = anglestoforward(self.angles);
	v_up = anglestoup(self.angles);
	self function_46006d68();
	level.var_f36ca012++;
	if(level.var_f36ca012 < level.var_2fc3a917.size)
	{
		level.var_2fc3a917[level.var_f36ca012] function_46006d68();
	}
	else
	{
		level flag::set(#"hash_6cf22ddb4ddabbaa");
	}
}

/*
	Name: function_6d5a79fe
	Namespace: namespace_a01a2431
	Checksum: 0xDDFCBC5C
	Offset: 0x1668
	Size: 0x134
	Parameters: 2
	Flags: Linked
*/
function function_6d5a79fe(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		foreach(var_d9ee8daa in level.var_2fc3a917)
		{
			if(var_d9ee8daa.var_53d39cb3 == 1)
			{
				var_d9ee8daa function_56d2143b();
			}
			if(var_d9ee8daa.var_53d39cb3 == 2)
			{
				var_d9ee8daa function_a66f0de2();
			}
		}
		/#
			iprintlnbold(((("" + level.var_276bd207[0]) + level.var_276bd207[1]) + level.var_276bd207[2]) + level.var_276bd207[3]);
		#/
	}
}

/*
	Name: function_cbeb9a33
	Namespace: namespace_a01a2431
	Checksum: 0xB3C1FEDD
	Offset: 0x17A8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_cbeb9a33()
{
	if(zm_utility::function_e51dc2d8())
	{
		level flag::wait_till("insanity_mode_triggered");
		var_38d35cb5 = struct::get_array("ww_quest_tv");
		array::run_all(var_38d35cb5, &function_dc4f41f7);
	}
}

/*
	Name: function_256cc56e
	Namespace: namespace_a01a2431
	Checksum: 0x3C69BB5B
	Offset: 0x1828
	Size: 0x234
	Parameters: 0
	Flags: Linked
*/
function function_256cc56e()
{
	if(isdefined(level.var_f13364b4.var_12633dc5) && zm_utility::is_classic())
	{
		level.var_f13364b4.var_12633dc5 thread namespace_9cf755b::function_491673da(#"hash_ef67a616ce1cb99");
	}
	if(!zm_utility::function_e51dc2d8())
	{
		level namespace_7d8e6ec3::function_31890499();
		namespace_7d8e6ec3::function_52838f02("both", 0);
		if(isdefined(level.var_f13364b4.s_keypad) && isdefined(level.var_f13364b4.s_keypad.s_unitrigger))
		{
			zm_unitrigger::unregister_unitrigger(level.var_f13364b4.s_keypad.s_unitrigger);
		}
	}
	wait(1);
	level.s_ww_printer_compartment scene::play("open");
	playsoundatposition(#"hash_7afd5b8ae2a40c53", level.s_ww_interact.origin);
	s_unitrigger = level.s_ww_interact zm_unitrigger::create(&function_c3076788, 64);
	zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
	zm_unitrigger::function_c9e3607c(s_unitrigger, "HINT_WEAPON", level.var_2aeeb358[2]);
	level.s_ww_interact thread function_7d123028();
	namespace_ca03bbb4::start_quest();
	namespace_3b2b9e06::start_quest();
	namespace_825eac6b::start_quest();
	namespace_90b0490e::start_quest();
}

/*
	Name: function_c3076788
	Namespace: namespace_a01a2431
	Checksum: 0x641EC9F9
	Offset: 0x1A68
	Size: 0x4B8
	Parameters: 1
	Flags: Linked
*/
function function_c3076788(e_player)
{
	if(level.var_7629d4e2 === 1)
	{
		return 0;
	}
	e_player.var_bec34462 = e_player function_117157d7();
	if(isdefined(e_player.var_bec34462.n_slot))
	{
		w_give = level.s_ww_interact.var_e76526e8[e_player.var_bec34462.n_slot].var_2153c223;
	}
	var_40d3de6c = e_player namespace_9cf755b::function_c7274071();
	switch(e_player.var_bec34462.n_id)
	{
		case 0:
		{
			str_hint = #"hash_3f0cb3a3a888e340";
			var_306b9dd6 = #"hash_351a359dee18e66c";
			break;
		}
		case 1:
		{
			str_hint = #"hash_45e0e71f5c4ad089";
			var_306b9dd6 = #"hash_2c1852a26bee7917";
			break;
		}
		case 2:
		{
			str_hint = #"hash_314a7588b45256eb";
			var_306b9dd6 = #"hash_6831cfd35264e1";
			var_339390e4 = w_give.displayname;
			break;
		}
		case 3:
		{
			str_hint = #"hash_53f9aac41c4fa384";
			var_306b9dd6 = #"hash_3a6067fdb28789e8";
			var_339390e4 = var_40d3de6c.displayname;
			break;
		}
		case 4:
		{
			str_hint = #"hash_7aea9fef103ab16";
			var_306b9dd6 = #"hash_3e916dea9d22f1b2";
			var_339390e4 = var_40d3de6c.displayname;
			var_45d63569 = w_give.displayname;
			break;
		}
		case 5:
		{
			str_hint = #"hash_1d175f6387d44262";
			var_306b9dd6 = #"hash_6686ce3bf4639b76";
			var_339390e4 = w_give.displayname;
			break;
		}
		case 6:
		{
			str_hint = #"hash_68ae5772aec47222";
			var_306b9dd6 = #"hash_58bd37425bd02736";
			var_339390e4 = var_40d3de6c.displayname;
			break;
		}
		case 7:
		{
			str_hint = #"hash_172253c9314825fc";
			var_306b9dd6 = #"hash_71016e43b6fe0570";
			var_339390e4 = w_give.displayname;
			var_45d63569 = var_40d3de6c.displayname;
			break;
		}
		case 8:
		{
			str_hint = #"hash_28c1446ca1a2440c";
			var_306b9dd6 = #"hash_2df82d83303d3d40";
			var_339390e4 = w_give.displayname;
			var_45d63569 = var_40d3de6c.displayname;
			break;
		}
		case 9:
		{
			return 0;
		}
	}
	if(e_player.currentweapon.isheroweapon === 1 || e_player.currentweapon.name === #"hash_603fdd2e4ae5b2b0")
	{
		self sethintstring("");
	}
	else if(isdefined(var_45d63569))
	{
		self sethintstring(zm_utility::function_d6046228(str_hint, var_306b9dd6), var_339390e4, var_45d63569);
	}
	else if(isdefined(var_339390e4))
	{
		self sethintstring(zm_utility::function_d6046228(str_hint, var_306b9dd6), var_339390e4);
	}
	else
	{
		self sethintstring(zm_utility::function_d6046228(str_hint, var_306b9dd6));
	}
	return 1;
}

/*
	Name: function_7d123028
	Namespace: namespace_a01a2431
	Checksum: 0x61C771EB
	Offset: 0x1F28
	Size: 0xC8
	Parameters: 0
	Flags: Linked
*/
function function_7d123028()
{
	self endon(#"death");
	while(true)
	{
		s_notify = undefined;
		s_notify = self waittill(#"trigger_activated");
		e_player = s_notify.e_who;
		if(isplayer(e_player) && e_player.currentweapon.isheroweapon === 0 && e_player.currentweapon.name !== #"hash_603fdd2e4ae5b2b0")
		{
			function_75e61716(e_player);
		}
	}
}

/*
	Name: function_75e61716
	Namespace: namespace_a01a2431
	Checksum: 0x87658409
	Offset: 0x1FF8
	Size: 0x22A
	Parameters: 1
	Flags: Linked
*/
function function_75e61716(e_player)
{
	switch(e_player.var_bec34462.n_id)
	{
		case 0:
		{
			e_player function_3f52f82();
			break;
		}
		case 1:
		{
			e_player function_a9051a62();
			break;
		}
		case 2:
		{
			e_player function_508273b4();
			break;
		}
		case 3:
		{
			e_player function_bdc61146();
			break;
		}
		case 4:
		{
			e_player function_bdc61146();
			e_player function_508273b4();
			break;
		}
		case 5:
		{
			e_player function_a9051a62();
			e_player function_508273b4();
			break;
		}
		case 6:
		{
			e_player function_bdc61146();
			e_player function_3f52f82();
			break;
		}
		case 7:
		{
			e_player function_ae224cc2();
			e_player function_508273b4();
			break;
		}
		case 8:
		{
			e_player function_ae224cc2();
			e_player function_a9051a62();
			e_player function_508273b4();
			break;
		}
	}
}

/*
	Name: function_3f52f82
	Namespace: namespace_a01a2431
	Checksum: 0x609B1FDD
	Offset: 0x2230
	Size: 0x2AA
	Parameters: 0
	Flags: Linked
*/
function function_3f52f82()
{
	self.var_382b64f2 = 1;
	namespace_6747c550::function_7df6bb60("zm_white_ww_husk_part", 1, self);
	self playsound("evt_rgun_frame_pickup");
	n_slot = self.var_bec34462.n_slot;
	if(isdefined(n_slot) && level.s_ww_interact.var_e76526e8[n_slot].n_state == 1)
	{
		level.s_ww_printer_compartment.entity hidepart("tag_gun_" + n_slot);
		level.s_ww_interact.var_e76526e8[n_slot].n_state = 0;
	}
	else
	{
		function_47181de();
	}
	if(!isdefined(level.s_ww_interact.var_bfee6dc4))
	{
		level.s_ww_interact.var_bfee6dc4 = [];
	}
	if(!array::contains(level.s_ww_interact.var_bfee6dc4, self))
	{
		if(!array::contains(level.s_ww_interact.var_5300c2f5, self))
		{
			if(!namespace_3e3742fd::function_6cebbce1() && zm_utility::is_classic())
			{
				zm_vo::function_8e0f4696("vox_ww_mod_hint_rush_0", 0, 1, 0, 0, 1);
			}
		}
		if(!isdefined(level.s_ww_interact.var_bfee6dc4))
		{
			level.s_ww_interact.var_bfee6dc4 = [];
		}
		else if(!isarray(level.s_ww_interact.var_bfee6dc4))
		{
			level.s_ww_interact.var_bfee6dc4 = array(level.s_ww_interact.var_bfee6dc4);
		}
		if(!isinarray(level.s_ww_interact.var_bfee6dc4, self))
		{
			level.s_ww_interact.var_bfee6dc4[level.s_ww_interact.var_bfee6dc4.size] = self;
		}
	}
}

/*
	Name: function_605e5c25
	Namespace: namespace_a01a2431
	Checksum: 0xF34501B9
	Offset: 0x24E8
	Size: 0x132
	Parameters: 1
	Flags: Linked
*/
function function_605e5c25(e_player)
{
	if(!isdefined(level.s_ww_interact.var_5300c2f5))
	{
		level.s_ww_interact.var_5300c2f5 = [];
	}
	if(!array::contains(level.s_ww_interact.var_5300c2f5, e_player))
	{
		if(!isdefined(level.s_ww_interact.var_5300c2f5))
		{
			level.s_ww_interact.var_5300c2f5 = [];
		}
		else if(!isarray(level.s_ww_interact.var_5300c2f5))
		{
			level.s_ww_interact.var_5300c2f5 = array(level.s_ww_interact.var_5300c2f5);
		}
		if(!isinarray(level.s_ww_interact.var_5300c2f5, e_player))
		{
			level.s_ww_interact.var_5300c2f5[level.s_ww_interact.var_5300c2f5.size] = e_player;
		}
	}
}

/*
	Name: function_47181de
	Namespace: namespace_a01a2431
	Checksum: 0x4974BC5F
	Offset: 0x2628
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_47181de()
{
	n_slot = function_5c934f81(1);
	if(isdefined(n_slot))
	{
		level.s_ww_interact.var_e76526e8[n_slot].n_state = 0;
		level.s_ww_printer_compartment.entity hidepart("tag_gun_" + n_slot);
	}
	/#
		if(!isdefined(n_slot))
		{
			iprintln("");
		}
	#/
}

/*
	Name: function_a9051a62
	Namespace: namespace_a01a2431
	Checksum: 0x19C8077B
	Offset: 0x26E0
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function function_a9051a62()
{
	self.var_382b64f2 = undefined;
	namespace_6747c550::function_7df6bb60("zm_white_ww_husk_part", 0, self);
	level.s_ww_printer_compartment.entity playsound("evt_rgun_frame_putback");
	n_slot = self.var_bec34462.n_slot;
	if(isdefined(n_slot) && level.s_ww_interact.var_e76526e8[n_slot].n_state == 0)
	{
		level.s_ww_printer_compartment.entity showpart("tag_gun_" + n_slot);
		level.s_ww_interact.var_e76526e8[n_slot].n_state = 1;
	}
	else
	{
		function_cf5be182();
	}
}

/*
	Name: function_508273b4
	Namespace: namespace_a01a2431
	Checksum: 0xAA3A1EB3
	Offset: 0x27F8
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function function_508273b4()
{
	n_slot = self.var_bec34462.n_slot;
	s_slot = level.s_ww_interact.var_e76526e8[n_slot];
	zm_weapons::weapon_give(s_slot.var_2153c223, 1);
	if(isdefined(s_slot.n_ammo_clip))
	{
		self setweaponammoclip(s_slot.var_2153c223, s_slot.n_ammo_clip);
		self setweaponammostock(s_slot.var_2153c223, s_slot.var_510d7f2b);
		if(isdefined(s_slot.var_f702cf26))
		{
			self setweaponammoclip(s_slot.var_2153c223.dualwieldweapon, s_slot.var_f702cf26);
		}
	}
	s_slot.n_state = 0;
	level.s_ww_printer_compartment.entity hidepart("tag_gun_full_" + n_slot);
}

/*
	Name: function_bdc61146
	Namespace: namespace_a01a2431
	Checksum: 0x71CE1EDB
	Offset: 0x2948
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_bdc61146()
{
	var_ea6b9209 = self namespace_9cf755b::function_c7274071();
	if(var_ea6b9209.dualwieldweapon != level.weaponnone)
	{
		var_f702cf26 = self getweaponammoclip(var_ea6b9209.dualwieldweapon);
	}
	function_b308d26b(var_ea6b9209, self getweaponammoclip(var_ea6b9209), self getweaponammostock(var_ea6b9209), var_f702cf26);
	zm_weapons::weapon_take(var_ea6b9209);
}

/*
	Name: function_b308d26b
	Namespace: namespace_a01a2431
	Checksum: 0x72615298
	Offset: 0x2A18
	Size: 0xFC
	Parameters: 4
	Flags: Linked
*/
function function_b308d26b(var_ea6b9209, n_ammo_clip, var_510d7f2b, var_f702cf26)
{
	n_slot = function_50564ecc(var_ea6b9209);
	s_slot = level.s_ww_interact.var_e76526e8[n_slot];
	s_slot.n_ammo_clip = n_ammo_clip;
	s_slot.var_510d7f2b = var_510d7f2b;
	s_slot.var_f702cf26 = var_f702cf26;
	function_83699c26(n_slot);
	s_slot.n_state = 2;
	s_slot.var_2153c223 = var_ea6b9209;
	level.s_ww_printer_compartment.entity showpart("tag_gun_full_" + n_slot);
}

/*
	Name: function_50564ecc
	Namespace: namespace_a01a2431
	Checksum: 0x31D7F6C0
	Offset: 0x2B20
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function function_50564ecc(var_281cb902)
{
	if(isdefined(var_281cb902))
	{
		if(var_281cb902 == level.var_2aeeb358[4] || var_281cb902 == level.var_2aeeb358[5])
		{
			return 0;
		}
		if(var_281cb902 == level.var_2aeeb358[6] || var_281cb902 == level.var_2aeeb358[7])
		{
			return 1;
		}
		if(var_281cb902 == level.var_2aeeb358[8] || var_281cb902 == level.var_2aeeb358[9])
		{
			return 2;
		}
		return 3;
	}
}

/*
	Name: function_83699c26
	Namespace: namespace_a01a2431
	Checksum: 0xDDBA2F47
	Offset: 0x2C00
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_83699c26(n_slot)
{
	s_slot = level.s_ww_interact.var_e76526e8[n_slot];
	if(s_slot.n_state == 1)
	{
		function_cf5be182();
		s_slot.n_state = 0;
		level.s_ww_printer_compartment.entity hidepart("tag_gun_" + n_slot);
	}
}

/*
	Name: function_cf5be182
	Namespace: namespace_a01a2431
	Checksum: 0x219B0FAD
	Offset: 0x2CA0
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_cf5be182()
{
	n_slot = function_5c934f81(0);
	if(isdefined(n_slot))
	{
		level.s_ww_interact.var_e76526e8[n_slot].n_state = 1;
		level.s_ww_printer_compartment.entity showpart("tag_gun_" + n_slot);
	}
	/#
		if(!isdefined(n_slot))
		{
			iprintln("");
		}
	#/
}

/*
	Name: function_5c934f81
	Namespace: namespace_a01a2431
	Checksum: 0x4485457F
	Offset: 0x2D58
	Size: 0x70
	Parameters: 1
	Flags: Linked
*/
function function_5c934f81(n_state)
{
	var_e76526e8 = level.s_ww_interact.var_e76526e8;
	for(i = 0; i < var_e76526e8.size; i++)
	{
		if(var_e76526e8[i].n_state == n_state)
		{
			return i;
		}
	}
}

/*
	Name: function_ae224cc2
	Namespace: namespace_a01a2431
	Checksum: 0xDE7FA2C
	Offset: 0x2DD8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_ae224cc2()
{
	var_ea6b9209 = self namespace_9cf755b::function_c7274071();
	zm_weapons::weapon_take(var_ea6b9209);
}

/*
	Name: function_117157d7
	Namespace: namespace_a01a2431
	Checksum: 0x7681551C
	Offset: 0x2E20
	Size: 0x2AA
	Parameters: 0
	Flags: Linked
*/
function function_117157d7()
{
	var_1c55459 = self.var_382b64f2 === 1;
	var_2c09b688 = self namespace_9cf755b::function_c7274071();
	s_action = spawnstruct();
	foreach(s_ww_pickup in level.var_c13ed74d)
	{
		if(self namespace_7d8e6ec3::function_bcec00bc(s_ww_pickup.origin, 15, 0))
		{
			n_slot = s_ww_pickup.script_int;
			break;
		}
	}
	if(isdefined(n_slot))
	{
		s_action.n_slot = n_slot;
		if(level.s_ww_interact.var_e76526e8[n_slot].n_state == 2)
		{
			if(var_1c55459)
			{
				if(isdefined(var_2c09b688))
				{
					s_action.n_id = 8;
				}
				else
				{
					s_action.n_id = 5;
				}
			}
			else if(isdefined(var_2c09b688))
			{
				if(namespace_9cf755b::function_c654e39a(var_2c09b688))
				{
					s_action.n_id = 4;
				}
				else
				{
					s_action.n_id = 7;
				}
			}
			else
			{
				s_action.n_id = 2;
			}
		}
		else if(level.s_ww_interact.var_e76526e8[n_slot].n_state == 1 && namespace_9cf755b::function_c654e39a(var_2c09b688))
		{
			s_action.n_id = 6;
		}
	}
	if(!isdefined(s_action.n_id))
	{
		if(var_1c55459)
		{
			s_action.n_id = 1;
		}
		else if(namespace_9cf755b::function_c654e39a(var_2c09b688))
		{
			s_action.n_id = 3;
		}
		else if(function_8ff10cdc())
		{
			s_action.n_id = 0;
		}
		else
		{
			s_action.n_id = 9;
		}
	}
	return s_action;
}

/*
	Name: function_8ff10cdc
	Namespace: namespace_a01a2431
	Checksum: 0x20E18429
	Offset: 0x30D8
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_8ff10cdc()
{
	foreach(s_slot in level.s_ww_interact.var_e76526e8)
	{
		if(s_slot.n_state == 1)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_63841688
	Namespace: namespace_a01a2431
	Checksum: 0x425E1096
	Offset: 0x3170
	Size: 0x5C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_63841688()
{
	callback::on_disconnect(&on_disconnect);
	level thread pap_timeout_watcher();
	callback::function_33f0ddd3(&function_33f0ddd3);
}

/*
	Name: on_disconnect
	Namespace: namespace_a01a2431
	Checksum: 0xEEEA4EA4
	Offset: 0x31D8
	Size: 0xBC
	Parameters: 0
	Flags: Linked, Private
*/
private function on_disconnect()
{
	if(self.var_382b64f2 === 1)
	{
		function_cf5be182();
		/#
			iprintln("");
		#/
	}
	else
	{
		var_ea6b9209 = self namespace_9cf755b::function_c7274071();
		if(namespace_9cf755b::function_c654e39a(var_ea6b9209))
		{
			function_537cf9cc(var_ea6b9209, self getweaponammoclip(var_ea6b9209), self getweaponammostock(var_ea6b9209));
		}
	}
}

/*
	Name: pap_timeout_watcher
	Namespace: namespace_a01a2431
	Checksum: 0xE2768D31
	Offset: 0x32A0
	Size: 0xA0
	Parameters: 0
	Flags: Linked, Private
*/
private function pap_timeout_watcher()
{
	level endon(#"end_game");
	while(true)
	{
		s_notify = undefined;
		s_notify = level waittill(#"pap_timeout");
		var_dbf50034 = s_notify.var_5e879929.unitrigger_stub.upgrade_weapon;
		if(namespace_9cf755b::function_c654e39a(var_dbf50034))
		{
			function_537cf9cc(var_dbf50034);
		}
	}
}

/*
	Name: function_33f0ddd3
	Namespace: namespace_a01a2431
	Checksum: 0x7E646D7F
	Offset: 0x3348
	Size: 0x24C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_33f0ddd3(s_event)
{
	if(s_event.event === "take_weapon" && namespace_9cf755b::function_c654e39a(s_event.weapon))
	{
		b_rescue = 0;
		var_ea6b9209 = s_event.weapon;
		if(level flag::get("round_reset") || level flag::get(#"hash_6acab8bde7078239"))
		{
			b_rescue = !isinarray(self.var_c27f1e90, #"specialty_additionalprimaryweapon") && self.var_2a62e678 === var_ea6b9209;
		}
		else
		{
			var_a84febff = getent("zm_pack_a_punch", "targetname");
			var_e75ac4c0 = var_a84febff.unitrigger_stub.current_weapon === var_ea6b9209;
			n_slot = function_50564ecc(var_ea6b9209);
			var_87103d2d = level.s_ww_interact.var_e76526e8[n_slot].n_state == 2;
			if(!var_e75ac4c0 && !var_87103d2d && !isdefined(self.var_679c4d4e))
			{
				b_rescue = 1;
			}
		}
		if(b_rescue)
		{
			if(var_ea6b9209.dualwieldweapon != level.weaponnone)
			{
				var_f702cf26 = self getweaponammoclip(var_ea6b9209.dualwieldweapon);
			}
			function_537cf9cc(var_ea6b9209, self getweaponammoclip(var_ea6b9209), self getweaponammostock(var_ea6b9209), var_f702cf26);
		}
	}
}

/*
	Name: function_537cf9cc
	Namespace: namespace_a01a2431
	Checksum: 0xC56585CA
	Offset: 0x35A0
	Size: 0x74
	Parameters: 4
	Flags: Linked, Private
*/
private function function_537cf9cc(var_ea6b9209, n_ammo_clip, var_510d7f2b, var_f702cf26)
{
	function_b308d26b(var_ea6b9209, n_ammo_clip, var_510d7f2b, var_f702cf26);
	/#
		iprintln(function_a16a090d(var_ea6b9209) + "");
	#/
}

/*
	Name: function_6392f719
	Namespace: namespace_a01a2431
	Checksum: 0x11FC6434
	Offset: 0x3620
	Size: 0x1C4
	Parameters: 0
	Flags: Linked
*/
function function_6392f719()
{
	self showpart("tag_screen_off");
	self hidepart("tag_screen_static");
	self hidepart("tag_screen_on");
	self hidepart("tag_screen_overlay_0");
	self hidepart("tag_screen_overlay_1");
	self hidepart("tag_screen_overlay_2");
	self hidepart("tag_screen_overlay_3");
	self hidepart("tag_screen_overlay_4");
	self hidepart("tag_screen_overlay_5");
	self hidepart("tag_screen_overlay_6");
	self hidepart("tag_screen_overlay_7");
	self hidepart("tag_screen_overlay_8");
	self hidepart("tag_screen_overlay_9");
	self hidepart("tag_screen_overlay_gun");
}

/*
	Name: function_bb7d7e2d
	Namespace: namespace_a01a2431
	Checksum: 0x20371E5A
	Offset: 0x37F0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_bb7d7e2d()
{
	self hidepart("tag_screen_off");
	self showpart("tag_screen_static");
}

/*
	Name: function_8ebc8dcf
	Namespace: namespace_a01a2431
	Checksum: 0x897517E7
	Offset: 0x3840
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function function_8ebc8dcf(n_value)
{
	self function_4f2e2bb();
	self showpart("tag_screen_on");
	if(n_value >= 0 && n_value <= 9)
	{
		var_e5f51c1 = "tag_screen_overlay_" + n_value;
	}
	else
	{
		var_e5f51c1 = "tag_screen_overlay_gun";
	}
	self showpart(var_e5f51c1);
}

/*
	Name: function_4f2e2bb
	Namespace: namespace_a01a2431
	Checksum: 0xB22862C1
	Offset: 0x38E8
	Size: 0x1C4
	Parameters: 0
	Flags: Linked
*/
function function_4f2e2bb()
{
	self hidepart("tag_screen_static");
	self hidepart("tag_screen_off");
	self hidepart("tag_screen_on");
	self hidepart("tag_screen_overlay_0");
	self hidepart("tag_screen_overlay_1");
	self hidepart("tag_screen_overlay_2");
	self hidepart("tag_screen_overlay_3");
	self hidepart("tag_screen_overlay_4");
	self hidepart("tag_screen_overlay_5");
	self hidepart("tag_screen_overlay_6");
	self hidepart("tag_screen_overlay_7");
	self hidepart("tag_screen_overlay_8");
	self hidepart("tag_screen_overlay_9");
	self hidepart("tag_screen_overlay_gun");
}

