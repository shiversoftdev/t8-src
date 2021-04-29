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
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
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

#namespace namespace_4834f482;

/*
	Name: function_89f2df9
	Namespace: namespace_4834f482
	Checksum: 0xC61AC578
	Offset: 0x1F8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_75393613dd2d736f", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_4834f482
	Checksum: 0x981DDCD1
	Offset: 0x240
	Size: 0x41E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "" + #"hash_faeb22982ab79dd", 16000, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_90f855c336338af", 16000, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_28495d5e2fe897d2", 16000, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_1fedb98c44ca1523", 16000, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_1e40b07387ffe8dd", 16000, 1, "counter");
	level.var_53789618 = getweapon(#"hash_67c8dea04eccf4ab");
	level.var_161aeda7 = getweapon(#"hash_6538045b64145e74");
	level.var_b784afad = getweapon(#"hash_57feb2fb3f73d361");
	level.var_54ed88ec = getweapon(#"hash_7d9d24e1aef966fc");
	zm_weapons::include_zombie_weapon(#"hash_67c8dea04eccf4ab", 0);
	zm_weapons::include_zombie_weapon(#"hash_6538045b64145e74", 0);
	zm_weapons::include_zombie_weapon(#"hash_57feb2fb3f73d361", 0);
	zm_weapons::include_zombie_weapon(#"hash_7d9d24e1aef966fc", 0);
	namespace_9ff9f642::register_slowdown(#"hash_4689473b7f0df2f7", 0.1, 3);
	namespace_9ff9f642::register_slowdown(#"hash_2b068d1172ea957", 0.3, 3);
	namespace_9ff9f642::register_slowdown(#"hash_315cdbcb170fa2c4", 0.5, 3);
	callback::on_connect(&on_player_connect);
	if(!isdefined(level.var_9295b8ef))
	{
		object = new throttle();
		[[ object ]]->__constructor();
		level.var_9295b8ef = object;
		[[ level.var_9295b8ef ]]->initialize(6, 0.1);
	}
	callback::function_34dea974(level.var_53789618, &function_10b4d6ac);
	callback::function_34dea974(level.var_161aeda7, &function_dd7bc108);
	callback::function_34dea974(level.var_b784afad, &function_10b4d6ac);
	callback::function_34dea974(level.var_54ed88ec, &function_10b4d6ac);
	level.var_4cd68405 = [];
	level.var_ff53a03a = [];
}

/*
	Name: on_player_connect
	Namespace: namespace_4834f482
	Checksum: 0x7FDB616B
	Offset: 0x668
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
	Namespace: namespace_4834f482
	Checksum: 0xB6290C11
	Offset: 0x690
	Size: 0x8A
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
		if(var_385703b7.weapon == level.var_53789618 || var_385703b7.weapon == level.var_54ed88ec)
		{
			level.var_a8472176 = 1;
		}
	}
}

/*
	Name: function_10b4d6ac
	Namespace: namespace_4834f482
	Checksum: 0xE3E91DDB
	Offset: 0x728
	Size: 0x316
	Parameters: 1
	Flags: Linked
*/
function function_10b4d6ac(weapon)
{
	self endon(#"death");
	if(weapon == level.var_54ed88ec)
	{
		n_damage = 8500;
		var_a4c20abe = 1;
	}
	else
	{
		n_damage = 5000;
		var_a4c20abe = 0;
	}
	a_e_targets = function_31ad5b3d(var_a4c20abe);
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
				self thread function_ce711b5c(e_projectile, a_e_targets[i], n_damage);
			}
			else if(i == 1 && isdefined(a_e_targets[i - 1]))
			{
				self thread function_ce711b5c(e_projectile, a_e_targets[i - 1], n_damage);
			}
			else if(i == 2)
			{
				if(isdefined(a_e_targets[i - 1]))
				{
					self thread function_ce711b5c(e_projectile, a_e_targets[i - 1], n_damage);
				}
				else if(isdefined(a_e_targets[i - 2]))
				{
					self thread function_ce711b5c(e_projectile, a_e_targets[i - 2], n_damage);
				}
			}
			else
			{
				self thread function_ce711b5c(e_projectile);
			}
			wait(0.1);
		}
	}
}

