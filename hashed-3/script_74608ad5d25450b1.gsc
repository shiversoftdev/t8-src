// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_174ce72cc0f850;
#using script_1c72973fb240f263;
#using script_24c32478acf44108;
#using script_3510d12b63a575c3;
#using script_3f9e0dc8454d98e1;
#using script_52c6c2d1a2ef1b46;
#using script_5bb072c3abf4652c;
#using script_6a3f43063dfd1bdc;
#using script_724752ab26bff81b;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_white_util.gsc;
#using scripts\zm\zm_white_zones.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_3b2b9e06;

/*
	Name: preload
	Namespace: namespace_3b2b9e06
	Checksum: 0x2C68E7F8
	Offset: 0x388
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	namespace_bd74bbd2::register(#"sc_mk2x", 20000, "sc_mk2x", &function_a66f0de2, &function_17f3e9e2);
	clientfield::register("scriptmover", "" + #"hash_56a1bc72bf8de8f1", 20000, 1, "int");
	clientfield::register("actor", "" + #"hash_38c69da8fb2b74e4", 20000, 1, "int");
}

/*
	Name: init
	Namespace: namespace_3b2b9e06
	Checksum: 0xFF341A9E
	Offset: 0x460
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.var_ae5fb719 = spawnstruct();
	level.var_ae5fb719.n_step = 0;
	level.var_ae5fb719.var_10630268 = getweapon("ray_gun_mk2x");
	level.var_ae5fb719.var_d58b0729 = getweapon("ray_gun_mk2x_upgraded");
	callback::on_disconnect(&on_disconnect);
}

/*
	Name: function_18a1849f
	Namespace: namespace_3b2b9e06
	Checksum: 0xBEBA0D8D
	Offset: 0x510
	Size: 0x40
	Parameters: 1
	Flags: Linked, Private
*/
private function function_18a1849f(e_player)
{
	if(!isdefined(level.var_ae5fb719.e_player))
	{
		return 0;
	}
	return e_player === level.var_ae5fb719.e_player;
}

/*
	Name: function_f6048ee
	Namespace: namespace_3b2b9e06
	Checksum: 0xFBEC118
	Offset: 0x558
	Size: 0xF4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f6048ee(e_player)
{
	if(isdefined(e_player))
	{
		if(!isdefined(level.var_ae5fb719.e_player))
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
		else if(level.var_ae5fb719.e_player == e_player)
		{
			self sethintstring(#"hash_74fc96e8d58ff646");
		}
		else
		{
			self sethintstring(#"hash_2054e8fdb6521566");
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_5b4f9f76
	Namespace: namespace_3b2b9e06
	Checksum: 0xD3614C16
	Offset: 0x658
	Size: 0x76
	Parameters: 1
	Flags: Linked, Private
*/
private function function_5b4f9f76(e_player)
{
	var_2fff5cb5 = level.var_ae5fb719.e_player === e_player;
	var_24441d81 = !isdefined(level.var_ae5fb719.e_player) && !isdefined(e_player.var_9c20e2c9);
	return var_2fff5cb5 || var_24441d81;
}

/*
	Name: function_5cedad9c
	Namespace: namespace_3b2b9e06
	Checksum: 0x367138C7
	Offset: 0x6D8
	Size: 0x4C
	Parameters: 1
	Flags: Private
*/
private function function_5cedad9c(w_weapon)
{
	return isdefined(w_weapon) && (w_weapon == level.var_ae5fb719.var_10630268 || w_weapon == level.var_ae5fb719.var_d58b0729);
}

