// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6a3f43063dfd1bdc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_lightning_chain.gsc;
#using scripts\zm\zm_trap_electric.gsc;
#using scripts\zm\zm_white_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_traps.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_f4159bfd;

/*
	Name: function_89f2df9
	Namespace: namespace_f4159bfd
	Checksum: 0x53FDE7EF
	Offset: 0x1B8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_505f91cbac42ed30", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_f4159bfd
	Checksum: 0x8BF3E00E
	Offset: 0x208
	Size: 0x2A
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._effect[#"tesla_bolt"] = "zm_ai/fx8_avo_elec_projectile";
}

/*
	Name: __main__
	Namespace: namespace_f4159bfd
	Checksum: 0x95DB868
	Offset: 0x240
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	function_32639301();
}

/*
	Name: function_32639301
	Namespace: namespace_f4159bfd
	Checksum: 0x1315A282
	Offset: 0x260
	Size: 0x290
	Parameters: 0
	Flags: Linked
*/
function function_32639301()
{
	level.s_apd_trap = struct::get("apd_trap", "targetname");
	level.s_apd_trap.var_38cd3d0e = lightning_chain::create_lightning_chain_params();
	s_trap = level.s_apd_trap;
	s_trap._trap_type = "soul";
	s_trap.v_touching = getent(s_trap.target, "targetname");
	s_trap.v_touching._trap_type = "soul";
	s_trap.var_54a168f2 = struct::get_array(s_trap.target2, "targetname");
	s_trap.a_s_bullets = struct::get_array(s_trap.target3, "targetname");
	s_trap.a_e_lights = getentarray(s_trap.target4, "targetname");
	s_trap.var_2c0d31a5 = struct::get_array(s_trap.target5, "targetname");
	s_trap.var_6b64b967 = 0;
	s_trap.var_41ee2ddc = 1;
	level flag::wait_till("all_players_spawned");
	level flag::wait_till(#"hash_25d9cfebd2bdf1f2");
	foreach(s_button in s_trap.var_54a168f2)
	{
		s_button zm_unitrigger::create(&function_d1112480, 64);
		s_button thread function_e14376a3();
		s_button thread function_65c804dc();
	}
}

/*
	Name: function_d1112480
	Namespace: namespace_f4159bfd
	Checksum: 0x78DE1289
	Offset: 0x4F8
	Size: 0x2C0
	Parameters: 1
	Flags: Linked
*/
function function_d1112480(e_player)
{
	if(e_player zm_utility::is_drinking())
	{
		self sethintstring("");
		return 0;
	}
	if(level.s_apd_trap.var_6b64b967 === 1)
	{
		self sethintstring(#"hash_39d080503c6a8d96");
		return 1;
	}
	if(isdefined(self.stub.related_parent.power_flag) && !level flag::get(self.stub.related_parent.power_flag))
	{
		self sethintstring(#"hash_71158766520dc432");
		return 1;
	}
	if(level flag::get(#"hash_1478cafcd626c361") && !level flag::get(#"circuit_step_complete"))
	{
		self sethintstring(#"hash_71158766520dc432");
		return 1;
	}
	if(level.s_apd_trap.var_41ee2ddc === 0)
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
	Name: function_e14376a3
	Namespace: namespace_f4159bfd
	Checksum: 0xAFE63EFE
	Offset: 0x7C8
	Size: 0x240
	Parameters: 0
	Flags: Linked
*/
function function_e14376a3()
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
		if(isdefined(self.power_flag) && !level flag::get(self.power_flag))
		{
			continue;
		}
		if(level.s_apd_trap.var_6b64b967 === 1)
		{
			continue;
		}
		if(level flag::get(#"hash_1478cafcd626c361") && !level flag::get(#"circuit_step_complete"))
		{
			continue;
		}
		if(zm_utility::is_player_valid(e_who) && level.s_apd_trap.var_41ee2ddc === 1)
		{
			b_purchased = level.s_apd_trap.a_e_lights[0] zm_traps::function_3f0a4c65(e_who, 1000);
			if(!b_purchased)
			{
				continue;
			}
			self notify(#"hash_1d482aca0464609a");
			self.var_64c09f7f = e_who;
			level.s_apd_trap.v_touching.activated_by_player = e_who;
			if(!(isdefined(level.var_3c9cfd6f) && level.var_3c9cfd6f) && zm_audio::function_65e5c19a())
			{
				e_who thread zm_audio::create_and_play_dialog(#"hash_3f3ef774cd01d778", #"activate");
			}
		}
	}
}

/*
	Name: function_65c804dc
	Namespace: namespace_f4159bfd
	Checksum: 0x9741B765
	Offset: 0xA10
	Size: 0x218
	Parameters: 0
	Flags: Linked
*/
function function_65c804dc()
{
	level endon(#"end_game");
	function_91ecec97(level.s_apd_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
	function_eb59d9fe(level.s_apd_trap.var_2c0d31a5);
	while(true)
	{
		self waittill(#"hash_1d482aca0464609a");
		function_91ecec97(level.s_apd_trap.a_e_lights, "p8_zm_off_trap_switch_light_red_on");
		level.s_apd_trap.var_6b64b967 = 1;
		e_who = self.var_64c09f7f;
		if(isdefined(e_who))
		{
			zm_utility::play_sound_at_pos("purchase", e_who.origin);
			level notify(#"trap_activated", {#trap:self, #hash_dd54ffdb:e_who});
		}
		level.s_apd_trap apd_trap_activate(e_who);
		level.s_apd_trap.var_6b64b967 = 0;
		level.s_apd_trap.var_41ee2ddc = 0;
		n_cooldown = zm_traps::function_da13db45(60, e_who);
		wait(n_cooldown);
		level.s_apd_trap.var_41ee2ddc = 1;
		function_91ecec97(level.s_apd_trap.a_e_lights, "p8_zm_off_trap_switch_light_green_on");
		playsoundatposition(#"zmb_trap_ready", self.origin);
	}
}

/*
	Name: apd_trap_activate
	Namespace: namespace_f4159bfd
	Checksum: 0x47E7EFCF
	Offset: 0xC30
	Size: 0x1F0
	Parameters: 1
	Flags: Linked
*/
function apd_trap_activate(e_player)
{
	level endon(#"end_game");
	n_total_time = 0;
	weapon = getweapon(#"hash_13a204ba6887b18f");
	while(n_total_time < 60)
	{
		var_890584df = [];
		foreach(ai in getaiteamarray(level.zombie_team))
		{
			if(ai istouching(self.v_touching))
			{
				if(!isdefined(var_890584df))
				{
					var_890584df = [];
				}
				else if(!isarray(var_890584df))
				{
					var_890584df = array(var_890584df);
				}
				var_890584df[var_890584df.size] = ai;
			}
		}
		if(var_890584df.size > 0)
		{
			foreach(ai in var_890584df)
			{
				ai thread function_25ede6c7(self);
			}
		}
		wait(3);
		n_total_time = n_total_time + 3;
	}
}

/*
	Name: function_25ede6c7
	Namespace: namespace_f4159bfd
	Checksum: 0x6AA61629
	Offset: 0xE28
	Size: 0x164
	Parameters: 1
	Flags: Linked
*/
function function_25ede6c7(s_trap)
{
	self endon_callback(&function_171226f4, #"death");
	self.var_410faa5f = util::spawn_model("tag_origin", s_trap.origin);
	fx = playfxontag(level._effect[#"tesla_bolt"], self.var_410faa5f, "tag_origin");
	playsoundatposition(#"hash_286b88c1d2e99649", s_trap.origin);
	self.var_410faa5f moveto(self gettagorigin("J_Spine4"), 0.6);
	self.var_410faa5f waittill(#"movedone");
	self.var_410faa5f delete();
	self thread zm_trap_electric::damage(s_trap.v_touching);
}

/*
	Name: function_171226f4
	Namespace: namespace_f4159bfd
	Checksum: 0x68CF082A
	Offset: 0xF98
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_171226f4(str_notify)
{
	if(isdefined(self.var_410faa5f))
	{
		self.var_410faa5f delete();
	}
}

/*
	Name: function_eb59d9fe
	Namespace: namespace_f4159bfd
	Checksum: 0x217848B
	Offset: 0xFD8
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
	Namespace: namespace_f4159bfd
	Checksum: 0x51210DAB
	Offset: 0x1068
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

