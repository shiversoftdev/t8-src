// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1d2e98050575ce0b;
#using script_256b8879317373de;
#using script_2dc48f46bfeac894;
#using script_545a0bac37bda541;
#using script_57f7003580bb15e0;
#using script_68d2ee1489345a1d;
#using script_8988fdbc78d6c53;
#using script_bc839bb0e693558;
#using script_ee56e8b680377b6;
#using scripts\core_common\audio_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\damage.gsc;
#using scripts\core_common\damagefeedback_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\killcam_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;

#namespace shockrifle;

/*
	Name: init_shared
	Namespace: shockrifle
	Checksum: 0xC8820309
	Offset: 0x290
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function init_shared()
{
	clientfield::register("toplayer", "shock_rifle_shocked", 1, 1, "int");
	clientfield::register("toplayer", "shock_rifle_damage", 1, 1, "int");
	clientfield::register("allplayers", "shock_rifle_sound", 1, 1, "int");
	level.var_1b72f911 = getweapon(#"shock_rifle");
	if(isdefined(level.var_1b72f911.var_4dd46f8a))
	{
		level.var_a5ff950 = getscriptbundle(level.var_1b72f911.var_4dd46f8a);
	}
	else
	{
		level.var_a5ff950 = getscriptbundle("shock_rifle_custom_settings");
	}
	weaponobjects::function_e6400478(#"shock_rifle", &function_c1aa8f6b, 0);
	globallogic_score::function_a458dbe1(#"shock_rifle_shock", &function_95a892a);
	callback::on_connecting(&onplayerconnect);
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: on_player_spawned
	Namespace: shockrifle
	Checksum: 0x2C25FADD
	Offset: 0x468
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self clientfield::set_to_player("shock_rifle_damage", 0);
	self clientfield::set("shock_rifle_sound", 0);
}

/*
	Name: onplayerconnect
	Namespace: shockrifle
	Checksum: 0xF28E5533
	Offset: 0x4B8
	Size: 0x26
	Parameters: 0
	Flags: Linked
*/
function onplayerconnect()
{
	self callback::on_player_killed(&onplayerkilled);
}