/*
	Name: start_quest
	Namespace: namespace_3b2b9e06
	Checksum: 0xE9289243
	Offset: 0x730
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
	Namespace: namespace_3b2b9e06
	Checksum: 0x6C04B17A
	Offset: 0x750
	Size: 0x222
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b60df00d()
{
	level thread function_cbeb9a33();
	if(!isdefined(level.var_ae5fb719.s_start))
	{
		level.var_ae5fb719.s_start = namespace_509a75d1::function_4e7f5b2e("mk2x_start");
	}
	level.var_ae5fb719.var_fead3ae9 = util::spawn_model("p8_zm_whi_fuse_pickup_empty", level.var_ae5fb719.s_start.origin, level.var_ae5fb719.s_start.angles);
	var_d1cdd613 = getent(level.var_ae5fb719.s_start.target, "targetname");
	if(!isdefined(var_d1cdd613.b_open))
	{
		var_d1cdd613 setcandamage(1);
		var_d1cdd613 val::set("quest_mk2x", "allowDeath", 0);
		var_d1cdd613 thread function_4e9f1680();
	}
	else
	{
		s_unitrigger = level.var_ae5fb719.var_fead3ae9 namespace_2e9c09b3::function_f1827cc6(&function_9d66ea6f, &function_f6048ee, &function_5b4f9f76, 80);
		zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
	}
	exploder::exploder("fxexp_mk2_x_smoke_emit_" + level.var_ae5fb719.s_start.exploder_id);
	level.var_ae5fb719.n_step = 1;
}

/*
	Name: function_4e9f1680
	Namespace: namespace_3b2b9e06
	Checksum: 0xC6B5782C
	Offset: 0x980
	Size: 0xE4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_4e9f1680()
{
	self endon(#"death");
	pixbeginevent(#"hash_73eb0f44c0388afc");
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = self waittill(#"damage");
		e_player = var_385703b7.attacker;
		if(var_385703b7 namespace_509a75d1::function_69320b44("zm_aat_frostbite"))
		{
			self setcandamage(0);
			self thread function_c0fc92d2();
			break;
		}
	}
	pixendevent();
}

/*
	Name: function_c0fc92d2
	Namespace: namespace_3b2b9e06
	Checksum: 0x4E227149
	Offset: 0xA70
	Size: 0x1C2
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c0fc92d2()
{
	self endon(#"death");
	exploder::stop_exploder("fxexp_mk2_x_smoke_emit_" + level.var_ae5fb719.s_start.exploder_id);
	v_dest = self.origin + 8 * self.var_e1434cbd;
	level.var_ae5fb719.var_fead3ae9 linkto(self);
	self playsound("zmb_ee_drawer_open");
	self moveto(v_dest, 0.1);
	self waittill(#"movedone");
	level.var_ae5fb719.var_fead3ae9 unlink();
	level.var_ae5fb719.s_start.origin = level.var_ae5fb719.var_fead3ae9.origin;
	s_unitrigger = level.var_ae5fb719.var_fead3ae9 namespace_2e9c09b3::function_f1827cc6(&function_9d66ea6f, &function_f6048ee, &function_5b4f9f76, 80);
	zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
	self.b_open = 1;
}

/*
	Name: function_9d66ea6f
	Namespace: namespace_3b2b9e06
	Checksum: 0xCE522B8C
	Offset: 0xC40
	Size: 0x144
	Parameters: 2
	Flags: Linked, Private
*/
private function function_9d66ea6f(var_2e1f34dd, e_player)
{
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold(e_player.name + "");
			println(e_player.name + "");
		}
	#/
	level.var_ae5fb719.e_player = e_player;
	namespace_a01a2431::function_605e5c25(e_player);
	e_player.var_9c20e2c9 = 1;
	e_player playsound("evt_canister_pickup");
	namespace_6747c550::function_7df6bb60("zm_white_ww_mod_phase", 1, e_player);
	namespace_6747c550::function_7df6bb60("zm_white_ww_mk2x_ammo", 1, e_player);
	e_player thread function_130ea633();
	function_87e09347();
}

/*
	Name: function_130ea633
	Namespace: namespace_3b2b9e06
	Checksum: 0x68E4FC82
	Offset: 0xD90
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_130ea633()
{
	if(zm_utility::is_classic())
	{
		self namespace_891c9bac::function_57b8cd17();
		self namespace_509a75d1::function_51b752a9("vox_ww_x_ammo_pickup");
		if(!namespace_3e3742fd::function_6cebbce1())
		{
			self zm_audio::do_player_or_npc_playvox("vox_ww_x_freeze_rush_0", 1);
		}
	}
}

/*
	Name: function_87e09347
	Namespace: namespace_3b2b9e06
	Checksum: 0x1CED3AA7
	Offset: 0xE18
	Size: 0x82
	Parameters: 0
	Flags: Linked, Private
*/
private function function_87e09347()
{
	level.var_ae5fb719.var_ad2870bb = 3;
	level.var_ae5fb719.var_128cd2c8 = 3;
	callback::on_ai_spawned(&function_ecdebc72);
	callback::on_ai_killed(&function_c6c9eeef);
	level.var_ae5fb719.n_step = 2;
}

