// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_35598499769dbb3d;
#using script_3f9e0dc8454d98e1;
#using script_467027ea7017462b;
#using script_4d000493c57bb851;
#using script_52c6c2d1a2ef1b46;
#using script_5bb072c3abf4652c;
#using script_760946ab27d685b4;
#using script_b52a163973f339f;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_c05f06c7;

/*
	Name: create_unitrigger
	Namespace: namespace_c05f06c7
	Checksum: 0x23D430E9
	Offset: 0x370
	Size: 0x1CE
	Parameters: 6
	Flags: Linked
*/
function create_unitrigger(s_loc, var_2a9fe786, hint_string, var_8c1cebd6, n_cost, var_ddbd86e1)
{
	s_loc.unitrigger_stub = spawnstruct();
	s_loc.unitrigger_stub.origin = s_loc.origin;
	s_loc.unitrigger_stub.angles = s_loc.angles;
	s_loc.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
	s_loc.unitrigger_stub.cursor_hint = "HINT_NOICON";
	s_loc.unitrigger_stub.require_look_at = 1;
	if(isdefined(var_8c1cebd6))
	{
		s_loc.unitrigger_stub.require_look_at = var_8c1cebd6;
	}
	s_loc.unitrigger_stub.var_2a9fe786 = var_2a9fe786;
	s_loc.unitrigger_stub.hint_string = hint_string;
	if(isdefined(n_cost) && n_cost > 0)
	{
		s_loc.unitrigger_stub.n_cost = n_cost;
	}
	s_loc.unitrigger_stub.prompt_and_visibility_func = &function_ab834b07;
	if(!isdefined(var_ddbd86e1))
	{
		zm_unitrigger::unitrigger_force_per_player_triggers(s_loc.unitrigger_stub, 1);
	}
	zm_unitrigger::register_static_unitrigger(s_loc.unitrigger_stub, var_2a9fe786);
	return s_loc.unitrigger_stub;
}

