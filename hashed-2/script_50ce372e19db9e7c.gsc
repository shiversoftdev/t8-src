// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2c5daa95f8fec03c;
#using script_35598499769dbb3d;
#using script_3819e7a1427df6d2;
#using script_3aa0f32b70d4f7cb;
#using script_3f9e0dc8454d98e1;
#using script_4324053ce5e27661;
#using script_47495939f228e438;
#using script_4d85e8de54b02198;
#using script_522aeb6ae906391e;
#using script_59f07c660e6710a5;
#using script_7b7ed6e4bc963a51;
#using script_7e59d7bba853fe4b;
#using script_caf007e2a98afa2;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_fc2e71d1;

/*
	Name: main
	Namespace: namespace_fc2e71d1
	Checksum: 0x1B7F4A85
	Offset: 0x308
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function main()
{
	registerbehaviorscriptfunctions();
	spawner::add_archetype_spawn_function(#"elephant", &function_4c731a08);
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: namespace_fc2e71d1
	Checksum: 0x4BE8A720
	Offset: 0x358
	Size: 0xA4
	Parameters: 0
	Flags: Linked, Private
*/
private function registerbehaviorscriptfunctions()
{
	animation::add_global_notetrack_handler("arrow_throw", &function_aef0aaa4, 0);
	animation::add_global_notetrack_handler("spear_unhide", &function_882f233, 0);
	animation::add_global_notetrack_handler("spear_hide", &function_e41280fd, 0);
	animation::add_global_notetrack_handler("start_gib", &function_dae74ff5, 0);
}

/*
	Name: function_4c731a08
	Namespace: namespace_fc2e71d1
	Checksum: 0xB22E7F1A
	Offset: 0x408
	Size: 0x19C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_4c731a08()
{
	if(!(isdefined(level.var_c8d8fe54) && level.var_c8d8fe54))
	{
		level thread aat::register_immunity("zm_aat_brain_decay", #"elephant", 1, 0, 0);
		level thread aat::register_immunity("zm_aat_frostbite", #"elephant", 1, 0, 0);
		level thread aat::register_immunity("zm_aat_kill_o_watt", #"elephant", 1, 0, 0);
		level thread aat::register_immunity("zm_aat_plasmatic_burst", #"elephant", 1, 0, 0);
		level.var_c8d8fe54 = 1;
	}
	self.ai.var_502d9d0d = &function_502d9d0d;
	self.var_126d7bef = 1;
	self.b_ignore_cleanup = 1;
	aiutility::addaioverridedamagecallback(self, &function_6b086058);
	self.ai.var_64eb729e = &function_9b64dc73;
	level.var_b394f92f = &function_767db9a1;
	function_deb99302();
}

/*
	Name: function_deb99302
	Namespace: namespace_fc2e71d1
	Checksum: 0x11CD8A05
	Offset: 0x5B0
	Size: 0x6E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_deb99302()
{
	if(isdefined(level.var_a92449fa))
	{
		return;
	}
	level.var_a92449fa = struct::get_array("spear_throw_pos", "targetname");
	level.var_5feff7d0 = &function_848ff0cc;
	level.var_6efc944c = &function_ad0f2b39;
}

/*
	Name: function_767db9a1
	Namespace: namespace_fc2e71d1
	Checksum: 0xECBCF4AE
	Offset: 0x628
	Size: 0x7A
	Parameters: 5
	Flags: Linked, Private
*/
private function function_767db9a1(attacker, weapon, boneindex, hitloc, point)
{
	var_786d7e06 = namespace_e0710ee6::function_422fdfd4(self, attacker, weapon, boneindex, hitloc, point);
	damage_scale = var_786d7e06.damage_scale;
	return damage_scale;
}

/*
	Name: function_ad0f2b39
	Namespace: namespace_fc2e71d1
	Checksum: 0x1FC87A64
	Offset: 0x6B0
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_ad0f2b39(aoe)
{
	if(isdefined(aoe.userdata))
	{
		aoe.userdata.inuse = 0;
	}
}

/*
	Name: function_848ff0cc
	Namespace: namespace_fc2e71d1
	Checksum: 0xC1C7236D
	Offset: 0x6F0
	Size: 0x1A6
	Parameters: 2
	Flags: Linked, Private
*/
private function function_848ff0cc(elephant, rider)
{
	if(isdefined(level.var_a92449fa))
	{
		var_acbadbe9 = [];
		foreach(struct in level.var_a92449fa)
		{
			if(!isdefined(struct.inuse) || !struct.inuse)
			{
				distsq = distancesquared(elephant.origin, struct.origin);
				if(distsq > 200 * 200)
				{
					if(util::within_fov(rider.origin + vectorscale((0, 0, -1), 40), rider.angles, struct.origin, cos(70)))
					{
						array::add(var_acbadbe9, struct);
					}
				}
			}
		}
		if(var_acbadbe9.size)
		{
			struct = array::random(var_acbadbe9);
			struct.inuse = 1;
			return struct;
		}
	}
	return undefined;
}

