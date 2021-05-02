// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_708634f09dc66b3;
#using script_79a7e1c31a3e8cc;
#using script_8988fdbc78d6c53;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\entityheadicons_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_placeable_mine.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_1f686a53;

/*
	Name: function_89f2df9
	Namespace: namespace_1f686a53
	Checksum: 0xE943CECB
	Offset: 0x180
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"claymore_zm", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_1f686a53
	Checksum: 0xD5731E47
	Offset: 0x1C8
	Size: 0x172
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	weaponobjects::function_e6400478(#"claymore", &createclaymorewatcher, 0);
	weaponobjects::function_e6400478(#"hash_4a5efaceb780ecb0", &createclaymorewatcher, 0);
	deployable::function_2e088f73(getweapon(#"claymore"), &function_4ed6fbd5, undefined, undefined, #"hash_1f65f161716fb57b");
	deployable::function_2e088f73(getweapon(#"hash_4a5efaceb780ecb0"), &function_4ed6fbd5, undefined, undefined, #"hash_1f65f161716fb57b");
	zm::function_84d343d(#"claymore", &function_84072422);
	zm::function_84d343d(#"hash_4a5efaceb780ecb0", &function_84072422);
	level.var_817314af = 0;
}

/*
	Name: function_4ed6fbd5
	Namespace: namespace_1f686a53
	Checksum: 0xAFE484A9
	Offset: 0x348
	Size: 0x3E
	Parameters: 3
	Flags: Linked
*/
function function_4ed6fbd5(v_origin, v_angles, player)
{
	if(!zm_utility::check_point_in_playable_area(v_origin))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_84072422
	Namespace: namespace_1f686a53
	Checksum: 0xD81BB614
	Offset: 0x390
	Size: 0xD2
	Parameters: 12
	Flags: Linked
*/
function function_84072422(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	var_b1c1c5cf = zm_equipment::function_7d948481(0.1, 0.25, 1, 1);
	var_5d7b4163 = zm_equipment::function_379f6b5d(damage, var_b1c1c5cf, 1, 4, 30);
	return var_5d7b4163;
}

/*
	Name: createclaymorewatcher
	Namespace: namespace_1f686a53
	Checksum: 0x3C55D638
	Offset: 0x470
	Size: 0x1B6
	Parameters: 1
	Flags: Linked
*/
function createclaymorewatcher(watcher)
{
	watcher.watchforfire = 1;
	watcher.activatesound = #"wpn_claymore_alert";
	watcher.hackable = 1;
	watcher.hackertoolradius = level.equipmenthackertoolradius;
	watcher.hackertooltimems = level.equipmenthackertooltimems;
	watcher.ownergetsassist = 1;
	watcher.ignoredirection = undefined;
	watcher.immediatedetonation = 1;
	watcher.immunespecialty = "specialty_immunetriggerbetty";
	watcher.deleteonplayerspawn = 0;
	watcher.detectiondot = cos(70);
	watcher.detectionmindist = 10;
	watcher.detectiongraceperiod = 0.3;
	watcher.detonateradius = 100;
	watcher.stuntime = 1;
	watcher.ondetonatecallback = &proximitydetonate;
	watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
	watcher.onspawn = &function_c9893179;
	watcher.stun = &weaponobjects::weaponstun;
	watcher.var_994b472b = &function_aeb91d3;
	watcher.ondamage = &function_cbb2f05b;
}

/*
	Name: proximitydetonate
	Namespace: namespace_1f686a53
	Checksum: 0xFBDB400B
	Offset: 0x630
	Size: 0x4C
	Parameters: 3
	Flags: Linked
*/
function proximitydetonate(attacker, weapon, target)
{
	self thread function_1479a342(attacker, weapon);
	self weaponobjects::weapondetonate(attacker, weapon);
}

/*
	Name: function_1479a342
	Namespace: namespace_1f686a53
	Checksum: 0xC34A28AD
	Offset: 0x688
	Size: 0x214
	Parameters: 2
	Flags: Linked
*/
function function_1479a342(attacker, weapon)
{
	v_origin = self.origin;
	var_62aaf679 = self.weapon;
	function_62e8a3();
	a_enemies = getaiteamarray(level.zombie_team);
	var_8345897c = arraysortclosest(a_enemies, v_origin, undefined, 0, var_62aaf679.explosionradius);
	var_84d440a5 = 0;
	foreach(ai in var_8345897c)
	{
		if(!isalive(ai))
		{
			continue;
		}
		n_dist = distance2d(ai.origin, v_origin);
		n_damage = math::linear_map(n_dist, 0, var_62aaf679.explosionradius, var_62aaf679.explosionouterdamage, var_62aaf679.explosioninnerdamage);
		ai dodamage(int(n_damage), v_origin, attacker, undefined, "none", "MOD_EXPLOSIVE", 0, var_62aaf679);
		var_84d440a5++;
		if(var_84d440a5 > 1)
		{
			waitframe(1);
			var_84d440a5 = 0;
		}
	}
	level.var_817314af--;
}

/*
	Name: function_62e8a3
	Namespace: namespace_1f686a53
	Checksum: 0xE04587AC
	Offset: 0x8A8
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_62e8a3(n_count_per_network_frame = 1)
{
	while(level.var_817314af > n_count_per_network_frame)
	{
		waitframe(1);
	}
	level.var_817314af++;
}

/*
	Name: function_aeb91d3
	Namespace: namespace_1f686a53
	Checksum: 0x6F7F2B88
	Offset: 0x8F8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_aeb91d3(player)
{
	self weaponobjects::weaponobjectfizzleout();
}

/*
	Name: function_c9893179
	Namespace: namespace_1f686a53
	Checksum: 0xCD2908C9
	Offset: 0x928
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function function_c9893179(watcher, player)
{
	proximity_grenade::onspawnproximitygrenadeweaponobject(watcher, player);
}

/*
	Name: play_claymore_effects
	Namespace: namespace_1f686a53
	Checksum: 0x71318D74
	Offset: 0x960
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function play_claymore_effects(e_planter)
{
	self endon(#"death");
	self zm_utility::waittill_not_moving();
}

/*
	Name: claymore_detonation
	Namespace: namespace_1f686a53
	Checksum: 0x9AC09980
	Offset: 0x9A0
	Size: 0x38A
	Parameters: 1
	Flags: None
*/
function claymore_detonation(e_planter)
{
	self endon(#"death");
	self zm_utility::waittill_not_moving();
	detonateradius = 96;
	damagearea = spawn("trigger_radius", self.origin, 512 | 1 + 8, detonateradius, detonateradius * 2);
	damagearea setexcludeteamfortrigger(self.owner.team);
	damagearea enablelinkto();
	damagearea linkto(self);
	if(isdefined(self.isonbus) && self.isonbus)
	{
		damagearea setmovingplatformenabled(1);
	}
	self.damagearea = damagearea;
	self thread delete_mines_on_death(self.owner, damagearea);
	if(!isdefined(self.owner.placeable_mines))
	{
		self.owner.placeable_mines = [];
	}
	else if(!isarray(self.owner.placeable_mines))
	{
		self.owner.placeable_mines = array(self.owner.placeable_mines);
	}
	self.owner.placeable_mines[self.owner.placeable_mines.size] = self;
	while(true)
	{
		waitresult = undefined;
		waitresult = damagearea waittill(#"trigger");
		ent = waitresult.activator;
		if(isdefined(self.owner) && ent == self.owner)
		{
			continue;
		}
		if(isdefined(ent.pers) && isdefined(ent.pers[#"team"]) && ent.pers[#"team"] == self.team)
		{
			continue;
		}
		if(isdefined(ent.ignore_placeable_mine) && ent.ignore_placeable_mine)
		{
			continue;
		}
		if(!ent should_trigger_claymore(self))
		{
			continue;
		}
		if(ent damageconetrace(self.origin, self) > 0)
		{
			self playsound(#"wpn_claymore_alert");
			wait(0.4);
			if(isdefined(self.owner))
			{
				self detonate(self.owner);
			}
			else
			{
				self detonate(undefined);
			}
			return;
		}
	}
}

/*
	Name: should_trigger_claymore
	Namespace: namespace_1f686a53
	Checksum: 0xCA912D8F
	Offset: 0xD38
	Size: 0x118
	Parameters: 1
	Flags: Linked, Private
*/
private function should_trigger_claymore(e_mine)
{
	n_detonation_dot = cos(70);
	pos = self.origin + vectorscale((0, 0, 1), 32);
	dirtopos = pos - e_mine.origin;
	objectforward = anglestoforward(e_mine.angles);
	dist = vectordot(dirtopos, objectforward);
	if(dist < 20)
	{
		return 0;
	}
	dirtopos = vectornormalize(dirtopos);
	dot = vectordot(dirtopos, objectforward);
	return dot > n_detonation_dot;
}

/*
	Name: delete_mines_on_death
	Namespace: namespace_1f686a53
	Checksum: 0x837534EF
	Offset: 0xE58
	Size: 0x74
	Parameters: 2
	Flags: Linked, Private
*/
private function delete_mines_on_death(player, ent)
{
	self waittill(#"death");
	if(isdefined(player))
	{
		arrayremovevalue(player.placeable_mines, self);
	}
	waitframe(1);
	if(isdefined(ent))
	{
		ent delete();
	}
}

/*
	Name: function_cbb2f05b
	Namespace: namespace_1f686a53
	Checksum: 0x14AC1
	Offset: 0xED8
	Size: 0x334
	Parameters: 1
	Flags: Linked
*/
function function_cbb2f05b(watcher)
{
	self endon(#"death", #"hacked", #"detonating");
	self setcandamage(1);
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	self.var_18acfe18 = 0;
	self.var_966835e3 = 150;
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		attacker = waitresult.attacker;
		weapon = waitresult.weapon;
		damage = waitresult.amount;
		type = waitresult.mod;
		idflags = waitresult.flags;
		damage = weapons::function_74bbb3fa(damage, weapon, self.weapon);
		self.var_18acfe18 = self.var_18acfe18 + damage;
		if(!isplayer(attacker) && isdefined(attacker.owner))
		{
			attacker = attacker.owner;
		}
		if(isdefined(weapon))
		{
			self weaponobjects::weapon_object_do_damagefeedback(weapon, attacker);
		}
		if(self.var_18acfe18 >= self.var_966835e3)
		{
			break;
		}
	}
	if(level.weaponobjectexplodethisframe)
	{
		wait(0.1 + randomfloat(0.4));
	}
	else
	{
		waitframe(1);
	}
	level.weaponobjectexplodethisframe = 1;
	self thread weaponobjects::resetweaponobjectexplodethisframe();
	self entityheadicons::setentityheadicon("none");
	if(isdefined(type) && (issubstr(type, "MOD_GRENADE_SPLASH") || issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE")))
	{
		self.waschained = 1;
	}
	if(isdefined(idflags) && idflags & 8)
	{
		self.wasdamagedfrombulletpenetration = 1;
	}
	self.wasdamaged = 1;
	watcher thread weaponobjects::waitanddetonate(self, 0, attacker, weapon);
}

