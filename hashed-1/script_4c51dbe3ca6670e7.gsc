// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_467027ea7017462b;
#using script_52c6c2d1a2ef1b46;
#using script_57f7003580bb15e0;
#using script_6a3f43063dfd1bdc;
#using script_6e3c826b1814cab6;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_trap_electric.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_traps.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_a6437486;

/*
	Name: function_89f2df9
	Namespace: namespace_a6437486
	Checksum: 0xD5C2047F
	Offset: 0x220
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5d4022ed5385d3fa", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a6437486
	Checksum: 0x88ACA4CD
	Offset: 0x270
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level init_clientfields();
}

/*
	Name: init_clientfields
	Namespace: namespace_a6437486
	Checksum: 0x49B6D44
	Offset: 0x298
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("actor", "" + #"electrocute_ai_fx", 20000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_6d40a3f1944d81b2", 20000, 2, "int");
}

/*
	Name: __main__
	Namespace: namespace_a6437486
	Checksum: 0x5B9A00C7
	Offset: 0x328
	Size: 0xC8
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	if(!namespace_59ff1d6c::function_901b751c(#"hash_4b16b22d8a0d3301"))
	{
		return;
	}
	var_c6eff49f = struct::get_array("s_electric", "targetname");
	foreach(var_edf030ab in var_c6eff49f)
	{
		var_edf030ab thread function_c6e2a4fd();
	}
}

/*
	Name: function_c6e2a4fd
	Namespace: namespace_a6437486
	Checksum: 0x2B06968F
	Offset: 0x3F8
	Size: 0x2A4
	Parameters: 0
	Flags: Linked
*/
function function_c6e2a4fd()
{
	var_5dac9747 = self.target2 + "_" + self.script_noteworthy;
	str_trigger = self.target3 + "_" + self.script_noteworthy;
	str_volume = self.target4 + "_" + self.script_noteworthy;
	self.var_5aecd907 = [];
	self.var_f35c90d7 = [];
	self.var_1be9f510 = [];
	self._trap_type = "electric";
	self.var_5aecd907 = struct::get_array(var_5dac9747, "targetname");
	self.var_f35c90d7 = struct::get_array(str_trigger, "targetname");
	self.a_e_lights = getentarray(self.target5, "targetname");
	self.var_1be9f510 = getentarray(str_volume, "targetname");
	foreach(vol in self.var_1be9f510)
	{
		vol._trap_type = "electric";
	}
	foreach(var_5c7a3998 in self.var_f35c90d7)
	{
		var_5c7a3998.trap_struct = self;
	}
	self.var_6b64b967 = 0;
	self.var_41ee2ddc = 1;
	if(isdefined(self.power_flag))
	{
		level flag::wait_till("all_players_spawned");
		level flag::wait_till(self.power_flag);
	}
	self thread function_4d2eaaf4();
	self thread function_f118c57a();
}

