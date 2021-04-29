// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5bb072c3abf4652c;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_57873b62;

/*
	Name: init
	Namespace: namespace_57873b62
	Checksum: 0x5F7E4A52
	Offset: 0x8A8
	Size: 0x1E0
	Parameters: 0
	Flags: Linked
*/
function init()
{
	getent("yoshi_doshi", "targetname") hide();
	init_clientfields();
	if(zm_utility::function_e51dc2d8())
	{
		init_flags();
		function_b11c26c9();
		level thread function_ea0460f4();
		level thread function_d3a41243();
		level thread function_59ecbee4();
		level thread function_8a44027();
		level thread function_7b89f32a();
		level thread function_558936ed();
		level thread function_678d6318();
		level thread function_a425bf07();
	}
	else
	{
		function_904b119();
		foreach(var_255658de in getentarray("leeloo_blue", "targetname"))
		{
			var_255658de delete();
		}
	}
}

/*
	Name: init_clientfields
	Namespace: namespace_57873b62
	Checksum: 0xC87DA794
	Offset: 0xA90
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"hash_e49c6031d46d5fe", 1, 1, "int");
}

/*
	Name: init_flags
	Namespace: namespace_57873b62
	Checksum: 0x2595729D
	Offset: 0xAE0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_7ae1182e79a1d06e");
}

/*
	Name: function_904b119
	Namespace: namespace_57873b62
	Checksum: 0x3CF8620C
	Offset: 0xB10
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_904b119()
{
	hidemiscmodels("freerangeanimalcrackers");
	getent("bloody_sight", "targetname") hide();
	getent("life_preserver_catch", "targetname") hide();
	getent("life_preserver_catch" + "_l", "targetname") hide();
	getent("life_preserver_catch" + "_r", "targetname") hide();
}

/*
	Name: function_a425bf07
	Namespace: namespace_57873b62
	Checksum: 0x77EFC285
	Offset: 0xC18
	Size: 0x2DA
	Parameters: 0
	Flags: Linked
*/
function function_a425bf07()
{
	var_581db771 = struct::get(#"hash_73fb993ed5a0cbfe");
	var_c597d89a = struct::get(var_581db771.target);
	var_39dbb29f = util::spawn_model(#"hash_249386b68e19b345", var_581db771.origin, var_581db771.angles);
	s_unitrigger = var_c597d89a zm_unitrigger::create(undefined, 32);
	var_c597d89a waittill(#"trigger_activated");
	var_39dbb29f thread function_e7fd1a33();
	while(true)
	{
		for(i = 0; i < var_2c8f1222.size; i++)
		{
			var_845efa03 = var_39dbb29f namespace_891c9bac::function_8e0f4696(var_2c8f1222[i]);
			if(!(isdefined(var_845efa03) && var_845efa03))
			{
				i--;
			}
			wait(0.25);
			var_c597d89a waittill(#"trigger_activated");
		}
	}
}

/*
	Name: function_e7fd1a33
	Namespace: namespace_57873b62
	Checksum: 0xC32B4796
	Offset: 0xF00
	Size: 0x258
	Parameters: 0
	Flags: Linked
*/
function function_e7fd1a33()
{
	self endon(#"death");
	var_f21d9eb3 = int(self.origin[0] - 12);
	while(isdefined(self))
	{
		wait(randomintrange(15, 30));
		while(true)
		{
			b_move = 1;
			players = util::get_active_players();
			foreach(player in players)
			{
				if(!isdefined(player))
				{
					continue;
				}
				if(player util::is_looking_at(self.origin))
				{
					b_move = 0;
					break;
				}
				waitframe(1);
			}
			if(b_move)
			{
				break;
			}
			wait(1);
		}
		n_rotate = randomintrange(160, 200);
		var_5a5f5d36 = randomintrange(var_f21d9eb3, n_max_x);
		self rotateto((self.angles[0], n_rotate, self.angles[2]), 0.25);
		self moveto((var_5a5f5d36, self.origin[1], self.origin[2]), 0.25);
	}
}

/*
	Name: function_7b89f32a
	Namespace: namespace_57873b62
	Checksum: 0x340857B9
	Offset: 0x1160
	Size: 0x284
	Parameters: 0
	Flags: Linked
*/
function function_7b89f32a()
{
	var_ff4b3a13 = getent("clottedcreamtea", "targetname");
	if(!isdefined(var_ff4b3a13))
	{
		return;
	}
	var_ff4b3a13 val::set(#"hash_53b16633b6e88995", "takedamage", 1);
	var_ff4b3a13 val::set(#"hash_53b16633b6e88995", "allowdeath", 0);
	w_weapon = getweapon(#"bowie_knife");
	while(var_61456417 < 9)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = var_ff4b3a13 waittill(#"damage");
		if(var_88706ea7.mod === #"mod_melee")
		{
			var_61456417++;
		}
	}
	s_loc = struct::get(#"clottedcreamtea");
	v_offset = vectorscale((0, 0, -1), 32);
	var_55e11aa9 = util::spawn_model("tag_origin", var_ff4b3a13.origin + v_offset, var_ff4b3a13.angles);
	var_ff4b3a13 linkto(var_55e11aa9);
	v_offset = (0, 20, 24);
	var_55e11aa9 moveto(s_loc.origin + v_offset, 1.5, 1.5);
	var_55e11aa9 rotatepitch(138, 1.5, 1.5);
	var_55e11aa9 waittill(#"movedone");
	var_55e11aa9 delete();
	var_ff4b3a13 disconnectpaths();
}

/*
	Name: function_8a44027
	Namespace: namespace_57873b62
	Checksum: 0x1663F92E
	Offset: 0x13F0
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_8a44027()
{
	scene::add_scene_func(#"hash_35a9b11128e1f7c9", &function_c3a5f1fe);
	scene::play(#"hash_35a9b11128e1f7c9");
}

/*
	Name: function_c3a5f1fe
	Namespace: namespace_57873b62
	Checksum: 0x579C49CE
	Offset: 0x1450
	Size: 0x204
	Parameters: 1
	Flags: Linked
*/
function function_c3a5f1fe(a_ents)
{
	var_e96b5d4f = a_ents[getfirstarraykey(a_ents)];
	var_e96b5d4f val::set(#"hash_6917ff944158c40d", "takedamage", 1);
	var_e96b5d4f val::set(#"hash_6917ff944158c40d", "allowdeath", 0);
	w_weapon = getweapon(#"hash_95dd69e40d99560");
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = var_e96b5d4f waittill(#"damage");
		if(var_88706ea7.weapon === w_weapon || var_88706ea7.weapon === var_eb115bf1)
		{
			if(isalive(var_88706ea7.attacker) && isplayer(var_88706ea7.attacker))
			{
				var_88706ea7.attacker util::show_hit_marker(1);
				break;
			}
		}
	}
	var_617131bd = getent("pages_of_words", "targetname");
	var_617131bd setmodel(#"hash_6a0ad79cfc79892d");
	var_e96b5d4f delete();
}

/*
	Name: function_59ecbee4
	Namespace: namespace_57873b62
	Checksum: 0x10316C11
	Offset: 0x1660
	Size: 0x1B0
	Parameters: 0
	Flags: Linked
*/
function function_59ecbee4()
{
	level waittill(#"hash_29cfd2a7a3f9f175");
	level thread function_240b713f();
	while(true)
	{
		b_show = 0;
		if(!(isdefined(level.var_7f5f5e6b) && level.var_7f5f5e6b))
		{
			foreach(player in util::get_players())
			{
				if(isdefined(player.var_6afa034c) && (isdefined(player.var_d6fe2916) && player.var_d6fe2916))
				{
					if(distancesquared(player.var_6afa034c.origin, var_5c608f55.origin) < 57600)
					{
						b_show = 1;
						break;
					}
				}
			}
		}
		if(b_show)
		{
			var_5c608f55 show();
		}
		else
		{
			var_5c608f55 hide();
		}
		wait(0.5);
	}
}

/*
	Name: function_240b713f
	Namespace: namespace_57873b62
	Checksum: 0x72D7E820
	Offset: 0x1818
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function function_240b713f()
{
	while(true)
	{
		if(level.e_clip_water_fore.origin[2] < 600)
		{
			level.var_7f5f5e6b = 1;
		}
		else
		{
			level.var_7f5f5e6b = 0;
		}
		wait(0.5);
	}
}

/*
	Name: function_d3a41243
	Namespace: namespace_57873b62
	Checksum: 0x1E59305A
	Offset: 0x1878
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function function_d3a41243()
{
	t_damage = spawn("trigger_damage", struct::get(#"hash_7dc6a17096359ecd").origin, 0, 6, 6);
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = t_damage waittill(#"damage");
		if(var_88706ea7.weapon === var_1bdfceb3)
		{
			mdl_fx = util::spawn_model("tag_origin", struct::get(#"hash_351dccee011931a").origin);
			mdl_fx linkto(level.var_56665536);
			mdl_fx clientfield::set("" + #"hash_e49c6031d46d5fe", 1);
			break;
		}
	}
}

/*
	Name: function_ea0460f4
	Namespace: namespace_57873b62
	Checksum: 0x991B3F9E
	Offset: 0x19F8
	Size: 0x5B8
	Parameters: 0
	Flags: Linked
*/
function function_ea0460f4()
{
	var_314c1b5a = [];
	var_314c1b5a[0] = array("vox_ee_diary_first_disc_0", "vox_ee_diary_first_disc_1", "vox_ee_diary_first_disc_2");
	var_314c1b5a[1] = array("vox_ee_prima_materia_alis_0", "vox_ee_prima_materia_alis_1");
	var_314c1b5a[2] = array("vox_ee_artifact_alis_0");
	var_314c1b5a[3] = array("vox_ee_sent_trial_alis_0", "vox_ee_sent_trial_alis_1");
	var_314c1b5a[4] = array("vox_ee_obsession_alis_0");
	var_314c1b5a[5] = array("vox_ee_order_alis_0");
	var_314c1b5a[6] = array("vox_ee_diary_order_leader_dlea_0");
	var_314c1b5a[7] = array("vox_ee_diary_brun_dieg_plr_3_0", "vox_ee_diary_brun_dieg_plr_2_1", "vox_ee_diary_brun_dieg_plr_3_2", "vox_ee_diary_brun_dieg_plr_2_3", "vox_ee_diary_brun_dieg_plr_3_4", "vox_ee_diary_brun_dieg_plr_2_5", "vox_ee_diary_brun_dieg_plr_3_6", "vox_ee_diary_brun_dieg_plr_2_7", "vox_ee_diary_brun_dieg_plr_3_8", "vox_ee_diary_brun_dieg_plr_2_9", "vox_ee_diary_brun_dieg_plr_3_10", "vox_ee_diary_brun_dieg_plr_2_11", "vox_ee_diary_brun_dieg_plr_3_12", "vox_ee_diary_brun_dieg_plr_2_13", "vox_ee_diary_brun_dieg_plr_3_14", "vox_ee_diary_brun_dieg_plr_2_15", "vox_ee_diary_brun_dieg_plr_3_16", "vox_ee_diary_brun_dieg_plr_2_17", "vox_ee_diary_brun_dieg_plr_3_18", "vox_ee_diary_brun_dieg_plr_2_19", "vox_ee_diary_brun_dieg_plr_3_20", "vox_ee_diary_brun_dieg_plr_2_21");
	var_314c1b5a[8] = array("vox_ee_diary_scar_shaw_plr_4_0", "vox_ee_diary_scar_shaw_plr_1_1", "vox_ee_diary_scar_shaw_plr_4_2", "vox_ee_diary_scar_shaw_plr_1_3", "vox_ee_diary_scar_shaw_plr_4_4", "vox_ee_diary_scar_shaw_plr_1_5", "vox_ee_diary_scar_shaw_plr_4_6", "vox_ee_diary_scar_shaw_plr_1_7", "vox_ee_diary_scar_shaw_plr_4_8", "vox_ee_diary_scar_shaw_plr_1_9", "vox_ee_diary_scar_shaw_plr_4_10", "vox_ee_diary_scar_shaw_plr_1_11", "vox_ee_diary_scar_shaw_plr_4_12", "vox_ee_diary_scar_shaw_plr_1_13", "vox_ee_diary_scar_shaw_plr_4_14", "vox_ee_diary_scar_shaw_plr_1_15", "vox_ee_diary_scar_shaw_plr_4_16", "vox_ee_diary_scar_shaw_plr_1_17");
	var_b90f3bf3 = getentarray("leeloo_blue", "targetname");
	var_18a4ffb4 = [];
	for(i = 0; i < var_b90f3bf3.size; i++)
	{
		foreach(var_255658de in var_b90f3bf3)
		{
			if(i == var_255658de.script_int)
			{
				var_18a4ffb4[i] = var_255658de;
				break;
			}
		}
	}
	var_b90f3bf3 = undefined;
	foreach(var_255658de in var_18a4ffb4)
	{
		s_unitrigger = var_255658de zm_unitrigger::create();
		zm_unitrigger::function_89380dda(s_unitrigger);
		if(isdefined(var_255658de.target))
		{
			var_c597d89a = struct::get(var_255658de.target);
			zm_unitrigger::function_47625e58(s_unitrigger, var_c597d89a.origin);
		}
		var_255658de thread function_aba430c2(s_unitrigger);
		var_255658de val::set(#"hash_4a35aca1f4d4f559", "takedamage", 1);
		var_255658de val::set(#"hash_4a35aca1f4d4f559", "allowdeath", 0);
	}
	var_b27c3401 = struct::get_array(#"hash_44ff0c493e2791eb");
	foreach(var_66a89e74 in var_b27c3401)
	{
		s_unitrigger = var_66a89e74 zm_unitrigger::create();
		var_66a89e74 thread function_63c3fd24(var_314c1b5a);
		if(isdefined(var_66a89e74.target))
		{
			var_c597d89a = struct::get(var_66a89e74.target);
			zm_unitrigger::function_47625e58(s_unitrigger, var_c597d89a.origin);
		}
	}
}

/*
	Name: function_aba430c2
	Namespace: namespace_57873b62
	Checksum: 0xAE1D83FB
	Offset: 0x1FB8
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_aba430c2(s_unitrigger)
{
	while(isdefined(self))
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"trigger_activated");
		e_player = var_88706ea7.e_who;
		if(isdefined(e_player) && !isdefined(e_player.var_68c35930))
		{
			e_player playsound(#"hash_7e0e4a1fb470d18f");
			e_player.var_68c35930 = self;
			self hide();
			zm_unitrigger::unregister_unitrigger(s_unitrigger);
			break;
		}
	}
}

/*
	Name: function_63c3fd24
	Namespace: namespace_57873b62
	Checksum: 0x7A5FA4D2
	Offset: 0x2098
	Size: 0x390
	Parameters: 1
	Flags: Linked
*/
function function_63c3fd24(var_314c1b5a)
{
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"trigger_activated");
		e_player = var_88706ea7.e_who;
		if(isdefined(e_player))
		{
			if(isdefined(e_player.var_68c35930) && !isdefined(self.var_68c35930))
			{
				self.var_68c35930 = e_player.var_68c35930;
				self.var_68c35930.origin = self.origin;
				self.var_68c35930.angles = self.angles;
				self.var_68c35930 show();
				self.var_68c35930 playsound(#"hash_343bf66b64f5830e");
				e_player.var_68c35930 = undefined;
			}
			if(!isdefined(self.var_68c35930) || level flag::get(#"hash_7ae1182e79a1d06e"))
			{
				continue;
			}
			self.var_68c35930 thread function_64834acd();
			level flag::set(#"hash_7ae1182e79a1d06e");
			self.var_68c35930 notify(#"hash_2b02b5a5a9af36e0");
			self.var_68c35930 notify(#"hash_44144f80f295a13f");
			self.var_68c35930 playsound(#"hash_7c91fa775c8a0134");
			if(self.var_68c35930.script_int == 0)
			{
				self.var_68c35930 playloopsound(#"hash_3d52d57aceee74ce");
			}
			else if(self.var_68c35930.script_int == 7)
			{
				self.var_68c35930 playloopsound(#"hash_5b492b8c8a8bb4d8");
			}
			else if(self.var_68c35930.script_int == 8)
			{
				self.var_68c35930 playloopsound(#"hash_704a9f09fe3a48c2");
			}
			else
			{
				self.var_68c35930 playloopsound(#"hash_2367dae4a69a4294");
			}
			wait(1);
			self.var_68c35930 namespace_891c9bac::function_cf1e151c(var_314c1b5a[self.var_68c35930.script_int]);
			level flag::clear(#"hash_7ae1182e79a1d06e");
			self.var_68c35930 notify(#"hash_53eb32eaa511640c");
			self.var_68c35930 stoploopsound();
			self.var_68c35930 playsound(#"hash_376eaa517cd09530");
			self.var_68c35930 thread function_ad05f6f3();
		}
	}
}

/*
	Name: function_64834acd
	Namespace: namespace_57873b62
	Checksum: 0x97239017
	Offset: 0x2430
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function function_64834acd()
{
	self notify("5029a7add8d29938");
	self endon("5029a7add8d29938");
	self endon(#"death");
	while(true)
	{
		self function_21a979f7();
		self waittill(#"hash_44144f80f295a13f");
	}
}

/*
	Name: function_21a979f7
	Namespace: namespace_57873b62
	Checksum: 0x2C276FDB
	Offset: 0x24A0
	Size: 0x9E
	Parameters: 0
	Flags: Linked
*/
function function_21a979f7()
{
	self endon(#"hash_53eb32eaa511640c");
	while(true)
	{
		if(self.angles[0] < 360)
		{
			self.angles = self.angles + vectorscale((1, 0, 0), 360);
		}
		self rotatepitch(self.angles[0] + 180 * -1, 2);
		self waittill(#"rotatedone");
	}
}

/*
	Name: function_ad05f6f3
	Namespace: namespace_57873b62
	Checksum: 0xDA1802A7
	Offset: 0x2548
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_ad05f6f3()
{
	self notify(#"hash_2b02b5a5a9af36e0");
	self endon(#"hash_2b02b5a5a9af36e0");
	while(isdefined(self))
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"damage");
		if(isplayer(var_88706ea7.attacker))
		{
			break;
		}
	}
	playsoundatposition(#"hash_2cf59d6222de4f6f", self.origin);
	self delete();
}

/*
	Name: function_558936ed
	Namespace: namespace_57873b62
	Checksum: 0x3891C72E
	Offset: 0x2608
	Size: 0xA94
	Parameters: 0
	Flags: Linked
*/
function function_558936ed()
{
	var_48c8e2bc = struct::get(#"hash_1ff61dc18e3fe8c");
	var_87e0cf0b = spawn("trigger_damage", var_48c8e2bc.origin - vectorscale((0, 0, 1), 10), 0, 12, 10);
	var_c75fe44b = util::spawn_model(#"hash_2ce772d39f43cc44" + "a", var_48c8e2bc.origin, var_48c8e2bc.angles);
	var_c75fe44b setscale(0.18);
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "b");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "c");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "d");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "e");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "f");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "g");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "h");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "i");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "i");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "h");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "j");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "d");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "k");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "h");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "l");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "b");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "e");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "i");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "j");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "d");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "b");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "m");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "f");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "d");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "h");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "a");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "b");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "c");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "e");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "d");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "k");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "n");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "e");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "m");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "d");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "o");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "b");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "e");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "g");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "n");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "b");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "i");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "h");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "p");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "q");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "h");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "a");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "b");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "c");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "e");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "h");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "d");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "c");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "e");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "p");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "h");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "j");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "d");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "b");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "r");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "h");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "s");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "n");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "q");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "b");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "m");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "d");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "n");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "i");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "i");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "t");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "f");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "e");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "q");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "k");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "h");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b, "j");
	var_c75fe44b function_7c9ab1ea(var_87e0cf0b);
}

