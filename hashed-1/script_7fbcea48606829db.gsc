// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_2dc48f46bfeac894;
#using script_35598499769dbb3d;
#using script_9e4105ea1798ccc;
#using script_fb16bd158a3e3e7;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_lightning_chain.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_net.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_3dec9f28;

/*
	Name: function_89f2df9
	Namespace: namespace_3dec9f28
	Checksum: 0x387566
	Offset: 0x278
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_1b45fa71df7a015f", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_3dec9f28
	Checksum: 0x722F08F2
	Offset: 0x2C0
	Size: 0x5A4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("allplayers", "" + #"hash_38e20721589d1fdc", 1, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_61e96e3005ea1d49", 1, 1, "counter");
	clientfield::register("scriptmover", "" + #"lightning_miss_fx", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_9e18cea0c11fb61", 1, 1, "int");
	clientfield::register("actor", "" + #"lightning_impact_fx", 1, 1, "int");
	clientfield::register("vehicle", "" + #"lightning_impact_fx", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_1e850b3e1aaeb945", 1, 1, "counter");
	clientfield::register("vehicle", "" + #"hash_1e850b3e1aaeb945", 1, 1, "counter");
	clientfield::register("actor", "" + #"lightning_arc_fx", 1, 1, "int");
	clientfield::register("vehicle", "" + #"lightning_arc_fx", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_227b5ad1ba4c6b6d", 1, 1, "int");
	clientfield::register("vehicle", "" + #"hash_227b5ad1ba4c6b6d", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_5da4c56e7c2e2aad", 1, 1, "counter");
	level.hero_weapon[#"hammer"][0] = getweapon(#"hero_hammer_lv1");
	level.hero_weapon[#"hammer"][1] = getweapon(#"hero_hammer_lv2");
	level.hero_weapon[#"hammer"][2] = getweapon(#"hero_hammer_lv3");
	level.var_af47ddb5 = getweapon(#"hash_76986baf9b6770c6");
	namespace_2ba51478::register_hero_weapon_for_level("hero_hammer_lv1");
	namespace_2ba51478::register_hero_weapon_for_level("hero_hammer_lv2");
	namespace_2ba51478::register_hero_weapon_for_level("hero_hammer_lv3");
	level.var_b9efae55 = 22500;
	level.var_87fbf13 = 57600;
	level.var_5cc0eb9f = 10000;
	if(!isdefined(level.var_61d958e8))
	{
		object = new throttle();
		[[ object ]]->__constructor();
		level.var_61d958e8 = object;
		[[ level.var_61d958e8 ]]->initialize(3, 0.1);
	}
	callback::on_connect(&function_c3f6fd96);
	callback::on_disconnect(&on_player_disconnect);
	callback::function_4b58e5ab(&function_4b58e5ab);
	level._effect[#"hash_6c99dc53e968631c"] = #"hash_5aa1120d061d1f6c";
	ability_player::register_gadget_activation_callbacks(11, undefined, &function_a3eae601);
}

/*
	Name: function_f820b73
	Namespace: namespace_3dec9f28
	Checksum: 0x49DF5A50
	Offset: 0x870
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function function_f820b73(weapon, var_e7c11b0c = 1)
{
	if(weapon == level.hero_weapon[#"hammer"][2])
	{
		return 1;
	}
	if(weapon == level.hero_weapon[#"hammer"][1] && var_e7c11b0c < 3)
	{
		return 1;
	}
	if(weapon == level.hero_weapon[#"hammer"][0] && var_e7c11b0c < 2)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_c3f6fd96
	Namespace: namespace_3dec9f28
	Checksum: 0x5F4BBA2D
	Offset: 0x948
	Size: 0x288
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c3f6fd96()
{
	self endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"weapon_change");
		wpn_cur = waitresult.weapon;
		wpn_prev = waitresult.last_weapon;
		if(isinarray(level.hero_weapon[#"hammer"], wpn_cur))
		{
			self thread function_1e661e68(1);
			self thread function_4493c71b(wpn_cur);
			self thread function_ba44cb5(wpn_cur);
		}
		if(wpn_cur == level.hero_weapon[#"hammer"][0])
		{
			zm_hero_weapon::show_hint(wpn_cur, #"hash_10c853c67454fff6");
		}
		else if(wpn_cur == level.hero_weapon[#"hammer"][1])
		{
			zm_hero_weapon::show_hint(wpn_cur, #"hash_2745ea06a4f8e7fd");
			self thread function_82466b73(wpn_cur);
			self thread function_478a4910(wpn_cur);
		}
		else if(wpn_cur == level.hero_weapon[#"hammer"][2])
		{
			if(!self gamepadusedlast())
			{
				self zm_hero_weapon::show_hint(wpn_cur, #"hash_78fab15695ef9758");
			}
			else
			{
				self zm_hero_weapon::show_hint(wpn_cur, #"hash_7b9c8543bd5b051c");
			}
			self thread function_82466b73(wpn_cur);
			self thread function_7399cd86(wpn_cur);
			self thread function_68ff89f7(wpn_cur);
		}
	}
}

/*
	Name: function_1286cbf
	Namespace: namespace_3dec9f28
	Checksum: 0xA2A404D4
	Offset: 0xBD8
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function function_1286cbf(s_params)
{
	if(isplayer(s_params.eattacker) && function_f820b73(s_params.weapon, 1) && s_params.smeansofdeath == "MOD_MELEE")
	{
		player = s_params.eattacker;
		var_d695a618 = 50 - player namespace_ad4d960b::get(#"hash_5c9caf0397b30f1e");
		if(var_d695a618 >= 10)
		{
			var_20694322 = 10;
		}
		else
		{
			var_20694322 = var_d695a618;
		}
		player set_armor(var_20694322);
	}
}

/*
	Name: function_82466b73
	Namespace: namespace_3dec9f28
	Checksum: 0xD7143DAE
	Offset: 0xCD0
	Size: 0xA8
	Parameters: 1
	Flags: Linked, Private
*/
private function function_82466b73(weapon)
{
	self endon(#"weapon_change", #"disconnect", #"bled_out");
	while(true)
	{
		self waittill(#"weapon_melee_power_left");
		if(!namespace_6b49f66b::function_5fbf572(weapon))
		{
			continue;
		}
		weapon thread function_1b60eebf(self);
		weapon function_70dbf9d1(self);
	}
}

/*
	Name: function_70dbf9d1
	Namespace: namespace_3dec9f28
	Checksum: 0xA7697CFD
	Offset: 0xD80
	Size: 0x274
	Parameters: 1
	Flags: Linked, Private
*/
private function function_70dbf9d1(player)
{
	player endon(#"weapon_change", #"disconnect", #"bled_out");
	wait(0.5);
	player playsound(#"hash_334d4a903f12856f");
	v_start = player geteye();
	v_forward = player getweaponforwarddir();
	v_end = v_start + v_forward * 32;
	s_trace = groundtrace(v_start, v_end, 0, player);
	v_start = s_trace[#"position"] + vectorscale((0, 0, 1), 5);
	v_end = v_start + vectorscale((0, 0, -1), 200);
	s_trace = groundtrace(v_start, v_end, 0, player);
	n_offset = v_end[2] + 96;
	var_b82ff340 = zm_utility::function_b0eeaada(s_trace[#"position"]);
	if(!isdefined(var_b82ff340) || n_offset >= player.origin[2])
	{
		/#
		#/
		return;
	}
	while(!isdefined(player.var_4618dc52))
	{
		player.var_4618dc52 = util::spawn_model("tag_origin", player.origin);
		util::wait_network_frame();
	}
	player.var_4618dc52.origin = var_b82ff340[#"point"] + vectorscale((0, 0, 1), 20);
	player thread function_6275aed3();
}

/*
	Name: function_6275aed3
	Namespace: namespace_3dec9f28
	Checksum: 0xAAF9EC76
	Offset: 0x1000
	Size: 0x16C
	Parameters: 0
	Flags: Linked
*/
function function_6275aed3()
{
	self endon(#"disconnect");
	self notify(#"hash_51ba139f52797f7d");
	self endon(#"hash_51ba139f52797f7d");
	waitframe(3);
	if(self.var_4618dc52 clientfield::get("" + #"hash_9e18cea0c11fb61"))
	{
		self.var_4618dc52 clientfield::set("" + #"hash_9e18cea0c11fb61", 0);
		util::wait_network_frame();
	}
	self.var_4618dc52 clientfield::set("" + #"hash_9e18cea0c11fb61", 1);
	self thread function_fd8e3604();
	wait(10);
	self.var_4618dc52 clientfield::set("" + #"hash_9e18cea0c11fb61", 0);
	util::wait_network_frame();
	self.var_4618dc52 delete();
}

/*
	Name: function_4493c71b
	Namespace: namespace_3dec9f28
	Checksum: 0x3D4917E7
	Offset: 0x1178
	Size: 0x98
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4493c71b(weapon)
{
	self endon(#"weapon_change", #"disconnect", #"bled_out");
	while(true)
	{
		self waittill(#"weapon_melee_power");
		if(!namespace_6b49f66b::function_5fbf572(weapon, 1))
		{
			continue;
		}
		weapon function_439c9b04(self);
	}
}

/*
	Name: function_1b60eebf
	Namespace: namespace_3dec9f28
	Checksum: 0xD0871DA3
	Offset: 0x1218
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_1b60eebf(player)
{
	player endon(#"weapon_change", #"disconnect");
	waitframe(15);
	player thread function_1e661e68(2);
	player thread function_1b29b59e(1, self);
}

/*
	Name: function_439c9b04
	Namespace: namespace_3dec9f28
	Checksum: 0x433048C8
	Offset: 0x1298
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_439c9b04(player)
{
	player endon(#"weapon_change", #"disconnect");
	waitframe(5);
	player thread function_1b29b59e(2, self);
	waitframe(11);
	player thread function_1b29b59e(3, self);
}

/*
	Name: function_ba44cb5
	Namespace: namespace_3dec9f28
	Checksum: 0x80C825B1
	Offset: 0x1318
	Size: 0x8C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ba44cb5(weapon)
{
	level callback::on_ai_killed(&function_1286cbf);
	self clientfield::increment_to_player("" + #"hash_61e96e3005ea1d49");
	self waittill(#"weapon_change");
	level callback::remove_on_ai_killed(&function_1286cbf);
}

/*
	Name: set_armor
	Namespace: namespace_3dec9f28
	Checksum: 0x8E7BCFCD
	Offset: 0x13B0
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
private function set_armor(var_27d70168)
{
	self thread namespace_ad4d960b::add(#"hash_5c9caf0397b30f1e", var_27d70168, 50);
}

/*
	Name: function_7399cd86
	Namespace: namespace_3dec9f28
	Checksum: 0xC23D2BC3
	Offset: 0x13F0
	Size: 0x90
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7399cd86(weapon)
{
	self endon(#"weapon_change", #"disconnect", #"bled_out");
	while(true)
	{
		self waittill(#"weapon_melee");
		if(!namespace_6b49f66b::function_5fbf572(weapon))
		{
			continue;
		}
		self thread function_f352c6b2(weapon);
	}
}

/*
	Name: function_9799924f
	Namespace: namespace_3dec9f28
	Checksum: 0x2B950BB4
	Offset: 0x1488
	Size: 0x394
	Parameters: 5
	Flags: Linked
*/
function function_9799924f(e_target, weapon = level.weaponnone, var_3e3892a7, v_to_target, n_damage)
{
	if(!isalive(e_target))
	{
		return;
	}
	if(!isdefined(e_target.var_6f84b820))
	{
		return;
	}
	self thread function_1e661e68(4);
	if(isactor(e_target))
	{
		[[ level.var_61d958e8 ]]->waitinqueue(e_target);
		if(!isdefined(e_target))
		{
			return;
		}
		switch(e_target.var_6f84b820)
		{
			case "popcorn":
			case "basic":
			case "enhanced":
			{
				n_damage = e_target.health;
				break;
			}
			case "heavy":
			{
				n_damage = int(e_target.maxhealth * 0.25);
				break;
			}
			case "miniboss":
			{
				n_damage = int(e_target.maxhealth * 0.15);
				break;
			}
		}
		e_target.no_gib = 1;
		e_target thread zm_hero_weapon::function_acee2761();
		e_target playsound(#"hash_774c028e67b9c337");
		self playsoundtoplayer(#"hash_45070d2fde57b8aa", self);
		e_target dodamage(n_damage, self.origin, self, self, "none", "MOD_MELEE", 0, weapon);
		if(e_target.health <= 0)
		{
			e_target clientfield::increment("" + #"hash_1e850b3e1aaeb945");
			e_target.ignoremelee = 1;
			switch(var_3e3892a7)
			{
				case 1:
				{
					v_fling = (0, 0, -1) * 250;
					break;
				}
				case 2:
				case 3:
				{
					v_fling = v_to_target * 250;
					break;
				}
			}
			self playrumbleonentity("damage_heavy");
			e_target zm_utility::function_ffc279(v_fling, self, undefined, weapon);
		}
		else
		{
			self playrumbleonentity("shotgun_fire");
		}
	}
	else
	{
		e_target dodamage(n_damage, self.origin, self, self, "none", "MOD_MELEE", 0, weapon);
	}
}

/*
	Name: function_1b29b59e
	Namespace: namespace_3dec9f28
	Checksum: 0xF0EF3B43
	Offset: 0x1828
	Size: 0x3B6
	Parameters: 2
	Flags: Linked
*/
function function_1b29b59e(var_3e3892a7, weapon = level.weaponnone)
{
	if(var_3e3892a7 == 1)
	{
		n_damage = 5000;
	}
	else
	{
		n_damage = 2500;
	}
	view_pos = self geteye();
	forward_view_angles = anglestoforward(self getplayerangles());
	if(forward_view_angles[2] < -0.7)
	{
		var_ccb70dad = (forward_view_angles[0], forward_view_angles[1], -0.25);
	}
	else
	{
		var_ccb70dad = forward_view_angles;
	}
	a_e_targets = zm_hero_weapon::function_7c3681f7();
	foreach(e_target in a_e_targets)
	{
		if(!isalive(e_target))
		{
			continue;
		}
		test_origin = e_target getcentroid();
		dist_sq = distancesquared(view_pos, test_origin);
		if(isdefined(e_target.var_35d30dee))
		{
			dist_to_check = e_target.var_35d30dee;
		}
		else
		{
			dist_to_check = level.var_b9efae55;
		}
		if(dist_sq > dist_to_check)
		{
			continue;
		}
		v_normal = vectornormalize(test_origin - self.origin);
		dot = vectordot(var_ccb70dad, v_normal);
		if(dot <= 0 && dist_sq > 1600)
		{
			continue;
		}
		if(0 == e_target damageconetrace(view_pos, self, forward_view_angles))
		{
			continue;
		}
		n_random_x = randomfloatrange(-3, 3);
		n_random_y = randomfloatrange(-3, 3);
		var_61906722 = randomfloatrange(5, 20);
		var_e6da270d = vectornormalize(e_target.origin - self.origin + (n_random_x, n_random_y, var_61906722));
		if(isdefined(e_target.var_5554df1))
		{
			self thread [[e_target.var_5554df1]](e_target, weapon, var_3e3892a7, var_e6da270d);
		}
		else
		{
			self thread function_9799924f(e_target, weapon, var_3e3892a7, var_e6da270d, n_damage);
		}
		waitframe(1);
	}
}

/*
	Name: function_f352c6b2
	Namespace: namespace_3dec9f28
	Checksum: 0x19FE7BF1
	Offset: 0x1BE8
	Size: 0x4B4
	Parameters: 1
	Flags: Linked
*/
function function_f352c6b2(weapon)
{
	self endon(#"disconnect");
	self playsound("wpn_hammer_bolt_fire");
	self thread function_1e661e68(3);
	waitframe(9);
	var_d571151f = vectortoangles(self getweaponforwarddir());
	var_d0407533 = self getweaponmuzzlepoint();
	level notify(#"lightning_ball_created", {#player:self});
	self notify(#"lightning_ball_created");
	if(!isdefined(var_d571151f))
	{
		var_d571151f = (0, 0, 0);
	}
	e_ball_fx = util::spawn_model(#"tag_origin", var_d0407533 + anglestoforward(var_d571151f) * 60, var_d571151f);
	e_ball_fx.str_weapon = weapon;
	e_ball_fx.n_range = 250;
	e_ball_fx.n_damage_per_sec = 1000;
	e_ball_fx clientfield::set("" + #"lightning_miss_fx", 1);
	e_ball_fx playloopsound(#"hash_15299b453cf5dd24", 0.5);
	v_end = var_d0407533 + anglestoforward(var_d571151f) * 600;
	trace = bullettrace(var_d0407533, v_end, 0, self);
	if(trace[#"fraction"] != 1)
	{
		v_end = trace[#"position"];
	}
	if(isdefined(trace[#"entity"]) && function_ffa5b184(trace[#"entity"]))
	{
		self thread function_43a6dfea(trace[#"entity"]);
	}
	if(isdefined(level.var_2e32e0bb))
	{
		self thread function_f911e261();
	}
	staff_lightning_ball_speed = 600 / 8 * 5;
	n_dist = distance(e_ball_fx.origin, v_end);
	n_max_movetime_s = 600 / staff_lightning_ball_speed;
	n_movetime_s = n_dist / staff_lightning_ball_speed;
	n_leftover_time = n_max_movetime_s - n_movetime_s;
	e_ball_fx thread staff_lightning_ball_kill_zombies(self);
	e_ball_fx moveto(v_end, n_movetime_s);
	finished_playing = e_ball_fx lightning_ball_wait(n_leftover_time);
	if(isdefined(e_ball_fx))
	{
		e_ball_fx stoploopsound(0.25);
		e_ball_fx playsound(#"hash_3f29c3ebe4a7417a");
		e_ball_fx notify(#"stop_killing");
		e_ball_fx notify(#"stop_debug_position");
		e_ball_fx clientfield::set("" + #"lightning_miss_fx", 0);
	}
	waitframe(1);
	if(isdefined(e_ball_fx))
	{
		e_ball_fx delete();
	}
}

/*
	Name: function_f911e261
	Namespace: namespace_3dec9f28
	Checksum: 0xE6B5211C
	Offset: 0x20A8
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function function_f911e261()
{
	var_2ed6f142 = self getweaponmuzzlepoint();
	v_forward = self getweaponforwarddir();
	v_end = var_2ed6f142 + v_forward * 10000;
	a_trace = bullettrace(var_2ed6f142, v_end, 0, self);
	level notify(#"hero_weapon_hit", {#v_position:a_trace[#"position"], #hash_80e17549:self.currentweapon, #e_entity:a_trace[#"entity"], #player:self});
}

/*
	Name: function_fd8e3604
	Namespace: namespace_3dec9f28
	Checksum: 0x901A9A8A
	Offset: 0x21C0
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_fd8e3604()
{
	self endon(#"disconnect", #"bled_out", #"death", #"hash_51ba139f52797f7d");
	self.var_4618dc52 endon(#"death");
	while(true)
	{
		a_e_targets = zm_hero_weapon::function_7c3681f7();
		array::thread_all(a_e_targets, &function_5ae28f27, self);
		wait(0.05);
	}
}

/*
	Name: function_5ae28f27
	Namespace: namespace_3dec9f28
	Checksum: 0x7B33C046
	Offset: 0x2280
	Size: 0x23A
	Parameters: 1
	Flags: Linked
*/
function function_5ae28f27(player)
{
	player endon(#"disconnect", #"bled_out", #"death", #"hash_51ba139f52797f7d");
	player.var_4618dc52 endon(#"death");
	/#
		assert(isdefined(player));
	#/
	var_359c1a94 = 10000;
	var_75ccefac = player.var_4618dc52.origin;
	if(!isalive(self) || (isdefined(self.takedamage) && !self.takedamage))
	{
		return;
	}
	if(!isdefined(self.var_6f84b820))
	{
		return;
	}
	if(self function_51caa467(var_75ccefac, 96, var_359c1a94))
	{
		self.var_74558e5 = 1;
		if(isalive(self))
		{
			switch(self.var_6f84b820)
			{
				case "heavy":
				case "miniboss":
				case "basic":
				case "enhanced":
				{
					self thread function_97429d68();
					break;
				}
				case "boss":
				{
					self dodamage(1, var_75ccefac, player, player);
					break;
				}
				case "popcorn":
				{
					self.var_bc973222 = 1;
					self dodamage(self.health + 100, var_75ccefac, player, player);
					break;
				}
			}
		}
	}
}

/*
	Name: function_97429d68
	Namespace: namespace_3dec9f28
	Checksum: 0xB77B3020
	Offset: 0x24C8
	Size: 0x156
	Parameters: 0
	Flags: Linked
*/
function function_97429d68()
{
	self endon(#"death");
	if(isdefined(self.aat_turned) && self.aat_turned || (isdefined(self.var_c6aafbdb) && self.var_c6aafbdb))
	{
		return;
	}
	self ai::stun();
	self.var_c6aafbdb = 1;
	if(!self clientfield::get("" + #"hash_227b5ad1ba4c6b6d"))
	{
		self clientfield::set("" + #"hash_227b5ad1ba4c6b6d", 1);
		if(self.archetype == #"zombie")
		{
			function_6eac4ca1(self, "electrocute");
		}
	}
	wait(0.2);
	self ai::function_62795e55();
	self clientfield::set("" + #"hash_227b5ad1ba4c6b6d", 0);
	self.var_c6aafbdb = 0;
}

/*
	Name: function_51caa467
	Namespace: namespace_3dec9f28
	Checksum: 0xFD098394
	Offset: 0x2628
	Size: 0xA2
	Parameters: 3
	Flags: Linked
*/
function function_51caa467(v_attack_source, n_allowed_z_diff, n_radius_sq)
{
	if(isalive(self))
	{
		n_z_diff = self.origin[2] - v_attack_source[2];
		if(abs(n_z_diff) < n_allowed_z_diff)
		{
			if(distance2dsquared(self.origin, v_attack_source) < n_radius_sq)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_4b58e5ab
	Namespace: namespace_3dec9f28
	Checksum: 0xC4C5B3CB
	Offset: 0x26D8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_4b58e5ab()
{
	if(isdefined(self.var_74558e5) && self.var_74558e5)
	{
		self.var_74558e5 = 0;
		self clientfield::set("lc_fx", 0);
	}
}

/*
	Name: function_43a6dfea
	Namespace: namespace_3dec9f28
	Checksum: 0x8FAD65B
	Offset: 0x2728
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_43a6dfea(var_b9812c05)
{
	var_b9812c05 endon(#"death");
	var_b9812c05 dodamage(1000, self.origin, self, self);
}

/*
	Name: staff_lightning_ball_kill_zombies
	Namespace: namespace_3dec9f28
	Checksum: 0x71237ED5
	Offset: 0x2778
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function staff_lightning_ball_kill_zombies(e_attacker)
{
	self endon(#"death", #"stop_killing");
	while(true)
	{
		a_zombies = staff_lightning_get_valid_targets(e_attacker, self.origin);
		if(isdefined(a_zombies))
		{
			foreach(zombie in a_zombies)
			{
				if(staff_lightning_is_target_valid(zombie))
				{
					e_attacker thread staff_lightning_arc_fx(self, zombie);
					wait(0.05);
				}
			}
		}
		wait(0.05);
	}
}

/*
	Name: staff_lightning_get_valid_targets
	Namespace: namespace_3dec9f28
	Checksum: 0x3BDE166C
	Offset: 0x2890
	Size: 0xF8
	Parameters: 2
	Flags: Linked
*/
function staff_lightning_get_valid_targets(player, v_source)
{
	a_enemies = [];
	a_zombies = zm_hero_weapon::function_7c3681f7();
	a_zombies = util::get_array_of_closest(v_source, a_zombies, undefined, undefined, self.n_range);
	if(isdefined(a_zombies))
	{
		foreach(ai_zombie in a_zombies)
		{
			if(staff_lightning_is_target_valid(ai_zombie))
			{
				a_enemies[a_enemies.size] = ai_zombie;
			}
		}
	}
	return a_enemies;
}

/*
	Name: staff_lightning_arc_fx
	Namespace: namespace_3dec9f28
	Checksum: 0xDB70AE02
	Offset: 0x2990
	Size: 0xD4
	Parameters: 2
	Flags: Linked
*/
function staff_lightning_arc_fx(e_source, ai_zombie)
{
	if(isplayer(self))
	{
		self endon(#"disconnect");
	}
	if(!isdefined(ai_zombie))
	{
		return;
	}
	if(!bullet_trace_throttled(e_source.origin, ai_zombie.origin + vectorscale((0, 0, 1), 20), ai_zombie))
	{
		return;
	}
	if(isdefined(e_source) && isdefined(ai_zombie) && isalive(ai_zombie))
	{
		level thread staff_lightning_ball_damage_over_time(e_source, ai_zombie, self);
	}
}

/*
	Name: staff_lightning_ball_damage_over_time
	Namespace: namespace_3dec9f28
	Checksum: 0x5D0432B
	Offset: 0x2A70
	Size: 0x40C
	Parameters: 3
	Flags: Linked
*/
function staff_lightning_ball_damage_over_time(e_source, e_target, e_attacker)
{
	if(isplayer(e_attacker))
	{
		e_attacker endon(#"disconnect");
	}
	if(!isalive(e_target) || (isdefined(e_target.takedamage) && !e_target.takedamage))
	{
		return;
	}
	e_target endon(#"death");
	if(!isdefined(e_target.var_6f84b820))
	{
		return;
	}
	e_target clientfield::set("" + #"lightning_impact_fx", 1);
	if(e_target.archetype === #"zombie")
	{
		function_6eac4ca1(e_target, "electrocute");
	}
	n_range_sq = e_source.n_range * e_source.n_range;
	e_target.is_being_zapped = 1;
	e_target clientfield::set("" + #"lightning_arc_fx", 1);
	if(isdefined(e_source))
	{
		if(!isdefined(e_source.n_damage_per_sec))
		{
			e_source.n_damage_per_sec = 1000;
		}
		n_damage_per_pulse = e_source.n_damage_per_sec * 0.25;
	}
	while(isdefined(e_source) && isalive(e_target))
	{
		e_target thread stun_zombie();
		var_21277708 = e_source.str_weapon;
		wait(0.25);
		if(!isalive(e_target))
		{
			break;
		}
		if(isalive(e_target) && isdefined(e_source))
		{
			switch(e_target.var_6f84b820)
			{
				case "basic":
				case "enhanced":
				{
					if(e_target.archetype != #"tiger" && e_target.archetype != #"hash_1bab8a0ba811401e")
					{
						e_target thread zombie_shock_eyes();
					}
					e_target.var_b7e3212 = 1;
					e_target thread function_1ca3b529(e_attacker, e_target.health + 100, var_21277708, "MOD_ELECTROCUTED");
					break;
				}
				default:
				{
					e_target thread function_1ca3b529(e_attacker, n_damage_per_pulse, var_21277708, "MOD_ELECTROCUTED");
					break;
				}
			}
		}
	}
	if(isalive(e_target))
	{
		e_target.is_being_zapped = 0;
		e_target clientfield::set("" + #"lightning_arc_fx", 0);
		e_target clientfield::set("" + #"lightning_impact_fx", 0);
	}
}

/*
	Name: bullet_trace_throttled
	Namespace: namespace_3dec9f28
	Checksum: 0x1A4544CE
	Offset: 0x2E88
	Size: 0xA2
	Parameters: 3
	Flags: Linked
*/
function bullet_trace_throttled(v_start, v_end, e_ignore)
{
	if(!isdefined(level.bullet_traces_this_frame))
	{
		level thread _throttle_bullet_trace_think();
	}
	while(level.bullet_traces_this_frame >= 2)
	{
		util::wait_network_frame();
	}
	level.bullet_traces_this_frame++;
	return bullettracepassed(v_start, v_end, 0, e_ignore);
}

/*
	Name: _throttle_bullet_trace_think
	Namespace: namespace_3dec9f28
	Checksum: 0x2419F12A
	Offset: 0x2F38
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function _throttle_bullet_trace_think()
{
	do
	{
		level.bullet_traces_this_frame = 0;
		util::wait_network_frame();
	}
	while(1);
}

/*
	Name: function_1ca3b529
	Namespace: namespace_3dec9f28
	Checksum: 0x133B8C3F
	Offset: 0x2F70
	Size: 0xCC
	Parameters: 4
	Flags: Linked
*/
function function_1ca3b529(e_attacker, n_amount, w_damage, str_mod)
{
	self endon(#"death");
	[[ level.var_61d958e8 ]]->waitinqueue(self);
	if(isstring(w_damage))
	{
		w_damage = getweapon(w_damage);
	}
	if(!isdefined(n_amount))
	{
		return;
	}
	self.staff_dmg = w_damage;
	self dodamage(n_amount, self.origin, e_attacker, e_attacker, "none", str_mod, 0, w_damage);
}

/*
	Name: lightning_ball_wait
	Namespace: namespace_3dec9f28
	Checksum: 0x1ABA3E62
	Offset: 0x3048
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function lightning_ball_wait(n_lifetime_after_move)
{
	level endon(#"lightning_ball_created");
	self waittill(#"movedone");
	wait(n_lifetime_after_move);
	return 1;
}

/*
	Name: staff_lightning_is_target_valid
	Namespace: namespace_3dec9f28
	Checksum: 0x5F566A70
	Offset: 0x3098
	Size: 0xA6
	Parameters: 1
	Flags: Linked
*/
function staff_lightning_is_target_valid(ai_zombie)
{
	if(!isdefined(ai_zombie))
	{
		return 0;
	}
	if(isdefined(ai_zombie.is_being_zapped) && ai_zombie.is_being_zapped)
	{
		return 0;
	}
	if(isdefined(ai_zombie.is_mechz) && ai_zombie.is_mechz)
	{
		return 0;
	}
	if(isvehicle(ai_zombie) && isdefined(ai_zombie.takedamage) && !ai_zombie.takedamage)
	{
		return 0;
	}
	return 1;
}

/*
	Name: stun_zombie
	Namespace: namespace_3dec9f28
	Checksum: 0xEA32D605
	Offset: 0x3148
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function stun_zombie()
{
	self endon(#"death");
	if(self.var_6f84b820 === #"miniboss" || self.var_6f84b820 === #"boss")
	{
		return;
	}
	if(isdefined(self.is_electrocuted) && self.is_electrocuted)
	{
		return;
	}
	if(!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area))
	{
		return;
	}
	self ai::stun();
}

/*
	Name: zombie_shock_eyes_network_safe
	Namespace: namespace_3dec9f28
	Checksum: 0xB20FB08
	Offset: 0x31E8
	Size: 0x8C
	Parameters: 3
	Flags: Linked
*/
function zombie_shock_eyes_network_safe(fx, entity, tag)
{
	if(zm_net::network_entity_valid(entity))
	{
		if(!(isdefined(self.head_gibbed) && self.head_gibbed) && !gibserverutils::isgibbed(self, 8))
		{
			playfxontag(fx, entity, tag);
		}
	}
}

/*
	Name: zombie_shock_eyes
	Namespace: namespace_3dec9f28
	Checksum: 0x83482DCB
	Offset: 0x3280
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function zombie_shock_eyes()
{
	if(isdefined(self.head_gibbed) && self.head_gibbed || gibserverutils::isgibbed(self, 8))
	{
		return;
	}
	if(self.var_6f84b820 === #"miniboss" || self.var_6f84b820 === #"boss" || isvehicle(self))
	{
		return;
	}
	if(isdefined(self gettagorigin("j_eyeball_le")))
	{
		zm_net::network_safe_init("shock_eyes", 2);
		zm_net::network_choke_action("shock_eyes", &zombie_shock_eyes_network_safe, level._effect[#"hash_6c99dc53e968631c"], self, "j_eyeball_le");
	}
}

/*
	Name: on_player_disconnect
	Namespace: namespace_3dec9f28
	Checksum: 0xE111C96A
	Offset: 0x3398
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_player_disconnect()
{
	self function_371c585a();
}

/*
	Name: function_371c585a
	Namespace: namespace_3dec9f28
	Checksum: 0xC9FB184
	Offset: 0x33C0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_371c585a()
{
	if(isdefined(self.var_4618dc52))
	{
		self.var_4618dc52 clientfield::set("" + #"hash_9e18cea0c11fb61", 0);
		self.var_4618dc52 delete();
	}
}

/*
	Name: function_a3eae601
	Namespace: namespace_3dec9f28
	Checksum: 0x8EC03026
	Offset: 0x3428
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_a3eae601(var_bcd1c2ff, w_hero)
{
	self notify(#"hash_51ba139f52797f7d");
	self function_371c585a();
}

/*
	Name: function_1e661e68
	Namespace: namespace_3dec9f28
	Checksum: 0x7C845ECB
	Offset: 0x3470
	Size: 0x122
	Parameters: 1
	Flags: Linked
*/
function function_1e661e68(n_index)
{
	self endon(#"death");
	if(n_index)
	{
		waitframe(1);
		switch(n_index)
		{
			case 1:
			{
				self playrumbleonentity("zm_weap_special_activate_rumble");
				break;
			}
			case 2:
			{
				playrumbleonposition("zm_weap_hammer_slam_rumble", self.origin);
				break;
			}
			case 3:
			{
				playrumbleonposition("zm_weap_hammer_storm_rumble", self.origin);
				break;
			}
			case 4:
			{
				self clientfield::increment_to_player("" + #"hash_5da4c56e7c2e2aad", 4);
				break;
			}
		}
	}
}

/*
	Name: function_478a4910
	Namespace: namespace_3dec9f28
	Checksum: 0xD8C924A4
	Offset: 0x35A0
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_478a4910(var_6ed98fb9)
{
	self endon(#"weapon_change", #"disconnect", #"bled_out");
	var_88706ea7 = undefined;
	var_88706ea7 = self waittill(#"weapon_melee_power_left");
	if(var_88706ea7.weapon == var_6ed98fb9)
	{
		self thread zm_audio::create_and_play_dialog(#"hash_6a87ca13e3ecd52d", #"hammer");
	}
}

/*
	Name: function_68ff89f7
	Namespace: namespace_3dec9f28
	Checksum: 0x1FF9FFA1
	Offset: 0x3658
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_68ff89f7(var_6ed98fb9)
{
	self endon(#"weapon_change", #"disconnect", #"bled_out");
	var_88706ea7 = undefined;
	var_88706ea7 = self waittill(#"weapon_melee");
	if(var_88706ea7.weapon === var_6ed98fb9)
	{
		self thread zm_audio::create_and_play_dialog(#"hash_6a87c913e3ecd37a", #"hammer");
	}
}