/*
	Name: onplayerkilled
	Namespace: shockrifle
	Checksum: 0xD78E2DC4
	Offset: 0x4E8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function onplayerkilled()
{
	self function_3474c820();
}

/*
	Name: function_95a892a
	Namespace: shockrifle
	Checksum: 0xC34EDA1E
	Offset: 0x510
	Size: 0x5A
	Parameters: 5
	Flags: Linked
*/
function function_95a892a(attacker, victim, var_3d1ed4bd, attackerweapon, meansofdeath)
{
	if(!isdefined(var_3d1ed4bd) || !isdefined(attackerweapon) || var_3d1ed4bd == attackerweapon)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_c1aa8f6b
	Namespace: shockrifle
	Checksum: 0xF20B2DAE
	Offset: 0x578
	Size: 0x1BE
	Parameters: 1
	Flags: Linked
*/
function function_c1aa8f6b(watcher)
{
	watcher.watchforfire = 1;
	watcher.hackable = 1;
	watcher.hackertoolradius = level.equipmenthackertoolradius;
	watcher.hackertooltimems = level.equipmenthackertooltimems;
	watcher.activatefx = 1;
	watcher.ownergetsassist = 1;
	watcher.ignoredirection = 1;
	watcher.immediatedetonation = 1;
	watcher.detectiongraceperiod = 0;
	watcher.detonateradius = level.var_a5ff950.var_9c0267f2 + 50;
	watcher.onstun = &weaponobjects::weaponstun;
	watcher.stuntime = 1;
	watcher.timeout = level.var_a5ff950.var_3ee2edfa;
	watcher.ondetonatecallback = &function_7ce0a335;
	watcher.activationdelay = 0;
	watcher.activatesound = #"wpn_claymore_alert";
	watcher.immunespecialty = "specialty_immunetriggershock";
	watcher.onspawn = &function_aa6e2f52;
	watcher.ondamage = &function_bcc47944;
	watcher.ontimeout = &function_7ce0a335;
	watcher.onfizzleout = &function_7ce0a335;
}

/*
	Name: function_a0081b68
	Namespace: shockrifle
	Checksum: 0xE4A0C5D0
	Offset: 0x740
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_a0081b68(ent)
{
	self endon(#"death");
	ent waittill(#"death");
	wait(level.var_a5ff950.var_e6dccd20);
	self function_7ce0a335(undefined, undefined, undefined);
}

/*
	Name: function_aa6e2f52
	Namespace: shockrifle
	Checksum: 0xC1B97891
	Offset: 0x7B0
	Size: 0x25A
	Parameters: 2
	Flags: Linked
*/
function function_aa6e2f52(watcher, owner)
{
	self endon(#"death");
	self.protected_entities = [];
	self.var_8d84345 = [];
	self.var_7471e7b7 = 0;
	self setcandamage(0);
	waitresult = undefined;
	waitresult = self waittill(#"grenade_stuck");
	waitframe(2);
	if(!isdefined(waitresult.hitent))
	{
		return;
	}
	if(isdefined(waitresult.hitent.isdog) && waitresult.hitent.isdog)
	{
		watcher.timeout = 0.75;
	}
	else
	{
		watcher.timeout = level.var_a5ff950.var_3ee2edfa;
	}
	self playsound("prj_lightning_impact_human_fatal");
	self thread function_a0081b68(waitresult.hitent);
	if(!isactor(waitresult.hitent))
	{
		self function_92eabc2f(waitresult.hitent, 1);
	}
	playfxontag("weapon/fx8_hero_sig_shockrifle_spike_active", self, "tag_fx");
	wait((isdefined(level.var_a5ff950.var_aded392d) ? level.var_a5ff950.var_aded392d : 0));
	if(isdefined(waitresult.hitent) && isdefined(owner) && util::function_fbce7263(waitresult.hitent.team, owner.team))
	{
		self thread function_5fff8c45(watcher, waitresult.hitent);
	}
	self.owner = owner;
}

/*
	Name: function_7cc07921
	Namespace: shockrifle
	Checksum: 0x9F57478D
	Offset: 0xA18
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function function_7cc07921(ent)
{
	if(distancesquared(self.origin, ent.origin) <= level.var_a5ff950.var_9c0267f2 * level.var_a5ff950.var_9c0267f2)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_a6beb598
	Namespace: shockrifle
	Checksum: 0x97241EB9
	Offset: 0xA80
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_a6beb598(notifystr)
{
	if(!isdefined(self) || !isdefined(self.var_56c34a84))
	{
		return;
	}
	self.var_56c34a84 function_7ce0a335(undefined, undefined, undefined);
}

/*
	Name: function_5fff8c45
	Namespace: shockrifle
	Checksum: 0x3C2A1656
	Offset: 0xAD8
	Size: 0x22C
	Parameters: 2
	Flags: Linked
*/
function function_5fff8c45(watcher, hitent)
{
	self endon(#"death", #"hacked", #"kill_target_detection");
	if(isdefined(hitent))
	{
		hitent endon_callback(&function_a6beb598, #"hash_16c7de1837351e82");
		hitent.var_56c34a84 = self;
	}
	damagearea = weaponobjects::proximityweaponobject_createdamagearea(watcher);
	up = anglestoup(self.angles);
	traceorigin = self.origin + up;
	while(self.var_7471e7b7 < level.var_a5ff950.var_1fb6bd43)
	{
		waitresult = undefined;
		waitresult = damagearea waittill(#"trigger");
		ent = waitresult.activator;
		if(isdefined(self.detonating) && self.detonating)
		{
			return;
		}
		if(!weaponobjects::proximityweaponobject_validtriggerentity(watcher, ent))
		{
			continue;
		}
		if(weaponobjects::proximityweaponobject_isspawnprotected(watcher, ent))
		{
			continue;
		}
		if(!function_7cc07921(ent))
		{
			continue;
		}
		if(function_33020ed7(ent))
		{
			continue;
		}
		if(!isplayer(ent))
		{
			continue;
		}
		if(ent damageconetrace(traceorigin, self) > 0)
		{
			self thread function_92eabc2f(ent, 0);
		}
	}
	function_7ce0a335(undefined, undefined, undefined);
}

/*
	Name: function_33020ed7
	Namespace: shockrifle
	Checksum: 0x9D8E2D53
	Offset: 0xD10
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_33020ed7(ent)
{
	for(i = 0; i < self.var_8d84345.size; i++)
	{
		if(self.var_8d84345[i] == ent)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_c23ed15d
	Namespace: shockrifle
	Checksum: 0x4AB97795
	Offset: 0xD70
	Size: 0x8E
	Parameters: 2
	Flags: Linked
*/
function function_c23ed15d(ent, var_3ee2edfa)
{
	if(isdefined(ent.var_21f48975) && ent.var_21f48975 + var_3ee2edfa + int((isdefined(level.var_a5ff950.var_80cecde8) ? level.var_a5ff950.var_80cecde8 : 0) * 1000) > gettime())
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_a64504d2
	Namespace: shockrifle
	Checksum: 0xB7630109
	Offset: 0xE08
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function function_a64504d2()
{
	var_3ee2edfa = level.var_a5ff950.var_3ee2edfa;
	if(isplayer(self))
	{
		var_341cbc9e = self function_aa61b0b();
		if(var_341cbc9e)
		{
			var_3ee2edfa = var_3ee2edfa * var_341cbc9e;
		}
	}
	return var_3ee2edfa;
}

/*
	Name: deleteobjective
	Namespace: shockrifle
	Checksum: 0xDB26A2F5
	Offset: 0xE80
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function deleteobjective(objectiveid)
{
	objective_delete(objectiveid);
	gameobjects::release_obj_id(objectiveid);
}

/*
	Name: function_13c7b967
	Namespace: shockrifle
	Checksum: 0xFF55D770
	Offset: 0xEC8
	Size: 0x142
	Parameters: 1
	Flags: Linked
*/
function function_13c7b967(owner)
{
	if(isdefined(self.var_c3f76d52))
	{
		return;
	}
	obj_id = gameobjects::get_next_obj_id();
	objective_add(obj_id, "invisible", self.origin, #"hash_6c3f4903a7f04ff5");
	objective_onentity(obj_id, self);
	objective_setvisibletoall(obj_id);
	objective_setteam(obj_id, owner getteam());
	function_da7940a3(obj_id, 1);
	objective_setinvisibletoplayer(obj_id, self);
	function_3ae6fa3(obj_id, owner getteam(), 0);
	objective_setstate(obj_id, "active");
	self.var_c3f76d52 = obj_id;
}

/*
	Name: function_3474c820
	Namespace: shockrifle
	Checksum: 0x21AEE504
	Offset: 0x1018
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function function_3474c820()
{
	if(!isdefined(self.var_c3f76d52))
	{
		return;
	}
	deleteobjective(self.var_c3f76d52);
	self.var_c3f76d52 = undefined;
}

/*
	Name: function_5439aa67
	Namespace: shockrifle
	Checksum: 0x2200A81F
	Offset: 0x1058
	Size: 0xE0
	Parameters: 1
	Flags: Linked
*/
function function_5439aa67(var_197afafd)
{
	self endon(#"death", #"hash_171a421886825497");
	while(isdefined(self))
	{
		if(self isplayerswimming())
		{
			if(isdefined(var_197afafd))
			{
				self dodamage(10000, var_197afafd.origin, var_197afafd.owner, var_197afafd, undefined, "MOD_UNKNOWN", 0, level.var_1b72f911);
			}
			else
			{
				self dodamage(10000, self.origin, undefined, undefined, undefined, "MOD_UNKNOWN", 0, level.var_1b72f911);
			}
			return;
		}
		waitframe(1);
	}
}

/*
	Name: watchfordeath
	Namespace: shockrifle
	Checksum: 0x4C66D592
	Offset: 0x1140
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function watchfordeath()
{
	self waittill(#"death");
	self clientfield::set("shock_rifle_sound", 0);
}

/*
	Name: function_c80bac1f
	Namespace: shockrifle
	Checksum: 0x3FDBEF8B
	Offset: 0x1188
	Size: 0x56E
	Parameters: 3
	Flags: Linked
*/
function function_c80bac1f(var_197afafd, var_51415470, var_3ee2edfa)
{
	self endon(#"death");
	self ability_player::function_fc4dc54(1);
	self.var_21f48975 = gettime();
	owner = var_197afafd.owner;
	damagepos = var_197afafd.origin;
	var_40aed931 = 0;
	if(var_40aed931)
	{
		self function_13c7b967(owner);
	}
	self playsound("wpn_shockrifle_bounce");
	if(isplayer(self))
	{
		self thread function_5439aa67(var_197afafd);
		self freezecontrolsallowlook(1);
	}
	var_fdc63b5e = getweapon(#"hash_740692024876c999");
	var_cb36e12 = getweapon(#"hash_19abd3767bd1566d");
	self giveweapon(var_fdc63b5e);
	self switchtoweaponimmediate(var_fdc63b5e, 1);
	prevstance = self getstance();
	self setstance("crouch");
	self disableweaponcycling();
	firstraisetime = (isdefined(var_fdc63b5e.firstraisetime) ? var_fdc63b5e.firstraisetime : 1);
	wait(firstraisetime);
	self allowcrouch(1);
	self allowprone(0);
	self allowstand(0);
	self giveweapon(var_cb36e12);
	self switchtoweaponimmediate(var_cb36e12, 1);
	if(isplayer(self))
	{
		self freezecontrolsallowlook(0);
		self clientfield::set_to_player("shock_rifle_shocked", 1);
		self clientfield::set("shock_rifle_sound", 1);
	}
	if(isdefined(owner) && util::function_fbce7263(self.team, owner.team))
	{
		if(var_51415470)
		{
			scoreevents::processscoreevent(#"hash_6f0ec202863eacd", owner, self, level.var_1b72f911);
		}
		else
		{
			scoreevents::processscoreevent(#"hash_2c9365f07df9dae6", owner, self, level.var_1b72f911);
		}
	}
	wait(var_3ee2edfa);
	if(isdefined(self))
	{
		self notify(#"hash_16c7de1837351e82");
	}
	self.var_beee9523 = 0;
	self function_3474c820();
	playsoundatposition(#"hash_f2b6a97233cbeb2", self.origin);
	if(isplayer(self))
	{
		self clientfield::set_to_player("shock_rifle_shocked", 0);
		self clientfield::set_to_player("shock_rifle_damage", 0);
		self clientfield::set("shock_rifle_sound", 0);
	}
	self enableweaponcycling();
	self takeweapon(var_cb36e12);
	self takeweapon(var_fdc63b5e);
	self killstreaks::switch_to_last_non_killstreak_weapon(1, 0, 0);
	self waittill(#"weapon_change");
	self setstance(prevstance);
	self allowprone(1);
	self allowstand(1);
	self notify(#"hash_171a421886825497");
}

/*
	Name: function_e0141557
	Namespace: shockrifle
	Checksum: 0x6E9CFB93
	Offset: 0x1700
	Size: 0x1C4
	Parameters: 2
	Flags: Linked
*/
function function_e0141557(ent, var_51415470)
{
	damage = (var_51415470 ? level.var_a5ff950.var_2c5ddff9 : level.var_a5ff950.var_e9661593);
	isplayer = isplayer(ent);
	if(isdefined(ent.var_beee9523) && ent.var_beee9523)
	{
		damage = 10000;
	}
	else if(isdefined(ent.var_dda9b735) && (isdefined(ent.var_dda9b735.isshocked) && ent.var_dda9b735.isshocked))
	{
		damage = 10000;
	}
	else if(isplayer && ent isplayerswimming())
	{
		damage = 10000;
	}
	else if(isplayer || isbot(ent) && (ent isremotecontrolling() || ent.currentweapon.statname == #"recon_car"))
	{
		damage = 10000;
	}
	damagescalar = (isplayer ? ent function_6e30f4a3() : 1);
	return damage * damagescalar;
}

/*
	Name: function_92eabc2f
	Namespace: shockrifle
	Checksum: 0xCE148C89
	Offset: 0x18D0
	Size: 0x404
	Parameters: 2
	Flags: Linked
*/
function function_92eabc2f(ent, var_51415470)
{
	ent endon(#"death");
	self endon(#"death");
	self.var_8d84345[self.var_8d84345.size] = ent;
	self.var_7471e7b7++;
	if(isplayer(ent) && isdefined(ent.var_d44d1214))
	{
		ent gadget_radiation_field::shutdown(1);
	}
	if(!var_51415470)
	{
		var_3e74fd3b = spawn("script_model", self.origin);
		var_3e74fd3b setmodel("tag_origin");
		tag = ent gettagorigin("j_spineupper");
		if(!isdefined(tag))
		{
			tag = ent.origin;
		}
		var_6fad972 = spawn("script_model", tag);
		var_6fad972 setmodel("tag_origin");
		beamlaunch(var_3e74fd3b, var_6fad972, "tag_origin", "tag_origin", level.var_1b72f911);
		level thread function_1c34cd1b(var_3e74fd3b);
		level thread function_1c34cd1b(var_6fad972);
	}
	ent.var_e8bb749a = 1;
	damage = function_e0141557(ent, var_51415470);
	ent dodamage(damage, self.origin, self.owner, self, undefined, "MOD_UNKNOWN", 0, level.var_1b72f911);
	ent.var_beee9523 = 1;
	var_3ee2edfa = ent function_a64504d2();
	params = function_4d1e7b48(#"shock_rifle_shock");
	ent status_effect::status_effect_apply(params, level.var_1b72f911, self.owner, 0, int(var_3ee2edfa + level.var_a5ff950.var_772f6a9c * 1000), undefined, self.origin);
	isplayer = isplayer(ent);
	if(isplayer)
	{
		ent clientfield::set_to_player("shock_rifle_damage", 1);
	}
	if(!function_c23ed15d(ent, var_3ee2edfa) && isplayer)
	{
		if(ent clientfield::get_to_player("vision_pulse_active") == 1)
		{
			ent [[level.var_432cfdb9]](0, 1, ent.var_1ad61d27);
			waitframe(1);
		}
		ent thread function_c80bac1f(self, var_51415470, var_3ee2edfa);
	}
	else
	{
		ent playsound("wpn_shockrifle_bounce");
	}
}

/*
	Name: function_7ce0a335
	Namespace: shockrifle
	Checksum: 0xBE14F82A
	Offset: 0x1CE0
	Size: 0xFC
	Parameters: 3
	Flags: Linked
*/
function function_7ce0a335(attacker, weapon, target)
{
	self endon(#"death");
	if(isdefined(self.detonating) && self.detonating)
	{
		return;
	}
	self.detonating = 1;
	playfx(#"hash_788f36f3ae067065", self.origin);
	self ghost();
	self notsolid();
	self stoploopsound(0.5);
	wait(level.var_a5ff950.var_3ee2edfa + 1);
	self delete();
}

/*
	Name: function_1c34cd1b
	Namespace: shockrifle
	Checksum: 0x36770AE3
	Offset: 0x1DE8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_1c34cd1b(object)
{
	wait(5);
	object delete();
}

/*
	Name: function_bcc47944
	Namespace: shockrifle
	Checksum: 0x16371324
	Offset: 0x1E18
	Size: 0x312
	Parameters: 1
	Flags: Linked
*/
function function_bcc47944(watcher)
{
	self endon(#"death");
	damagemax = 20;
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	self.damagetaken = 0;
	attacker = undefined;
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		attacker = waitresult.attacker;
		weapon = waitresult.weapon;
		damage = waitresult.amount;
		type = waitresult.mod;
		idflags = waitresult.flags;
		if(weapon == level.var_1b72f911)
		{
			continue;
		}
		damage = weapons::function_74bbb3fa(damage, weapon, self.weapon);
		attacker = self [[level.figure_out_attacker]](waitresult.attacker);
		if(!isplayer(attacker))
		{
			continue;
		}
		if(level.teambased)
		{
			if(!level.hardcoremode && !util::function_fbce7263(self.owner.team, attacker.pers[#"team"]) && self.owner != attacker)
			{
				continue;
			}
		}
		if(watcher.stuntime > 0 && weapon.dostun)
		{
			self thread weaponobjects::stunstart(watcher, watcher.stuntime);
		}
		if(damage::friendlyfirecheck(self.owner, attacker))
		{
			if(damagefeedback::dodamagefeedback(weapon, attacker))
			{
				attacker damagefeedback::update();
			}
		}
		if(type == "MOD_MELEE" || weapon.isemp || weapon.destroysequipment)
		{
			self.damagetaken = damagemax;
		}
		else
		{
			self.damagetaken = self.damagetaken + damage;
		}
		if(self.damagetaken >= damagemax)
		{
			watcher thread weaponobjects::waitanddetonate(self, 0.05, attacker, weapon);
			return;
		}
	}
}