/*
	Name: function_7c9ab1ea
	Namespace: namespace_57873b62
	Checksum: 0xE36C2E04
	Offset: 0x30A8
	Size: 0x1D2
	Parameters: 2
	Flags: Linked
*/
function function_7c9ab1ea(var_87e0cf0b, var_f96aafd8)
{
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = var_87e0cf0b waittill(#"trigger");
		if(isdefined(var_88706ea7.activator) && isplayer(var_88706ea7.activator))
		{
			self rotateroll(360, 0.25);
			self waittill(#"rotatedone");
			if(!isdefined(var_f96aafd8))
			{
				self delete();
				break;
			}
			self setmodel(#"hash_2ce772d39f43cc44" + var_f96aafd8);
			self setscale(0.18);
			self.angles = (0, self.angles[1], self.angles[2]);
			self hide();
			waitframe(1);
			self show();
			self rotateroll(360, 0.5);
			self waittill(#"rotatedone");
			self.angles = (0, self.angles[1], self.angles[2]);
			break;
		}
	}
}

/*
	Name: function_b11c26c9
	Namespace: namespace_57873b62
	Checksum: 0xC3ACE64C
	Offset: 0x3288
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function function_b11c26c9()
{
	var_56665536 = getent("skybox_water", "targetname");
	var_4f3558ce = getent("life_preserver_catch", "targetname");
	var_21bb918c = getent("life_preserver_catch" + "_l", "targetname");
	var_c8279d50 = getent("life_preserver_catch" + "_r", "targetname");
	var_4f3558ce setscale(5);
	var_21bb918c setscale(1.75);
	var_c8279d50 setscale(1.75);
	var_4f3558ce linkto(var_56665536);
	var_21bb918c linkto(var_56665536);
	var_c8279d50 linkto(var_56665536);
	var_4f3558ce ghost();
	var_21bb918c ghost();
	var_c8279d50 ghost();
	level thread function_c867ac0a(var_4f3558ce, var_21bb918c, var_c8279d50);
}

/*
	Name: function_e1a452f5
	Namespace: namespace_57873b62
	Checksum: 0xBE7DEFAE
	Offset: 0x3468
	Size: 0x2C0
	Parameters: 3
	Flags: Linked
*/
function function_e1a452f5(var_4f3558ce, var_21bb918c, var_c8279d50)
{
	level endon(#"hash_6aec924aa525b354");
	var_4f3558ce setinvisibletoplayer(self);
	var_21bb918c setinvisibletoplayer(self);
	var_c8279d50 setinvisibletoplayer(self);
	while(true)
	{
		var_93027823 = trigger::wait_till("trigger_life_preserver", "targetname", self);
		player = var_93027823.who;
		if(isalive(player))
		{
			weapon = player getcurrentweapon();
			if(player === self && isdefined(weapon) && player adsbuttonpressed() && util::getweaponclass(weapon) === #"weapon_sniper")
			{
				wait(0.2);
				if(isalive(player))
				{
					level notify(#"hash_57175159706ca9bf");
					var_4f3558ce setvisibletoplayer(player);
					var_21bb918c setvisibletoplayer(player);
					var_c8279d50 setvisibletoplayer(player);
					do
					{
						wait(0.25);
					}
					while(isalive(player) && player adsbuttonpressed() && player istouching(var_93027823) && player util::is_looking_at(var_4f3558ce));
					if(isalive(player))
					{
						var_4f3558ce setinvisibletoplayer(player);
						var_21bb918c setinvisibletoplayer(player);
						var_c8279d50 setinvisibletoplayer(player);
					}
				}
			}
		}
		wait(0.2);
	}
}

/*
	Name: function_c867ac0a
	Namespace: namespace_57873b62
	Checksum: 0xC3AECF2D
	Offset: 0x3730
	Size: 0x106C
	Parameters: 3
	Flags: Linked
*/
function function_c867ac0a(var_4f3558ce, var_21bb918c, var_c8279d50)
{
	level waittill(#"power_on");
	trigger::wait_till("trigger_life_preserver");
	var_4f3558ce thread scene::play(#"hash_3cfd8e7348ff04ed", var_4f3558ce);
	var_4f3558ce show();
	var_21bb918c show();
	var_c8279d50 show();
	foreach(player in util::get_players())
	{
		player thread function_e1a452f5(var_4f3558ce, var_21bb918c, var_c8279d50);
	}
	callback::on_connect(&function_e1a452f5, undefined, var_4f3558ce, var_21bb918c, var_c8279d50);
	level waittill(#"hash_57175159706ca9bf");
	var_4f3558ce sethighdetail(1);
	var_21bb918c sethighdetail(1);
	var_c8279d50 sethighdetail(1);
	var_21bb918c.var_55e11aa9 = util::spawn_model("tag_origin", var_21bb918c.origin);
	var_c8279d50.var_55e11aa9 = util::spawn_model("tag_origin", var_c8279d50.origin);
	var_21bb918c.var_55e11aa9 linkto(level.var_56665536);
	var_c8279d50.var_55e11aa9 linkto(level.var_56665536);
	var_3ddef74 = function_a7ae2066();
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"start");
	wait(1);
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"y");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"o");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"u");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"space");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"h");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"a");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"v");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"e");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"space");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"q");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"u");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"e");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"s");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"t");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"i");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"o");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"n");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"s");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"space");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"o");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"f");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"space");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"y");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"o");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"u");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"r");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"space");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"f");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"a");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"m");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"i");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"l");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"y");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"s");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"space");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"h");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"i");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"s");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"t");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"o");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"r");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"y");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"space");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"y");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"o");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"u");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"space");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"m");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"a");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"y");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"space");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"n");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"o");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"t");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"space");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"l");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"i");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"k");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"e");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"space");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"w");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"h");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"e");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"r");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"e");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"space");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"t");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"h");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"e");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"space");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"a");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"n");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"s");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"w");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"e");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"r");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"s");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"space");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"l");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"e");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"a");
	function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, #"d");
	callback::remove_on_connect(&function_e1a452f5);
	level notify(#"hash_6aec924aa525b354");
	var_21bb918c.var_55e11aa9 delete();
	var_c8279d50.var_55e11aa9 delete();
	var_21bb918c delete();
	var_c8279d50 delete();
	var_4f3558ce scene::stop(#"hash_3cfd8e7348ff04ed", 1);
	if(isdefined(var_4f3558ce))
	{
		var_4f3558ce delete();
	}
}

/*
	Name: function_dc92e2d4
	Namespace: namespace_57873b62
	Checksum: 0x625A2182
	Offset: 0x47A8
	Size: 0x164
	Parameters: 4
	Flags: Linked
*/
function function_dc92e2d4(var_3ddef74, var_21bb918c, var_c8279d50, str_letter)
{
	var_21bb918c unlink();
	var_c8279d50 unlink();
	var_21bb918c rotateto(var_3ddef74[#"left"][str_letter], 0.5);
	var_c8279d50 rotateto(var_3ddef74[#"right"][str_letter], 0.5);
	var_c8279d50 waittill(#"rotatedone");
	var_21bb918c.origin = var_21bb918c.var_55e11aa9.origin;
	var_c8279d50.origin = var_c8279d50.var_55e11aa9.origin;
	var_21bb918c linkto(level.var_56665536);
	var_c8279d50 linkto(level.var_56665536);
	wait(1.25);
}

/*
	Name: function_a7ae2066
	Namespace: namespace_57873b62
	Checksum: 0xB999511B
	Offset: 0x4918
	Size: 0x5A6
	Parameters: 0
	Flags: Linked
*/
function function_a7ae2066()
{
	var_b1e4b9a0 = [];
	var_75d1ad4a = [];
	var_b1e4b9a0[#"start"] = vectorscale((0, 1, 0), 270);
	var_75d1ad4a[#"start"] = vectorscale((1, 1, 0), 90);
	var_b1e4b9a0[#"space"] = (135, 90, 0);
	var_75d1ad4a[#"space"] = (135, 270, 0);
	var_b1e4b9a0[#"y"] = (45, 270, 0);
	var_75d1ad4a[#"y"] = vectorscale((1, 1, 0), 90);
	var_b1e4b9a0[#"o"] = (90, 270, 0);
	var_75d1ad4a[#"o"] = (45, 270, 0);
	var_b1e4b9a0[#"u"] = (45, 270, 0);
	var_75d1ad4a[#"u"] = (45, 90, 0);
	var_b1e4b9a0[#"h"] = (90, 270, 0);
	var_75d1ad4a[#"h"] = (135, 270, 0);
	var_b1e4b9a0[#"a"] = (135, 270, 0);
	var_75d1ad4a[#"a"] = (180, 90, 0);
	var_b1e4b9a0[#"v"] = vectorscale((0, 1, 0), 270);
	var_75d1ad4a[#"v"] = (135, 90, 0);
	var_b1e4b9a0[#"e"] = (180, 270, 0);
	var_75d1ad4a[#"e"] = (45, 90, 0);
	var_b1e4b9a0[#"q"] = (90, 270, 0);
	var_75d1ad4a[#"q"] = (45, 90, 0);
	var_b1e4b9a0[#"s"] = (90, 270, 0);
	var_75d1ad4a[#"s"] = (135, 90, 0);
	var_b1e4b9a0[#"t"] = (45, 270, 0);
	var_75d1ad4a[#"t"] = vectorscale((0, 1, 0), 90);
	var_b1e4b9a0[#"i"] = (45, 270, 0);
	var_75d1ad4a[#"i"] = (135, 270, 0);
	var_b1e4b9a0[#"n"] = (135, 270, 0);
	var_75d1ad4a[#"n"] = (135, 90, 0);
	var_b1e4b9a0[#"f"] = (180, 270, 0);
	var_75d1ad4a[#"f"] = vectorscale((1, 1, 0), 90);
	var_b1e4b9a0[#"r"] = (90, 270, 0);
	var_75d1ad4a[#"r"] = vectorscale((1, 1, 0), 90);
	var_b1e4b9a0[#"m"] = (135, 270, 0);
	var_75d1ad4a[#"m"] = vectorscale((1, 1, 0), 90);
	var_b1e4b9a0[#"l"] = (135, 270, 0);
	var_75d1ad4a[#"l"] = (45, 90, 0);
	var_b1e4b9a0[#"k"] = (135, 270, 0);
	var_75d1ad4a[#"k"] = vectorscale((0, 1, 0), 90);
	var_b1e4b9a0[#"w"] = (45, 90, 0);
	var_75d1ad4a[#"w"] = vectorscale((1, 1, 0), 90);
	var_b1e4b9a0[#"d"] = vectorscale((0, 1, 0), 270);
	var_75d1ad4a[#"d"] = (180, 90, 0);
	var_b088cf52 = [];
	var_b088cf52[#"left"] = var_b1e4b9a0;
	var_b088cf52[#"right"] = var_75d1ad4a;
	return var_b088cf52;
}

/*
	Name: function_678d6318
	Namespace: namespace_57873b62
	Checksum: 0x9F2255E5
	Offset: 0x4EC8
	Size: 0xE5C
	Parameters: 0
	Flags: Linked
*/
function function_678d6318()
{
	var_c597d89a = struct::get(#"hash_2ca9b43546a096e3");
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = var_c597d89a waittill(#"trigger_activated");
		player = var_88706ea7.e_who;
		if(isalive(player) && isplayer(player))
		{
			if(isdefined(player.var_4618dc52) && isdefined(s_unitrigger.trigger))
			{
				if(player.var_4618dc52 istouching(s_unitrigger.trigger))
				{
					break;
				}
			}
		}
		wait(0.25);
	}
	var_8940de41 = function_7199779e();
	var_ff439c7c = struct::get_array(#"hash_12938a97ea1a6c1");
	var_ba1a70ec = struct::get_array(#"hash_12935a97ea1a1a8");
	var_cf41d641 = struct::get_array(#"hash_12936a97ea1a35b");
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"r");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"u");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"n");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"n");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"i");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"n");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"g");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"space");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"f");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"r");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"o");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"m");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"space");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"y");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"o");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"u");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"r");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"space");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"f");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"o");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"r");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"m");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"e");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"r");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"space");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"l");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"i");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"f");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"e");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"space");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"d");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"o");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"e");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"s");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"space");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"n");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"o");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"t");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"space");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"e");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"r");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"a");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"s");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"e");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"space");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"t");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"h");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"e");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"space");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"s");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"i");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"n");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"s");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"space");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"o");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"f");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"space");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"y");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"o");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"u");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"r");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"space");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"p");
	function_bef7f017(var_c597d89a);
	level thread function_f64a749c(var_ff439c7c, var_8940de41, #"a");
	level thread function_f64a749c(var_ba1a70ec, var_8940de41, #"s");
	level thread function_f64a749c(var_cf41d641, var_8940de41, #"t");
	function_bef7f017(var_c597d89a);
	zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

/*
	Name: function_bef7f017
	Namespace: namespace_57873b62
	Checksum: 0x2ED56C3D
	Offset: 0x5D30
	Size: 0x234
	Parameters: 1
	Flags: Linked
*/
function function_bef7f017(var_c597d89a)
{
	while(true)
	{
		a_players = util::get_active_players();
		var_b796a21e = 1;
		n_current_time = gettime();
		foreach(player in a_players)
		{
			if(isalive(player) && isdefined(var_c597d89a.s_unitrigger) && isdefined(var_c597d89a.s_unitrigger.trigger))
			{
				if(player istouching(var_c597d89a.s_unitrigger.trigger))
				{
					var_b796a21e = 0;
					var_cefd4edd = undefined;
					break;
					continue;
				}
				waitframe(1);
			}
		}
		if(var_b796a21e)
		{
			if(!isdefined(var_cefd4edd))
			{
				var_cefd4edd = gettime();
			}
			if(n_current_time > var_cefd4edd + 1500)
			{
				level notify(#"hash_20b6d10f9de5d13a");
				foreach(player in util::get_active_players())
				{
					player playrumbleonentity(#"hash_2c759068c6a8567d");
				}
				break;
			}
		}
		wait(0.5);
	}
	var_c597d89a waittill(#"trigger_activated");
}

/*
	Name: function_f64a749c
	Namespace: namespace_57873b62
	Checksum: 0x9D0F79A4
	Offset: 0x5F70
	Size: 0xC0
	Parameters: 3
	Flags: Linked
*/
function function_f64a749c(var_6fc696ed, var_8940de41, str_letter)
{
	foreach(struct in var_6fc696ed)
	{
		n_value = var_8940de41[str_letter][struct.script_int - 1];
		if(n_value)
		{
			struct thread function_24d85b68();
		}
	}
}

/*
	Name: function_24d85b68
	Namespace: namespace_57873b62
	Checksum: 0xA28EAE84
	Offset: 0x6038
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_24d85b68()
{
	level endon(#"hash_20b6d10f9de5d13a");
	while(true)
	{
		a_players = util::get_active_players();
		var_f1ace900 = 0;
		foreach(player in a_players)
		{
			if(player.origin[2] < 750 && distancesquared(player.origin, self.origin) < 169)
			{
				player playrumbleonentity(#"hash_2c759068c6a8567d");
			}
			waitframe(1);
		}
		wait(0.2);
	}
}

/*
	Name: function_7199779e
	Namespace: namespace_57873b62
	Checksum: 0x180FD400
	Offset: 0x6170
	Size: 0x476
	Parameters: 0
	Flags: Linked
*/
function function_7199779e()
{
	var_451b9958 = [];
	var_451b9958[#"space"] = array(0, 0, 0, 0, 0, 0);
	var_451b9958[#"r"] = array(1, 0, 1, 1, 1, 0);
	var_451b9958[#"u"] = array(1, 0, 0, 0, 1, 1);
	var_451b9958[#"n"] = array(1, 1, 0, 1, 1, 0);
	var_451b9958[#"i"] = array(0, 1, 1, 0, 0, 0);
	var_451b9958[#"g"] = array(1, 1, 1, 1, 0, 0);
	var_451b9958[#"f"] = array(1, 1, 1, 0, 0, 0);
	var_451b9958[#"o"] = array(1, 0, 0, 1, 1, 0);
	var_451b9958[#"m"] = array(1, 1, 0, 0, 1, 0);
	var_451b9958[#"y"] = array(1, 1, 0, 1, 1, 1);
	var_451b9958[#"e"] = array(1, 0, 0, 1, 0, 0);
	var_451b9958[#"l"] = array(1, 0, 1, 0, 1, 0);
	var_451b9958[#"d"] = array(1, 1, 0, 1, 0, 0);
	var_451b9958[#"s"] = array(0, 1, 1, 0, 1, 0);
	var_451b9958[#"n"] = array(1, 1, 0, 1, 1, 0);
	var_451b9958[#"t"] = array(0, 1, 1, 1, 1, 0);
	var_451b9958[#"a"] = array(1, 0, 0, 0, 0, 0);
	var_451b9958[#"h"] = array(1, 0, 1, 1, 0, 0);
	var_451b9958[#"p"] = array(1, 1, 1, 0, 1, 0);
	return var_451b9958;
}

