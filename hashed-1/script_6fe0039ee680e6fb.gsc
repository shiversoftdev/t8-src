// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_24c32478acf44108;
#using script_2dc48f46bfeac894;
#using script_35598499769dbb3d;
#using script_3f9e0dc8454d98e1;
#using script_9e4105ea1798ccc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
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
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_23a9b248;

/*
	Name: function_89f2df9
	Namespace: namespace_23a9b248
	Checksum: 0x75D95D2
	Offset: 0x1F0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_65ddf3efec755b91", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_23a9b248
	Checksum: 0xC6B142F6
	Offset: 0x238
	Size: 0x3FE
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "hemera_shoot", 16000, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_47f6efd679c0437d", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_551f6ae1cc666550", 16000, 1, "counter");
	clientfield::register("allplayers", "hemera_proj_flash", 16000, 1, "int");
	clientfield::register("allplayers", "hemera_beam_flash", 16000, 1, "int");
	clientfield::register("actor", "hemera_proj_death", 16000, 1, "int");
	clientfield::register("actor", "" + #"hash_5a8f1796382ec694", 16000, 1, "int");
	level.var_45072d7d = getweapon(#"hash_67c8dba04eccef92");
	level.var_f10d87a1 = getweapon(#"hash_4f2a3ad24337dd19");
	level.var_e8ffa40 = getweapon(#"hash_64a8e509557af3d0");
	level.var_836fa4da = getweapon(#"hash_403bfa4250f7a743");
	zm_weapons::include_zombie_weapon(#"hash_67c8dba04eccef92", 0);
	zm_weapons::include_zombie_weapon(#"hash_4f2a3ad24337dd19", 0);
	zm_weapons::include_zombie_weapon(#"hash_64a8e509557af3d0", 0);
	zm_weapons::include_zombie_weapon(#"hash_403bfa4250f7a743", 0);
	callback::on_connect(&on_player_connect);
	if(!isdefined(level.var_ab6fef61))
	{
		object = new throttle();
		[[ object ]]->__constructor();
		level.var_ab6fef61 = object;
		[[ level.var_ab6fef61 ]]->initialize(6, 0.1);
	}
	namespace_9ff9f642::register_slowdown(#"hash_7e8287b2e2587da1", 0.6, 3);
	callback::function_34dea974(level.var_45072d7d, &function_10b4d6ac);
	callback::function_34dea974(level.var_f10d87a1, &function_dd7bc108);
	callback::function_34dea974(level.var_e8ffa40, &function_10b4d6ac);
	callback::function_34dea974(level.var_836fa4da, &function_10b4d6ac);
	level.var_7148b584 = [];
	level.var_e51fadba = [];
}

/*
	Name: on_player_connect
	Namespace: namespace_23a9b248
	Checksum: 0x2F2CFA14
	Offset: 0x640
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self thread function_3f8da82c();
}

/*
	Name: function_3f8da82c
	Namespace: namespace_23a9b248
	Checksum: 0x5651D944
	Offset: 0x668
	Size: 0x108
	Parameters: 0
	Flags: Linked
*/
function function_3f8da82c()
{
	self endon(#"disconnect");
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = self waittill(#"weapon_change");
		if(var_385703b7.weapon === level.var_e8ffa40)
		{
		}
		else if(var_385703b7.weapon === level.var_45072d7d || var_385703b7.weapon === level.var_836fa4da)
		{
			self.var_e34577ca = undefined;
			self thread function_54922a21();
		}
		else if(isdefined(self.var_8999a4bf))
		{
			self.var_8999a4bf clientfield::set("" + #"hash_47f6efd679c0437d", 0);
			self.var_8999a4bf delete();
		}
	}
}

/*
	Name: function_10b4d6ac
	Namespace: namespace_23a9b248
	Checksum: 0xCAF4C225
	Offset: 0x778
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_10b4d6ac(weapon)
{
	self endon(#"death");
	self function_d8a9b5a6(weapon);
}

/*
	Name: function_d8a9b5a6
	Namespace: namespace_23a9b248
	Checksum: 0x374923C6
	Offset: 0x7B8
	Size: 0x354
	Parameters: 1
	Flags: Linked
*/
function function_d8a9b5a6(weapon)
{
	self endon(#"death");
	if(weapon == level.var_836fa4da)
	{
		n_damage = 8500;
		var_a4c20abe = 1;
	}
	else
	{
		n_damage = 5000;
		var_a4c20abe = 0;
	}
	self clientfield::set("hemera_proj_flash", 1);
	a_e_targets = function_6880852f(var_a4c20abe);
	if(isdefined(a_e_targets))
	{
		if(isdefined(a_e_targets[0]) && a_e_targets[0].var_6f84b820 === #"boss")
		{
			var_e753f573 = 3;
		}
		else if(!a_e_targets.size || (a_e_targets.size === 1 && !isactor(a_e_targets[0])))
		{
			var_e753f573 = 1;
		}
		else
		{
			var_e753f573 = 3;
		}
	}
	for(i = 0; i < var_e753f573; i++)
	{
		e_projectile = util::spawn_model("tag_origin", self gettagorigin("tag_flash"), self gettagangles("tag_flash"));
		if(isdefined(e_projectile))
		{
			e_projectile thread function_78de2d2e(i);
			if(isdefined(a_e_targets) && isdefined(a_e_targets[i]))
			{
				self thread function_8e7f5291(e_projectile, a_e_targets[i], n_damage);
			}
			else if(i == 1 && isdefined(a_e_targets[i - 1]))
			{
				self thread function_8e7f5291(e_projectile, a_e_targets[i - 1], n_damage);
			}
			else if(i == 2)
			{
				if(isdefined(a_e_targets[i - 1]))
				{
					self thread function_8e7f5291(e_projectile, a_e_targets[i - 1], n_damage);
				}
				else if(isdefined(a_e_targets[i - 2]))
				{
					self thread function_8e7f5291(e_projectile, a_e_targets[i - 2], n_damage);
				}
			}
			else
			{
				self thread function_8e7f5291(e_projectile);
			}
		}
		wait(0.1);
	}
	self clientfield::set("hemera_proj_flash", 0);
}

/*
	Name: function_54922a21
	Namespace: namespace_23a9b248
	Checksum: 0xC86C4A9D
	Offset: 0xB18
	Size: 0xF2
	Parameters: 0
	Flags: Linked
*/
function function_54922a21()
{
	self endon(#"death", #"weapon_change");
	while(true)
	{
		while(self.chargeshotlevel != 2 || !self attackbuttonpressed() && (self.currentweapon === level.var_45072d7d || self.currentweapon === level.var_836fa4da))
		{
			waitframe(1);
		}
		self thread function_b27148c8(self.currentweapon);
		self waittill(#"weapon_fired", #"hash_609518a5a35564bf");
		while(self.chargeshotlevel >= 2)
		{
			waitframe(1);
		}
	}
}

/*
	Name: function_dd7bc108
	Namespace: namespace_23a9b248
	Checksum: 0xFF0E9703
	Offset: 0xC18
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_dd7bc108(weapon)
{
	if(!(isdefined(self.var_e34577ca) && self.var_e34577ca))
	{
		self function_d8a9b5a6(weapon);
	}
}

/*
	Name: function_6880852f
	Namespace: namespace_23a9b248
	Checksum: 0x112ACC00
	Offset: 0xC60
	Size: 0x5C4
	Parameters: 1
	Flags: Linked
*/
function function_6880852f(var_a4c20abe)
{
	if(var_a4c20abe)
	{
		n_range = 3000;
	}
	else
	{
		n_range = 2150;
	}
	view_pos = self geteye();
	forward_view_angles = anglestoforward(self getplayerangles());
	if(forward_view_angles[2] < -0.7)
	{
		var_ccb70dad = vectornormalize((forward_view_angles[0], forward_view_angles[1], -0.25));
	}
	else
	{
		var_ccb70dad = vectornormalize(forward_view_angles);
	}
	a_e_targets = function_3874b38f();
	var_180d380d = [];
	foreach(e_target in a_e_targets)
	{
		if(self is_valid_target(e_target, n_range))
		{
			var_180d380d[var_180d380d.size] = e_target;
		}
	}
	var_180d380d = array::get_all_closest(self.origin, var_180d380d);
	var_e115ff2 = [];
	foreach(e_target in var_180d380d)
	{
		if(isdefined(e_target.var_564012c4) && e_target.var_564012c4)
		{
			if(!isdefined(var_e115ff2))
			{
				var_e115ff2 = [];
			}
			else if(!isarray(var_e115ff2))
			{
				var_e115ff2 = array(var_e115ff2);
			}
			var_e115ff2[var_e115ff2.size] = e_target;
		}
	}
	foreach(e_target in var_e115ff2)
	{
		arrayremovevalue(var_180d380d, e_target);
		array::push_front(var_180d380d, e_target);
	}
	var_99588c0f = function_3ebebb9c();
	if(isdefined(var_99588c0f))
	{
		var_99588c0f = array::remove_undefined(var_99588c0f);
		var_99588c0f = arraysortclosest(var_99588c0f, self.origin);
		foreach(e_target in var_99588c0f)
		{
			if(!self zm_utility::is_player_looking_at(e_target getcentroid(), 0.9, 0, self) && !self zm_utility::is_player_looking_at(e_target.origin, 0.9, 0, self))
			{
				continue;
			}
			if(distance2dsquared(self.origin, e_target.origin) > n_range * n_range)
			{
				continue;
			}
			array::push_front(var_180d380d, e_target);
		}
	}
	var_465b9157 = function_b9a3e6f9();
	if(isdefined(var_465b9157))
	{
		var_465b9157 = array::remove_undefined(var_465b9157);
		var_465b9157 = arraysortclosest(var_465b9157, self.origin);
		foreach(e_target in var_465b9157)
		{
			if(!self zm_utility::is_player_looking_at(e_target.origin, 0.9, 1, self))
			{
				continue;
			}
			if(distance2dsquared(self.origin, e_target.origin) > n_range * n_range)
			{
				continue;
			}
			e_target.var_3df1a748 = 1;
			array::push_front(var_180d380d, e_target);
		}
	}
	return var_180d380d;
}

/*
	Name: is_valid_target
	Namespace: namespace_23a9b248
	Checksum: 0x904CDA37
	Offset: 0x1230
	Size: 0x2B2
	Parameters: 2
	Flags: Linked
*/
function is_valid_target(e_target, n_range)
{
	if(zm_utility::is_magic_bullet_shield_enabled(e_target))
	{
		return 0;
	}
	if(isdefined(e_target.var_aea6e035) && e_target.var_aea6e035 || (isdefined(e_target.var_f9b38410) && e_target.var_f9b38410))
	{
		return 0;
	}
	if(isdefined(e_target.marked_for_death) && e_target.marked_for_death)
	{
		return 0;
	}
	if(distance2dsquared(self.origin, e_target.origin) <= 64 * 64 && (self zm_utility::is_player_looking_at(e_target getcentroid(), 0.3, 1, self) || self zm_utility::is_player_looking_at(e_target getcentroid() + vectorscale((0, 0, 1), 32), 0.3, 1, self)))
	{
		return 1;
	}
	if(isdefined(e_target.fake_death) && e_target.fake_death)
	{
		return 0;
	}
	if(!isalive(e_target))
	{
		return 0;
	}
	if(distance2dsquared(self.origin, e_target.origin) > n_range * n_range)
	{
		return 0;
	}
	var_c060d2c8 = !(isdefined(level.var_58f509b6) && level.var_58f509b6);
	if(!self zm_utility::is_player_looking_at(e_target getcentroid(), 0.9, var_c060d2c8, self) && !self zm_utility::is_player_looking_at(e_target.origin, 0.9, var_c060d2c8, self) && !self zm_utility::is_player_looking_at(e_target getcentroid() + vectorscale((0, 0, 1), 28), 0.9, var_c060d2c8, self))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_78de2d2e
	Namespace: namespace_23a9b248
	Checksum: 0xADDFCA11
	Offset: 0x14F0
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_78de2d2e(n_index)
{
	self endon(#"death");
	self.n_index = n_index;
	wait(0.1);
	self clientfield::increment("hemera_shoot");
}

/*
	Name: function_8e7f5291
	Namespace: namespace_23a9b248
	Checksum: 0x2B418DC5
	Offset: 0x1550
	Size: 0x8CC
	Parameters: 3
	Flags: Linked
*/
function function_8e7f5291(e_projectile, ai_zombie, n_damage)
{
	e_projectile endon(#"death");
	self endon(#"disconnect");
	if(isdefined(ai_zombie) && (!(isdefined(ai_zombie.marked_for_death) && ai_zombie.marked_for_death)))
	{
		ai_zombie.marked_for_death = 1;
	}
	e_projectile thread function_723b1d66();
	v_end = self function_3f079da();
	n_dist = distance(e_projectile.origin, v_end);
	n_time = n_dist / 1500;
	if(n_time <= 0.1)
	{
		n_time = 0.1;
	}
	if(!isdefined(ai_zombie) || (isdefined(ai_zombie.var_3df1a748) && ai_zombie.var_3df1a748))
	{
		e_projectile moveto(v_end, n_time);
		e_projectile waittill(#"movedone");
		e_projectile clientfield::increment("" + #"hash_551f6ae1cc666550");
		waitframe(1);
	}
	else
	{
		var_2ed6f142 = self getweaponmuzzlepoint();
		v_forward = self getweaponforwarddir();
		v_end = var_2ed6f142 + v_forward * 200;
		n_dist_sq = distance2dsquared(self.origin, v_end);
		if(isdefined(ai_zombie) && distance2dsquared(e_projectile.origin, ai_zombie.origin) <= n_dist_sq)
		{
			n_dist = distance(e_projectile.origin, ai_zombie.origin);
			n_time = n_dist / 1500;
			if(n_time <= 0.1)
			{
				n_time = 0.1;
			}
			if(isdefined(ai_zombie))
			{
				e_projectile moveto(ai_zombie getcentroid(), n_time);
				wait(n_time - 0.05);
			}
		}
		else if(isdefined(ai_zombie))
		{
			var_4d8b7233 = 0;
			var_14dcf3ed = 0;
			v_org = function_30239376(ai_zombie);
			n_dist = distance(self.origin, v_org);
			var_7fd007f9 = n_dist * 0.5;
			v_end = var_2ed6f142 + v_forward * 100;
			var_a93a9211 = distance(self.origin, v_end);
			v_right = var_2ed6f142 + anglestoright(self.angles) * 50;
			v_right_end = v_right + v_forward * 100 + vectorscale((0, 0, 1), 24);
			v_left = var_2ed6f142 - anglestoright(self.angles) * 50;
			v_left_end = v_left + v_forward * 100 + vectorscale((0, 0, -1), 24);
			n_time = var_a93a9211 / 1500;
			if(n_time <= 0.1)
			{
				n_time = 0.1;
			}
			if(e_projectile.n_index === 1)
			{
				e_projectile moveto(v_right_end, n_time);
			}
			else if(e_projectile.n_index === 2)
			{
				e_projectile moveto(v_left_end, n_time);
			}
			else
			{
				e_projectile moveto(v_end, n_time);
			}
			wait(n_time - 0.05);
			if(isdefined(ai_zombie) && ai_zombie.var_6f84b820 === #"boss")
			{
				if(isdefined(ai_zombie gettagorigin("j_tail_1")))
				{
					n_hit_dist_sq = 2500;
				}
				else
				{
					n_hit_dist_sq = 400;
				}
			}
			else
			{
				n_hit_dist_sq = 400;
			}
			while(isdefined(ai_zombie))
			{
				v_target = function_30239376(ai_zombie);
				n_dist = distance(e_projectile.origin, v_target);
				if(n_dist > var_7fd007f9)
				{
					if(var_4d8b7233 <= 100)
					{
						var_4d8b7233 = var_4d8b7233 + 20;
					}
					if(e_projectile.n_index === 1)
					{
						var_8ffd01b1 = v_target + anglestoright(ai_zombie.angles) * 100;
					}
					else if(e_projectile.n_index === 2)
					{
						var_8ffd01b1 = v_target - anglestoright(ai_zombie.angles) * 100;
					}
					else
					{
						var_8ffd01b1 = v_target;
					}
					if(isdefined(var_8ffd01b1))
					{
						v_end = var_8ffd01b1 + (0, 0, var_4d8b7233);
					}
				}
				else
				{
					var_4d8b7233 = var_4d8b7233 - 20;
					if(isdefined(v_target))
					{
						v_end = v_target + (0, 0, var_4d8b7233);
						if(v_end[2] < v_target[2] + 8)
						{
							v_end = v_target + vectorscale((0, 0, 1), 8);
						}
					}
				}
				n_time = n_dist / 1500;
				if(n_time <= 0.1)
				{
					n_time = 0.1;
				}
				if(isdefined(v_end) && isdefined(ai_zombie))
				{
					if(distance2dsquared(e_projectile.origin, ai_zombie.origin) <= 400)
					{
						v_end = ai_zombie getcentroid();
					}
					e_projectile moveto(v_end, n_time);
				}
				waitframe(1);
				var_dc65d1c = distance2dsquared(e_projectile.origin, v_end);
				if(var_dc65d1c <= n_hit_dist_sq)
				{
					break;
				}
			}
		}
	}
	if(isdefined(ai_zombie))
	{
		v_end = function_30239376(ai_zombie);
	}
	if(isdefined(v_end))
	{
		e_projectile moveto(v_end, 0.05);
		e_projectile waittill(#"movedone");
	}
	if(isalive(ai_zombie) || (isdefined(ai_zombie) && ai_zombie.var_6f84b820 === #"boss"))
	{
		self thread function_dced5aef(ai_zombie, level.var_e8ffa40, n_damage);
	}
	waitframe(1);
	e_projectile delete();
}

/*
	Name: function_30239376
	Namespace: namespace_23a9b248
	Checksum: 0x4588D1FC
	Offset: 0x1E28
	Size: 0x126
	Parameters: 1
	Flags: Linked
*/
function function_30239376(e_target)
{
	if(isdefined(e_target) && e_target.var_6f84b820 === #"boss")
	{
		if(isdefined(e_target gettagorigin("j_tail_1")))
		{
			v_org = e_target gettagorigin("j_tail_1");
		}
		else if(isdefined(e_target gettagorigin("j_spine4")))
		{
			v_org = e_target gettagorigin("j_spine4");
		}
		else
		{
			v_org = e_target getcentroid();
		}
	}
	else if(isdefined(e_target gettagorigin("j_spine4")))
	{
		v_org = e_target gettagorigin("j_spine4");
	}
	else
	{
		v_org = e_target.origin;
	}
	return v_org;
}

/*
	Name: function_723b1d66
	Namespace: namespace_23a9b248
	Checksum: 0x86460139
	Offset: 0x1F58
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_723b1d66()
{
	self endon(#"death");
	wait(5);
	self delete();
}

/*
	Name: function_dced5aef
	Namespace: namespace_23a9b248
	Checksum: 0x8FCD778D
	Offset: 0x1F98
	Size: 0x48C
	Parameters: 4
	Flags: Linked
*/
function function_dced5aef(e_target, weapon = level.weaponnone, n_damage, var_276d45bf)
{
	self endon(#"disconnect");
	e_target endon(#"death");
	if(isactor(e_target) && zm_utility::is_magic_bullet_shield_enabled(e_target))
	{
		return;
	}
	if(isdefined(e_target) && isdefined(e_target.var_6f84b820))
	{
		[[ level.var_ab6fef61 ]]->waitinqueue(e_target);
		switch(e_target.var_6f84b820)
		{
			case "popcorn":
			case "basic":
			case "enhanced":
			{
				if(isdefined(level.var_14f649ad) && level.var_14f649ad)
				{
					n_damage = e_target.health + 666;
				}
				if(n_damage >= e_target.health)
				{
					e_target.marked_for_death = 1;
				}
				if(e_target.archetype === #"skeleton")
				{
					e_target dodamage(n_damage, self.origin, self, undefined, "none", "MOD_UNKNOWN", 0, weapon);
				}
				else if(isdefined(e_target.marked_for_death) && e_target.marked_for_death)
				{
					self thread function_e56c350e(e_target, var_276d45bf, n_damage);
				}
				else
				{
					e_target dodamage(n_damage, e_target.origin, self, self, "none", "MOD_UNKNOWN", 0, weapon);
				}
				break;
			}
			case "heavy":
			{
				if(!isdefined(var_276d45bf))
				{
					n_damage = n_damage * 0.75;
				}
				e_target dodamage(n_damage, self.origin, self, undefined, "none", "MOD_UNKNOWN", 0, weapon);
				break;
			}
			case "miniboss":
			{
				if(isdefined(var_276d45bf))
				{
					n_damage = int(n_damage * 0.2);
				}
				else
				{
					n_damage = int(n_damage * 0.3);
				}
				if(randomint(10) == 0)
				{
					e_target thread ai::stun();
				}
				e_target thread function_aa6f2b4();
				e_target dodamage(n_damage, self.origin, self, undefined, "none", "MOD_UNKNOWN", 0, weapon);
				if(isdefined(e_target))
				{
					e_target.marked_for_death = 0;
				}
				break;
			}
			case "boss":
			{
				if(!isactor(e_target))
				{
					e_target clientfield::increment("" + #"hash_551f6ae1cc666550");
				}
				n_damage = 175;
				e_target dodamage(n_damage, self.origin, self, undefined, "none", "MOD_UNKNOWN", 0, weapon);
				if(isdefined(e_target))
				{
					e_target.marked_for_death = 0;
				}
				break;
			}
		}
	}
	else
	{
		e_target dodamage(n_damage, self.origin, self, undefined, "none", "MOD_UNKNOWN", 0, weapon);
	}
}

/*
	Name: function_aa6f2b4
	Namespace: namespace_23a9b248
	Checksum: 0x4905FB31
	Offset: 0x2430
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_aa6f2b4()
{
	if(isalive(self))
	{
		self clientfield::set("hemera_proj_death", 1);
	}
	wait(1);
	if(isdefined(self))
	{
		self clientfield::set("hemera_proj_death", 0);
	}
}

/*
	Name: function_3f079da
	Namespace: namespace_23a9b248
	Checksum: 0x8B2F306E
	Offset: 0x24A8
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function function_3f079da()
{
	var_2ed6f142 = self getweaponmuzzlepoint();
	v_forward = self getweaponforwarddir();
	v_end = var_2ed6f142 + v_forward * 3000;
	a_trace = bullettrace(var_2ed6f142, v_end, 1, self);
	if(isdefined(level.var_137b8e71))
	{
		level notify(#"hash_53f322a8c39f79d6", {#v_position:a_trace[#"position"], #e_entity:a_trace[#"entity"], #player:self});
	}
	return a_trace[#"position"];
}

/*
	Name: function_b27148c8
	Namespace: namespace_23a9b248
	Checksum: 0x6331B158
	Offset: 0x25C0
	Size: 0x3B6
	Parameters: 1
	Flags: Linked
*/
function function_b27148c8(weapon)
{
	self endon_callback(&function_8a56ed15, #"death", #"disconnect", #"weapon_change", #"weapon_fired", #"hash_609518a5a35564bf");
	v_trace = self function_3f079da();
	v_ground = groundtrace(v_trace + vectorscale((0, 0, 1), 200), v_trace + vectorscale((0, 0, -1), 1000), 0, self)[#"position"];
	if(!isdefined(self.var_8999a4bf))
	{
		self.var_8999a4bf = util::spawn_model("tag_origin", v_ground);
		if(!isdefined(self.var_8999a4bf))
		{
			self notify(#"hash_609518a5a35564bf");
			return;
		}
	}
	else
	{
		return;
	}
	self notify(#"hash_4969a839c4e666dc");
	self clientfield::set("hemera_beam_flash", 1);
	self.var_8999a4bf clientfield::set("" + #"hash_47f6efd679c0437d", 1);
	self playsound(#"hash_1f3a25ed02b0fb5f");
	self thread function_1e39fbc5(weapon);
	self thread function_8bf301a6();
	self thread function_a2065170();
	while(zm_utility::is_player_valid(self) && self attackbuttonpressed() && self getweaponammostock(weapon) && self getcurrentweapon() === weapon)
	{
		waitframe(5);
		self.var_e34577ca = 1;
		waitframe(2);
		v_trace = self function_3f079da();
		if(isdefined(v_trace))
		{
			v_ground = groundtrace(v_trace + vectorscale((0, 0, 1), 100), v_trace + vectorscale((0, 0, -1), 1000), 0, self)[#"position"];
		}
		if(isdefined(v_ground) && isdefined(self.var_8999a4bf))
		{
			self.var_8999a4bf moveto(v_ground, 0.3);
		}
	}
	self clientfield::set("hemera_beam_flash", 0);
	if(isdefined(self.var_8999a4bf))
	{
		self.var_8999a4bf clientfield::set("" + #"hash_47f6efd679c0437d", 0);
		self.var_8999a4bf delete();
	}
	self notify(#"hash_609518a5a35564bf");
}

/*
	Name: function_8a56ed15
	Namespace: namespace_23a9b248
	Checksum: 0xE2C1D76A
	Offset: 0x2980
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function function_8a56ed15(var_385703b7)
{
	self endon(#"death");
	self clientfield::set("hemera_beam_flash", 0);
	if(isdefined(self.var_8999a4bf))
	{
		self playsound(#"hash_7aeea3d29c1624a");
		self.var_8999a4bf clientfield::set("" + #"hash_47f6efd679c0437d", 0);
		self.var_8999a4bf delete();
	}
	wait(0.1);
	self.var_e34577ca = undefined;
}

/*
	Name: function_a2065170
	Namespace: namespace_23a9b248
	Checksum: 0x7432E27C
	Offset: 0x2A50
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function function_a2065170()
{
	self endon(#"death", #"weapon_change", #"hash_609518a5a35564bf", #"weapon_fired");
	while(true)
	{
		if(self meleebuttonpressed())
		{
			self notify(#"hash_609518a5a35564bf");
		}
		waitframe(1);
	}
}

/*
	Name: function_8bf301a6
	Namespace: namespace_23a9b248
	Checksum: 0xEB45AC6C
	Offset: 0x2AD8
	Size: 0x214
	Parameters: 0
	Flags: Linked
*/
function function_8bf301a6()
{
	self endon(#"death", #"weapon_change", #"hash_609518a5a35564bf");
	self.var_8999a4bf endon(#"death");
	if(self.currentweapon === level.var_836fa4da)
	{
		n_damage = 8500;
		n_range = 10000;
	}
	else
	{
		n_damage = 5000;
		n_range = 6400;
	}
	wait(0.3);
	while(true)
	{
		a_e_targets = zm_hero_weapon::function_7c3681f7();
		foreach(e_target in a_e_targets)
		{
			if(isalive(e_target) && (!(isdefined(e_target.var_8ac7cc49) && e_target.var_8ac7cc49)) && (!(isdefined(e_target.var_339655cf) && e_target.var_339655cf)) && (!(isdefined(e_target.var_aea6e035) && e_target.var_aea6e035)) && distance2dsquared(self.var_8999a4bf.origin, e_target.origin) <= n_range)
			{
				self thread function_dced5aef(e_target, level.var_45072d7d, n_damage, 1);
			}
		}
		wait(0.1);
	}
}

/*
	Name: function_1e39fbc5
	Namespace: namespace_23a9b248
	Checksum: 0xBEA50D0B
	Offset: 0x2CF8
	Size: 0x18C
	Parameters: 1
	Flags: Linked
*/
function function_1e39fbc5(weapon)
{
	self endon(#"death", #"hash_609518a5a35564bf", #"weapon_change");
	wait(0.3);
	while(zm_utility::is_player_valid(self) && self attackbuttonpressed())
	{
		self thread function_6e71e724();
		n_ammo = self getweaponammoclip(weapon);
		if(n_ammo)
		{
			n_ammo--;
			self notify(#"hash_7d855302d88c6701", {#weapon:weapon});
		}
		var_e2ea0440 = self getcurrentweapon();
		if(var_e2ea0440 != weapon)
		{
			break;
		}
		self setweaponammoclip(weapon, n_ammo);
		if(n_ammo < 1)
		{
			if(self weaponcyclingenabled())
			{
				self switchtoweapon();
			}
			self notify(#"hash_609518a5a35564bf");
		}
		wait(1);
	}
}

/*
	Name: function_6e71e724
	Namespace: namespace_23a9b248
	Checksum: 0x6520C681
	Offset: 0x2E90
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function function_6e71e724()
{
	self notify(#"hash_4692cd2b3c8d2de6");
	self endon(#"death", #"hash_4692cd2b3c8d2de6", #"hash_609518a5a35564bf", #"weapon_change");
	while(zm_utility::is_player_valid(self) && self attackbuttonpressed())
	{
		waitframe(1);
	}
	self notify(#"hash_609518a5a35564bf");
}

/*
	Name: function_e56c350e
	Namespace: namespace_23a9b248
	Checksum: 0xFF6D8DD6
	Offset: 0x2F40
	Size: 0x2CE
	Parameters: 3
	Flags: Linked
*/
function function_e56c350e(e_target, var_276d45bf, n_damage)
{
	self endon(#"death");
	e_target endon(#"death");
	if(zm_utility::is_magic_bullet_shield_enabled(e_target))
	{
		return;
	}
	e_target.var_8ac7cc49 = 1;
	e_target.var_61768419 = 1;
	e_target.marked_for_death = 1;
	[[ level.var_ab6fef61 ]]->waitinqueue(e_target);
	w_weapon = level.var_e8ffa40;
	if(isdefined(var_276d45bf))
	{
		e_target clientfield::set("" + #"hash_5a8f1796382ec694", 1);
		e_target.var_4dcd7a1c = 1;
		n_damage = e_target.health + 999;
		w_weapon = level.var_45072d7d;
	}
	else if(e_target.health <= n_damage)
	{
		e_target.marked_for_death = 1;
		e_target clientfield::set("hemera_proj_death", 1);
		e_target thread ai::stun(2);
		wait(1);
		e_target clientfield::set("hemera_proj_death", 0);
		gibserverutils::annihilate(e_target);
		n_damage = e_target.health + 999;
	}
	else
	{
		n_damage = n_damage;
	}
	if(isalive(e_target))
	{
		if(e_target.archetype === #"skeleton")
		{
			e_target dodamage(n_damage, self.origin, self, undefined, "none", "MOD_UNKNOWN", 0, w_weapon);
		}
		else
		{
			e_target dodamage(n_damage, self.origin, self, undefined, "none", "MOD_UNKNOWN", 0, w_weapon);
		}
	}
	e_target.var_61768419 = 0;
	e_target.var_8ac7cc49 = 0;
	wait(0.1);
	if(isdefined(e_target))
	{
		e_target.marked_for_death = 0;
	}
}

/*
	Name: function_3874b38f
	Namespace: namespace_23a9b248
	Checksum: 0xEC54EBEA
	Offset: 0x3218
	Size: 0x2A
	Parameters: 0
	Flags: Linked
*/
function function_3874b38f()
{
	var_72714481 = getaiteamarray("axis");
	return var_72714481;
}

/*
	Name: function_5fc81f0a
	Namespace: namespace_23a9b248
	Checksum: 0x3CB1C409
	Offset: 0x3250
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function function_5fc81f0a(e_target)
{
	if(!isdefined(level.var_7148b584))
	{
		level.var_7148b584 = [];
	}
	else if(!isarray(level.var_7148b584))
	{
		level.var_7148b584 = array(level.var_7148b584);
	}
	if(!isinarray(level.var_7148b584, e_target))
	{
		level.var_7148b584[level.var_7148b584.size] = e_target;
	}
}

/*
	Name: function_6d783edd
	Namespace: namespace_23a9b248
	Checksum: 0xA11032C5
	Offset: 0x3310
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_6d783edd(e_target)
{
	arrayremovevalue(level.var_7148b584, e_target);
}

/*
	Name: function_3ebebb9c
	Namespace: namespace_23a9b248
	Checksum: 0xC2C6B0BC
	Offset: 0x3348
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function function_3ebebb9c()
{
	return level.var_7148b584;
}

/*
	Name: function_25513188
	Namespace: namespace_23a9b248
	Checksum: 0xC7CB7B79
	Offset: 0x3360
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function function_25513188(e_target)
{
	if(!isdefined(level.var_e51fadba))
	{
		level.var_e51fadba = [];
	}
	else if(!isarray(level.var_e51fadba))
	{
		level.var_e51fadba = array(level.var_e51fadba);
	}
	if(!isinarray(level.var_e51fadba, e_target))
	{
		level.var_e51fadba[level.var_e51fadba.size] = e_target;
	}
}

/*
	Name: function_5760b289
	Namespace: namespace_23a9b248
	Checksum: 0xEE4B24CB
	Offset: 0x3420
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_5760b289(e_target)
{
	arrayremovevalue(level.var_e51fadba, e_target);
}

/*
	Name: function_b9a3e6f9
	Namespace: namespace_23a9b248
	Checksum: 0x5348A08E
	Offset: 0x3458
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function function_b9a3e6f9()
{
	return level.var_e51fadba;
}

