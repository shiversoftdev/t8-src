// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_6a3f43063dfd1bdc;
#using script_ab890501c40b73c;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_traps.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_790eb878;

/*
	Name: init
	Namespace: namespace_790eb878
	Checksum: 0xD256E43D
	Offset: 0x2B8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("actor", "freeze_trap_death_fx", 24000, 1, "int");
	clientfield::register("scriptmover", "freeze_trap_fx", 24000, 1, "int");
	clientfield::register("toplayer", "player_freeze_trap_post_fx", 24000, 1, "int");
}

/*
	Name: main
	Namespace: namespace_790eb878
	Checksum: 0xB9BDAAF4
	Offset: 0x358
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level thread function_e62e184a();
}

/*
	Name: function_e62e184a
	Namespace: namespace_790eb878
	Checksum: 0x91B9873D
	Offset: 0x380
	Size: 0x258
	Parameters: 0
	Flags: Linked
*/
function function_e62e184a()
{
	level.s_freeze_trap = struct::get("s_freeze_trap", "targetname");
	s_trap = level.s_freeze_trap;
	s_trap._trap_type = "freeze";
	s_trap.e_volume = getent(s_trap.target, "targetname");
	s_trap.e_volume._trap_type = "freeze";
	s_trap.var_28ea1870 = struct::get_array(s_trap.target3, "targetname");
	s_trap.var_54a168f2 = struct::get_array(s_trap.target2, "targetname");
	s_trap.a_e_lights = getentarray(s_trap.target4, "targetname");
	s_trap.var_2c0d31a5 = struct::get_array(s_trap.target5, "targetname");
	s_trap.var_6b64b967 = 0;
	s_trap.var_41ee2ddc = 1;
	level flag::wait_till("all_players_spawned");
	foreach(s_button in s_trap.var_54a168f2)
	{
		s_button.s_trap = s_trap;
		s_button zm_unitrigger::create(&function_67b12ae8, 64);
		s_button thread function_c2e32275();
		s_button thread function_270aecf7();
	}
}