/*
	Name: function_9b64dc73
	Namespace: namespace_fc2e71d1
	Checksum: 0xF0A40CB8
	Offset: 0x8A0
	Size: 0x9A
	Parameters: 2
	Flags: Linked, Private
*/
private function function_9b64dc73(enemies, entity)
{
	foreach(enemy in enemies)
	{
		enemy zombie_utility::setup_zombie_knockdown(entity);
		enemy.knockdown_type = "knockdown_stun";
	}
}

/*
	Name: function_502d9d0d
	Namespace: namespace_fc2e71d1
	Checksum: 0x2CADA206
	Offset: 0x948
	Size: 0x34
	Parameters: 2
	Flags: Linked, Private
*/
private function function_502d9d0d(entity, projectile)
{
	projectile thread function_d13a21cb(entity, projectile);
}

/*
	Name: function_dae74ff5
	Namespace: namespace_fc2e71d1
	Checksum: 0x80F724D1
	Offset: 0x988
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_dae74ff5()
{
}

/*
	Name: function_e41280fd
	Namespace: namespace_fc2e71d1
	Checksum: 0xFBFD9CF9
	Offset: 0x998
	Size: 0x4E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e41280fd()
{
	if(isdefined(self.var_c8ec4813) && self.var_c8ec4813)
	{
		self detach("p7_shr_weapon_spear_lrg", "tag_weapon_right");
		self.var_c8ec4813 = 0;
	}
}

/*
	Name: function_882f233
	Namespace: namespace_fc2e71d1
	Checksum: 0x2E06B869
	Offset: 0x9F0
	Size: 0x52
	Parameters: 0
	Flags: Linked, Private
*/
private function function_882f233()
{
	if(isdefined(self.var_c8ec4813) && !self.var_c8ec4813)
	{
		self attach("p7_shr_weapon_spear_lrg", "tag_weapon_right");
		self.var_c8ec4813 = 1;
	}
}

/*
	Name: function_aef0aaa4
	Namespace: namespace_fc2e71d1
	Checksum: 0x25DF1028
	Offset: 0xA50
	Size: 0x26E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_aef0aaa4()
{
	/#
		assert(isdefined(self.ai.var_ed782d5));
	#/
	forwarddir = anglestoforward(self.angles);
	var_a137cb9f = self gettagorigin("tag_weapon_right");
	if(isdefined(self.ai.var_c3f91959))
	{
		var_eb549b4f = self.ai.var_c3f91959.origin;
		projectile = magicbullet(self.ai.var_ed782d5, var_a137cb9f, var_eb549b4f, self.ai.elephant);
	}
	else if(isdefined(self.ai.elephant.favoriteenemy))
	{
		var_eb549b4f = self.ai.elephant.favoriteenemy.origin;
		projectile = magicbullet(self.ai.var_ed782d5, var_a137cb9f, var_eb549b4f, self.ai.elephant, self.ai.elephant.favoriteenemy);
	}
	else
	{
		return;
	}
	var_e15d8b1f = 2;
	if(self.ai.elephant.ai.var_112ec817 == #"hash_8e170ae91588f20")
	{
		var_e15d8b1f = 3;
	}
	projectile thread function_7d162bd0(projectile, var_e15d8b1f, self.ai.var_c3f91959);
	projectile thread function_61d12301(projectile);
	projectile thread watch_for_death(projectile);
	if(self.var_c8ec4813)
	{
		self detach("p7_shr_weapon_spear_lrg", "tag_weapon_right");
		self.var_c8ec4813 = 0;
	}
}

/*
	Name: function_7b10e526
	Namespace: namespace_fc2e71d1
	Checksum: 0x7828F1E7
	Offset: 0xCC8
	Size: 0x1AA
	Parameters: 3
	Flags: None
*/
function function_7b10e526(index, multival, target)
{
	normal = vectornormalize(target.origin - self.origin);
	pitch = randomfloatrange(15, 30);
	var_a978e158 = randomfloatrange(-10, 10);
	yaw = -180 + 360 / multival * index + var_a978e158;
	angles = (pitch * -1, yaw, 0);
	dir = anglestoforward(angles);
	c = vectorcross(normal, dir);
	f = vectorcross(c, normal);
	theta = 90 - pitch;
	dir = normal * cos(theta) + f * sin(theta);
	dir = vectornormalize(dir);
	return dir;
}