/*
	Name: function_ecdebc72
	Namespace: namespace_3b2b9e06
	Checksum: 0xF688F2A4
	Offset: 0xEA8
	Size: 0x114
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ecdebc72()
{
	self endon(#"death");
	if(self.archetype === #"zombie" && math::cointoss(20))
	{
		while(!isdefined(self.spawn_pos))
		{
			waitframe(1);
		}
		if(namespace_9146fc8b::function_8920570d(self.spawn_pos.zone_name) && function_e4f54b1d() < level.var_ae5fb719.var_ad2870bb)
		{
			self.var_13a2274b = 1;
			self.actor_damage_func = &function_cdddec81;
			self zombie_utility::set_zombie_run_cycle("walk");
			self clientfield::set("" + #"hash_38c69da8fb2b74e4", 1);
		}
	}
}

/*
	Name: function_e4f54b1d
	Namespace: namespace_3b2b9e06
	Checksum: 0x973992B
	Offset: 0xFC8
	Size: 0xB2
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e4f54b1d()
{
	n_count = 0;
	a_ai_zombies = getaiteamarray(level.zombie_team);
	foreach(ai_zombie in a_ai_zombies)
	{
		if(ai_zombie.var_13a2274b === 1)
		{
			n_count++;
		}
	}
	return n_count;
}

/*
	Name: function_cdddec81
	Namespace: namespace_3b2b9e06
	Checksum: 0x27C8F494
	Offset: 0x1088
	Size: 0x1B6
	Parameters: 12
	Flags: Linked
*/
function function_cdddec81(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isplayer(attacker))
	{
		if(attacker namespace_509a75d1::function_fab5fb4d(weapon, "zm_aat_frostbite"))
		{
			if(self.var_7ba65499 !== 1)
			{
				self function_75edd32b(1);
				self thread function_53817e75();
			}
			if(damage >= self.health)
			{
				return 0;
			}
		}
		else if(meansofdeath == "MOD_MELEE" && self.var_7ba65499 === 1)
		{
			if(level.var_ae5fb719.var_ad2870bb > 0)
			{
				level thread function_baec0416(self.origin, self.angles);
			}
			self zombie_utility::zombie_eye_glow_stop();
			self clientfield::set("" + #"hash_757f891a37d3db00", 1);
			return self.health + 666;
		}
	}
	return damage;
}