/*
	Name: function_31ad5b3d
	Namespace: namespace_4834f482
	Checksum: 0x303D146A
	Offset: 0xA48
	Size: 0x75C
	Parameters: 1
	Flags: Linked
*/
function function_31ad5b3d(var_a4c20abe)
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
		var_4784577e = var_180d380d.size;
		var_f9486bd2 = 0;
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
			if(isdefined(level.var_5b7d4d8d) && level.var_5b7d4d8d)
			{
				var_f9486bd2++;
				if(var_4784577e == 0)
				{
					array::push_front(var_180d380d, e_target);
				}
				continue;
			}
			var_f9486bd2++;
			array::push_front(var_180d380d, e_target);
		}
		if(isdefined(level.var_5b7d4d8d) && level.var_5b7d4d8d && var_4784577e > 0)
		{
			if(var_f9486bd2 == var_99588c0f.size)
			{
				foreach(var_ef7e8e7c in var_99588c0f)
				{
					array::push_front(var_180d380d, var_ef7e8e7c);
				}
			}
			else
			{
				var_f9486bd2 = 0;
			}
		}
		if(isdefined(level.var_f521216c) && level.var_f521216c && var_f9486bd2 > 0)
		{
			level notify(#"hash_1e5cf7b7965152f3", {#e_player:self, #hash_f9486bd2:var_f9486bd2});
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
	Namespace: namespace_4834f482
	Checksum: 0x217741DE
	Offset: 0x11B0
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
	if(isdefined(e_target.var_5a3ebaa3) && e_target.var_5a3ebaa3 || (isdefined(e_target.var_f9b38410) && e_target.var_f9b38410))
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
	Namespace: namespace_4834f482
	Checksum: 0xA558F9DA
	Offset: 0x1470
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_78de2d2e(n_index)
{
	self endon(#"death");
	self.n_index = n_index;
	wait(0.1);
	self clientfield::increment("" + #"hash_90f855c336338af");
}

/*
	Name: function_ce711b5c
	Namespace: namespace_4834f482
	Checksum: 0x1DAE527C
	Offset: 0x14E0
	Size: 0x7FC
	Parameters: 3
	Flags: Linked
*/
function function_ce711b5c(e_projectile, ai_zombie, n_damage)
{
	e_projectile endon(#"death");
	self endon(#"disconnect");
	e_projectile thread function_723b1d66();
	v_end = self function_39e8ed04();
	n_dist = distance(e_projectile.origin, v_end);
	n_time = n_dist / 1500;
	if(n_time <= 0.1)
	{
		n_time = 0.1;
	}
	if(!isdefined(ai_zombie))
	{
		e_projectile moveto(v_end, n_time);
		e_projectile waittill(#"movedone");
		e_projectile clientfield::increment("" + #"hash_28495d5e2fe897d2");
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
			v_right_end = v_right + v_forward * 100;
			v_left = var_2ed6f142 - anglestoright(self.angles) * 50;
			v_left_end = v_left + v_forward * 100;
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
					var_4d8b7233 = var_4d8b7233 + 20;
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
		self thread function_dced5aef(ai_zombie, level.var_b784afad, n_damage, undefined);
	}
	waitframe(1);
	e_projectile delete();
}

/*
	Name: function_30239376
	Namespace: namespace_4834f482
	Checksum: 0x2E6EB8EC
	Offset: 0x1CE8
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
	Namespace: namespace_4834f482
	Checksum: 0x5A5F7207
	Offset: 0x1E18
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
	Name: function_794f3059
	Namespace: namespace_4834f482
	Checksum: 0x28DF9F14
	Offset: 0x1E58
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function function_794f3059(v_end)
{
	v_to_goal = v_end - self.origin;
	v_face_angles = vectortoangles(v_to_goal);
	return v_face_angles;
}

/*
	Name: function_dced5aef
	Namespace: namespace_4834f482
	Checksum: 0xBEE5010E
	Offset: 0x1EB0
	Size: 0x474
	Parameters: 5
	Flags: Linked
*/
function function_dced5aef(e_target, weapon = level.weaponnone, n_damage, var_276d45bf, v_dir)
{
	self endon(#"disconnect");
	e_target endon(#"death");
	if(isactor(e_target) && zm_utility::is_magic_bullet_shield_enabled(e_target))
	{
		return;
	}
	if(isdefined(e_target) && isdefined(e_target.var_6f84b820))
	{
		[[ level.var_9295b8ef ]]->waitinqueue(e_target);
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
				else if(isdefined(e_target.marked_for_death) && e_target.marked_for_death || isdefined(var_276d45bf))
				{
					self thread function_85d88e17(e_target, var_276d45bf, v_dir, n_damage);
				}
				else
				{
					e_target dodamage(n_damage, e_target.origin, self, self, "none", "MOD_UNKNOWN", 0, weapon);
				}
				break;
			}
			case "heavy":
			{
				e_target dodamage(n_damage, self.origin, self, undefined, "none", "MOD_UNKNOWN", 0, weapon);
				e_target.var_61768419 = 0;
				break;
			}
			case "miniboss":
			{
				if(!isdefined(var_276d45bf))
				{
					e_target clientfield::increment("" + #"hash_faeb22982ab79dd");
				}
				n_damage = int(n_damage * 0.3);
				e_target dodamage(n_damage, e_target.origin, self, undefined, "none", "MOD_UNKNOWN", 0, weapon);
				e_target.var_61768419 = 0;
				if(randomint(10) == 0)
				{
					e_target thread ai::stun();
				}
				break;
			}
			case "boss":
			{
				if(!isactor(e_target))
				{
					e_target clientfield::increment("" + #"hash_28495d5e2fe897d2");
				}
				n_damage = 175;
				e_target dodamage(n_damage, self.origin, self, undefined, "none", "MOD_UNKNOWN", 0, weapon);
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
	Name: function_39e8ed04
	Namespace: namespace_4834f482
	Checksum: 0x803C4C63
	Offset: 0x2330
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function function_39e8ed04()
{
	var_2ed6f142 = self getweaponmuzzlepoint();
	v_forward = self getweaponforwarddir();
	v_end = var_2ed6f142 + v_forward * 10000;
	a_trace = bullettrace(var_2ed6f142, v_end, 0, self);
	if(isdefined(level.var_1e60b889))
	{
		level notify(#"hash_7841606423d6fe4c", {#v_position:a_trace[#"position"], #e_entity:a_trace[#"entity"], #player:self});
	}
	return a_trace[#"position"];
}

/*
	Name: function_dd7bc108
	Namespace: namespace_4834f482
	Checksum: 0xF17FDA55
	Offset: 0x2448
	Size: 0x4BA
	Parameters: 1
	Flags: Linked
*/
function function_dd7bc108(weapon)
{
	self endon(#"disconnect", #"weapon_change");
	if(!level.var_a8472176)
	{
		return;
	}
	level.var_a8472176 = 0;
	if(self.currentweapon === level.var_54ed88ec)
	{
		n_damage = 8500;
		var_a4c20abe = 1;
	}
	else
	{
		n_damage = 5000;
		var_a4c20abe = 0;
	}
	n_inc = 100;
	v_org = self.origin;
	if(self.currentweapon === level.var_54ed88ec || self.currentweapon === level.var_53789618)
	{
		n_ammo = self getweaponammoclip(self.currentweapon);
	}
	if(n_ammo >= 2)
	{
		n_ammo = n_ammo - 2;
	}
	else
	{
		return;
	}
	if(self.currentweapon === level.var_54ed88ec || self.currentweapon === level.var_53789618)
	{
		self setweaponammoclip(self.currentweapon, n_ammo);
	}
	self notify(#"hash_1b2c21ba7b18dbf9");
	a_e_targets = function_31ad5b3d(var_a4c20abe);
	level thread function_35f548bc();
	var_d29931f9 = 0;
	for(i = 0; i < 15; i++)
	{
		v_forward = anglestoforward(self.angles) * n_inc;
		v_target = v_org + v_forward;
		while(!isdefined(v_ground))
		{
			v_trace = groundtrace(v_target + vectorscale((0, 0, 1), 200), v_target + vectorscale((0, 0, -1), 2000), 0, self, 1)[#"position"];
			v_trace = v_trace + (randomintrange(-10, 10), randomintrange(-10, 10), 0);
			v_on_navmesh = zm_utility::function_b0eeaada(v_trace);
			if(isdefined(v_on_navmesh))
			{
				v_ground = v_on_navmesh[#"point"];
			}
			waitframe(1);
		}
		mdl_spike = util::spawn_model("p8_fxanim_zm_red_gaia_spikes_mod", v_ground, self.angles + (0, randomintrange(-30, 30), 0), 0);
		if(isdefined(mdl_spike))
		{
			mdl_spike.owner = self;
			mdl_spike thread scene::play("p8_fxanim_zm_red_gaia_spikes_bundle", "rise", mdl_spike);
			mdl_spike thread function_33f9ab00(a_e_targets, self.currentweapon);
		}
		n_inc = n_inc + 50;
		wait(0.1);
		if(isdefined(mdl_spike) && (isdefined(mdl_spike.var_6fe9ec3f) && mdl_spike.var_6fe9ec3f))
		{
			var_d29931f9++;
		}
	}
	self notify(#"hash_4c8edf52fbfca691", {#hash_e0ae28d:var_d29931f9});
	foreach(e_target in a_e_targets)
	{
		if(isdefined(e_target))
		{
			e_target.var_61768419 = 0;
		}
	}
}

/*
	Name: function_35f548bc
	Namespace: namespace_4834f482
	Checksum: 0x3476FB46
	Offset: 0x2910
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function function_35f548bc()
{
	wait(1.8);
	level.var_a8472176 = 1;
}

/*
	Name: function_33f9ab00
	Namespace: namespace_4834f482
	Checksum: 0xA69A998A
	Offset: 0x2938
	Size: 0x284
	Parameters: 2
	Flags: Linked
*/
function function_33f9ab00(a_e_targets, weapon)
{
	self endon(#"death");
	v_pos = self.origin;
	foreach(e_target in a_e_targets)
	{
		if(isalive(e_target) && distancesquared(v_pos, e_target.origin) <= 60 * 60 && (!(isdefined(e_target.var_317b8f00) && e_target.var_317b8f00)) && (!(isdefined(e_target.var_5a3ebaa3) && e_target.var_5a3ebaa3)) && (!(isdefined(e_target.var_339655cf) && e_target.var_339655cf)) && v_pos[2] <= e_target.origin[2])
		{
			if(isdefined(self.owner))
			{
				self.owner thread function_f2f6947f(e_target);
			}
			if(!(isdefined(self.var_6fe9ec3f) && self.var_6fe9ec3f) && (!(isdefined(e_target.var_a447e680) && e_target.var_a447e680)) && (e_target.archetype === #"zombie" || e_target.archetype === #"hash_1bab8a0ba811401e"))
			{
				self.var_6fe9ec3f = 1;
				e_target.var_a447e680 = 1;
				self thread scene::play(#"hash_10b486a0eff3b1cb", e_target);
			}
		}
	}
	wait(1.5);
	self function_bf0a3b0a(v_pos, weapon);
}

/*
	Name: function_bf0a3b0a
	Namespace: namespace_4834f482
	Checksum: 0x601B14BF
	Offset: 0x2BC8
	Size: 0x324
	Parameters: 2
	Flags: Linked
*/
function function_bf0a3b0a(v_pos, weapon)
{
	self endon(#"death");
	if(weapon == level.var_54ed88ec)
	{
		n_dist = 62500;
	}
	else
	{
		n_dist = 40000;
	}
	self thread scene::play("p8_fxanim_zm_red_gaia_spikes_bundle", "explode", self);
	wait(0.1);
	level notify(#"hash_3ac605b3a73cc198", {#v_origin:v_pos});
	a_e_targets = function_3874b38f();
	foreach(e_target in a_e_targets)
	{
		if(isalive(e_target) && (!(isdefined(e_target.var_61768419) && e_target.var_61768419)) && (!(isdefined(e_target.var_5a3ebaa3) && e_target.var_5a3ebaa3)) && (!(isdefined(e_target.var_339655cf) && e_target.var_339655cf)) && distancesquared(self.origin, e_target.origin) <= n_dist && abs(self.origin[2] - e_target.origin[2]) <= 20)
		{
			e_target.var_61768419 = 1;
			if(self function_1d315fcd(e_target))
			{
				v_dir = anglestoright(self.angles) * randomintrange(100, 150) + (0, 0, randomintrange(50, 150));
			}
			else
			{
				v_dir = anglestoright(self.angles) * randomintrange(-150, -100) + (0, 0, randomintrange(50, 150));
			}
			self thread function_5bca6886(e_target, v_dir);
		}
	}
	wait(1.5);
	self delete();
}

/*
	Name: function_1d315fcd
	Namespace: namespace_4834f482
	Checksum: 0x9C5AADDF
	Offset: 0x2EF8
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_1d315fcd(e_target)
{
	n_dot = self math::get_dot_right(e_target.origin);
	if(n_dot > 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_1e39fbc5
	Namespace: namespace_4834f482
	Checksum: 0xBAEEE734
	Offset: 0x2F50
	Size: 0xE8
	Parameters: 0
	Flags: None
*/
function function_1e39fbc5()
{
	self endon(#"death", #"hash_609518a5a35564bf", #"weapon_change");
	while(zm_utility::is_player_valid(self) && self attackbuttonpressed() && !self fragbuttonpressed())
	{
		n_ammo = self getweaponammoclip(level.var_53789618);
		if(n_ammo)
		{
			n_ammo--;
		}
		self setweaponammoclip(level.var_53789618, n_ammo);
		wait(0.5);
	}
}

/*
	Name: function_5bca6886
	Namespace: namespace_4834f482
	Checksum: 0x79596DA9
	Offset: 0x3040
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function function_5bca6886(e_target, v_dir)
{
	self endon(#"death");
	e_target endon(#"death");
	player = self.owner;
	if(isdefined(player))
	{
		if(player.currentweapon == level.var_54ed88ec)
		{
			n_damage = 8500;
		}
		else
		{
			n_damage = 5000;
		}
		player thread function_dced5aef(e_target, level.var_53789618, n_damage, 1, v_dir);
	}
}

/*
	Name: function_85d88e17
	Namespace: namespace_4834f482
	Checksum: 0x77D437AA
	Offset: 0x3108
	Size: 0x252
	Parameters: 4
	Flags: Linked
*/
function function_85d88e17(e_target, var_276d45bf, v_dir, n_damage)
{
	self endon(#"death");
	e_target endon(#"death");
	if(zm_utility::is_magic_bullet_shield_enabled(e_target))
	{
		return;
	}
	e_target.var_61768419 = 1;
	[[ level.var_9295b8ef ]]->waitinqueue(e_target);
	w_weapon = level.var_b784afad;
	if(isdefined(var_276d45bf) && isdefined(v_dir))
	{
		e_target.marked_for_death = 1;
		w_weapon = level.var_53789618;
		e_target zm_utility::function_ffc279(v_dir, self, undefined, w_weapon);
		wait(randomfloatrange(1.5, 2));
		if(isdefined(e_target))
		{
			gibserverutils::annihilate(e_target);
			n_damage = e_target.health + 999;
		}
	}
	if(isalive(e_target))
	{
		e_target clientfield::increment("" + #"hash_faeb22982ab79dd");
		waitframe(1);
		if(n_damage >= e_target.health)
		{
			e_target.marked_for_death = 1;
		}
		if(e_target.archetype === #"skeleton")
		{
			e_target dodamage(n_damage, self.origin, self, undefined, "none", "MOD_UNKNOWN", 0, w_weapon);
		}
		else
		{
			e_target dodamage(n_damage, e_target.origin, self, undefined, "none", "MOD_UNKNOWN", 0, w_weapon);
		}
	}
	e_target.var_61768419 = 0;
}

/*
	Name: function_f2f6947f
	Namespace: namespace_4834f482
	Checksum: 0xE042B549
	Offset: 0x3368
	Size: 0x172
	Parameters: 1
	Flags: Linked
*/
function function_f2f6947f(e_target)
{
	self endon(#"death");
	e_target endon(#"death");
	if(isdefined(e_target.var_317b8f00) && e_target.var_317b8f00)
	{
		return;
	}
	e_target.var_317b8f00 = 1;
	if(!isdefined(e_target.var_6f84b820))
	{
		return;
	}
	switch(e_target.var_6f84b820)
	{
		case "popcorn":
		case "basic":
		case "enhanced":
		{
			e_target thread namespace_9ff9f642::slowdown(#"hash_4689473b7f0df2f7");
			break;
		}
		case "heavy":
		{
			e_target thread namespace_9ff9f642::slowdown(#"hash_2b068d1172ea957");
			break;
		}
		case "miniboss":
		{
			e_target thread namespace_9ff9f642::slowdown(#"hash_315cdbcb170fa2c4");
			break;
		}
	}
	wait(3);
	e_target.var_317b8f00 = 0;
}

/*
	Name: function_3874b38f
	Namespace: namespace_4834f482
	Checksum: 0xB133641C
	Offset: 0x34E8
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
	Namespace: namespace_4834f482
	Checksum: 0x1982001B
	Offset: 0x3520
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function function_5fc81f0a(e_target)
{
	if(!isdefined(level.var_4cd68405))
	{
		level.var_4cd68405 = [];
	}
	else if(!isarray(level.var_4cd68405))
	{
		level.var_4cd68405 = array(level.var_4cd68405);
	}
	if(!isinarray(level.var_4cd68405, e_target))
	{
		level.var_4cd68405[level.var_4cd68405.size] = e_target;
	}
}

/*
	Name: function_6d783edd
	Namespace: namespace_4834f482
	Checksum: 0x38692CBE
	Offset: 0x35E0
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_6d783edd(e_target)
{
	arrayremovevalue(level.var_4cd68405, e_target);
}

/*
	Name: function_3ebebb9c
	Namespace: namespace_4834f482
	Checksum: 0x2BF96529
	Offset: 0x3618
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function function_3ebebb9c()
{
	return level.var_4cd68405;
}

/*
	Name: function_25513188
	Namespace: namespace_4834f482
	Checksum: 0x2A89F2C8
	Offset: 0x3630
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function function_25513188(e_target)
{
	if(!isdefined(level.var_ff53a03a))
	{
		level.var_ff53a03a = [];
	}
	else if(!isarray(level.var_ff53a03a))
	{
		level.var_ff53a03a = array(level.var_ff53a03a);
	}
	if(!isinarray(level.var_ff53a03a, e_target))
	{
		level.var_ff53a03a[level.var_ff53a03a.size] = e_target;
	}
}

/*
	Name: function_5760b289
	Namespace: namespace_4834f482
	Checksum: 0x69E9D00F
	Offset: 0x36F0
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_5760b289(e_target)
{
	arrayremovevalue(level.var_ff53a03a, e_target);
}

/*
	Name: function_b9a3e6f9
	Namespace: namespace_4834f482
	Checksum: 0x4FACF155
	Offset: 0x3728
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function function_b9a3e6f9()
{
	return level.var_ff53a03a;
}

