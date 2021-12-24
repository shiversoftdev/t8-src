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
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_2928dd4b;

/*
	Name: function_89f2df9
	Namespace: namespace_2928dd4b
	Checksum: 0x28480F08
	Offset: 0x2B0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_7f773699ffe5f857", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_2928dd4b
	Checksum: 0xCC8B78C1
	Offset: 0x2F8
	Size: 0x3F0
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.hero_weapon[#"flamethrower"][0] = getweapon(#"hash_18829d56b3fbd75b");
	level.hero_weapon[#"flamethrower"][1] = getweapon(#"hash_18829e56b3fbd90e");
	level.hero_weapon[#"flamethrower"][2] = getweapon(#"hash_18829f56b3fbdac1");
	zm_loadout::register_hero_weapon_for_level(#"hash_18829d56b3fbd75b");
	zm_loadout::register_hero_weapon_for_level(#"hash_18829e56b3fbd90e");
	zm_loadout::register_hero_weapon_for_level(#"hash_18829f56b3fbdac1");
	clientfield::register("scriptmover", "flamethrower_tornado_fx", 1, 1, "int");
	clientfield::register("toplayer", "hero_flamethrower_vigor_postfx", 1, 1, "counter");
	clientfield::register("toplayer", "flamethrower_wind_blast_flash", -1, 1, "counter");
	clientfield::register("allplayers", "flamethrower_wind_blast_tu16", 16000, 1, "counter");
	clientfield::register("toplayer", "flamethrower_tornado_blast_flash", 1, 1, "counter");
	callback::on_connect(&function_f5430720);
	zm::function_84d343d(#"hash_18829d56b3fbd75b", &function_f63feeb6);
	zm::function_84d343d(#"hash_18829e56b3fbd90e", &function_f63feeb6);
	zm::function_84d343d(#"hash_18829f56b3fbdac1", &function_f63feeb6);
	namespace_9ff9f642::register_slowdown(#"hash_6ff4731de876ab68", 0.6, 1);
	namespace_9ff9f642::register_slowdown(#"hash_6a420a16118789e1", 0.6, 3);
	namespace_9ff9f642::function_9d45c058(#"hash_18829d56b3fbd75b", 16, 6);
	namespace_9ff9f642::function_9d45c058(#"hash_18829e56b3fbd90e", 16, 6);
	namespace_9ff9f642::function_9d45c058(#"hash_18829f56b3fbdac1", 16, 6);
	level.n_zombies_lifted_for_ragdoll = 0;
	if(!isdefined(level.var_f2f67d17))
	{
		object = new throttle();
		[[ object ]]->__constructor();
		level.var_f2f67d17 = object;
		[[ level.var_f2f67d17 ]]->initialize(5, 0.1);
	}
}

/*
	Name: function_b1dc801b
	Namespace: namespace_2928dd4b
	Checksum: 0x5CAAAB28
	Offset: 0x6F0
	Size: 0xD4
	Parameters: 2
	Flags: Linked
*/
function function_b1dc801b(weapon, var_e7c11b0c = 1)
{
	if(!isdefined(weapon))
	{
		return 0;
	}
	if(weapon == level.hero_weapon[#"flamethrower"][2])
	{
		return 1;
	}
	if(weapon == level.hero_weapon[#"flamethrower"][1] && var_e7c11b0c < 3)
	{
		return 1;
	}
	if(weapon == level.hero_weapon[#"flamethrower"][0] && var_e7c11b0c < 2)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_f5430720
	Namespace: namespace_2928dd4b
	Checksum: 0x318B4AED
	Offset: 0x7D0
	Size: 0x340
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f5430720()
{
	self endon(#"disconnect");
	self thread function_82f451d4();
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"weapon_change");
		wpn_cur = waitresult.weapon;
		wpn_prev = waitresult.last_weapon;
		if(isinarray(level.hero_weapon[#"flamethrower"], wpn_cur))
		{
			self clientfield::increment_to_player("hero_flamethrower_vigor_postfx");
			self function_8cbc7c8f(1);
			self thread function_58bc825e(wpn_cur);
			level callback::on_ai_killed(&function_1d6d54c0);
		}
		else if(isinarray(level.hero_weapon[#"flamethrower"], wpn_prev))
		{
			self function_8cbc7c8f(0);
			self notify(#"hash_5d832df3b9639676");
			level callback::remove_on_ai_killed(&function_1d6d54c0);
		}
		if(wpn_cur == level.hero_weapon[#"flamethrower"][0])
		{
			zm_hero_weapon::show_hint(wpn_cur, #"hash_258f60f733c7a181");
		}
		else if(wpn_cur == level.hero_weapon[#"flamethrower"][1])
		{
			zm_hero_weapon::show_hint(wpn_cur, #"hash_4c83bb6fd69bf1ea");
			self thread function_16f31337(wpn_cur);
			self thread function_478a4910(wpn_cur);
		}
		else if(wpn_cur == level.hero_weapon[#"flamethrower"][2])
		{
			if(!self gamepadusedlast())
			{
				self zm_hero_weapon::show_hint(wpn_cur, #"hash_1a1e29920a655055");
			}
			else
			{
				self zm_hero_weapon::show_hint(wpn_cur, #"hash_43cbc37ab728289b");
			}
			self thread function_16f31337(wpn_cur);
			self thread function_29bbc43a(wpn_cur);
			self thread function_68ff89f7(wpn_cur);
		}
	}
}

/*
	Name: function_82f451d4
	Namespace: namespace_2928dd4b
	Checksum: 0x23B842F6
	Offset: 0xB18
	Size: 0x98
	Parameters: 0
	Flags: Linked, Private
*/
private function function_82f451d4()
{
	self endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"hash_3ea6a76d799083d6");
		var_cad4df8e = waitresult.weapon;
		if(function_b1dc801b(var_cad4df8e, 2))
		{
			self clientfield::increment_to_player("hero_flamethrower_vigor_postfx");
		}
	}
}

/*
	Name: function_1d6d54c0
	Namespace: namespace_2928dd4b
	Checksum: 0xCD15F2FF
	Offset: 0xBB8
	Size: 0x11C
	Parameters: 1
	Flags: Linked
*/
function function_1d6d54c0(s_params)
{
	if(isplayer(s_params.eattacker) && function_b1dc801b(s_params.weapon, 1) && (!(isdefined(self.var_d9e7a08a) && self.var_d9e7a08a)) && s_params.smeansofdeath == "MOD_BURNED")
	{
		e_player = s_params.eattacker;
		var_d695a618 = 50 - e_player zm_armor::get(#"hash_5c9caf0397b30f1e");
		if(var_d695a618 >= 5)
		{
			var_20694322 = 5;
		}
		else
		{
			var_20694322 = var_d695a618;
		}
		e_player thread zm_armor::add(#"hash_5c9caf0397b30f1e", var_20694322, 50);
	}
}

/*
	Name: function_f63feeb6
	Namespace: namespace_2928dd4b
	Checksum: 0x31B00BD
	Offset: 0xCE0
	Size: 0x250
	Parameters: 12
	Flags: Linked
*/
function function_f63feeb6(einflictor, eattacker, idamage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isplayer(einflictor) && (!(isdefined(self.var_95468c43) && self.var_95468c43)) && meansofdeath === "MOD_BURNED")
	{
		self thread function_d8ee4d6a(eattacker);
	}
	if(meansofdeath === "MOD_BURNED" && self.health <= idamage && self.var_6f84b820 == #"basic")
	{
		self.var_b364c165 = 1;
	}
	if(isplayer(einflictor) && meansofdeath === "MOD_BURNED" && (!(isdefined(self.is_on_fire) && self.is_on_fire)))
	{
		var_bb6709b6 = zm_equipment::function_379f6b5d(16);
		self namespace_9ff9f642::burn(weapon.name, eattacker, weapon, var_bb6709b6);
	}
	if(isplayer(einflictor) && (!(isdefined(self.var_d9e7a08a) && self.var_d9e7a08a)) && meansofdeath === "MOD_BURNED")
	{
		if(self.var_6f84b820 == #"basic" || self.var_6f84b820 == #"popcorn" || self.var_6f84b820 == #"enhanced")
		{
			return self.health;
		}
	}
	return idamage;
}

/*
	Name: function_d8ee4d6a
	Namespace: namespace_2928dd4b
	Checksum: 0x7EC74241
	Offset: 0xF38
	Size: 0x172
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d8ee4d6a(eattacker)
{
	self endon(#"death");
	self.var_95468c43 = 1;
	if(self.var_6f84b820 == #"miniboss" || self.var_6f84b820 == #"popcorn")
	{
		self thread namespace_9ff9f642::slowdown(#"hash_6ff4731de876ab68");
		wait(1);
	}
	else if(self.var_6f84b820 == #"boss")
	{
		wait(1);
	}
	else if(self.var_6f84b820 == #"basic" || self.var_6f84b820 == #"enhanced")
	{
		if(self zombie_utility::function_33da7a07() !== "walk")
		{
			self thread function_c95fe16();
		}
		while(isdefined(self.is_on_fire) && self.is_on_fire)
		{
			self thread namespace_9ff9f642::slowdown(#"hash_6a420a16118789e1");
			wait(3);
		}
	}
	self.var_95468c43 = undefined;
}

/*
	Name: function_c95fe16
	Namespace: namespace_2928dd4b
	Checksum: 0x89611AB5
	Offset: 0x10B8
	Size: 0x6C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c95fe16()
{
	self endon(#"death");
	self zombie_utility::set_zombie_run_cycle_override_value("walk");
	while(isdefined(self.is_on_fire) && self.is_on_fire)
	{
		wait(0.1);
	}
	self zombie_utility::set_zombie_run_cycle_restore_from_override();
}

/*
	Name: function_d8e7e308
	Namespace: namespace_2928dd4b
	Checksum: 0x44915371
	Offset: 0x1130
	Size: 0xBC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d8e7e308(v_position)
{
	self endon(#"death");
	if(self.var_6f84b820 !== #"basic" || self.var_6f84b820 !== #"enhanced" || (isdefined(self.knockdown) && self.knockdown))
	{
		return;
	}
	[[ level.var_f2f67d17 ]]->waitinqueue(self);
	if(isdefined(self.knockdown) && self.knockdown)
	{
		return;
	}
	self zombie_utility::setup_zombie_knockdown(v_position);
}

/*
	Name: function_58bc825e
	Namespace: namespace_2928dd4b
	Checksum: 0x11E748D4
	Offset: 0x11F8
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function function_58bc825e(var_1c041bd9)
{
	self endon(#"bled_out", #"death", #"hash_5d832df3b9639676");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"weapon_fired");
		if(s_result.weapon == var_1c041bd9)
		{
			self thread function_aa93af91(var_1c041bd9);
		}
	}
}

/*
	Name: function_aa93af91
	Namespace: namespace_2928dd4b
	Checksum: 0x5BDA7505
	Offset: 0x1298
	Size: 0x214
	Parameters: 1
	Flags: Linked, Private
*/
private function function_aa93af91(var_1c041bd9)
{
	a_e_targets = zm_hero_weapon::function_7c3681f7();
	var_560ef51 = [];
	v_start_pos = self geteye();
	var_a993e05e = self getweaponforwarddir();
	a_ai_zombies = util::get_array_of_closest(self.origin, a_e_targets, undefined, undefined, 64);
	foreach(ai_zombie in a_ai_zombies)
	{
		if(isdefined(ai_zombie sightconetrace(v_start_pos, self, var_a993e05e, 29)) && ai_zombie sightconetrace(v_start_pos, self, var_a993e05e, 29))
		{
			if(!isdefined(var_560ef51))
			{
				var_560ef51 = [];
			}
			else if(!isarray(var_560ef51))
			{
				var_560ef51 = array(var_560ef51);
			}
			if(!isinarray(var_560ef51, ai_zombie))
			{
				var_560ef51[var_560ef51.size] = ai_zombie;
			}
		}
	}
	array::thread_all(var_560ef51, &function_e296efef, var_1c041bd9, self);
	array::thread_all(var_560ef51, &function_d8e7e308, self.origin);
}

/*
	Name: function_e296efef
	Namespace: namespace_2928dd4b
	Checksum: 0x9F9CACA3
	Offset: 0x14B8
	Size: 0xA4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_e296efef(var_1c041bd9, e_player)
{
	self endon(#"death");
	[[ level.var_f2f67d17 ]]->waitinqueue(self);
	if(!(isdefined(self.is_on_fire) && self.is_on_fire))
	{
		var_bb6709b6 = zm_equipment::function_379f6b5d(16);
		self namespace_9ff9f642::burn(var_1c041bd9.name, e_player, var_1c041bd9, var_bb6709b6);
	}
}

/*
	Name: function_31a142a2
	Namespace: namespace_2928dd4b
	Checksum: 0x60699759
	Offset: 0x1568
	Size: 0xE2
	Parameters: 1
	Flags: None
*/
function function_31a142a2(var_1c041bd9)
{
	switch(var_1c041bd9.name)
	{
		case "hash_18829e56b3fbd90e":
		{
			var_c4d00e65 = 0.75;
			break;
		}
		case "hash_18829f56b3fbdac1":
		{
			var_c4d00e65 = 1;
			break;
		}
		default:
		{
			var_c4d00e65 = 0.5;
			break;
		}
	}
	if(!isdefined(self.maxhealth))
	{
		self.maxhealth = self.health;
	}
	var_24a53699 = var_c4d00e65 * self.maxhealth;
	return max(var_24a53699, var_1c041bd9.maxdamage);
}

/*
	Name: function_16f31337
	Namespace: namespace_2928dd4b
	Checksum: 0x55920A81
	Offset: 0x1658
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_16f31337(var_1c041bd9)
{
	self endon(#"bled_out", #"death", #"hash_5d832df3b9639676");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"weapon_melee_power_left");
		if(s_result.weapon == var_1c041bd9)
		{
			self clientfield::increment("flamethrower_wind_blast_tu16");
			self thread function_99207e4d(var_1c041bd9);
		}
	}
}

/*
	Name: function_99207e4d
	Namespace: namespace_2928dd4b
	Checksum: 0x32BECB34
	Offset: 0x1718
	Size: 0x3D4
	Parameters: 1
	Flags: Linked
*/
function function_99207e4d(var_1c041bd9)
{
	var_a092956c = [];
	var_560ef51 = [];
	var_2ed6f142 = self getweaponmuzzlepoint();
	var_a993e05e = self getweaponforwarddir();
	self playrumbleonentity("grenade_rumble");
	a_ai_zombies = util::get_array_of_closest(var_2ed6f142, getaispeciesarray(level.zombie_team), undefined, undefined, 614);
	foreach(ai_zombie in a_ai_zombies)
	{
		if(!isdefined(ai_zombie.var_6f84b820))
		{
			/#
				if(isdefined(ai_zombie.targetname))
				{
					iprintlnbold("" + ai_zombie.targetname);
				}
			#/
			continue;
		}
		if(distance(ai_zombie.origin, self.origin) <= 161)
		{
			if(!isdefined(var_a092956c))
			{
				var_a092956c = [];
			}
			else if(!isarray(var_a092956c))
			{
				var_a092956c = array(var_a092956c);
			}
			if(!isinarray(var_a092956c, ai_zombie))
			{
				var_a092956c[var_a092956c.size] = ai_zombie;
			}
			self.var_1374cdc6 = 1;
		}
		if(isdefined(ai_zombie sightconetrace(var_2ed6f142, self, var_a993e05e, 29)) && ai_zombie sightconetrace(var_2ed6f142, self, var_a993e05e, 29))
		{
			if(distance(ai_zombie.origin, self.origin) <= 296)
			{
				if(!isdefined(var_a092956c))
				{
					var_a092956c = [];
				}
				else if(!isarray(var_a092956c))
				{
					var_a092956c = array(var_a092956c);
				}
				if(!isinarray(var_a092956c, ai_zombie))
				{
					var_a092956c[var_a092956c.size] = ai_zombie;
				}
				self.var_1374cdc6 = 1;
				continue;
			}
			if(!isdefined(var_560ef51))
			{
				var_560ef51 = [];
			}
			else if(!isarray(var_560ef51))
			{
				var_560ef51 = array(var_560ef51);
			}
			if(!isinarray(var_560ef51, ai_zombie))
			{
				var_560ef51[var_560ef51.size] = ai_zombie;
			}
		}
	}
	array::thread_all(var_a092956c, &function_ea906434, self, var_1c041bd9);
	array::thread_all(var_560ef51, &function_d8e7e308, self.origin);
}

/*
	Name: function_ea906434
	Namespace: namespace_2928dd4b
	Checksum: 0x722FB7C2
	Offset: 0x1AF8
	Size: 0x5BC
	Parameters: 2
	Flags: Linked
*/
function function_ea906434(e_player, var_1c041bd9)
{
	self endon(#"death");
	/#
		assert(isdefined(self.var_6f84b820), "");
	#/
	if(!isdefined(self.var_6f84b820))
	{
		return;
	}
	if(self.var_6f84b820 == #"miniboss" || self.var_6f84b820 == #"boss")
	{
		self thread function_d8ee4d6a(e_player);
		[[ level.var_f2f67d17 ]]->waitinqueue(self);
		self dodamage(self.maxhealth * 0.18, e_player.origin, e_player, e_player, "torso_lower", "MOD_IMPACT", 0, var_1c041bd9);
	}
	if(self.var_6f84b820 == #"heavy")
	{
		self thread function_d8ee4d6a(e_player);
		[[ level.var_f2f67d17 ]]->waitinqueue(self);
		self dodamage(self.maxhealth * 0.2, e_player.origin, e_player, e_player, "torso_lower", "MOD_IMPACT", 0, var_1c041bd9);
	}
	else if(self.var_6f84b820 == #"basic" || self.var_6f84b820 == #"enhanced")
	{
		[[ level.var_f2f67d17 ]]->waitinqueue(self);
		n_dist = distance2d(self.origin, e_player.origin);
		if(n_dist <= 64)
		{
			if(isdefined(level.no_gib_in_wolf_area) && (isdefined(self [[level.no_gib_in_wolf_area]]()) && self [[level.no_gib_in_wolf_area]]()))
			{
				self.no_gib = 1;
			}
			if(!(isdefined(self.no_gib) && self.no_gib))
			{
				gibserverutils::annihilate(self);
				self playsound(#"zmb_zombie_head_gib");
			}
			self dodamage(self.health + 100, e_player.origin, e_player, e_player, "torso_lower", "MOD_IMPACT", 0, var_1c041bd9);
			return;
		}
		if(math::cointoss())
		{
			if(isdefined(level.no_gib_in_wolf_area) && (isdefined(self [[level.no_gib_in_wolf_area]]()) && self [[level.no_gib_in_wolf_area]]()))
			{
				self.no_gib = 1;
			}
			if(!(isdefined(self.no_gib) && self.no_gib))
			{
				self playsound(#"zmb_zombie_head_gib");
				self zombie_utility::gib_random_parts();
			}
		}
		if(isdefined(level.no_gib_in_wolf_area) && (isdefined(self [[level.no_gib_in_wolf_area]]()) && self [[level.no_gib_in_wolf_area]]()))
		{
			self dodamage(self.health + 100, e_player.origin, e_player, e_player, "torso_lower", "MOD_IMPACT", 0, var_1c041bd9);
			return;
		}
		v_dir = self.origin - e_player.origin;
		var_eb0d0f20 = 75 * vectornormalize(v_dir);
		var_eb0d0f20 = (var_eb0d0f20[0], var_eb0d0f20[1], 20);
		self startragdoll();
		self launchragdoll(var_eb0d0f20);
		self dodamage(self.health + 100, e_player.origin, e_player, e_player, "torso_lower", "MOD_IMPACT", 0, var_1c041bd9);
	}
	else if(self.var_6f84b820 == #"popcorn")
	{
		[[ level.var_f2f67d17 ]]->waitinqueue(self);
		self dodamage(self.health + 100, e_player.origin, e_player, e_player, undefined, "MOD_IMPACT", 0, var_1c041bd9);
	}
}

/*
	Name: function_29bbc43a
	Namespace: namespace_2928dd4b
	Checksum: 0xB80AE1FB
	Offset: 0x20C0
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_29bbc43a(var_1c041bd9)
{
	self endon(#"bled_out", #"death", #"hash_5d832df3b9639676");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"weapon_melee");
		if(s_result.weapon == var_1c041bd9)
		{
			self clientfield::increment_to_player("flamethrower_tornado_blast_flash");
			self function_3be93b07(var_1c041bd9);
		}
	}
}

/*
	Name: function_3be93b07
	Namespace: namespace_2928dd4b
	Checksum: 0x2CC6FAC4
	Offset: 0x2180
	Size: 0x4AC
	Parameters: 1
	Flags: Linked
*/
function function_3be93b07(var_1c041bd9)
{
	self notify(#"hash_2ca901b5ada4f20f");
	self endon(#"bled_out", #"death", #"hash_5d832df3b9639676", #"hash_2ca901b5ada4f20f");
	var_a85d39a2 = [];
	var_2ed6f142 = self getweaponmuzzlepoint();
	var_a993e05e = self getweaponforwarddir();
	var_a812a69b = var_2ed6f142 + (var_a993e05e * 40);
	var_a812a69b = getclosestpointonnavmesh(var_a812a69b, 128, 16);
	if(!isdefined(var_a812a69b))
	{
		var_a812a69b = var_2ed6f142;
	}
	s_trace = groundtrace(var_a812a69b + vectorscale((0, 0, 1), 100), var_a812a69b + (vectorscale((0, 0, -1), 1000)), 0, undefined, 0);
	if(!isdefined(self.var_be72e7c2))
	{
		self.var_be72e7c2 = util::spawn_model("tag_origin");
		util::wait_network_frame();
	}
	self.var_be72e7c2.origin = s_trace[#"position"];
	self.var_be72e7c2.angles = self.angles;
	self.var_be72e7c2.v_start = self.var_be72e7c2.origin;
	if(!isdefined(self.var_be72e7c2.t_damage))
	{
		self.var_be72e7c2.t_damage = spawn("trigger_radius_new", self.var_be72e7c2.origin, 512 | 1, 80, 128);
		self.var_be72e7c2.t_damage enablelinkto();
		self.var_be72e7c2.t_damage linkto(self.var_be72e7c2);
	}
	self thread function_10c91a46();
	if(self.var_be72e7c2 clientfield::get("flamethrower_tornado_fx"))
	{
		self.var_be72e7c2 clientfield::set("flamethrower_tornado_fx", 0);
		util::wait_network_frame();
	}
	self.var_be72e7c2 clientfield::set("flamethrower_tornado_fx", 1);
	a_ai_zombies = util::get_array_of_closest(var_a812a69b, getaispeciesarray(level.zombie_team), undefined, undefined, 400);
	foreach(ai_zombie in a_ai_zombies)
	{
		if(isdefined(ai_zombie sightconetrace(var_2ed6f142, self, var_a993e05e, 29)) && ai_zombie sightconetrace(var_2ed6f142, self, var_a993e05e, 29))
		{
			if(!isdefined(var_a85d39a2))
			{
				var_a85d39a2 = [];
			}
			else if(!isarray(var_a85d39a2))
			{
				var_a85d39a2 = array(var_a85d39a2);
			}
			if(!isinarray(var_a85d39a2, ai_zombie))
			{
				var_a85d39a2[var_a85d39a2.size] = ai_zombie;
			}
		}
	}
	self.var_be72e7c2 thread function_6c891578(var_a993e05e, var_a85d39a2);
	self thread function_95195ac0();
}

/*
	Name: function_95195ac0
	Namespace: namespace_2928dd4b
	Checksum: 0xB04EFA1B
	Offset: 0x2638
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_95195ac0()
{
	self endon(#"hash_2ca901b5ada4f20f");
	if(!isdefined(self.var_be72e7c2))
	{
		return;
	}
	var_be72e7c2 = self.var_be72e7c2;
	var_be72e7c2 endon(#"death");
	self waittill(#"death", #"hash_5d832df3b9639676");
	if(isdefined(self))
	{
		self notify(#"hash_751e0293eed9a1cf");
	}
	var_be72e7c2 clientfield::set("flamethrower_tornado_fx", 0);
	var_be72e7c2 notify(#"hash_751e0293eed9a1cf");
	waitframe(1);
	if(isdefined(var_be72e7c2.t_damage))
	{
		if(isdefined(var_be72e7c2.t_damage))
		{
			var_be72e7c2.t_damage delete();
		}
		var_be72e7c2 delete();
	}
}

/*
	Name: function_6c891578
	Namespace: namespace_2928dd4b
	Checksum: 0xD6CF09A0
	Offset: 0x2768
	Size: 0x732
	Parameters: 2
	Flags: Linked
*/
function function_6c891578(var_a993e05e, var_a85d39a2)
{
	self endon(#"death", #"hash_2ca901b5ada4f20f");
	var_2ddb51af = self.v_start + vectorscale((0, 0, 1), 16);
	var_d825e9dd = 1;
	v_start_pos = self.v_start + vectorscale((0, 0, 1), 16);
	while(true)
	{
		if(isdefined(var_d825e9dd) && var_d825e9dd)
		{
			var_d825e9dd = undefined;
			var_94a175c3 = 200;
			if(var_a85d39a2.size)
			{
				ai_zombie = array::random(var_a85d39a2);
				v_target_pos = ai_zombie.origin;
				arrayremovevalue(var_a85d39a2, ai_zombie);
			}
			else if(isdefined(bullettracepassed(var_2ddb51af, var_2ddb51af + (var_a993e05e * var_94a175c3), 0, self)) && bullettracepassed(var_2ddb51af, var_2ddb51af + (var_a993e05e * var_94a175c3), 0, self))
			{
				v_target_pos = var_2ddb51af + (var_a993e05e * var_94a175c3);
			}
			else
			{
				v_target_pos = bullettrace(var_2ddb51af, var_2ddb51af + (var_a993e05e * var_94a175c3), 0, self)[#"position"];
			}
		}
		else if(var_a85d39a2.size)
		{
			ai_zombie = array::random(var_a85d39a2);
			v_target_pos = ai_zombie.origin;
			arrayremovevalue(var_a85d39a2, ai_zombie);
		}
		else
		{
			v_target_pos = self function_5adaf171(var_2ddb51af);
		}
		var_6fba13f1 = getclosestpointonnavmesh(v_target_pos, 512, 16);
		if(isdefined(var_6fba13f1))
		{
			v_target_pos = var_6fba13f1;
		}
		var_6fba13f1 = groundtrace(v_target_pos + vectorscale((0, 0, 1), 100), v_target_pos + (vectorscale((0, 0, -1), 1000)), 0, undefined, 0)[#"position"];
		if(isdefined(var_6fba13f1))
		{
			v_target_pos = var_6fba13f1;
		}
		n_dist = distance(v_start_pos, v_target_pos);
		n_time = n_dist / 100;
		if(n_time <= 0)
		{
			n_time = 0.5;
		}
		self moveto(v_target_pos, n_time);
		if(isdefined(ai_zombie))
		{
			level util::waittill_any_ents(self, "movedone", ai_zombie, "death");
			ai_zombie = undefined;
		}
		else
		{
			self waittill(#"movedone");
		}
		v_start_pos = self.origin + vectorscale((0, 0, 1), 16);
		if(var_a85d39a2.size)
		{
			foreach(ai in var_a85d39a2)
			{
				if(isvehicle(ai) && (!(isdefined(bullettracepassed(v_start_pos, ai.origin, 0, self)) && bullettracepassed(v_start_pos, ai.origin, 0, self))))
				{
					arrayremovevalue(var_a85d39a2, ai, 1);
					continue;
				}
				if(issentient(ai) && isalive(ai) && (!(isdefined(bullettracepassed(v_start_pos, ai geteye(), 0, self)) && bullettracepassed(v_start_pos, ai geteye(), 0, self))))
				{
					arrayremovevalue(var_a85d39a2, ai, 1);
				}
			}
			var_a85d39a2 = array::remove_undefined(var_a85d39a2);
		}
		if(!var_a85d39a2.size)
		{
			var_a85d39a2 = util::get_array_of_closest(self.v_start, getaiteamarray(level.zombie_team), undefined, undefined, 400);
			foreach(ai in var_a85d39a2)
			{
				if(isvehicle(ai) && (!(isdefined(bullettracepassed(v_start_pos, ai.origin, 0, self)) && bullettracepassed(v_start_pos, ai.origin, 0, self))))
				{
					arrayremovevalue(var_a85d39a2, ai, 1);
					continue;
				}
				if(!(isdefined(bullettracepassed(v_start_pos, ai geteye(), 0, self)) && bullettracepassed(v_start_pos, ai geteye(), 0, self)))
				{
					arrayremovevalue(var_a85d39a2, ai, 1);
				}
			}
			var_a85d39a2 = array::remove_undefined(var_a85d39a2);
		}
	}
}

/*
	Name: function_5adaf171
	Namespace: namespace_2928dd4b
	Checksum: 0x88BD90D3
	Offset: 0x2EA8
	Size: 0x1AC
	Parameters: 1
	Flags: Linked
*/
function function_5adaf171(var_2ddb51af)
{
	self endon(#"death");
	for(var_dc9e1b43 = 0; var_dc9e1b43 < 4; var_dc9e1b43++)
	{
		v_target_pos = (var_2ddb51af[0] + randomfloat(400), var_2ddb51af[1] + randomfloat(400), var_2ddb51af[2]);
		s_trace = bullettrace(self.origin + vectorscale((0, 0, 1), 16), v_target_pos, 0, self);
		if(isdefined(s_trace[#"position"]))
		{
			if(sighttracepassed(s_trace[#"position"], v_target_pos, 0, self))
			{
				return s_trace[#"position"];
			}
			continue;
		}
		if(bullettracepassed(self.origin + vectorscale((0, 0, 1), 16), v_target_pos, 0, self) && sighttracepassed(self.origin + vectorscale((0, 0, 1), 16), v_target_pos, 0, self))
		{
			return v_target_pos;
		}
	}
	return var_2ddb51af;
}

/*
	Name: function_10c91a46
	Namespace: namespace_2928dd4b
	Checksum: 0xC9F2B98C
	Offset: 0x3060
	Size: 0x16E
	Parameters: 0
	Flags: Linked
*/
function function_10c91a46()
{
	self endon(#"disconnect", #"hash_2ca901b5ada4f20f");
	self.var_be72e7c2 endon(#"death");
	self.var_be72e7c2.t_damage endon(#"death");
	while(true)
	{
		s_result = undefined;
		s_result = self.var_be72e7c2.t_damage waittill(#"trigger");
		if(isdefined(s_result.activator.var_d9e7a08a) && s_result.activator.var_d9e7a08a)
		{
			continue;
		}
		if(isinarray(getaiteamarray(level.zombie_team), s_result.activator))
		{
			s_result.activator thread function_72601dd2(self, self.var_be72e7c2, 128, randomintrange(128, 200), randomintrange(150, 200));
		}
		waitframe(1);
	}
}

/*
	Name: function_103fae4e
	Namespace: namespace_2928dd4b
	Checksum: 0xAFB6203D
	Offset: 0x31D8
	Size: 0xA6
	Parameters: 1
	Flags: None
*/
function function_103fae4e(t_damage)
{
	self endon(#"disconnect");
	self.var_d9e7a08a = 1;
	self clientfield::set("burn", 1);
	while(isdefined(t_damage) && self istouching(t_damage))
	{
		waitframe(1);
	}
	self clientfield::set("burn", 0);
	self.var_d9e7a08a = undefined;
}

/*
	Name: function_72601dd2
	Namespace: namespace_2928dd4b
	Checksum: 0x9417D7D0
	Offset: 0x3288
	Size: 0x914
	Parameters: 5
	Flags: Linked, Private
*/
private function function_72601dd2(e_player, var_ab287846, n_push_away, n_lift_height, n_lift_speed)
{
	var_1c041bd9 = e_player.var_fd05e363;
	self.var_d9e7a08a = 1;
	v_origin = var_ab287846.origin;
	if(self.var_6f84b820 == #"popcorn")
	{
		self.no_powerups = 1;
		self dodamage(self.health + 100, v_origin, e_player, e_player, undefined, "MOD_BURNED", 0, var_1c041bd9);
	}
	else if(self.var_6f84b820 == #"miniboss" || self.var_6f84b820 == #"boss" || self.var_6f84b820 == #"heavy")
	{
		self endon(#"death");
		[[ level.var_f2f67d17 ]]->waitinqueue(self);
		if(var_ab287846 function_58942bba(self) && self.var_6f84b820 == #"miniboss")
		{
			var_ab287846 thread scene::init(#"p8_zm_flame_tornado_miniboss_scene", self);
			self dodamage(self.maxhealth * 0.18, v_origin, e_player, e_player, "none", "MOD_BURNED", 0, var_1c041bd9);
			self.var_42d5176d = 1;
			self val::set(#"hash_77bfbbee3d2c15d", "ignoreall", 1);
			v_pos = groundtrace(self.origin + vectorscale((0, 0, 1), 100), self.origin + (vectorscale((0, 0, -1), 1000)), 0, self)[#"position"];
			if(!isdefined(v_pos))
			{
				v_pos = self.origin;
			}
			self.var_68f4c9de = util::spawn_model("tag_origin", v_pos, self.angles);
			self.var_68f4c9de thread scene::init(#"p8_zm_flame_tornado_miniboss_scene", self);
			self thread function_e6f0a2c7(var_ab287846);
			var_ab287846 waittill(#"death", #"hash_751e0293eed9a1cf", #"hash_124840b260697eb9");
			if(isdefined(self) && isdefined(self.var_68f4c9de))
			{
				self.var_68f4c9de scene::play(#"p8_zm_flame_tornado_miniboss_scene", self);
			}
			if(isdefined(self) && isdefined(self.var_68f4c9de))
			{
				self.var_42d5176d = undefined;
				self val::reset(#"hash_77bfbbee3d2c15d", "ignoreall");
				self.var_d9e7a08a = undefined;
				self.var_68f4c9de delete();
			}
		}
		else if(self.var_6f84b820 == #"heavy")
		{
			self zombie_utility::setup_zombie_knockdown(e_player);
			self dodamage(self.maxhealth * 0.2, v_origin, e_player, e_player, "none", "MOD_BURNED", 0, var_1c041bd9);
			wait(1);
			self.var_d9e7a08a = undefined;
		}
		else
		{
			self thread function_d8ee4d6a(e_player);
			self dodamage(self.maxhealth * 0.16, v_origin, e_player, e_player, "none", "MOD_BURNED", 0, var_1c041bd9);
			wait(1);
			self.var_d9e7a08a = undefined;
		}
	}
	else
	{
		self endon(#"death");
		[[ level.var_f2f67d17 ]]->waitinqueue(self);
		if(level.n_zombies_lifted_for_ragdoll < 9)
		{
			self thread track_lifted_for_ragdoll_count();
			self setplayercollision(0);
			self zm_spawner::zombie_flame_damage("MOD_BURNED", e_player);
			if(isdefined(var_ab287846) && var_ab287846 function_58942bba(self))
			{
				var_ab287846 thread scene::play(#"hash_12dad71980d51ac8", self);
				var_ab287846 thread function_943cd1e3(e_player, self);
				var_c74251a4 = scene::function_8582657c(#"hash_12dad71980d51ac8", "Shot 1");
				n_time = randomfloatrange(2, var_c74251a4);
				e_player waittill_timeout(n_time, #"hash_20d02a4b6d08596d", #"hash_2ca901b5ada4f20f", #"hash_751e0293eed9a1cf");
				if(!isdefined(self))
				{
					return;
				}
				self thread scene::stop(#"hash_12dad71980d51ac8");
			}
			if(isdefined(level.no_gib_in_wolf_area) && (isdefined(self [[level.no_gib_in_wolf_area]]()) && self [[level.no_gib_in_wolf_area]]()))
			{
				self dodamage(self.health + 100, v_origin, e_player, e_player, "torso_lower", "MOD_BURNED", 0, var_1c041bd9);
				return;
			}
			self playsound(#"zmb_zombie_head_gib");
			self zombie_utility::gib_random_parts();
			v_away_from_source = vectornormalize(self.origin - v_origin);
			v_away_from_source = v_away_from_source * n_push_away;
			v_away_from_source = (v_away_from_source[0], v_away_from_source[1], n_lift_height);
			if(!(isdefined(level.ignore_gravityspikes_ragdoll) && level.ignore_gravityspikes_ragdoll))
			{
				self startragdoll();
				self launchragdoll((100 * anglestoup(self.angles)) + (v_away_from_source[0], v_away_from_source[1], 0));
			}
			self clientfield::set("ragdoll_impact_watch", 1);
		}
		else if(isdefined(level.no_gib_in_wolf_area) && (isdefined(self [[level.no_gib_in_wolf_area]]()) && self [[level.no_gib_in_wolf_area]]()))
		{
			self.no_gib = 1;
		}
		if(!(isdefined(self.no_gib) && self.no_gib))
		{
			gibserverutils::annihilate(self);
			self playsound(#"zmb_zombie_head_gib");
		}
		self dodamage(self.health + 100, v_origin, e_player, e_player, "torso_lower", "MOD_BURNED", 0, var_1c041bd9);
	}
}

/*
	Name: function_e6f0a2c7
	Namespace: namespace_2928dd4b
	Checksum: 0x3379D436
	Offset: 0x3BA8
	Size: 0xC0
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e6f0a2c7(var_ab287846)
{
	if(!isdefined(var_ab287846) || !isdefined(var_ab287846.t_damage))
	{
		return;
	}
	var_ab287846 endon(#"death", #"hash_751e0293eed9a1cf");
	var_ab287846.t_damage endon(#"death");
	while(isdefined(self) && self istouching(var_ab287846.t_damage))
	{
		waitframe(1);
	}
	var_ab287846 notify(#"hash_124840b260697eb9");
}

/*
	Name: track_lifted_for_ragdoll_count
	Namespace: namespace_2928dd4b
	Checksum: 0xBA8B2741
	Offset: 0x3C70
	Size: 0x30
	Parameters: 0
	Flags: Linked, Private
*/
private function track_lifted_for_ragdoll_count()
{
	level.n_zombies_lifted_for_ragdoll++;
	self waittill(#"death");
	level.n_zombies_lifted_for_ragdoll--;
}

/*
	Name: function_943cd1e3
	Namespace: namespace_2928dd4b
	Checksum: 0x8FF1C6EB
	Offset: 0x3CA8
	Size: 0x70
	Parameters: 2
	Flags: Linked, Private
*/
private function function_943cd1e3(e_player, ai_zombie)
{
	while(isdefined(self) && isalive(ai_zombie))
	{
		if(!self function_58942bba(ai_zombie))
		{
			e_player notify(#"hash_20d02a4b6d08596d");
			return;
		}
		wait(0.5);
	}
}

/*
	Name: function_58942bba
	Namespace: namespace_2928dd4b
	Checksum: 0x91DE795D
	Offset: 0x3D20
	Size: 0x1A6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_58942bba(e_ignore)
{
	if(!isdefined(self))
	{
		return 0;
	}
	v_start_pos = self.origin + vectorscale((0, 0, 1), 16);
	if(!bullettracepassed(self.origin + vectorscale((0, 0, 1), 5), self.origin + (0, 0, 128), 0, e_ignore))
	{
		return 0;
	}
	if(!bullettracepassed(v_start_pos, v_start_pos + (anglestoforward(self.angles) * 50), 0, e_ignore))
	{
		return 0;
	}
	if(!bullettracepassed(v_start_pos, v_start_pos + (anglestoforward(self.angles) * (50 * -1)), 0, e_ignore))
	{
		return 0;
	}
	if(!bullettracepassed(v_start_pos, v_start_pos + (anglestoright(self.angles) * 50), 0, e_ignore))
	{
		return 0;
	}
	if(!bullettracepassed(v_start_pos, v_start_pos + (anglestoright(self.angles) * (50 * -1)), 0, e_ignore))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_8cbc7c8f
	Namespace: namespace_2928dd4b
	Checksum: 0x9B9A1B8C
	Offset: 0x3ED0
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function function_8cbc7c8f(var_2fb75486)
{
	self.var_2fb75486 = var_2fb75486;
}

/*
	Name: function_478a4910
	Namespace: namespace_2928dd4b
	Checksum: 0x79A1E061
	Offset: 0x3EF8
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_478a4910(var_1c041bd9)
{
	self endon(#"bled_out", #"death", #"hash_5d832df3b9639676");
	s_result = undefined;
	s_result = self waittill(#"weapon_melee_power_left");
	if(s_result.weapon == var_1c041bd9)
	{
		self thread zm_audio::create_and_play_dialog(#"hash_6a87ca13e3ecd52d", #"flamethrower");
	}
}

/*
	Name: function_68ff89f7
	Namespace: namespace_2928dd4b
	Checksum: 0x9FE90F64
	Offset: 0x3FB0
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_68ff89f7(var_1c041bd9)
{
	self endon(#"bled_out", #"death", #"hash_5d832df3b9639676");
	s_result = undefined;
	s_result = self waittill(#"weapon_melee");
	if(s_result.weapon == var_1c041bd9)
	{
		self thread zm_audio::create_and_play_dialog(#"hash_6a87c913e3ecd37a", #"flamethrower");
	}
}