/*
	Name: function_75edd32b
	Namespace: namespace_3b2b9e06
	Checksum: 0xEC0B0B60
	Offset: 0x1248
	Size: 0x17E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_75edd32b(b_frozen = 1)
{
	if(b_frozen)
	{
		self clientfield::set("" + #"hash_5ad28d5f104a6e3b", 1);
		self clientfield::set("" + #"hash_1aa3522b88c2b76f", 1);
		self clientfield::set("" + #"hash_259cdeffe60fe48f", 1);
		self namespace_9ff9f642::freeze();
		self.var_7ba65499 = 1;
	}
	else
	{
		self clientfield::set("" + #"hash_5ad28d5f104a6e3b", 0);
		self clientfield::set("" + #"hash_1aa3522b88c2b76f", 0);
		self clientfield::set("" + #"hash_259cdeffe60fe48f", 0);
		self namespace_9ff9f642::unfreeze();
		self.var_7ba65499 = undefined;
	}
}

/*
	Name: function_c6c9eeef
	Namespace: namespace_3b2b9e06
	Checksum: 0xD72909A3
	Offset: 0x13D0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_c6c9eeef(s_params)
{
	if(self.var_7ba65499 === 1)
	{
		self function_75edd32b(0);
	}
}

/*
	Name: function_53817e75
	Namespace: namespace_3b2b9e06
	Checksum: 0x36D38A0D
	Offset: 0x1410
	Size: 0x34
	Parameters: 0
	Flags: Linked, Private
*/
private function function_53817e75()
{
	self endon(#"death");
	wait(5);
	self function_75edd32b(0);
}

/*
	Name: function_baec0416
	Namespace: namespace_3b2b9e06
	Checksum: 0xFFD310C9
	Offset: 0x1450
	Size: 0x1B4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_baec0416(v_pos, v_angles)
{
	if(isdefined(v_pos))
	{
		var_b82ff340 = namespace_509a75d1::function_6d41bab8(v_pos, 360);
	}
	if(isdefined(var_b82ff340))
	{
		v_ground = groundtrace(var_b82ff340 + vectorscale((0, 0, 1), 32) + vectorscale((0, 0, 1), 8), var_b82ff340 + vectorscale((0, 0, 1), 32) + vectorscale((0, 0, -1), 100000), 0, self)[#"position"];
		v_normal = getnavmeshfacenormal(var_b82ff340, 32);
		var_55ab02db = function_c1fa62a2(v_angles, v_normal);
		var_a79daf1f = util::spawn_model("p8_zm_whi_goop_puddle_01", v_ground, var_55ab02db);
		var_a79daf1f namespace_2e9c09b3::function_f1827cc6(&function_cf69599, "", &function_18a1849f, 96);
		var_a79daf1f.targetname = "mk2x_goo";
		level.var_ae5fb719.var_ad2870bb--;
		waitframe(1);
		if(isdefined(var_a79daf1f))
		{
			zm_unitrigger::reregister_unitrigger_as_dynamic(var_a79daf1f.s_unitrigger);
		}
	}
}

/*
	Name: function_cf69599
	Namespace: namespace_3b2b9e06
	Checksum: 0x8E3FF59C
	Offset: 0x1610
	Size: 0x1C4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_cf69599(var_2e1f34dd, e_player)
{
	level.var_ae5fb719.var_128cd2c8--;
	e_player playsound("evt_ee_goo_pickup");
	if(level.var_ae5fb719.var_128cd2c8 == 2)
	{
		if(zm_utility::is_classic())
		{
			e_player thread namespace_509a75d1::function_51b752a9("vox_ww_x_goo_acquire");
		}
	}
	else if(level.var_ae5fb719.var_128cd2c8 < 1)
	{
		/#
			if(getdvarint(#"hash_7919e37cd5d57659", 0))
			{
				iprintlnbold(e_player.name + "");
				println(e_player.name + "");
			}
		#/
		if(!namespace_3e3742fd::function_6cebbce1() && (!(isdefined(level.var_5dd0d3ff.isspeaking) && level.var_5dd0d3ff.isspeaking)))
		{
			if(zm_utility::is_classic())
			{
				e_player thread namespace_9cf755b::function_491673da(#"hash_aec062a8a2a5d26");
			}
		}
		function_6f437b06();
		function_b99d76c0();
	}
}

/*
	Name: function_6f437b06
	Namespace: namespace_3b2b9e06
	Checksum: 0x1DD51058
	Offset: 0x17E0
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
private function function_6f437b06()
{
	callback::remove_on_ai_spawned(&function_ecdebc72);
	callback::remove_on_ai_killed(&function_c6c9eeef);
}

/*
	Name: function_f05be4f1
	Namespace: namespace_3b2b9e06
	Checksum: 0x23375439
	Offset: 0x1830
	Size: 0x5C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f05be4f1()
{
	function_6f437b06();
	var_5a7b8007 = getentarray("mk2x_goo", "targetname");
	array::run_all(var_5a7b8007, &namespace_2e9c09b3::function_d6812b9d);
}

/*
	Name: function_b99d76c0
	Namespace: namespace_3b2b9e06
	Checksum: 0xA13E7406
	Offset: 0x1898
	Size: 0x72
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b99d76c0()
{
	var_3b901e6a = struct::get("mk2x_sc");
	var_3b901e6a zm_unitrigger::create("");
	var_3b901e6a thread function_473f437();
	level.var_ae5fb719.n_step = 3;
}

/*
	Name: function_473f437
	Namespace: namespace_3b2b9e06
	Checksum: 0xA5BCDDD7
	Offset: 0x1918
	Size: 0x144
	Parameters: 0
	Flags: Linked, Private
*/
private function function_473f437()
{
	self endon(#"death", #"stop_think");
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = self waittill(#"trigger_activated");
		playsoundatposition("evt_rgun_frame_putback", (-223, -1658, -178));
		if(function_18a1849f(var_385703b7.e_who))
		{
			level.var_ae5fb719.var_fead3ae9 = util::spawn_model("p8_zm_whi_fuse_pickup_fluid_purple_half", self.origin, self.angles);
			namespace_bd74bbd2::start(#"sc_mk2x");
			if(zm_utility::is_classic())
			{
				level.var_ae5fb719.e_player thread namespace_509a75d1::function_51b752a9("vox_ww_x_charge");
			}
			zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
			break;
		}
	}
}

/*
	Name: function_a66f0de2
	Namespace: namespace_3b2b9e06
	Checksum: 0xB3ECCDB7
	Offset: 0x1A68
	Size: 0xFC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a66f0de2()
{
	namespace_bd74bbd2::end(#"sc_mk2x");
	s_unitrigger = level.var_ae5fb719.var_fead3ae9 namespace_2e9c09b3::function_f1827cc6(&function_b9a31cb, &function_f6048ee, &function_5b4f9f76);
	zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
	level.var_ae5fb719.var_fead3ae9 setmodel("p8_zm_whi_fuse_pickup_fluid_purple");
	level.var_ae5fb719.var_fead3ae9 clientfield::set("" + #"hash_56a1bc72bf8de8f1", 1);
}

/*
	Name: function_b9a31cb
	Namespace: namespace_3b2b9e06
	Checksum: 0xA057C504
	Offset: 0x1B70
	Size: 0x134
	Parameters: 2
	Flags: Linked, Private
*/
private function function_b9a31cb(var_2e1f34dd, e_player)
{
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold(e_player.name + "");
			println(e_player.name + "");
		}
	#/
	namespace_6747c550::function_7df6bb60("zm_white_ww_mk2x_ammo", 2, e_player);
	e_player.var_f7694097 = 1;
	e_player playsound("evt_canister_pickup");
	if(!namespace_3e3742fd::function_6cebbce1() && zm_utility::is_classic())
	{
		e_player thread namespace_9cf755b::function_491673da(#"hash_28707927bb714f9");
	}
	function_a36c4a5e();
}

/*
	Name: function_17f3e9e2
	Namespace: namespace_3b2b9e06
	Checksum: 0xF0E3656C
	Offset: 0x1CB0
	Size: 0x74
	Parameters: 0
	Flags: Linked, Private
*/
private function function_17f3e9e2()
{
	s_unitrigger = level.var_ae5fb719.var_fead3ae9 zm_unitrigger::create(&function_7015dc35);
	zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
	level.var_ae5fb719.var_fead3ae9 thread function_2ac1278b();
}

/*
	Name: function_7015dc35
	Namespace: namespace_3b2b9e06
	Checksum: 0x50B2B750
	Offset: 0x1D30
	Size: 0x84
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7015dc35(e_player)
{
	if(isdefined(e_player))
	{
		if(level.var_ae5fb719.e_player === e_player)
		{
			self sethintstring(#"hash_14eae7c162ebb8d2");
		}
		else
		{
			self sethintstring(#"hash_2054e8fdb6521566");
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_2ac1278b
	Namespace: namespace_3b2b9e06
	Checksum: 0xD286C96D
	Offset: 0x1DC0
	Size: 0xAC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_2ac1278b()
{
	self endon(#"death");
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = self waittill(#"trigger_activated");
		e_player = var_385703b7.e_who;
		if(function_18a1849f(e_player))
		{
			namespace_bd74bbd2::start(#"sc_mk2x");
			zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
			break;
		}
	}
}

/*
	Name: function_bafa7a2b
	Namespace: namespace_3b2b9e06
	Checksum: 0xAC9028E8
	Offset: 0x1E78
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_bafa7a2b()
{
	if(isdefined(level.var_ae5fb719.var_fead3ae9))
	{
		namespace_bd74bbd2::end(#"sc_mk2x");
		level.var_ae5fb719.var_fead3ae9 delete();
	}
	else
	{
		var_3b901e6a = struct::get("mk2x_sc");
		var_3b901e6a notify(#"stop_think");
		zm_unitrigger::unregister_unitrigger(var_3b901e6a.s_unitrigger);
	}
}

/*
	Name: function_a36c4a5e
	Namespace: namespace_3b2b9e06
	Checksum: 0x37866FBB
	Offset: 0x1F38
	Size: 0x3A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a36c4a5e()
{
	level.var_ae5fb719.e_player thread function_cba90c3c();
	level.var_ae5fb719.n_step = 4;
}

/*
	Name: function_cba90c3c
	Namespace: namespace_3b2b9e06
	Checksum: 0xC1ABCD8A
	Offset: 0x1F80
	Size: 0x4C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_cba90c3c()
{
	self endon(#"death");
	self waittill(#"hash_13f3f231b45420ef");
	self thread function_c6fc34a();
	function_fa74521f();
}

/*
	Name: function_c6fc34a
	Namespace: namespace_3b2b9e06
	Checksum: 0x4113651C
	Offset: 0x1FD8
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_c6fc34a()
{
	if(zm_utility::is_classic())
	{
		self namespace_891c9bac::function_57b8cd17();
		self namespace_509a75d1::function_51b752a9("vox_ww_x_craft");
		if(!namespace_3e3742fd::function_6cebbce1())
		{
			self zm_audio::do_player_or_npc_playvox("vox_ww_x_craft_rush_1", 1);
		}
	}
}

/*
	Name: function_fa74521f
	Namespace: namespace_3b2b9e06
	Checksum: 0x25A41605
	Offset: 0x2060
	Size: 0xC2
	Parameters: 0
	Flags: Linked, Private
*/
private function function_fa74521f()
{
	/#
		if(getdvarint(#"hash_7919e37cd5d57659", 0))
		{
			iprintlnbold(level.var_ae5fb719.e_player.name + "");
			println(level.var_ae5fb719.e_player.name + "");
		}
	#/
	level.var_ae5fb719.e_player = undefined;
	level.var_ae5fb719.n_step = 5;
}

/*
	Name: on_disconnect
	Namespace: namespace_3b2b9e06
	Checksum: 0x3D92402C
	Offset: 0x2130
	Size: 0x34
	Parameters: 0
	Flags: Linked, Private
*/
private function on_disconnect()
{
	if(function_18a1849f(self))
	{
		function_ac5deb51();
	}
}

/*
	Name: function_ac5deb51
	Namespace: namespace_3b2b9e06
	Checksum: 0x3E9DCD6
	Offset: 0x2170
	Size: 0xD4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ac5deb51(var_e19b7aed = 1)
{
	switch(level.var_ae5fb719.n_step)
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
	level.var_ae5fb719.e_player = undefined;
	if(var_e19b7aed)
	{
		function_b60df00d();
	}
}

/*
	Name: function_cbeb9a33
	Namespace: namespace_3b2b9e06
	Checksum: 0x96F3FFF6
	Offset: 0x2250
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_cbeb9a33()
{
	level waittill(#"insanity_mode_triggered");
	exploder::stop_exploder("fxexp_mk2_x_smoke_emit_" + level.var_ae5fb719.s_start.exploder_id);
	if(isdefined(level.var_ae5fb719.var_fead3ae9) && isdefined(level.var_ae5fb719.var_fead3ae9.s_unitrigger))
	{
		zm_unitrigger::unregister_unitrigger(level.var_ae5fb719.var_fead3ae9.s_unitrigger);
		level.var_ae5fb719.var_fead3ae9 delete();
	}
	function_ac5deb51(0);
}

