// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_weapons.gsc;
#using script_24c32478acf44108;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\aat_shared.gsc;

#namespace zm_weap_tricannon;

/*
	Name: __init__system__
	Namespace: zm_weap_tricannon
	Checksum: 0x9985DAA8
	Offset: 0x188
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_weap_tricannon", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_tricannon
	Checksum: 0x65B2AADF
	Offset: 0x1D0
	Size: 0x516
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_ai_damage(&function_79f6f273);
	callback::add_weapon_fired(getweapon(#"ww_tricannon_t8"), &function_68e4ed32);
	callback::add_weapon_fired(getweapon(#"ww_tricannon_t8" + "_upgraded"), &function_68e4ed32);
	callback::add_weapon_fired(getweapon(#"ww_tricannon_earth_t8"), &function_8ef8873e);
	callback::add_weapon_fired(getweapon(#"ww_tricannon_earth_t8" + "_upgraded"), &function_8ef8873e);
	callback::add_weapon_fired(getweapon(#"ww_tricannon_air_t8"), &function_4f2ea5e7);
	callback::add_weapon_fired(getweapon(#"ww_tricannon_air_t8" + "_upgraded"), &function_c8912144);
	callback::add_weapon_fired(getweapon(#"ww_tricannon_fire_t8"), &function_5a24e804);
	callback::add_weapon_fired(getweapon(#"ww_tricannon_fire_t8" + "_upgraded"), &function_5a24e804);
	callback::add_weapon_fired(getweapon(#"ww_tricannon_water_t8"), &function_14d49bd7);
	callback::add_weapon_fired(getweapon(#"ww_tricannon_water_t8" + "_upgraded"), &function_14d49bd7);
	namespace_9ff9f642::register_slowdown(#"hash_7dd6cbed104dd8bd", 0.75, 1);
	namespace_9ff9f642::register_slowdown(#"hash_7eece5e5a5f9cc4d", 0.85, 1);
	namespace_9ff9f642::register_slowdown(#"hash_64aafe3cc04860be", 0.65, 1);
	namespace_9ff9f642::register_slowdown(#"hash_111531769a0bf9e", 0.77, 1);
	namespace_9ff9f642::register_burn(#"hash_6adb03deacc3534", 200, 5);
	namespace_9ff9f642::register_burn(#"hash_474208b088fd5b3d", 400, 5);
	clientfield::register("actor", "water_tricannon_slow_fx", 1, 1, "int");
	clientfield::register("allplayers", "fire_tricannon_muzzle_fx", 1, 1, "counter");
	clientfield::register("allplayers", "water_tricannon_muzzle_fx", 1, 1, "counter");
	level._effect[#"earth_impact"] = #"hash_4587acdb7cd704b6";
	level._effect[#"fire_impact"] = #"hash_65320106e9ad659c";
	level.custom_magic_box_selection_logic = &function_a543db40;
	level.var_ee565b3f = &function_689d923b;
	level.var_bb2323e4 = &function_73a498c8;
}

/*
	Name: function_79f6f273
	Namespace: zm_weap_tricannon
	Checksum: 0x1D0340F4
	Offset: 0x6F0
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_79f6f273(params)
{
	if(params.weapon == getweapon(#"ww_tricannon_earth_t8") || params.weapon == (getweapon(#"ww_tricannon_earth_t8" + "_upgraded")))
	{
		self function_71233d37(params);
	}
	else if(params.weapon == getweapon(#"ww_tricannon_fire_t8") || params.weapon == (getweapon(#"ww_tricannon_fire_t8" + "_upgraded")))
	{
		var_88fd6852 = self function_3e2e539(params);
		if(var_88fd6852)
		{
			self function_aa1a2228(params);
		}
	}
}

/*
	Name: function_a543db40
	Namespace: zm_weap_tricannon
	Checksum: 0x1F3D22CB
	Offset: 0x838
	Size: 0x17E
	Parameters: 2
	Flags: Linked
*/
function function_a543db40(w_weapon, e_player)
{
	if(w_weapon === getweapon(#"ww_tricannon_t8"))
	{
		if(e_player zm_weapons::has_weapon_or_upgrade(getweapon(#"ww_tricannon_t8")))
		{
			return false;
		}
		if(e_player zm_weapons::has_weapon_or_upgrade(getweapon(#"ww_tricannon_air_t8")))
		{
			return false;
		}
		if(e_player zm_weapons::has_weapon_or_upgrade(getweapon(#"ww_tricannon_earth_t8")))
		{
			return false;
		}
		if(e_player zm_weapons::has_weapon_or_upgrade(getweapon(#"ww_tricannon_fire_t8")))
		{
			return false;
		}
		if(e_player zm_weapons::has_weapon_or_upgrade(getweapon(#"ww_tricannon_water_t8")))
		{
			return false;
		}
	}
	return true;
}

/*
	Name: function_68e4ed32
	Namespace: zm_weap_tricannon
	Checksum: 0x50369747
	Offset: 0x9C0
	Size: 0x2A0
	Parameters: 1
	Flags: Linked
*/
function function_68e4ed32(weapon)
{
	self endon(#"disconnect");
	self thread function_321f468b();
	v_start = self getweaponmuzzlepoint();
	var_ee5864e0 = self getweaponforwarddir();
	a_targets = getentitiesinradius(self.origin, 192, 15);
	foreach(ai in a_targets)
	{
		if(!isalive(ai) || (ai.archetype !== #"zombie" && ai.archetype !== #"catalyst") || ai getteam() !== level.zombie_team || ai function_dd070839())
		{
			continue;
		}
		v_ai = ai getcentroid();
		v_normal = vectornormalize(v_ai - v_start);
		dot = vectordot(var_ee5864e0, v_normal);
		if(dot <= 0)
		{
			continue;
		}
		waitframe(1);
		if(isalive(ai))
		{
			var_f1aedaaa = vectornormalize(var_ee5864e0);
			if(0 == ai sightconetrace(v_start, self, var_f1aedaaa, 22.5))
			{
				continue;
			}
			ai zombie_utility::setup_zombie_knockdown(self);
		}
	}
}

/*
	Name: function_321f468b
	Namespace: zm_weap_tricannon
	Checksum: 0x3DA63AD6
	Offset: 0xC68
	Size: 0x1BE
	Parameters: 0
	Flags: Linked
*/
function function_321f468b()
{
	self endon(#"disconnect");
	a_targets = getentitiesinradius(self.origin, 64, 15);
	v_start = self getweaponmuzzlepoint();
	foreach(ai in a_targets)
	{
		if(!isalive(ai) || (ai.archetype !== #"zombie" && ai.archetype !== #"catalyst") || ai getteam() !== level.zombie_team || ai function_dd070839())
		{
			continue;
		}
		if(!sighttracepassed(v_start, ai getcentroid(), 0, self))
		{
			waitframe(1);
			continue;
		}
		if(isdefined(self))
		{
			ai zombie_utility::setup_zombie_knockdown(self);
		}
		waitframe(1);
	}
}

/*
	Name: function_c8912144
	Namespace: zm_weap_tricannon
	Checksum: 0xD536BF0E
	Offset: 0xE30
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_c8912144(weapon)
{
	self thread function_321f468b();
	self function_54d03fdd(weapon, 1);
}

/*
	Name: function_4f2ea5e7
	Namespace: zm_weap_tricannon
	Checksum: 0xF0934ED5
	Offset: 0xE80
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_4f2ea5e7(weapon)
{
	self thread function_321f468b();
	self function_54d03fdd(weapon, 0);
}

/*
	Name: function_54d03fdd
	Namespace: zm_weap_tricannon
	Checksum: 0xA446F815
	Offset: 0xEC8
	Size: 0x588
	Parameters: 2
	Flags: Linked
*/
function function_54d03fdd(weapon, b_packed)
{
	self endon(#"disconnect");
	/#
		if(!isdefined(self.var_b01de37))
		{
			self.var_b01de37 = [];
		}
		else if(!isarray(self.var_b01de37))
		{
			self.var_b01de37 = array(self.var_b01de37);
		}
		self.var_b01de37[weapon] = 4;
	#/
	v_start = self getweaponmuzzlepoint();
	var_ee5864e0 = self getweaponforwarddir();
	var_ae51959e = getentitiesinradius(self.origin, 350);
	var_ae51959e = arraysortclosest(var_ae51959e, self.origin, undefined);
	foreach(ai in var_ae51959e)
	{
		if(!isalive(ai))
		{
			continue;
		}
		if(ai getentitytype() !== 15 && ai getentitytype() !== 12 && ai getentitytype() !== 6)
		{
			continue;
		}
		if(ai.takedamage !== 1 || (ai getteam() !== level.zombie_team && ai getentitytype() !== 6))
		{
			continue;
		}
		var_b7523d07 = ai getcentroid();
		normal = vectornormalize(var_b7523d07 - v_start);
		dot = vectordot(var_ee5864e0, normal);
		if(dot <= 0)
		{
			continue;
		}
		waitframe(1);
		if(!isalive(ai))
		{
			continue;
		}
		var_f1aedaaa = vectornormalize(var_ee5864e0);
		if(0 == ai sightconetrace(v_start, self, var_f1aedaaa, 50))
		{
			continue;
		}
		n_dist_sq = distancesquared(v_start, var_b7523d07);
		n_damage = 5000 * ((122500 - n_dist_sq) / 122500);
		if(n_damage < 3000)
		{
			n_damage = 3000;
		}
		n_launch = 75;
		if(b_packed)
		{
			n_damage = n_damage * 1.75;
			n_launch = n_launch * 1.5;
			n_damage = int(n_damage);
		}
		if(ai getentitytype() === 6)
		{
			ai dodamage(n_damage, v_start, self, self);
			continue;
		}
		if(ai.knockdown === 1)
		{
			var_a6127b01 = 1;
		}
		else
		{
			var_a6127b01 = 0;
		}
		ai dodamage(n_damage, v_start, self, self);
		if(!isalive(ai))
		{
			ai startragdoll(1);
			ai launchragdoll((vectornormalize(var_b7523d07 - self.origin)) * n_launch);
			continue;
		}
		if(var_a6127b01 == 1)
		{
			continue;
		}
		if(n_dist_sq < 122500)
		{
			if(ai.var_6f84b820 === #"heavy" || ai.var_6f84b820 === #"miniboss")
			{
				ai ai::stun();
				continue;
			}
			ai zombie_utility::setup_zombie_knockdown(self);
		}
	}
}

/*
	Name: function_8ef8873e
	Namespace: zm_weap_tricannon
	Checksum: 0x4479FB57
	Offset: 0x1458
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_8ef8873e(weapon)
{
	/#
		if(!isdefined(self.var_b01de37))
		{
			self.var_b01de37 = [];
		}
		else if(!isarray(self.var_b01de37))
		{
			self.var_b01de37 = array(self.var_b01de37);
		}
		self.var_b01de37[weapon] = 2;
	#/
	self function_68e4ed32(weapon);
}

/*
	Name: function_71233d37
	Namespace: zm_weap_tricannon
	Checksum: 0xC65B0BDC
	Offset: 0x14F0
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_71233d37(params)
{
	playfx(level._effect[#"earth_impact"], params.vpoint);
	if(params.idamage >= self.health)
	{
		if(self.archetype == #"zombie")
		{
			self clientfield::set("zombie_gut_explosion", 1);
			waitframe(5);
			if(isdefined(self))
			{
				self delete();
			}
		}
	}
	else
	{
		if(self.var_6f84b820 === #"heavy" || self.var_6f84b820 === #"miniboss")
		{
			self ai::stun();
		}
		else if(self.knockdown !== 1)
		{
			self zombie_utility::setup_zombie_knockdown(params.eattacker);
		}
	}
}

/*
	Name: function_14d49bd7
	Namespace: zm_weap_tricannon
	Checksum: 0x4F1ED64
	Offset: 0x1628
	Size: 0x1D4
	Parameters: 1
	Flags: Linked
*/
function function_14d49bd7(weapon)
{
	/#
		if(!isdefined(self.var_b01de37))
		{
			self.var_b01de37 = [];
		}
		else if(!isarray(self.var_b01de37))
		{
			self.var_b01de37 = array(self.var_b01de37);
		}
		self.var_b01de37[weapon] = 1;
	#/
	self clientfield::increment("water_tricannon_muzzle_fx", 1);
	self function_68e4ed32(weapon);
	v_start = self getweaponmuzzlepoint();
	v_forward = self getweaponforwarddir();
	v_end = v_start + (v_forward * 4000);
	results = undefined;
	results = self waittill(#"projectile_impact");
	v_impact = results.position;
	if(weapon == (getweapon(#"ww_tricannon_water_t8" + "_upgraded")))
	{
		var_bdbde2d2 = #"hash_64aafe3cc04860be";
		n_duration = 5;
	}
	else
	{
		var_bdbde2d2 = #"hash_7dd6cbed104dd8bd";
		n_duration = 4;
	}
	self function_cee7424b(v_impact, var_bdbde2d2, n_duration);
}

/*
	Name: function_2d6e2fb
	Namespace: zm_weap_tricannon
	Checksum: 0x592E19FC
	Offset: 0x1808
	Size: 0x48
	Parameters: 1
	Flags: None
*/
function function_2d6e2fb(e_shot)
{
	while(isdefined(e_shot))
	{
		if(isdefined(e_shot.origin))
		{
			v_impact = e_shot.origin;
		}
		waitframe(1);
	}
	return v_impact;
}

/*
	Name: function_cee7424b
	Namespace: zm_weap_tricannon
	Checksum: 0x41B540B9
	Offset: 0x1858
	Size: 0x1FC
	Parameters: 3
	Flags: Linked
*/
function function_cee7424b(v_impact, var_bdbde2d2, n_duration)
{
	n_time_passed = 0;
	while(n_time_passed <= n_duration)
	{
		var_ae51959e = getaiteamarray(level.zombie_team);
		var_ae51959e = arraysortclosest(var_ae51959e, v_impact, undefined, undefined, 112);
		foreach(ai in var_ae51959e)
		{
			if(ai.var_6f84b820 === #"heavy" || ai.var_6f84b820 === #"miniboss")
			{
				if(var_bdbde2d2 == #"hash_64aafe3cc04860be")
				{
					ai thread namespace_9ff9f642::slowdown(#"hash_111531769a0bf9e");
				}
				else
				{
					ai thread namespace_9ff9f642::slowdown(#"hash_7eece5e5a5f9cc4d");
				}
			}
			else
			{
				ai thread namespace_9ff9f642::slowdown(var_bdbde2d2);
			}
			ai clientfield::set("water_tricannon_slow_fx", 1);
			ai thread function_16149496();
		}
		wait(0.25);
		n_time_passed = n_time_passed + 0.25;
	}
}

/*
	Name: function_16149496
	Namespace: zm_weap_tricannon
	Checksum: 0x57016C64
	Offset: 0x1A60
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_16149496()
{
	self notify("3b62451e9d2a5945");
	self endon("3b62451e9d2a5945");
	self endon(#"death");
	do
	{
		waitframe(1);
	}
	while(isdefined(self.a_n_slowdown_timeouts[#"hash_7dd6cbed104dd8bd"]) || isdefined(self.a_n_slowdown_timeouts[#"hash_64aafe3cc04860be"]) || isdefined(self.a_n_slowdown_timeouts[#"hash_7eece5e5a5f9cc4d"]) || isdefined(self.a_n_slowdown_timeouts[#"hash_f87f19d867f4e2e"]));
	self clientfield::set("water_tricannon_slow_fx", 0);
}

/*
	Name: function_5a24e804
	Namespace: zm_weap_tricannon
	Checksum: 0x5412CF13
	Offset: 0x1B40
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_5a24e804(weapon)
{
	/#
		if(!isdefined(self.var_b01de37))
		{
			self.var_b01de37 = [];
		}
		else if(!isarray(self.var_b01de37))
		{
			self.var_b01de37 = array(self.var_b01de37);
		}
		self.var_b01de37[weapon] = 3;
	#/
	self function_68e4ed32(weapon);
	self clientfield::increment("fire_tricannon_muzzle_fx", 1);
}

/*
	Name: function_3e2e539
	Namespace: zm_weap_tricannon
	Checksum: 0x89000FF4
	Offset: 0x1BF8
	Size: 0x2AC
	Parameters: 1
	Flags: Linked
*/
function function_3e2e539(params)
{
	if(params.smeansofdeath === "MOD_PROJECTILE_SPLASH")
	{
		return true;
	}
	if(params.smeansofdeath !== "MOD_PROJECTILE")
	{
		return false;
	}
	if(isdefined(params.einflictor) && isactor(params.einflictor))
	{
		return false;
	}
	if(isalive(self))
	{
		if(self.health <= params.idamage)
		{
			v_z_offset = (0, 0, randomfloat(0.6));
			v_launch = (vectornormalize(params.vdir) + v_z_offset) * randomintrange(75, 125);
			self startragdoll(1);
			self launchragdoll(v_launch);
			return false;
		}
		if(self.var_6f84b820 === #"heavy" || self.var_6f84b820 === #"miniboss")
		{
			self ai::stun();
			if(isdefined(params.vpoint) && isdefined(params.vdir))
			{
				playfx(level._effect[#"fire_impact"], params.vpoint, params.vdir);
			}
			params.einflictor notify(#"death");
			waitframe(1);
			if(isdefined(params.einflictor) && isdefined(params.eattacker) && isplayer(params.eattacker))
			{
				params.einflictor detonate(params.eattacker);
			}
		}
		else
		{
			self zombie_utility::setup_zombie_knockdown(params.eattacker);
		}
		return true;
	}
	return false;
}

/*
	Name: function_aa1a2228
	Namespace: zm_weap_tricannon
	Checksum: 0xA26FC9D7
	Offset: 0x1EB0
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_aa1a2228(params)
{
	if(!isdefined(self) || self.health <= params.idamage)
	{
		return;
	}
	if(params.weapon === (getweapon(#"ww_tricannon_fire_t8" + "_upgraded")))
	{
		self namespace_9ff9f642::burn(#"hash_474208b088fd5b3d", params.eattacker, params.weapon);
	}
	else
	{
		self namespace_9ff9f642::burn(#"hash_6adb03deacc3534", params.eattacker, params.weapon);
	}
}

/*
	Name: function_689d923b
	Namespace: zm_weap_tricannon
	Checksum: 0x91044EFE
	Offset: 0x1F90
	Size: 0x298
	Parameters: 1
	Flags: Linked
*/
function function_689d923b(weapon)
{
	w_tricannon = getweapon(#"ww_tricannon_t8");
	var_fd8edc1d = getweapon(#"ww_tricannon_t8" + "_upgraded");
	var_1255446b = getweapon(#"ww_tricannon_earth_t8");
	var_2e5cd323 = getweapon(#"ww_tricannon_earth_t8" + "_upgraded");
	var_36fc4957 = getweapon(#"ww_tricannon_air_t8");
	var_5c582d9a = getweapon(#"ww_tricannon_air_t8" + "_upgraded");
	var_2e998842 = getweapon(#"ww_tricannon_fire_t8");
	var_e95ae897 = getweapon(#"ww_tricannon_fire_t8" + "_upgraded");
	var_e62dfd5a = getweapon(#"ww_tricannon_water_t8");
	var_25c5df74 = getweapon(#"ww_tricannon_water_t8" + "_upgraded");
	var_62b4bdef = array(w_tricannon, var_fd8edc1d, var_1255446b, var_2e5cd323, var_36fc4957, var_5c582d9a, var_2e998842, var_e95ae897, var_e62dfd5a, var_25c5df74);
	if(isinarray(var_62b4bdef, weapon))
	{
		foreach(w_tricannon in var_62b4bdef)
		{
			if(self hasweapon(w_tricannon, 1))
			{
				return w_tricannon;
			}
		}
	}
}

/*
	Name: function_73a498c8
	Namespace: zm_weap_tricannon
	Checksum: 0x29D746B
	Offset: 0x2230
	Size: 0x8E8
	Parameters: 2
	Flags: Linked
*/
function function_73a498c8(oldweapondata, newweapondata)
{
	w_tricannon = getweapon(#"ww_tricannon_t8");
	var_fd8edc1d = getweapon(#"ww_tricannon_t8" + "_upgraded");
	var_1255446b = getweapon(#"ww_tricannon_earth_t8");
	var_2e5cd323 = getweapon(#"ww_tricannon_earth_t8" + "_upgraded");
	var_36fc4957 = getweapon(#"ww_tricannon_air_t8");
	var_5c582d9a = getweapon(#"ww_tricannon_air_t8" + "_upgraded");
	var_2e998842 = getweapon(#"ww_tricannon_fire_t8");
	var_e95ae897 = getweapon(#"ww_tricannon_fire_t8" + "_upgraded");
	var_e62dfd5a = getweapon(#"ww_tricannon_water_t8");
	var_25c5df74 = getweapon(#"ww_tricannon_water_t8" + "_upgraded");
	var_62b4bdef = array(w_tricannon, var_fd8edc1d, var_1255446b, var_2e5cd323, var_36fc4957, var_5c582d9a, var_2e998842, var_e95ae897, var_e62dfd5a, var_25c5df74);
	if(isinarray(var_62b4bdef, oldweapondata[#"weapon"]) && isinarray(var_62b4bdef, newweapondata[#"weapon"]))
	{
		weapondata = [];
		if(oldweapondata[#"weapon"] === var_25c5df74 || newweapondata[#"weapon"] === var_25c5df74)
		{
			weapondata[#"weapon"] = var_2e5cd323;
		}
		else
		{
			if(oldweapondata[#"weapon"] === var_5c582d9a || newweapondata[#"weapon"] === var_5c582d9a)
			{
				weapondata[#"weapon"] = var_2e5cd323;
			}
			else
			{
				if(oldweapondata[#"weapon"] === var_e95ae897 || newweapondata[#"weapon"] === var_e95ae897)
				{
					weapondata[#"weapon"] = var_e95ae897;
				}
				else
				{
					if(oldweapondata[#"weapon"] === var_2e5cd323 || newweapondata[#"weapon"] === var_2e5cd323)
					{
						weapondata[#"weapon"] = var_2e5cd323;
					}
					else
					{
						if(oldweapondata[#"weapon"] === var_fd8edc1d || newweapondata[#"weapon"] === var_fd8edc1d)
						{
							weapondata[#"weapon"] = var_fd8edc1d;
						}
						else
						{
							if(oldweapondata[#"weapon"] === var_e62dfd5a || newweapondata[#"weapon"] === var_e62dfd5a)
							{
								weapondata[#"weapon"] = var_2e998842;
							}
							else
							{
								if(oldweapondata[#"weapon"] === var_36fc4957 || newweapondata[#"weapon"] === var_36fc4957)
								{
									weapondata[#"weapon"] = var_1255446b;
								}
								else
								{
									if(oldweapondata[#"weapon"] === var_2e998842 || newweapondata[#"weapon"] === var_2e998842)
									{
										weapondata[#"weapon"] = var_2e998842;
									}
									else
									{
										if(oldweapondata[#"weapon"] === var_1255446b || newweapondata[#"weapon"] === var_1255446b)
										{
											weapondata[#"weapon"] = var_1255446b;
										}
										else
										{
											weapondata[#"weapon"] = w_tricannon;
										}
									}
								}
							}
						}
					}
				}
			}
		}
		weapon = weapondata[#"weapon"];
		weapondata[#"clip"] = newweapondata[#"clip"] + oldweapondata[#"clip"];
		weapondata[#"stock"] = newweapondata[#"stock"] + oldweapondata[#"stock"];
		weapondata[#"fuel"] = newweapondata[#"fuel"] + oldweapondata[#"fuel"];
		weapondata[#"clip"] = int(min(weapondata[#"clip"], weapon.clipsize));
		weapondata[#"stock"] = int(min(weapondata[#"stock"], weapon.maxammo));
		weapondata[#"fuel"] = int(min(weapondata[#"fuel"], weapon.fuellife));
		weapondata[#"heat"] = int(min(newweapondata[#"heat"], oldweapondata[#"heat"]));
		weapondata[#"overheat"] = int(min(newweapondata[#"overheat"], oldweapondata[#"overheat"]));
		weapondata[#"power"] = int(max((isdefined(newweapondata[#"power"]) ? newweapondata[#"power"] : 0), (isdefined(oldweapondata[#"power"]) ? oldweapondata[#"power"] : 0)));
		return weapondata;
	}
}