/*
	Name: function_4d2eaaf4
	Namespace: namespace_a6437486
	Checksum: 0xA65B31BB
	Offset: 0x6A8
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_4d2eaaf4()
{
	foreach(var_5c7a3998 in self.var_f35c90d7)
	{
		var_5c7a3998 zm_unitrigger::create(&function_d12e5ff9, 64, &electric_trap_think);
	}
}

/*
	Name: function_d12e5ff9
	Namespace: namespace_a6437486
	Checksum: 0xF5B18397
	Offset: 0x748
	Size: 0x308
	Parameters: 1
	Flags: Linked
*/
function function_d12e5ff9(e_player)
{
	if(e_player zm_utility::is_drinking())
	{
		self sethintstring("");
		return 0;
	}
	if(self.stub.related_parent.trap_struct.var_6b64b967 === 1)
	{
		self sethintstring(#"hash_39d080503c6a8d96");
		return 1;
	}
	if(isdefined(self.stub.related_parent.trap_struct.power_flag) && !level flag::get(self.stub.related_parent.trap_struct.power_flag))
	{
		self sethintstring(#"hash_71158766520dc432");
		return 1;
	}
	if(level flag::get(#"hash_1478cafcd626c361") && !level flag::get(#"circuit_step_complete"))
	{
		self sethintstring(#"hash_71158766520dc432");
		return 1;
	}
	if(self.stub.related_parent.trap_struct.var_41ee2ddc === 0 || (isdefined(level.var_4f7df1ac) && level.var_4f7df1ac))
	{
		self sethintstring(#"hash_21db2780833a8bfd");
		return 1;
	}
	if(util::function_5df4294() == "zstandard")
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_61d85c966dd9e83f");
			return 1;
		}
		self sethintstring(#"hash_24a438482954901");
		return 1;
	}
	if(function_8b1a219a())
	{
		self sethintstring(#"hash_6e8ef1b690e98e51", 1000);
		return 1;
	}
	self sethintstring(#"hash_23c1c09e94181fdb", 1000);
	return 1;
}

/*
	Name: electric_trap_think
	Namespace: namespace_a6437486
	Checksum: 0x70C39D35
	Offset: 0xA60
	Size: 0x2C8
	Parameters: 0
	Flags: Linked
*/
function electric_trap_think()
{
	level endon(#"end_game");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger");
		e_who = var_be17187b.activator;
		if(!zm_utility::can_use(e_who))
		{
			continue;
		}
		if(isdefined(level.var_4f7df1ac) && level.var_4f7df1ac)
		{
			continue;
		}
		if(isdefined(self.stub.related_parent.trap_struct.power_flag) && !level flag::get(self.stub.related_parent.trap_struct.power_flag))
		{
			continue;
		}
		if(level flag::get(#"hash_1478cafcd626c361") && !level flag::get(#"circuit_step_complete"))
		{
			continue;
		}
		if(self.stub.related_parent.trap_struct.var_6b64b967 === 1)
		{
			continue;
		}
		if(zm_utility::is_player_valid(e_who) && self.stub.related_parent.trap_struct.var_41ee2ddc === 1)
		{
			var_b5f26b1a = self.stub.related_parent.trap_struct.a_e_lights[0] zm_traps::function_3f0a4c65(e_who, 1000);
			if(!var_b5f26b1a)
			{
				continue;
			}
			self.stub.related_parent.trap_struct notify(#"hash_5c14ac54b628d28");
			self.stub.related_parent.trap_struct.var_64c09f7f = e_who;
			if(!(isdefined(level.var_3c9cfd6f) && level.var_3c9cfd6f) && zm_audio::function_65e5c19a())
			{
				e_who thread zm_audio::create_and_play_dialog(#"trap_electric", #"activate");
			}
		}
	}
}

/*
	Name: function_f118c57a
	Namespace: namespace_a6437486
	Checksum: 0xC71B981E
	Offset: 0xD30
	Size: 0x2C0
	Parameters: 1
	Flags: Linked
*/
function function_f118c57a(e_player)
{
	level endon(#"end_game");
	function_91ecec97(self.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
	while(true)
	{
		self waittill(#"hash_5c14ac54b628d28");
		function_91ecec97(self.a_e_lights, "p8_zm_off_trap_switch_light_red_on");
		self.var_6b64b967 = 1;
		e_who = self.var_64c09f7f;
		foreach(e_volume in self.var_1be9f510)
		{
			e_volume.activated_by_player = e_who;
		}
		if(isdefined(e_who))
		{
			zm_utility::play_sound_at_pos("purchase", e_who.origin);
			if(isdefined(self._trap_type))
			{
				e_who zm_audio::create_and_play_dialog(#"trap_activate", self._trap_type);
			}
			level notify(#"trap_activated", {#trap:self, #hash_dd54ffdb:e_who});
		}
		switch(self.script_string)
		{
			case "sequential":
			{
				self function_193dbfbb();
				break;
			}
			case "moving":
			{
				self function_6ae39b5();
				break;
			}
		}
		self.var_6b64b967 = 0;
		self.var_41ee2ddc = 0;
		var_628a2951 = zm_traps::function_da13db45(60, e_who);
		wait(var_628a2951);
		function_91ecec97(self.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
		self.var_41ee2ddc = 1;
		playsoundatposition(#"zmb_trap_ready", self.origin);
	}
}

/*
	Name: function_193dbfbb
	Namespace: namespace_a6437486
	Checksum: 0x1428DDD2
	Offset: 0xFF8
	Size: 0x264
	Parameters: 0
	Flags: Linked
*/
function function_193dbfbb()
{
	level endon(#"end_game");
	n_total_time = 0;
	n_check_time = 0.1;
	var_ac5cd5d = 1;
	var_34e4f6b8 = spawn("script_origin", self.origin);
	var_34e4f6b8 playsound(#"hash_1fb395621513432f");
	var_34e4f6b8 playloopsound(#"hash_177d7a6df8ed0d7b");
	foreach(var_131f4c21 in self.var_5aecd907)
	{
		var_131f4c21.var_c82ab529 = util::spawn_model("tag_origin", var_131f4c21.origin, var_131f4c21.angles);
	}
	while(n_total_time < 40)
	{
		if(var_ac5cd5d == 1)
		{
			var_ac5cd5d = 0;
		}
		else
		{
			var_ac5cd5d = 1;
		}
		self function_70557fa2(var_ac5cd5d);
		for(i = 0; i < 2 / n_check_time; i++)
		{
			self thread function_a01c3869(var_ac5cd5d);
			self thread function_fae74a9e(var_ac5cd5d);
			wait(n_check_time);
		}
		n_total_time = n_total_time + 2;
	}
	if(isdefined(var_34e4f6b8))
	{
		playsoundatposition(#"hash_3819c6cd06a27f15", var_34e4f6b8.origin);
		var_34e4f6b8 delete();
	}
	self function_8f250fa1();
}

/*
	Name: function_70557fa2
	Namespace: namespace_a6437486
	Checksum: 0x1E18A99C
	Offset: 0x1268
	Size: 0x138
	Parameters: 1
	Flags: Linked
*/
function function_70557fa2(var_ac5cd5d)
{
	foreach(var_131f4c21 in self.var_5aecd907)
	{
		if(var_131f4c21.script_int === var_ac5cd5d)
		{
			if(var_131f4c21.var_7f831216 === 2)
			{
				var_131f4c21.var_c82ab529 clientfield::set("" + #"hash_6d40a3f1944d81b2", 2);
			}
			else
			{
				var_131f4c21.var_c82ab529 clientfield::set("" + #"hash_6d40a3f1944d81b2", 1);
			}
			continue;
		}
		var_131f4c21.var_c82ab529 clientfield::set("" + #"hash_6d40a3f1944d81b2", 0);
	}
}

/*
	Name: function_a01c3869
	Namespace: namespace_a6437486
	Checksum: 0x9E4B6FB8
	Offset: 0x13A8
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function function_a01c3869(var_ac5cd5d)
{
	a_ai_zombies = getaiteamarray(level.zombie_team);
	foreach(ai_zombie in a_ai_zombies)
	{
		foreach(var_6cc24199 in self.var_1be9f510)
		{
			if(var_6cc24199.script_int === var_ac5cd5d && isalive(ai_zombie) && ai_zombie istouching(var_6cc24199))
			{
				ai_zombie thread zm_trap_electric::damage(var_6cc24199);
			}
		}
	}
}

/*
	Name: function_fae74a9e
	Namespace: namespace_a6437486
	Checksum: 0xCA1E7EA
	Offset: 0x1508
	Size: 0x1AC
	Parameters: 1
	Flags: Linked
*/
function function_fae74a9e(var_ac5cd5d)
{
	a_e_players = getplayers();
	foreach(e_player in a_e_players)
	{
		foreach(var_6cc24199 in self.var_1be9f510)
		{
			if(var_6cc24199.script_int === var_ac5cd5d && isalive(e_player) && e_player istouching(var_6cc24199))
			{
				e_player thread function_93284efd(var_6cc24199);
				continue;
			}
			if(isalive(e_player) && e_player istouching(var_6cc24199))
			{
				if(!isdefined(e_player.var_58538bef))
				{
					e_player thread function_9492f89b(var_6cc24199, 1);
				}
			}
		}
	}
}

/*
	Name: function_6ae39b5
	Namespace: namespace_a6437486
	Checksum: 0x1EAE0896
	Offset: 0x16C0
	Size: 0x18C
	Parameters: 0
	Flags: Linked
*/
function function_6ae39b5()
{
	level endon(#"end_game");
	n_total_time = 0;
	n_check_time = 0.1;
	var_131f4c21 = self.var_5aecd907[0];
	var_fc92faff = self.var_1be9f510[0];
	var_131f4c21.var_c82ab529 = util::spawn_model("tag_origin", var_131f4c21.origin, var_131f4c21.angles);
	var_131f4c21.var_c82ab529 enablelinkto();
	var_fc92faff enablelinkto();
	var_fc92faff linkto(var_131f4c21.var_c82ab529);
	self thread function_3b764073();
	self thread function_242055cf();
	while(n_total_time < 40)
	{
		self thread function_a01c3869();
		self thread function_fae74a9e();
		wait(n_check_time);
		n_total_time = n_total_time + n_check_time;
	}
	self function_8f250fa1();
}

/*
	Name: function_242055cf
	Namespace: namespace_a6437486
	Checksum: 0x9EAC6542
	Offset: 0x1858
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_242055cf()
{
	level endon(#"end_game");
	var_c82ab529 = self.var_5aecd907[0].var_c82ab529;
	v_start_pos = var_c82ab529.origin;
	var_65c6475f = ceil(40 / 3 * 2);
	for(i = 0; i < var_65c6475f; i++)
	{
		var_c82ab529 moveto(self.origin, 2);
		var_c82ab529 waittill(#"movedone");
		wait(1);
		var_c82ab529 moveto(v_start_pos, 2);
		var_c82ab529 waittill(#"movedone");
		wait(1);
	}
}

/*
	Name: function_3b764073
	Namespace: namespace_a6437486
	Checksum: 0xC2345CC9
	Offset: 0x1988
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function function_3b764073()
{
	foreach(var_131f4c21 in self.var_5aecd907)
	{
		if(isdefined(var_131f4c21.var_c82ab529))
		{
			var_131f4c21.var_c82ab529 clientfield::set("" + #"hash_6d40a3f1944d81b2", 1);
		}
	}
}

/*
	Name: function_8f250fa1
	Namespace: namespace_a6437486
	Checksum: 0x4C0F113F
	Offset: 0x1A38
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function function_8f250fa1()
{
	foreach(var_131f4c21 in self.var_5aecd907)
	{
		if(isdefined(var_131f4c21.var_c82ab529))
		{
			var_131f4c21.var_c82ab529 clientfield::set("" + #"hash_6d40a3f1944d81b2", 0);
		}
	}
}

/*
	Name: function_c0d65ddd
	Namespace: namespace_a6437486
	Checksum: 0x4E5E4B35
	Offset: 0x1AE8
	Size: 0x234
	Parameters: 2
	Flags: None
*/
function function_c0d65ddd(var_64c09f7f, e_volume)
{
	self endon(#"death");
	self clientfield::set("" + #"electrocute_ai_fx", 1);
	self.marked_for_death = 1;
	if(isactor(self))
	{
		refs[0] = "guts";
		refs[1] = "right_arm";
		refs[2] = "left_arm";
		refs[3] = "right_leg";
		refs[4] = "left_leg";
		refs[5] = "no_legs";
		refs[6] = "head";
		self.a.gib_ref = refs[randomint(refs.size)];
		playsoundatposition(#"hash_5183b687ad8d715a", self.origin);
		if(randomint(100) > 50)
		{
			self thread zm_traps::electroctute_death_fx();
		}
		function_6eac4ca1(self, "electrocute");
		self notify(#"bhtn_action_notify", {#action:"electrocute"});
		wait(randomfloat(1.25));
		self playsound(#"hash_5183b687ad8d715a");
	}
	self dodamage(self.health + 666, self.origin, var_64c09f7f, e_volume);
}

/*
	Name: function_93284efd
	Namespace: namespace_a6437486
	Checksum: 0x245B4C7
	Offset: 0x1D28
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_93284efd(e_trigger)
{
	if(!isdefined(self.var_58538bef))
	{
		self thread function_9492f89b(e_trigger, 0);
	}
	else if(self.var_58538bef)
	{
		self.var_58538bef = 0;
	}
	var_5b857980 = function_4d1e7b48(#"hash_19533caf858a9f3b");
	if(e_trigger zm_traps::function_3f401e8d(self))
	{
		return;
	}
	if(!(isdefined(self.b_no_trap_damage) && self.b_no_trap_damage))
	{
		self thread zm_traps::player_elec_damage(e_trigger);
		status_effect::status_effect_apply(var_5b857980, undefined, self, 0);
	}
}

/*
	Name: function_91ecec97
	Namespace: namespace_a6437486
	Checksum: 0x49599EF1
	Offset: 0x1E10
	Size: 0x88
	Parameters: 2
	Flags: Linked
*/
function function_91ecec97(a_e_lights, str_model)
{
	foreach(light in a_e_lights)
	{
		light setmodel(str_model);
	}
}

/*
	Name: function_9492f89b
	Namespace: namespace_a6437486
	Checksum: 0x40C1775A
	Offset: 0x1EA0
	Size: 0xCE
	Parameters: 2
	Flags: Linked
*/
function function_9492f89b(var_394e1495, var_1e034eed)
{
	self endon(#"disconnect");
	while(isalive(self) && self istouching(var_394e1495))
	{
		waitframe(1);
	}
	if(self.var_58538bef && (self zm_utility::is_jumping() || self issliding()))
	{
		self notify(#"hash_15541419dbbe7e1a");
	}
	self.var_58538bef = undefined;
}