/*
	Name: function_ab834b07
	Namespace: namespace_c05f06c7
	Checksum: 0xB49CFD54
	Offset: 0x548
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function function_ab834b07(player)
{
	self.hint_string = self.stub.hint_string;
	if(isdefined(self.stub.n_cost))
	{
		self sethintstring(self.stub.hint_string, self.stub.n_cost);
	}
	else
	{
		self sethintstring(self.stub.hint_string);
	}
	return 1;
}

/*
	Name: zombie_death_gib
	Namespace: namespace_c05f06c7
	Checksum: 0x9A83AF9E
	Offset: 0x5E8
	Size: 0xC4
	Parameters: 0
	Flags: None
*/
function zombie_death_gib()
{
	gibserverutils::gibhead(self);
	if(math::cointoss())
	{
		gibserverutils::gibleftarm(self);
	}
	else
	{
		gibserverutils::gibrightarm(self);
	}
	gibserverutils::giblegs(self);
	self dodamage(self.health, self.origin);
	wait(0.1);
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: function_89e9bca5
	Namespace: namespace_c05f06c7
	Checksum: 0x432A9C3
	Offset: 0x6B8
	Size: 0x6A
	Parameters: 3
	Flags: Linked
*/
function function_89e9bca5(var_df1a3385, v_origin, v_angles)
{
	var_1c01fdda = namespace_a1d9b01d::function_4c2f8683(var_df1a3385);
	var_b1ea95c6 = namespace_93829f86::spawn_item(var_1c01fdda, v_origin, v_angles);
	return var_b1ea95c6;
}

/*
	Name: function_57423f
	Namespace: namespace_c05f06c7
	Checksum: 0x49B57BF4
	Offset: 0x730
	Size: 0xC0
	Parameters: 1
	Flags: None
*/
function function_57423f(var_a4107301)
{
	var_6fbf9624 = getentarray("use_elec_switch", "targetname");
	foreach(var_5350c7cd in var_6fbf9624)
	{
		if(var_5350c7cd.script_int === var_a4107301)
		{
			var_5350c7cd trigger::use();
		}
	}
}

/*
	Name: get_player_index
	Namespace: namespace_c05f06c7
	Checksum: 0x454823B7
	Offset: 0x7F8
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function get_player_index(e_player)
{
	a_players = getplayers(e_player.team);
	for(i = 0; i < a_players.size; i++)
	{
		if(e_player == a_players[i])
		{
			return i;
		}
	}
}

/*
	Name: function_5f42b3e2
	Namespace: namespace_c05f06c7
	Checksum: 0x7581F3F8
	Offset: 0x870
	Size: 0x156
	Parameters: 1
	Flags: Linked
*/
function function_5f42b3e2(s_anim)
{
	if(self.characterindex == 9)
	{
		var_3c828299 = "p_zm_seer_stone_s_in_female";
		var_c2852abc = "p_zm_seer_stone_s_loop_female";
		var_39e963ce = "p_zm_seer_stone_s_out_female";
	}
	else
	{
		var_3c828299 = "p_zm_seer_stone_s_in_male";
		var_c2852abc = "p_zm_seer_stone_s_loop_male";
		var_39e963ce = "p_zm_seer_stone_s_out_male";
	}
	s_anim scene::play(var_3c828299, self);
	if(isplayer(self))
	{
		self notify(#"hash_18259ed594f164dc");
		s_anim thread scene::play(var_c2852abc, self);
		self waittill(#"hash_770bb1239dc37ad0", #"disconnect");
	}
	if(isplayer(self))
	{
		s_anim scene::play(var_39e963ce, self);
		self notify(#"hash_18259ed594f164dc");
	}
}

/*
	Name: function_58dfa337
	Namespace: namespace_c05f06c7
	Checksum: 0xD60416A
	Offset: 0x9D0
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function function_58dfa337(n_time)
{
	self endon(#"disconnect");
	self.var_d049df11 = 1;
	wait(n_time);
	self.var_d049df11 = 0;
}

/*
	Name: function_a113df82
	Namespace: namespace_c05f06c7
	Checksum: 0xA2B7FF9
	Offset: 0xA18
	Size: 0xF0
	Parameters: 1
	Flags: Linked
*/
function function_a113df82(n_time)
{
	a_ai_zombies = getaiteamarray("axis");
	foreach(ai_zombie in a_ai_zombies)
	{
		if(distance2dsquared(self.origin, ai_zombie.origin) <= 160000)
		{
			ai_zombie.var_126d7bef = 1;
			ai_zombie.b_ignore_cleanup = 1;
			ai_zombie thread function_ca2d69a(n_time);
		}
	}
}

/*
	Name: function_ca2d69a
	Namespace: namespace_c05f06c7
	Checksum: 0xD31E5B9A
	Offset: 0xB10
	Size: 0x36
	Parameters: 1
	Flags: Linked
*/
function function_ca2d69a(n_time)
{
	self endon(#"death");
	wait(n_time);
	self.var_126d7bef = undefined;
	self.b_ignore_cleanup = undefined;
}

/*
	Name: function_656e5fd1
	Namespace: namespace_c05f06c7
	Checksum: 0x9D16F096
	Offset: 0xB50
	Size: 0x86
	Parameters: 0
	Flags: None
*/
function function_656e5fd1()
{
	self endon(#"disconnect", #"hide_equipment_hint_text");
	waitframe(1);
	if(!self gamepadusedlast())
	{
		self util::waittill_use_button_held();
	}
	else
	{
		self util::waittill_stance_button_held();
	}
	self notify(#"hide_equipment_hint_text");
}

/*
	Name: function_ebad0e52
	Namespace: namespace_c05f06c7
	Checksum: 0xD2645533
	Offset: 0xBE0
	Size: 0x10C
	Parameters: 1
	Flags: None
*/
function function_ebad0e52(var_88f1eaa8)
{
	self endon(#"disconnect");
	var_88f1eaa8 endon(#"death");
	v_org = var_88f1eaa8.origin;
	while(self.var_e60ec8e9)
	{
		var_88f1eaa8 movey(-600, 3);
		var_88f1eaa8 waittill(#"movedone");
		var_88f1eaa8 hide();
		var_88f1eaa8 moveto(v_org, 0.05);
		var_88f1eaa8 waittill(#"movedone");
		var_88f1eaa8 show();
	}
	var_88f1eaa8 delete();
}

/*
	Name: is_valid
	Namespace: namespace_c05f06c7
	Checksum: 0x915EEFA0
	Offset: 0xCF8
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function is_valid()
{
	if(self zm_utility::in_revive_trigger())
	{
		return 0;
	}
	if(self zm_utility::is_drinking())
	{
		return 0;
	}
	if(isdefined(self.var_564dec14) && self.var_564dec14)
	{
		return 0;
	}
	if(!zm_utility::is_player_valid(self))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_a8176b98
	Namespace: namespace_c05f06c7
	Checksum: 0xEE3BBE0E
	Offset: 0xD78
	Size: 0xE4
	Parameters: 2
	Flags: Linked
*/
function function_a8176b98(v_pos, n_radius)
{
	if(!isdefined(v_pos))
	{
		return;
	}
	v_drop_point = zm_utility::function_b0eeaada(v_pos, 1500);
	if(isdefined(v_drop_point) && zm_zonemgr::function_66bf6a43(v_drop_point[#"point"]))
	{
		return v_drop_point[#"point"];
	}
	if(!isdefined(v_drop_point) && isdefined(n_radius))
	{
		var_de3c569e = getclosestpointonnavmesh(v_pos, n_radius, 16);
		if(zm_zonemgr::function_66bf6a43(var_de3c569e))
		{
			return var_de3c569e;
		}
	}
}

/*
	Name: waittill_player_nearby
	Namespace: namespace_c05f06c7
	Checksum: 0x9AA5AF51
	Offset: 0xE68
	Size: 0x37A
	Parameters: 2
	Flags: Linked
*/
function waittill_player_nearby(e_player, var_5a365909 = 0)
{
	self endon(#"death", #"destroyed");
	/#
		if(getdvarint(#"hash_716ad286541e0f2d", 0))
		{
			return;
		}
	#/
	var_9d3d31a = 0;
	while(true)
	{
		if(isdefined(e_player))
		{
			if(var_5a365909)
			{
				if(isdefined(e_player.b_is_designated_target) && e_player.b_is_designated_target && distance2dsquared(self.origin, e_player.origin) <= 150 * 150 && e_player util::is_player_looking_at(self.origin, 0.1, 0, self))
				{
					return;
				}
			}
			else if(distance2dsquared(self.origin, e_player.origin) <= 150 * 150 && e_player util::is_player_looking_at(self.origin, 0.1, 0, self))
			{
				return;
			}
		}
		else
		{
			foreach(player in util::get_active_players())
			{
				if(!isdefined(self.radius) || (isdefined(self.radius) && self.radius < 150))
				{
					self.radius = 150;
				}
				if(var_5a365909)
				{
					if(isdefined(player.b_is_designated_target) && player.b_is_designated_target && distance2dsquared(self.origin, player.origin) <= self.n_radius * self.n_radius && player util::is_player_looking_at(self.origin, 0.1, 0, self))
					{
						return;
					}
					continue;
				}
				if(distance2dsquared(self.origin, player.origin) <= self.n_radius * self.n_radius && player util::is_player_looking_at(self.origin, 0.1, 0, self))
				{
					return;
				}
			}
		}
		wait(0.1);
		var_9d3d31a = var_9d3d31a + 0.1;
		if(var_9d3d31a > 5)
		{
			level notify(#"hash_5ed8f262549ea460");
			var_9d3d31a = 0;
		}
	}
}

/*
	Name: function_6a523c8c
	Namespace: namespace_c05f06c7
	Checksum: 0x4CCC9F95
	Offset: 0x11F0
	Size: 0x198
	Parameters: 1
	Flags: Linked
*/
function function_6a523c8c(var_16a0ef91 = (0, 0, 1))
{
	self endon_callback(&function_43ac0bb7, #"death", #"stop_wobble", #"hash_7e05ecbcf6c25592");
	if(!isdefined(self.v_start_origin))
	{
		self.v_start_origin = self.origin;
	}
	if(!isdefined(self.v_start_angles))
	{
		self.v_start_angles = self.angles;
	}
	while(true)
	{
		n_pitch = randomint(4) + 2;
		self moveto(self.origin + var_16a0ef91, 0.35);
		self rotatepitch(n_pitch, 0.35);
		self waittill(#"movedone");
		self moveto(self.origin - var_16a0ef91, 0.1);
		self rotatepitch(n_pitch * -1, 0.35);
		self waittill(#"movedone");
		wait(0.2);
	}
}

/*
	Name: function_43ac0bb7
	Namespace: namespace_c05f06c7
	Checksum: 0xA91EF6EE
	Offset: 0x1390
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_43ac0bb7(str_notify)
{
	if(isdefined(self) && str_notify === "stop_wobble")
	{
		if(isdefined(self.v_start_origin))
		{
			self moveto(self.v_start_origin, 0.1);
		}
		if(isdefined(self.v_start_angles))
		{
			self rotateto(self.v_start_angles, 0.1);
		}
	}
}

/*
	Name: function_da5cd631
	Namespace: namespace_c05f06c7
	Checksum: 0x122FBB5B
	Offset: 0x1428
	Size: 0xEA
	Parameters: 1
	Flags: Linked
*/
function function_da5cd631(var_abc1506e = vectorscale((0, 0, 1), 180))
{
	self endon(#"death", #"hash_3946eb0fdd8a2c0e");
	self notify(#"hash_7e05ecbcf6c25592");
	n_wait = 6;
	while(true)
	{
		self rotateto(self.angles + var_abc1506e, n_wait);
		self waittill(#"rotatedone");
		n_wait = max(n_wait - 0.25, 0.25);
	}
}

/*
	Name: function_9e147e0c
	Namespace: namespace_c05f06c7
	Checksum: 0x8104AEF0
	Offset: 0x1520
	Size: 0x2AC
	Parameters: 1
	Flags: Linked
*/
function function_9e147e0c(s_params)
{
	if(self.archetype === #"werewolf" && isplayer(s_params.eattacker))
	{
		s_params.eattacker thread function_6e9bca65(s_params.weapon);
		if(s_params.eattacker zm_utility::function_aa45670f(s_params.weapon, 0))
		{
			self.var_e0f90289 = 1;
			if(!level flag::get("flag_player_grabbed_werewolf_material"))
			{
				var_9420259c = self.origin;
				var_9cb648a3 = self.angles;
				if(isdefined(var_9420259c))
				{
					var_b82ff340 = function_a8176b98(var_9420259c, 360);
				}
				if(isdefined(var_b82ff340))
				{
					s_loc = spawnstruct();
					s_loc.origin = groundtrace(var_b82ff340 + vectorscale((0, 0, 1), 32) + vectorscale((0, 0, 1), 8), var_b82ff340 + vectorscale((0, 0, 1), 32) + vectorscale((0, 0, -1), 100000), 0, self)[#"position"];
					v_normal = getnavmeshfacenormal(var_b82ff340, 32);
					s_loc.angles = function_c1fa62a2(var_9cb648a3, v_normal);
					wait(0.5);
					s_loc thread function_e7d4e4f0();
				}
			}
		}
	}
	else if(self.archetype === #"hash_50f4e0eea9f4e4a4" && isplayer(s_params.eattacker) && (!(isdefined(level.var_f1028094[#"hash_2464612c580fec24"]) && level.var_f1028094[#"hash_2464612c580fec24"])))
	{
		s_params.eattacker thread function_9e4c5bfb();
	}
}

/*
	Name: function_9e4c5bfb
	Namespace: namespace_c05f06c7
	Checksum: 0x2361F1BA
	Offset: 0x17D8
	Size: 0x19A
	Parameters: 0
	Flags: Linked
*/
function function_9e4c5bfb()
{
	if(!isdefined(self.var_aed1893c))
	{
		self.var_aed1893c = [];
	}
	if(!(isdefined(self.var_aed1893c[#"hash_2464612c580fec24"]) && self.var_aed1893c[#"hash_2464612c580fec24"]) || math::cointoss(20) && (!(isdefined(level.var_f1028094[#"hash_2464612c580fec24"]) && level.var_f1028094[#"hash_2464612c580fec24"])) && zm_utility::is_player_valid(self))
	{
		self.var_aed1893c[#"hash_2464612c580fec24"] = 1;
		level.var_f1028094[#"hash_2464612c580fec24"] = 1;
		self zm_audio::create_and_play_dialog(#"hash_50f4e0eea9f4e4a4", #"kill", undefined, 1);
		wait(randomintrange(30, 3 * 30));
		level.var_f1028094[#"hash_2464612c580fec24"] = 0;
	}
}

/*
	Name: function_6e9bca65
	Namespace: namespace_c05f06c7
	Checksum: 0xD466B615
	Offset: 0x1980
	Size: 0x114
	Parameters: 1
	Flags: Linked
*/
function function_6e9bca65(w_weapon)
{
	if(self zm_utility::function_aa45670f(w_weapon, 0))
	{
		if(!(isdefined(self.var_d8cb9364) && self.var_d8cb9364))
		{
			self.var_d8cb9364 = self zm_audio::create_and_play_dialog(#"hash_598274de09f76c96", #"kill", undefined, 1);
		}
		else if(math::cointoss(20))
		{
			self zm_audio::create_and_play_dialog(#"hash_598274de09f76c96", #"kill");
		}
	}
	else if(math::cointoss(20))
	{
		self zm_audio::create_and_play_dialog(#"werewolf", #"kill");
	}
}

/*
	Name: function_e7d4e4f0
	Namespace: namespace_c05f06c7
	Checksum: 0xB3CAEE1A
	Offset: 0x1AA0
	Size: 0x33C
	Parameters: 0
	Flags: Linked
*/
function function_e7d4e4f0()
{
	if(!isdefined(level.var_98cb7c84))
	{
		level.var_98cb7c84 = [];
	}
	else if(!isarray(level.var_98cb7c84))
	{
		level.var_98cb7c84 = array(level.var_98cb7c84);
	}
	array::remove_undefined(level.var_98cb7c84, 0);
	if(level.var_98cb7c84.size >= 1)
	{
		return;
	}
	self endon_callback(&function_3cfa50, #"hash_50b4cc0a4e4185b7");
	self util::delay_notify(120, #"hash_50b4cc0a4e4185b7");
	self.var_817342a7 = util::spawn_model("c_t8_zmb_dlc1_werewolf_chaos_drop", self.origin, self.angles);
	if(!isdefined(level.var_98cb7c84))
	{
		level.var_98cb7c84 = [];
	}
	else if(!isarray(level.var_98cb7c84))
	{
		level.var_98cb7c84 = array(level.var_98cb7c84);
	}
	level.var_98cb7c84[level.var_98cb7c84.size] = self;
	util::wait_network_frame();
	self.var_817342a7 clientfield::set("" + #"hash_487e544e29aa8e45", 1);
	playsoundatposition(#"zmb_sq_souls_release", self.var_817342a7.origin);
	self.origin = self.origin + vectorscale((0, 0, 1), 8);
	e_holder = self zm_unitrigger::function_fac87205(&function_f3d694d6, (64, 64, 100));
	if(!level flag::get("flag_player_grabbed_werewolf_material"))
	{
		e_holder thread namespace_891c9bac::function_a2bd5a0c(#"hash_161206ddd7dcc321", 1);
		level namespace_6747c550::function_7df6bb60(#"hash_3761ebdf006d549e", 1);
		self.var_817342a7 delete();
		self struct::delete();
		level.var_98cb7c84 = undefined;
		level flag::set("flag_player_grabbed_werewolf_material");
	}
}

/*
	Name: function_3cfa50
	Namespace: namespace_c05f06c7
	Checksum: 0xD3839A3A
	Offset: 0x1DE8
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_3cfa50(var_385703b7)
{
	if(isdefined(self.var_817342a7))
	{
		self.var_817342a7 delete();
	}
	if(isdefined(self.s_unitrigger))
	{
		zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	}
	arrayremovevalue(level.var_98cb7c84, self);
	self struct::delete();
}

/*
	Name: function_f3d694d6
	Namespace: namespace_c05f06c7
	Checksum: 0xE08803A2
	Offset: 0x1E88
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function function_f3d694d6(player)
{
	if(!level flag::get("flag_player_grabbed_werewolf_material"))
	{
		str_prompt = zm_utility::function_d6046228(#"hash_429528a8bde9599d", #"hash_5af9d3bd478d8243");
		self sethintstringforplayer(player, str_prompt);
	}
	else
	{
		self sethintstringforplayer(player, "");
	}
	return 1;
}

/*
	Name: function_4aea06b0
	Namespace: namespace_c05f06c7
	Checksum: 0x8AFB7ED2
	Offset: 0x1F40
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function function_4aea06b0(b_disable = 1)
{
	if(b_disable)
	{
		level.var_5cfc800b = &function_d1e2d722;
		level.var_d97d59d7 = &return_false;
	}
	else
	{
		level.var_5cfc800b = undefined;
		level.var_d97d59d7 = undefined;
	}
}

/*
	Name: return_false
	Namespace: namespace_c05f06c7
	Checksum: 0xE50712D
	Offset: 0x1FC0
	Size: 0xE
	Parameters: 1
	Flags: Linked
*/
function return_false(player)
{
	return 0;
}

/*
	Name: function_d1e2d722
	Namespace: namespace_c05f06c7
	Checksum: 0xF2DAEB49
	Offset: 0x1FD8
	Size: 0x6
	Parameters: 0
	Flags: Linked
*/
function function_d1e2d722()
{
	return undefined;
}

/*
	Name: function_7d92a49c
	Namespace: namespace_c05f06c7
	Checksum: 0xC3E19E02
	Offset: 0x1FE8
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function function_7d92a49c(b_disable = 1)
{
	if(b_disable)
	{
		level.custom_spawnplayer = &function_b1fb2b71;
	}
	else
	{
		level.custom_spawnplayer = undefined;
	}
}

/*
	Name: function_b1fb2b71
	Namespace: namespace_c05f06c7
	Checksum: 0xD8BC9518
	Offset: 0x2040
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_b1fb2b71()
{
	if(isdefined(level.var_923e8cb4))
	{
		foreach(s_loc in level.var_923e8cb4)
		{
			if(s_loc.script_int === self.playernum)
			{
				self.spectator_respawn = s_loc;
				break;
			}
		}
		if(isdefined(self.spectator_respawn))
		{
			self zm_player::spectator_respawn();
		}
	}
}

/*
	Name: function_45ac4bb8
	Namespace: namespace_c05f06c7
	Checksum: 0x5A647DC1
	Offset: 0x2110
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_45ac4bb8()
{
	zm_powerups::function_74b8ec6b(#"nuke");
	zm_powerups::function_74b8ec6b(#"insta_kill");
}

/*
	Name: function_5904a8e1
	Namespace: namespace_c05f06c7
	Checksum: 0xB6055B72
	Offset: 0x2160
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_5904a8e1()
{
	zm_powerups::function_41cedb05(#"nuke");
	zm_powerups::function_74b8ec6b(#"insta_kill");
}

/*
	Name: function_98ca58fc
	Namespace: namespace_c05f06c7
	Checksum: 0x2B1DFBE5
	Offset: 0x21B0
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function function_98ca58fc(e_trigger)
{
	foreach(player in util::get_active_players())
	{
		if(player istouching(e_trigger) && !player laststand::player_is_in_laststand())
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_91dfc9d4
	Namespace: namespace_c05f06c7
	Checksum: 0xA867604B
	Offset: 0x2270
	Size: 0x118
	Parameters: 1
	Flags: Linked
*/
function function_91dfc9d4(e_trigger)
{
	a_players = [];
	foreach(player in util::get_active_players())
	{
		if(player istouching(e_trigger) && !player laststand::player_is_in_laststand())
		{
			if(!isdefined(a_players))
			{
				a_players = [];
			}
			else if(!isarray(a_players))
			{
				a_players = array(a_players);
			}
			a_players[a_players.size] = player;
		}
	}
	return a_players;
}

/*
	Name: function_7b248ec9
	Namespace: namespace_c05f06c7
	Checksum: 0x98C12FE0
	Offset: 0x2390
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_7b248ec9()
{
	a_blockers = getentarray("script_blocker", "targetname");
	foreach(e_blocker in a_blockers)
	{
		e_blocker notsolid();
	}
}

/*
	Name: function_f1c106b
	Namespace: namespace_c05f06c7
	Checksum: 0x6D018786
	Offset: 0x2438
	Size: 0x298
	Parameters: 2
	Flags: Linked
*/
function function_f1c106b(var_da816ebe, var_15d2b367)
{
	a_blockers = getentarray(var_da816ebe, "script_blocker");
	if(var_15d2b367)
	{
		switch(var_da816ebe)
		{
			case "loc4":
			{
				str_spawner = "greenhouse_lab_respawns";
				break;
			}
			case "loc3":
			{
				str_spawner = "cemetery_respawns";
				break;
			}
			case "loc2":
			{
				str_spawner = "forest_n_respawns";
				break;
			}
			case "loc1":
			{
				function_5f310cf9();
				break;
			}
		}
		if(isdefined(str_spawner))
		{
			level.var_923e8cb4 = struct::get_array(str_spawner, "targetname");
		}
		level zm_bgb_anywhere_but_here::function_886fce8f(0);
		function_4aea06b0(1);
		function_7d92a49c(1);
		foreach(e_blocker in a_blockers)
		{
			e_blocker solid();
		}
	}
	else
	{
		level.var_923e8cb4 = undefined;
		level zm_bgb_anywhere_but_here::function_886fce8f(1);
		function_4aea06b0(0);
		function_7d92a49c(0);
		foreach(e_blocker in a_blockers)
		{
			e_blocker notsolid();
		}
	}
}

/*
	Name: function_5f310cf9
	Namespace: namespace_c05f06c7
	Checksum: 0xC6CC90A7
	Offset: 0x26D8
	Size: 0x23C
	Parameters: 0
	Flags: Linked
*/
function function_5f310cf9()
{
	level.var_923e8cb4 = undefined;
	for(i = 0; i <= 3; i++)
	{
		switch(i)
		{
			case 0:
			{
				v_origin = (-5381, 84, -176);
				v_angles = vectorscale((0, 1, 0), 360);
				break;
			}
			case 1:
			{
				v_origin = (-5386, 7, -176);
				v_angles = vectorscale((0, 1, 0), 360);
				break;
			}
			case 2:
			{
				v_origin = (-5390, -104, -176);
				v_angles = vectorscale((0, 1, 0), 360);
				break;
			}
			case 3:
			{
				v_origin = (-5394, -198, -176);
				v_angles = vectorscale((0, 1, 0), 360);
				break;
			}
		}
		if(isdefined(v_origin) && isdefined(v_angles))
		{
			var_5a37a7fc = spawnstruct();
			var_5a37a7fc.origin = v_origin;
			var_5a37a7fc.angles = v_angles;
			var_5a37a7fc.targetname = "crypt_respawns";
			var_5a37a7fc.script_int = i;
			var_5a37a7fc.script_noteworthy = "player_" + i;
			if(!isdefined(level.var_923e8cb4))
			{
				level.var_923e8cb4 = [];
			}
			else if(!isarray(level.var_923e8cb4))
			{
				level.var_923e8cb4 = array(level.var_923e8cb4);
			}
			level.var_923e8cb4[level.var_923e8cb4.size] = var_5a37a7fc;
		}
	}
}

/*
	Name: function_9b4de361
	Namespace: namespace_c05f06c7
	Checksum: 0xF76F0904
	Offset: 0x2920
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function function_9b4de361(w_current)
{
	if(isdefined(w_current) && (isdefined(w_current.isriotshield) && w_current.isriotshield))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_f15c4657
	Namespace: namespace_c05f06c7
	Checksum: 0xC3A49C16
	Offset: 0x2968
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_f15c4657()
{
	self endon(#"death");
	if(!isdefined(level.var_7b6d01c))
	{
		level.var_7b6d01c = 0;
	}
	level.var_7b6d01c++;
	str_alias = #"hash_63097ff550404256" + level.var_7b6d01c + "_pickup";
	if(self namespace_48f3568::function_69e9e553(array(#"hash_5ebf024e1559c04a")) && level.var_7b6d01c == 3)
	{
		self namespace_891c9bac::function_a2bd5a0c(#"hash_4c470787fc7738eb");
		self playsoundtoplayer(#"hash_663346a99e3bdffc", self);
	}
	else
	{
		self namespace_891c9bac::function_a2bd5a0c(str_alias, 0, 1, 9999);
	}
}

/*
	Name: function_6ebb0e45
	Namespace: namespace_c05f06c7
	Checksum: 0x33FD0F7B
	Offset: 0x2A98
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_6ebb0e45(n_range_sq = 9000000)
{
	if(!isdefined(self.var_7988eee5) || !isalive(self.var_7988eee5))
	{
		e_player = self get_closest_valid_player(n_range_sq);
	}
	else
	{
		e_player = self.var_7988eee5;
	}
	if(zm_utility::is_player_valid(e_player))
	{
		return {#n_index:e_player namespace_48f3568::function_d35e4c92(), #e_player:e_player};
	}
	return undefined;
}

/*
	Name: get_closest_valid_player
	Namespace: namespace_c05f06c7
	Checksum: 0x357E8581
	Offset: 0x2B78
	Size: 0x144
	Parameters: 1
	Flags: Linked
*/
function get_closest_valid_player(n_range_sq = 9000000)
{
	a_players = util::get_active_players();
	var_df053feb = arraysortclosest(a_players, self.origin);
	foreach(player in var_df053feb)
	{
		v_player = player getcentroid();
		n_dist = distance2dsquared(self.origin, v_player);
		if(zm_utility::is_player_valid(player) && n_dist < n_range_sq * 4.5)
		{
			return player;
		}
	}
	return undefined;
}

/*
	Name: create_hudelem
	Namespace: namespace_c05f06c7
	Checksum: 0xBECECC6
	Offset: 0x2CC8
	Size: 0xBE
	Parameters: 2
	Flags: None
*/
function create_hudelem(x, y)
{
	/#
		var_aa917a22 = newdebughudelem();
		var_aa917a22.alignx = "";
		var_aa917a22.horzalign = "";
		var_aa917a22.aligny = "";
		var_aa917a22.vertalign = "";
		var_aa917a22.y = y;
		var_aa917a22.x = x;
		var_aa917a22.fontscale = 1.25;
		return var_aa917a22;
	#/
}

/*
	Name: function_bb613572
	Namespace: namespace_c05f06c7
	Checksum: 0xF11F4736
	Offset: 0x2D90
	Size: 0x2F0
	Parameters: 4
	Flags: Linked
*/
function function_bb613572(var_eb3b90d, var_8b518bb0, n_spawn_delay = 1, n_round = 20)
{
	level flag::clear(#"hash_29b12646045186fa");
	if(isdefined(var_8b518bb0))
	{
		if(!isdefined(var_8b518bb0))
		{
			var_8b518bb0 = [];
		}
		else if(!isarray(var_8b518bb0))
		{
			var_8b518bb0 = array(var_8b518bb0);
		}
		foreach(str_endon in var_8b518bb0)
		{
			level endon(str_endon);
		}
	}
	level.var_3dd9f9be = 0;
	n_players = getplayers().size;
	if(n_players < 1)
	{
		n_players = 1;
	}
	n_spawn_delay = n_spawn_delay / n_players;
	var_e8711f44 = 14 + n_players * 2;
	var_3a615dd8 = getspawnerarray("spawner_zm_zombie", "targetname");
	var_7c332548 = arraycopy(var_eb3b90d);
	while(true)
	{
		while(getaiteamarray(level.zombie_team).size >= var_e8711f44 || level flag::get(#"hash_29b12646045186fa"))
		{
			wait(0.5);
		}
		s_spawn = array::random(var_7c332548);
		sp_zombie = array::random(var_3a615dd8);
		ai = zombie_utility::spawn_zombie(sp_zombie, undefined, s_spawn, n_round);
		if(isdefined(ai))
		{
			level.var_3dd9f9be++;
			ai.var_12745932 = 1;
			arrayremovevalue(var_7c332548, s_spawn, 0);
			if(!var_7c332548.size)
			{
				var_7c332548 = var_eb3b90d;
			}
			wait(n_spawn_delay);
		}
	}
}

/*
	Name: any_player_looking_at
	Namespace: namespace_c05f06c7
	Checksum: 0xBC757A5E
	Offset: 0x3088
	Size: 0xBA
	Parameters: 4
	Flags: None
*/
function any_player_looking_at(v_origin, n_dot, b_do_trace, e_ignore)
{
	foreach(e_player in getplayers())
	{
		if(e_player util::is_player_looking_at(v_origin, n_dot, b_do_trace, e_player))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_268efa09
	Namespace: namespace_c05f06c7
	Checksum: 0xA6BCA4D0
	Offset: 0x3150
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_268efa09(b_active = 0)
{
	self clientfield::set_player_uimodel("zmhud.ammoModifierActive", b_active);
}

/*
	Name: function_dce687ca
	Namespace: namespace_c05f06c7
	Checksum: 0xD734AD4C
	Offset: 0x3198
	Size: 0x8E
	Parameters: 0
	Flags: None
*/
function function_dce687ca()
{
	/#
		while(isdefined(self) && getdvarint(#"hash_3c4df2fe4b1618d5", 0))
		{
			draw_arrow(self.origin, anglestoforward(self.angles), (0, 1, 0), function_9e72a96(self.model));
			waitframe(1);
		}
	#/
}

/*
	Name: draw_arrow
	Namespace: namespace_c05f06c7
	Checksum: 0xB94EA890
	Offset: 0x3230
	Size: 0x33C
	Parameters: 4
	Flags: None
*/
function draw_arrow(org, ang, opcolor, str)
{
	/#
		forward = anglestoforward(ang);
		forwardfar = vectorscale(forward, 50);
		forwardclose = vectorscale(forward, 50 * 0.8);
		right = anglestoright(ang);
		left = anglestoright(ang) * -1;
		leftdraw = vectorscale(right, 50 * -0.2);
		rightdraw = vectorscale(right, 50 * 0.2);
		up = anglestoup(ang);
		right = vectorscale(right, 50);
		left = vectorscale(left, 50);
		up = vectorscale(up, 50);
		red = (0.9, 0.2, 0.2);
		green = (0.2, 0.9, 0.2);
		blue = (0.2, 0.2, 0.9);
		if(isdefined(opcolor))
		{
			red = opcolor;
			green = opcolor;
			blue = opcolor;
		}
		line(org, org + forwardfar, red, 0.9);
		line(org + forwardfar, org + forwardclose + rightdraw, red, 0.9);
		line(org + forwardfar, org + forwardclose + leftdraw, red, 0.9);
		line(org, org + right, blue, 0.9);
		line(org, org + left, blue, 0.9);
		line(org, org + up, green, 0.9);
		if(isdefined(str))
		{
			print3d(self.origin, str, (0, 1, 0), 1, 0.5);
		}
	#/
}

/*
	Name: function_2057ddc1
	Namespace: namespace_c05f06c7
	Checksum: 0x1ECE246F
	Offset: 0x3578
	Size: 0x344
	Parameters: 9
	Flags: Linked
*/
function function_2057ddc1(v_loc, var_9fa0c0f, var_bff0cf99, var_440d7980, var_d8ad5f6e, var_1ef7b21 = 10, b_wait_if_busy = 1, var_39238c39 = 0, var_eb20a7c = 0)
{
	level endon(#"end_game", #"intermission");
	if(!isdefined(level.var_f1028094))
	{
		level.var_f1028094 = [];
	}
	if(!(isdefined(level.var_f1028094[var_d8ad5f6e]) && level.var_f1028094[var_d8ad5f6e]))
	{
		a_e_players = util::get_active_players();
		if(isdefined(v_loc))
		{
			a_e_players = arraysortclosest(a_e_players, v_loc);
		}
		else
		{
			a_e_players = array::randomize(a_e_players);
		}
		foreach(e_player in a_e_players)
		{
			if(!isdefined(e_player.var_aed1893c))
			{
				e_player.var_aed1893c = [];
			}
			if(!(isdefined(e_player.var_aed1893c[var_d8ad5f6e]) && e_player.var_aed1893c[var_d8ad5f6e]))
			{
				level.var_f1028094[var_d8ad5f6e] = 1;
				e_player.var_aed1893c[var_d8ad5f6e] = !var_39238c39;
				n_character_index = e_player namespace_48f3568::function_d35e4c92();
				if(isdefined(var_440d7980))
				{
					var_7275593e = array::random(var_440d7980);
				}
				else
				{
					var_7275593e = 0;
				}
				str_vo = "vox_" + var_9fa0c0f + "_" + var_bff0cf99 + "_plr_" + n_character_index + "_" + var_7275593e;
				if(isdefined(var_eb20a7c) && var_eb20a7c)
				{
					e_player stopsounds();
					wait(0.1);
				}
				if(isalive(e_player))
				{
					e_player namespace_891c9bac::function_8e0f4696(str_vo, 0, b_wait_if_busy, 9999);
				}
				wait(var_1ef7b21);
				level.var_f1028094[var_d8ad5f6e] = 0;
				return;
			}
		}
	}
}