/*
	Name: function_c2e32275
	Namespace: namespace_790eb878
	Checksum: 0xA0868663
	Offset: 0x5E0
	Size: 0x298
	Parameters: 0
	Flags: Linked
*/
function function_c2e32275()
{
	level endon(#"end_game");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		e_who = var_be17187b.e_who;
		if(isdefined(level.var_4f7df1ac) && level.var_4f7df1ac)
		{
			continue;
		}
		if(isdefined(self.wait_flag) && !level flag::get(self.wait_flag))
		{
			continue;
		}
		if(isdefined(self.power_flag) && !level flag::get(self.power_flag))
		{
			continue;
		}
		if(level.s_freeze_trap.var_6b64b967 === 1)
		{
			continue;
		}
		if(zm_utility::is_player_valid(e_who) && level.s_freeze_trap.var_41ee2ddc === 1)
		{
			if(level flag::get(#"half_price_traps"))
			{
				b_purchased = self.s_trap.a_e_lights[0] zm_traps::function_3f0a4c65(e_who, int(500));
			}
			else
			{
				b_purchased = self.s_trap.a_e_lights[0] zm_traps::function_3f0a4c65(e_who, 1000);
			}
			if(!b_purchased)
			{
				continue;
			}
			self notify(#"hash_35807fa157a46934");
			self.var_64c09f7f = e_who;
			level.s_freeze_trap.activated_by_player = e_who;
			if(!(isdefined(level.var_3c9cfd6f) && level.var_3c9cfd6f) && zm_audio::function_65e5c19a())
			{
				e_who thread zm_audio::create_and_play_dialog(#"hash_62747bb1fc893f8a", #"activate");
			}
		}
	}
}

/*
	Name: function_270aecf7
	Namespace: namespace_790eb878
	Checksum: 0x25C0F070
	Offset: 0x880
	Size: 0x2B0
	Parameters: 0
	Flags: Linked
*/
function function_270aecf7()
{
	level endon(#"end_game");
	function_91ecec97(level.s_freeze_trap.a_e_lights, "p8_zm_off_trap_switch_light");
	if(isdefined(self.wait_flag))
	{
		level flag::wait_till(self.wait_flag);
	}
	if(isdefined(self.power_flag))
	{
		level flag::wait_till(self.power_flag);
	}
	function_91ecec97(level.s_freeze_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
	function_eb59d9fe(level.s_freeze_trap.var_2c0d31a5);
	while(true)
	{
		self waittill(#"hash_35807fa157a46934");
		function_91ecec97(level.s_freeze_trap.a_e_lights, "p8_zm_off_trap_switch_light_red_on");
		level.s_freeze_trap.var_6b64b967 = 1;
		e_who = self.var_64c09f7f;
		if(isdefined(e_who))
		{
			zm_utility::play_sound_at_pos("purchase", e_who.origin);
			level notify(#"trap_activated", {#trap:self, #hash_dd54ffdb:e_who});
			level.s_freeze_trap.e_volume.activated_by_player = e_who;
		}
		level.s_freeze_trap function_4bbed101(e_who);
		level.s_freeze_trap.var_6b64b967 = 0;
		level.s_freeze_trap.var_41ee2ddc = 0;
		n_cooldown = zm_traps::function_da13db45(60, e_who);
		wait(n_cooldown);
		function_91ecec97(level.s_freeze_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
		level.s_freeze_trap.var_41ee2ddc = 1;
		playsoundatposition(#"zmb_trap_ready", self.origin);
	}
}

/*
	Name: function_4bbed101
	Namespace: namespace_790eb878
	Checksum: 0x999325B2
	Offset: 0xB38
	Size: 0x374
	Parameters: 1
	Flags: Linked
*/
function function_4bbed101(e_player)
{
	level endon(#"end_game");
	n_total_time = 0;
	self thread freeze_trap_fx(1);
	sndent = spawn("script_origin", self.origin);
	sndent playloopsound(#"hash_1df9464f442b0b6d", 1);
	if(isdefined(level.s_soapstone) && isdefined(level.s_soapstone.s_placement))
	{
		level.s_soapstone.var_e15f0d15 = 1;
		if(!level.s_soapstone.is_charged || level.s_soapstone.is_hot)
		{
			level thread namespace_3263198e::function_fd24e47f("vox_generic_responses_positive", -1, 1, 0);
		}
	}
	while(n_total_time < 40)
	{
		self thread function_3d9b6ed6(e_player);
		self thread function_c38e2c52();
		wait(0.1);
		n_total_time = n_total_time + 0.1;
	}
	if(isdefined(level.s_soapstone) && isdefined(level.s_soapstone.s_placement) && level.s_soapstone.var_e15f0d15 === 1)
	{
		if(!level.s_soapstone.is_charged || level.s_soapstone.is_hot)
		{
			level thread namespace_3263198e::function_fd24e47f("vox_soap_stones_freeze", -1, 1, 0);
		}
		level.s_soapstone.is_charged = 1;
		level.s_soapstone.is_hot = 0;
		level.s_soapstone.s_placement.var_4eed727b clientfield::set("soapstone_start_fx", 1);
		level.s_soapstone.s_placement.var_4eed727b setmodel("p8_zm_ora_soapstone_01_cold");
		if(level.s_soapstone.var_b6e5b65f == 2)
		{
			level.s_soapstone.s_placement.var_28f1732d clientfield::set("soapstone_start_fx", 1);
			level.s_soapstone.s_placement.var_28f1732d setmodel("p8_zm_ora_soapstone_01_cold");
		}
	}
	sndent stoploopsound(1);
	sndent delete();
	self thread freeze_trap_fx(0);
}

/*
	Name: function_3d9b6ed6
	Namespace: namespace_790eb878
	Checksum: 0x75EF01AD
	Offset: 0xEB8
	Size: 0x100
	Parameters: 1
	Flags: Linked
*/
function function_3d9b6ed6(var_64c09f7f)
{
	foreach(ai in getaiteamarray(level.zombie_team))
	{
		if(isalive(ai) && ai istouching(self.e_volume) && (!isdefined(ai.marked_for_death) || !ai.marked_for_death))
		{
			ai thread function_92f341d0(var_64c09f7f, self.e_volume);
		}
	}
}

/*
	Name: function_92f341d0
	Namespace: namespace_790eb878
	Checksum: 0xBC5F51A1
	Offset: 0xFC0
	Size: 0x164
	Parameters: 2
	Flags: Linked
*/
function function_92f341d0(var_64c09f7f, e_volume)
{
	self endon(#"death");
	self.marked_for_death = 1;
	wait(randomfloatrange(0.25, 0.5));
	if(isalive(self))
	{
		self.water_damage = 1;
		if(isplayer(level.s_freeze_trap.activated_by_player))
		{
			level.s_freeze_trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
			level.s_freeze_trap.activated_by_player contracts::function_5b88297d(#"hash_1f11b620a6de486b");
		}
		level notify(#"trap_kill", {#trap:e_volume, #victim:self});
		self dodamage(self.health + 1000, e_volume.origin, e_volume);
	}
}

/*
	Name: freeze_trap_fx
	Namespace: namespace_790eb878
	Checksum: 0xFEF5A0AD
	Offset: 0x1130
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function freeze_trap_fx(var_9d9f02b4)
{
	if(var_9d9f02b4)
	{
		exploder::exploder("fxexp_frost_trap");
	}
	else
	{
		exploder::stop_exploder("fxexp_frost_trap");
	}
}

/*
	Name: function_cedd130e
	Namespace: namespace_790eb878
	Checksum: 0x11FE6253
	Offset: 0x1188
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function function_cedd130e()
{
	wait(2);
	if(isdefined(self))
	{
		self clientfield::set("freeze_trap_death_fx", 0);
	}
}

/*
	Name: function_c38e2c52
	Namespace: namespace_790eb878
	Checksum: 0xFCF2D2FF
	Offset: 0x11C8
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_c38e2c52()
{
	foreach(e_player in getplayers())
	{
		if(e_player istouching(self.e_volume))
		{
			e_player thread function_67a7a129(self);
		}
	}
}

/*
	Name: function_67a7a129
	Namespace: namespace_790eb878
	Checksum: 0x3D84E415
	Offset: 0x1270
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_67a7a129(s_trap)
{
	self endon(#"death", #"disconnect");
	if(!isdefined(self.var_88eddb97) || !self.var_88eddb97)
	{
		self.var_88eddb97 = 1;
		e_volume = s_trap.e_volume;
		self thread function_be814134();
		if(e_volume zm_traps::function_3f401e8d(self))
		{
			return;
		}
		if(!self laststand::player_is_in_laststand())
		{
			if(zm_utility::is_standard())
			{
				self dodamage(50, self.origin, undefined, e_volume);
			}
			else
			{
				self dodamage(150, self.origin, undefined, e_volume);
			}
			self zm_audio::playerexert("cough");
		}
	}
}

/*
	Name: function_be814134
	Namespace: namespace_790eb878
	Checksum: 0x2E8876A9
	Offset: 0x13B8
	Size: 0xC6
	Parameters: 0
	Flags: Linked
*/
function function_be814134()
{
	self endon(#"bled_out", #"disconnect");
	if(self clientfield::get_to_player("player_freeze_trap_post_fx") === 1)
	{
		return;
	}
	self clientfield::set_to_player("player_freeze_trap_post_fx", 1);
	self playsoundtoplayer(#"hash_35baaf86bb47b64d", self);
	wait(0.25);
	self clientfield::set_to_player("player_freeze_trap_post_fx", 0);
	wait(1);
	self.var_88eddb97 = 0;
}

/*
	Name: function_e32bd356
	Namespace: namespace_790eb878
	Checksum: 0x76755E46
	Offset: 0x1488
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function function_e32bd356(trap)
{
	playsoundatposition(#"hash_4b93c2d674807e60", self.origin);
	self waittill(#"available");
	playsoundatposition(#"zmb_acid_trap_available", self.origin);
}

/*
	Name: function_67b12ae8
	Namespace: namespace_790eb878
	Checksum: 0xBF0D030A
	Offset: 0x1508
	Size: 0x3C8
	Parameters: 1
	Flags: Linked
*/
function function_67b12ae8(e_player)
{
	s_button = self.stub.related_parent;
	if(e_player zm_utility::is_drinking())
	{
		self sethintstring("");
		return 0;
	}
	if(s_button.s_trap.var_6b64b967 === 1)
	{
		self sethintstring(#"hash_39d080503c6a8d96");
		return 1;
	}
	if(isdefined(s_button.wait_flag) && !level flag::get(s_button.wait_flag))
	{
		self sethintstring(#"hash_2276db2c26ee907a");
		return 1;
	}
	if(isdefined(level.var_4f7df1ac) && level.var_4f7df1ac)
	{
		self sethintstring(#"hash_2276db2c26ee907a");
		return 1;
	}
	if(isdefined(s_button.power_flag) && !level flag::get(s_button.power_flag))
	{
		self sethintstring(#"hash_71158766520dc432");
		return 1;
	}
	if(s_button.s_trap.var_41ee2ddc === 0)
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
		if(level flag::get(#"half_price_traps"))
		{
			self sethintstring(#"hash_6e8ef1b690e98e51", int(500));
			return 1;
		}
		self sethintstring(#"hash_6e8ef1b690e98e51", 1000);
		return 1;
	}
	if(level flag::get(#"half_price_traps"))
	{
		self sethintstring(#"hash_23c1c09e94181fdb", int(500));
		return 1;
	}
	self sethintstring(#"hash_23c1c09e94181fdb", 1000);
	return 1;
}

/*
	Name: function_eb59d9fe
	Namespace: namespace_790eb878
	Checksum: 0x17AF6245
	Offset: 0x18E0
	Size: 0x88
	Parameters: 1
	Flags: Linked
*/
function function_eb59d9fe(var_2c0d31a5)
{
	foreach(panel in var_2c0d31a5)
	{
		panel thread scene::play("open");
	}
}

/*
	Name: function_91ecec97
	Namespace: namespace_790eb878
	Checksum: 0x3DC9D612
	Offset: 0x1970
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