/*
	Name: function_d13a21cb
	Namespace: namespace_fc2e71d1
	Checksum: 0xF573475B
	Offset: 0xE80
	Size: 0x2C4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_d13a21cb(entity, projectile)
{
	projectile endon(#"death");
	landpos = entity.var_f6ea2286;
	if(!isdefined(landpos))
	{
		landpos = entity.favoriteenemy.origin;
	}
	projectile clientfield::set("towers_boss_head_proj_explosion_fx_cf", 1);
	enemyorigin = landpos;
	physicsexplosionsphere(projectile.origin, 1000, 300, 400);
	/#
		recordsphere(enemyorigin, 15, (0, 0, 0), "");
	#/
	for(i = 0; i < 5; i++)
	{
		var_e2e956c1 = randomintrange(120, 360);
		var_a978e158 = randomfloatrange(-10, 10);
		yaw = -180 + 72 * i + var_a978e158;
		angles = (0, yaw, 0);
		dir = anglestoforward(angles) * var_e2e956c1;
		var_c6b637a5 = landpos + dir;
		/#
			recordsphere(var_c6b637a5, 15, (1, 0.5, 0), "");
		#/
		launchvelocity = vectornormalize(var_c6b637a5 - projectile.origin) * 1400;
		grenade = entity magicmissile(entity.ai.var_a05929e4, projectile.origin, launchvelocity);
		grenade thread function_7d162bd0(grenade);
	}
	projectile clientfield::set("towers_boss_head_proj_fx_cf", 0);
	wait(0.1);
	projectile delete();
}

/*
	Name: function_7d162bd0
	Namespace: namespace_fc2e71d1
	Checksum: 0xE06AD053
	Offset: 0x1150
	Size: 0x33C
	Parameters: 3
	Flags: Linked, Private
*/
private function function_7d162bd0(projectile, var_e15d8b1f, var_c3f91959)
{
	projectile endon(#"hash_2f76a2bbdf38f407");
	result = undefined;
	result = projectile waittill(#"projectile_impact_explode");
	if(!(isdefined(projectile.isdamaged) && projectile.isdamaged))
	{
		if(isdefined(result.position))
		{
			id = 1;
			var_f34f8a95 = "zm_aoe_spear";
			if(isdefined(var_e15d8b1f))
			{
				id = var_e15d8b1f;
				switch(var_e15d8b1f)
				{
					case 2:
					{
						var_f34f8a95 = "zm_aoe_spear_small";
						break;
					}
					case 3:
					{
						var_f34f8a95 = "zm_aoe_spear_big";
						break;
					}
				}
			}
			if(isdefined(function_9cc082d2(result.position, 30)))
			{
				if(isdefined(var_c3f91959))
				{
					aoe = namespace_65dba40e::function_371b4147(id, var_f34f8a95, groundtrace(result.position + vectorscale((0, 0, 1), 8), result.position + vectorscale((0, 0, -1), 100000), 0, projectile)[#"position"], var_c3f91959);
				}
				else
				{
					aoe = namespace_65dba40e::function_371b4147(id, var_f34f8a95, groundtrace(result.position + vectorscale((0, 0, 1), 8), result.position + vectorscale((0, 0, -1), 100000), 0, projectile)[#"position"]);
				}
			}
			var_a5a1f99c = getaiarchetypearray(#"zombie");
			var_a5a1f99c = arraycombine(var_a5a1f99c, getaiarchetypearray(#"hash_1bab8a0ba811401e"), 0, 0);
			var_a5a1f99c = arraycombine(var_a5a1f99c, getaiarchetypearray(#"tiger"), 0, 0);
			var_a5a1f99c = array::filter(var_a5a1f99c, 0, &function_5ae551a6, projectile);
			function_9b64dc73(var_a5a1f99c, projectile);
			physicsexplosionsphere(result.position, 200, 100, 2);
		}
	}
}

/*
	Name: function_5ae551a6
	Namespace: namespace_fc2e71d1
	Checksum: 0x3357D78
	Offset: 0x1498
	Size: 0xA0
	Parameters: 2
	Flags: Linked, Private
*/
private function function_5ae551a6(enemy, projectile)
{
	if(isdefined(enemy.knockdown) && enemy.knockdown)
	{
		return 0;
	}
	if(!isdefined(projectile))
	{
		return 0;
	}
	if(gibserverutils::isgibbed(enemy, 384))
	{
		return 0;
	}
	if(distancesquared(enemy.origin, projectile.origin) > 250 * 250)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_61d12301
	Namespace: namespace_fc2e71d1
	Checksum: 0x6BE63D9C
	Offset: 0x1540
	Size: 0x56
	Parameters: 1
	Flags: Linked, Private
*/
private function function_61d12301(projectile)
{
	projectile endon(#"death");
	result = undefined;
	result = projectile waittill(#"damage");
	projectile.isdamaged = 1;
}

/*
	Name: watch_for_death
	Namespace: namespace_fc2e71d1
	Checksum: 0xF66DDF5F
	Offset: 0x15A0
	Size: 0x38
	Parameters: 1
	Flags: Linked, Private
*/
private function watch_for_death(projectile)
{
	projectile waittill(#"death");
	waittillframeend();
	projectile notify(#"hash_2f76a2bbdf38f407");
}

/*
	Name: function_6b086058
	Namespace: namespace_fc2e71d1
	Checksum: 0xF1CE7708
	Offset: 0x15E0
	Size: 0x528
	Parameters: 12
	Flags: Linked
*/
function function_6b086058(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	if(isdefined(attacker) && attacker.team === self.team)
	{
		return 0;
	}
	if(isdefined(attacker) && !isplayer(attacker))
	{
		return 0;
	}
	self.var_265cb589 = 1;
	var_88cb1bf9 = namespace_d2f65e05::function_498f147(self, point, boneindex);
	if(!isdefined(var_88cb1bf9))
	{
		if(isdefined(dir))
		{
			playfx("maps/zm_towers/fx8_boss_dmg_flesh", point, dir * -1);
		}
		attacker playhitmarker(undefined, 1, undefined, 0);
		var_786d7e06 = namespace_e0710ee6::function_422fdfd4(self, attacker, weapon, boneindex);
		return damage * var_786d7e06.damage_scale;
	}
	if(self.ai.var_112ec817 == #"hash_8e173ae91589439")
	{
		var_dd54fdb1 = namespace_81245006::function_37e3f011(self, "tag_carriage_ws_le");
		if(isdefined(var_dd54fdb1) && namespace_81245006::function_f29756fe(var_dd54fdb1) === 1)
		{
			var_786d7e06 = namespace_e0710ee6::function_422fdfd4(self, attacker, weapon, var_88cb1bf9, undefined, undefined, var_dd54fdb1);
			damage = damage * var_786d7e06.damage_scale;
			namespace_d2f65e05::function_e864f0da(self, damage, attacker, point, dir, var_88cb1bf9);
			return 0;
		}
		attacker playhitmarker(undefined, 1, undefined, 0);
		var_786d7e06 = namespace_e0710ee6::function_422fdfd4(self, attacker, weapon, boneindex);
		return damage * var_786d7e06.damage_scale;
	}
	if(self.ai.var_112ec817 == #"hash_8e170ae91588f20")
	{
		var_dd54fdb1 = namespace_81245006::function_37e3f011(self, "tag_head_ws");
		if(isdefined(var_dd54fdb1) && namespace_81245006::function_f29756fe(var_dd54fdb1) === 1)
		{
			if(attacker hasperk(#"hash_6afc24062d2515a2"))
			{
				damage = damage * 1.1;
				damage = int(damage);
			}
			attacker playhitmarker(undefined, 5, undefined, 1, 0);
			var_786d7e06 = namespace_e0710ee6::function_422fdfd4(self, attacker, weapon, var_88cb1bf9, undefined, undefined, var_dd54fdb1);
			damage = damage * var_786d7e06.damage_scale;
			namespace_81245006::function_ef87b7e8(var_dd54fdb1, damage);
			playfx("maps/zm_towers/fx8_boss_dmg_weakspot_organ", point, dir * -1);
			/#
				iprintlnbold("" + var_dd54fdb1.health);
			#/
			if(namespace_81245006::function_f29756fe(var_dd54fdb1) === 3)
			{
				/#
					iprintlnbold("");
				#/
			}
			return 0;
		}
		attacker playhitmarker(undefined, 1, undefined, 0);
		var_786d7e06 = namespace_e0710ee6::function_422fdfd4(self, attacker, weapon, boneindex);
		return damage * var_786d7e06.damage_scale;
	}
	attacker playhitmarker(undefined, 1, undefined, 0);
	var_786d7e06 = namespace_e0710ee6::function_422fdfd4(self, attacker, weapon, boneindex);
	return damage * var_786d7e06.damage_scale;
}

