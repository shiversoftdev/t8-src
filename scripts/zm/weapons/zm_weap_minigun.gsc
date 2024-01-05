// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\abilities\ability_player.gsc;
#using scripts\zm\powerup\zm_powerup_nuke.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_net.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\ai\zombie_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\player\player_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_weap_minigun;

/*
	Name: __init__system__
	Namespace: zm_weap_minigun
	Checksum: 0x4AE07E94
	Offset: 0x270
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_weap_minigun", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_minigun
	Checksum: 0x21DE5A40
	Offset: 0x2B8
	Size: 0x3CC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "hero_minigun_vigor_postfx", 1, 1, "counter");
	clientfield::register("allplayers", "minigun_launcher_muzzle_fx", 1, 1, "counter");
	clientfield::register("missile", "minigun_nuke_rob", 1, 1, "int");
	clientfield::register("toplayer", "minigun_nuke_rumble", 1, 1, "counter");
	level.hero_weapon[#"minigun"][0] = getweapon(#"hero_minigun_t8_lv1");
	level.hero_weapon[#"minigun"][1] = getweapon(#"hero_minigun_t8_lv2");
	level.hero_weapon[#"minigun"][2] = getweapon(#"hero_minigun_t8_lv3");
	zm_loadout::register_hero_weapon_for_level(#"hero_minigun_t8_lv1");
	zm_loadout::register_hero_weapon_for_level(#"hero_minigun_t8_lv2");
	zm_loadout::register_hero_weapon_for_level(#"hero_minigun_t8_lv3");
	zm_hero_weapon::function_7eabd65d(getweapon(#"hash_492e530f9862f6cc"));
	zm_hero_weapon::function_7eabd65d(getweapon(#"hash_628d99860c78650f"));
	level._effect[#"launcher_flash"] = #"hash_65b54823a8e8631e";
	if(!isdefined(level.var_90e0e2a0))
	{
		level.var_90e0e2a0 = new throttle();
		[[ level.var_90e0e2a0 ]]->initialize(4, 0.1);
	}
	callback::on_connect(&function_9592c5c1);
	zm::function_84d343d(#"hero_minigun_t8_lv1", &function_34a75fed);
	zm::function_84d343d(#"hero_minigun_t8_lv2", &function_34a75fed);
	zm::function_84d343d(#"hero_minigun_t8_lv3", &function_34a75fed);
	zm::function_84d343d(#"hash_492e530f9862f6cc", &function_34a75fed);
	zm::function_84d343d(#"hash_628d99860c78650f", &function_34a75fed);
}

/*
	Name: function_83c8b26e
	Namespace: zm_weap_minigun
	Checksum: 0x4F1AEE30
	Offset: 0x690
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function function_83c8b26e(weapon, var_e7c11b0c = 1)
{
	if(weapon == level.hero_weapon[#"minigun"][2])
	{
		return true;
	}
	if(weapon == level.hero_weapon[#"minigun"][1] && var_e7c11b0c < 3)
	{
		return true;
	}
	if(weapon == level.hero_weapon[#"minigun"][0] && var_e7c11b0c < 2)
	{
		return true;
	}
	return false;
}

/*
	Name: function_9592c5c1
	Namespace: zm_weap_minigun
	Checksum: 0xC9B1744B
	Offset: 0x768
	Size: 0x308
	Parameters: 0
	Flags: Linked, Private
*/
function private function_9592c5c1()
{
	self endon(#"disconnect");
	self thread function_1b26ce66();
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"weapon_change");
		wpn_cur = waitresult.weapon;
		wpn_prev = waitresult.last_weapon;
		if(isinarray(level.hero_weapon[#"minigun"], wpn_cur))
		{
			self clientfield::increment_to_player("hero_minigun_vigor_postfx");
			self function_768a7fab(1);
			self thread function_335a27d1();
			self thread function_6fa9af0e(wpn_cur);
		}
		else if(isinarray(level.hero_weapon[#"minigun"], wpn_prev))
		{
			self thread function_5ef1fdde(wpn_prev);
		}
		if(wpn_cur == level.hero_weapon[#"minigun"][0])
		{
			zm_hero_weapon::show_hint(wpn_cur, #"hash_6933501bf415a72c");
		}
		else
		{
			if(wpn_cur == level.hero_weapon[#"minigun"][1])
			{
				zm_hero_weapon::show_hint(wpn_cur, #"hash_30df02915fdc6a67");
				self thread function_ebaedcdd(wpn_cur);
				self thread function_478a4910(wpn_cur);
			}
			else if(wpn_cur == level.hero_weapon[#"minigun"][2])
			{
				if(!self gamepadusedlast())
				{
					self zm_hero_weapon::show_hint(wpn_cur, #"hash_53f4514d440c7816");
				}
				else
				{
					self zm_hero_weapon::show_hint(wpn_cur, #"hash_407cc98232081886");
				}
				self thread function_ebaedcdd(wpn_cur);
				self thread function_9d166ae8(wpn_cur);
				self thread function_68ff89f7(wpn_cur);
			}
		}
	}
}

/*
	Name: function_1b26ce66
	Namespace: zm_weap_minigun
	Checksum: 0xE5A6365E
	Offset: 0xA78
	Size: 0x98
	Parameters: 0
	Flags: Linked, Private
*/
function private function_1b26ce66()
{
	self endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"hero_weapon_give");
		var_cad4df8e = waitresult.weapon;
		if(function_83c8b26e(var_cad4df8e, 2))
		{
			self clientfield::increment_to_player("hero_minigun_vigor_postfx");
		}
	}
}

/*
	Name: function_5ef1fdde
	Namespace: zm_weap_minigun
	Checksum: 0x5CCA94B2
	Offset: 0xB18
	Size: 0x86
	Parameters: 1
	Flags: Linked, Private
*/
function private function_5ef1fdde(w_minigun)
{
	self endon(#"disconnect");
	n_slot = self gadgetgetslot(w_minigun);
	while(self function_36dfc05f(n_slot))
	{
		waitframe(1);
	}
	self function_768a7fab(0);
	self notify(#"hero_minigun_expired");
}

/*
	Name: function_34a75fed
	Namespace: zm_weap_minigun
	Checksum: 0xA8E0476C
	Offset: 0xBA8
	Size: 0x34E
	Parameters: 12
	Flags: Linked
*/
function function_34a75fed(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(!isdefined(self.var_6f84b820))
	{
		return damage;
	}
	switch(weapon.name)
	{
		case "hash_492e530f9862f6cc":
		{
			if(isalive(self))
			{
				switch(self.var_6f84b820)
				{
					case "basic":
					case "enhanced":
					{
						if(isdefined(level.no_gib_in_wolf_area) && (isdefined(self [[level.no_gib_in_wolf_area]]()) && self [[level.no_gib_in_wolf_area]]()))
						{
							self.no_gib = 1;
						}
						if(!(isdefined(self.no_gib) && self.no_gib))
						{
							self thread function_fae65b82();
						}
						return self.health;
					}
					case "popcorn":
					{
						return self.health;
					}
				}
			}
			break;
		}
		case "hash_628d99860c78650f":
		{
			if(isalive(self))
			{
				switch(self.var_6f84b820)
				{
					case "popcorn":
					case "basic":
					case "enhanced":
					{
						return 0;
						break;
					}
				}
			}
			break;
		}
		case "hero_minigun_t8_lv1":
		case "hero_minigun_t8_lv3":
		case "hero_minigun_t8_lv2":
		{
			if(meansofdeath === "MOD_RIFLE_BULLET")
			{
				if(isdefined(level.headshots_only) && level.headshots_only && (!(isdefined(self zm_utility::is_headshot(weapon, shitloc, meansofdeath)) && self zm_utility::is_headshot(weapon, shitloc, meansofdeath))))
				{
					return 0;
				}
			}
			if(self.var_6f84b820 == #"basic" || self.var_6f84b820 == #"enhanced")
			{
				n_damage = self function_bce04a11(weapon);
				if(n_damage > damage)
				{
					return n_damage;
				}
			}
			else if(self.var_6f84b820 == #"popcorn")
			{
				return self.health;
			}
			break;
		}
	}
	return damage;
}

/*
	Name: function_fae65b82
	Namespace: zm_weap_minigun
	Checksum: 0x239FE647
	Offset: 0xF00
	Size: 0x3C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_fae65b82()
{
	[[ level.var_90e0e2a0 ]]->waitinqueue(self);
	if(isdefined(self))
	{
		self zombie_utility::gib_random_parts();
	}
}

/*
	Name: function_335a27d1
	Namespace: zm_weap_minigun
	Checksum: 0x3C75CB3
	Offset: 0xF48
	Size: 0x24A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_335a27d1()
{
	if(self.var_9b5f3241 === 1)
	{
		self.var_1bdf157c = 1;
		self.var_5762241e = 40;
	}
	while(isalive(self) && self.var_9b5f3241 === 1)
	{
		foreach(e_player in level.players)
		{
			if(distancesquared(e_player.origin, self.origin) <= 1048576)
			{
				if(!isdefined(e_player.var_9b5f3241) || e_player.var_9b5f3241 !== 1 && !e_player laststand::player_is_in_laststand() && (!(isdefined(e_player.var_1bdf157c) && e_player.var_1bdf157c)))
				{
					e_player.var_1bdf157c = 1;
					e_player.var_5762241e = 40;
				}
				continue;
			}
			if(isdefined(e_player.var_1bdf157c) && e_player.var_1bdf157c)
			{
				e_player.var_1bdf157c = undefined;
				e_player.var_5762241e = undefined;
			}
		}
		waitframe(1);
	}
	foreach(e_player in level.players)
	{
		if(isdefined(e_player.var_1bdf157c) && e_player.var_1bdf157c)
		{
			e_player.var_1bdf157c = undefined;
			e_player.var_5762241e = undefined;
		}
	}
}

/*
	Name: function_6fa9af0e
	Namespace: zm_weap_minigun
	Checksum: 0xDF256637
	Offset: 0x11A0
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_6fa9af0e(w_minigun)
{
	self endon(#"bled_out", #"death", #"hero_minigun_expired");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"weapon_fired");
	}
}

/*
	Name: function_bce04a11
	Namespace: zm_weap_minigun
	Checksum: 0xA1739BC9
	Offset: 0x1230
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function function_bce04a11(w_minigun)
{
	switch(w_minigun.name)
	{
		case "hero_minigun_t8_lv2":
		{
			var_c4d00e65 = 0.12;
			break;
		}
		case "hero_minigun_t8_lv3":
		{
			var_c4d00e65 = 0.15;
			break;
		}
		default:
		{
			var_c4d00e65 = 0.1;
			break;
		}
	}
	if(!isdefined(self.maxhealth))
	{
		self.maxhealth = self.health;
	}
	n_percent_health = var_c4d00e65 * self.maxhealth;
	return max(n_percent_health, w_minigun.maxdamage);
}

/*
	Name: function_ebaedcdd
	Namespace: zm_weap_minigun
	Checksum: 0xB040028E
	Offset: 0x1320
	Size: 0x22E
	Parameters: 1
	Flags: Linked
*/
function function_ebaedcdd(w_minigun)
{
	self endon(#"bled_out", #"death", #"hero_minigun_expired");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"weapon_melee_power_left");
		if(s_result.weapon == w_minigun)
		{
			var_79db2feb = self gettagorigin("tag_flash2");
			v_forward_angles = anglestoforward(self getplayerangles());
			v_up = anglestoup(self getplayerangles());
			var_98739a5 = v_up * 10;
			var_52594630 = anglestoright(self getplayerangles()) * 5;
			clientfield::increment("minigun_launcher_muzzle_fx");
			var_70346f17 = v_forward_angles[0] * 1650;
			var_5a76439b = v_forward_angles[1] * 1650;
			var_4bbea62c = (v_forward_angles[2] * 1650) + 250;
			var_a460aa94 = (var_70346f17, var_5a76439b, var_4bbea62c);
			self magicgrenadetype(getweapon(#"hash_492e530f9862f6cc"), (var_79db2feb + var_98739a5) + var_52594630, var_a460aa94);
			waitframe(1);
		}
	}
}

/*
	Name: function_9d166ae8
	Namespace: zm_weap_minigun
	Checksum: 0x3684A4DB
	Offset: 0x1558
	Size: 0x4B2
	Parameters: 1
	Flags: Linked
*/
function function_9d166ae8(w_minigun)
{
	self endon(#"bled_out", #"death", #"hero_minigun_expired");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"weapon_melee");
		if(s_result.weapon === w_minigun && s_result._notify == "weapon_melee")
		{
			self playsoundontag("wpn_minigun_lvl3_throw", "j_head");
			wait(1.35);
			self thread zm_hero_weapon::function_4e984e83(w_minigun, 1);
			var_79db2feb = self gettagorigin("tag_weapon_right");
			var_79db2feb = var_79db2feb + vectorscale((0, 0, 1), 15);
			v_forward_angles = anglestoforward(self getplayerangles());
			var_70346f17 = v_forward_angles[0] * 850;
			var_5a76439b = v_forward_angles[1] * 850;
			var_4bbea62c = (v_forward_angles[2] * 850) + 150;
			var_a460aa94 = (var_70346f17, var_5a76439b, var_4bbea62c);
			var_40076092 = vectorscale((0, 0, 1), 12);
			e_grenade = self magicgrenadetype(getweapon(#"hash_628d99860c78650f"), var_79db2feb, var_a460aa94, 2);
			while(isdefined(e_grenade))
			{
				s_result = undefined;
				s_result = e_grenade waittilltimeout(4, #"stationary", #"death");
				if(isdefined(e_grenade))
				{
					if(s_result._notify == "stationary")
					{
						v_ground_pos = groundtrace(e_grenade.origin + vectorscale((0, 0, 1), 50), e_grenade.origin + (vectorscale((0, 0, -1), 500)), 0, e_grenade, 0, 0)[#"position"];
						if(isdefined(v_ground_pos))
						{
							v_end_pos = getclosestpointonnavmesh(v_ground_pos, 128, 24);
							if(isdefined(v_end_pos))
							{
								e_grenade.origin = v_end_pos + var_40076092;
							}
							else
							{
								e_grenade.origin = v_ground_pos + var_40076092;
							}
						}
						else
						{
							v_end_pos = e_grenade.origin;
						}
						e_grenade clientfield::set("minigun_nuke_rob", 1);
						e_grenade playloopsound("wpn_minigun_nuke_riser");
					}
					else
					{
						if(s_result._notify == "timeout")
						{
							v_end_pos = e_grenade.origin;
							e_grenade delete();
							break;
						}
						else
						{
							e_grenade clientfield::set("minigun_nuke_rob", 0);
						}
					}
				}
			}
			if(!isdefined(v_end_pos))
			{
				v_end_pos = self.origin + (anglestoforward(self.angles) * 128);
			}
			self thread function_13409329(v_end_pos, w_minigun);
			self gadgetpowerset(self gadgetgetslot(w_minigun), 0);
			self ability_player::function_f2250880(w_minigun);
			self notify(#"hero_minigun_expired");
		}
	}
}

/*
	Name: function_13409329
	Namespace: zm_weap_minigun
	Checksum: 0x516D1D04
	Offset: 0x1A18
	Size: 0x6A8
	Parameters: 2
	Flags: Linked
*/
function function_13409329(v_end_pos, w_minigun)
{
	level thread zm_powerup_nuke::nuke_flash(self.team);
	foreach(e_player in level.activeplayers)
	{
		e_player clientfield::increment_to_player("minigun_nuke_rumble");
	}
	if(!isdefined(v_end_pos))
	{
		v_end_pos = self.origin;
	}
	var_367c14cc = [];
	var_1ae49e8d = 0;
	a_ai_zombies = array::get_all_closest(v_end_pos, getaiteamarray(level.zombie_team), undefined, undefined, 4096);
	for(i = 0; i < a_ai_zombies.size; i++)
	{
		if(isdefined(a_ai_zombies[i].ignore_nuke) && a_ai_zombies[i].ignore_nuke || (isdefined(a_ai_zombies[i].marked_for_death) && a_ai_zombies[i].marked_for_death) || zm_utility::is_magic_bullet_shield_enabled(a_ai_zombies[i]))
		{
			continue;
		}
		if(a_ai_zombies[i].var_6f84b820 == #"basic" || a_ai_zombies[i].var_6f84b820 == #"popcorn" || a_ai_zombies[i].var_6f84b820 == #"enhanced")
		{
			if(isdefined(a_ai_zombies[i].var_f256a4d9))
			{
				var_1ae49e8d = var_1ae49e8d + a_ai_zombies[i].var_f256a4d9;
				a_ai_zombies[i].var_f256a4d9 = 0;
			}
			a_ai_zombies[i].marked_for_death = 1;
			a_ai_zombies[i] zombie_utility::set_zombie_run_cycle_override_value("walk");
			if(!(isdefined(a_ai_zombies[i].nuked) && a_ai_zombies[i].nuked) && var_367c14cc.size <= 12)
			{
				a_ai_zombies[i].nuked = 1;
				a_ai_zombies[i] clientfield::set("zm_nuked", 1);
			}
		}
		if(!isdefined(var_367c14cc))
		{
			var_367c14cc = [];
		}
		else if(!isarray(var_367c14cc))
		{
			var_367c14cc = array(var_367c14cc);
		}
		if(!isinarray(var_367c14cc, a_ai_zombies[i]))
		{
			var_367c14cc[var_367c14cc.size] = a_ai_zombies[i];
		}
	}
	for(i = 0; i < var_367c14cc.size; i++)
	{
		wait(randomfloatrange(0.1, 0.3));
		if(!isdefined(var_367c14cc[i]))
		{
			continue;
		}
		if(zm_utility::is_magic_bullet_shield_enabled(var_367c14cc[i]))
		{
			continue;
		}
		if(var_367c14cc[i].var_6f84b820 == #"basic" || var_367c14cc[i].var_6f84b820 == #"enhanced" || var_367c14cc[i].var_6f84b820 == #"popcorn")
		{
			var_367c14cc[i] thread function_292bb3d7(self, w_minigun, v_end_pos);
			continue;
		}
		if(var_367c14cc[i].var_6f84b820 == #"miniboss" || var_367c14cc[i].var_6f84b820 == #"boss")
		{
			if(isdefined(self.maxhealth))
			{
				var_4fbc5aad = var_367c14cc[i].maxhealth * 0.25;
			}
			else
			{
				var_4fbc5aad = var_367c14cc[i].health * 0.25;
			}
			var_367c14cc[i] dodamage(var_4fbc5aad, v_end_pos, undefined, self, "torso_lower", "MOD_BURNED", 0, w_minigun);
		}
	}
	n_score = 0;
	if(var_1ae49e8d > 0)
	{
		n_score = int(var_1ae49e8d * (1 / level.players.size));
	}
	if(level.players.size == 1 && n_score > 400)
	{
		n_score = 400;
	}
	foreach(e_player in level.players)
	{
		e_player zm_score::add_to_player_score(n_score);
	}
}

/*
	Name: function_292bb3d7
	Namespace: zm_weap_minigun
	Checksum: 0x4B655A39
	Offset: 0x20C8
	Size: 0x10C
	Parameters: 3
	Flags: Linked, Private
*/
function private function_292bb3d7(e_player, w_minigun, v_pos)
{
	self endon(#"death");
	[[ level.var_90e0e2a0 ]]->waitinqueue(self);
	if(self.var_6f84b820 == #"popcorn")
	{
		str_hit_loc = "none";
	}
	else
	{
		str_hit_loc = "torso_lower";
		if(!(isdefined(self.no_gib) && self.no_gib))
		{
			self zombie_utility::zombie_head_gib();
		}
	}
	self playsound(#"evt_nuked");
	self dodamage(self.health + 100, v_pos, undefined, e_player, str_hit_loc, "MOD_BURNED", 0, w_minigun);
}

/*
	Name: function_768a7fab
	Namespace: zm_weap_minigun
	Checksum: 0xF7E2429C
	Offset: 0x21E0
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function function_768a7fab(var_9b5f3241)
{
	self.var_9b5f3241 = var_9b5f3241;
}

/*
	Name: function_478a4910
	Namespace: zm_weap_minigun
	Checksum: 0xE4714FB5
	Offset: 0x2208
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_478a4910(w_minigun)
{
	self endon(#"bled_out", #"death", #"hero_minigun_expired");
	s_result = undefined;
	s_result = self waittill(#"weapon_melee_power_left");
	if(s_result.weapon == w_minigun)
	{
		self thread zm_audio::create_and_play_dialog(#"hero_level_2", #"minigun");
	}
}

/*
	Name: function_68ff89f7
	Namespace: zm_weap_minigun
	Checksum: 0x3596D4FE
	Offset: 0x22C0
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_68ff89f7(w_minigun)
{
	self endon(#"bled_out", #"death", #"hero_minigun_expired");
	s_result = undefined;
	s_result = self waittill(#"weapon_melee");
	if(s_result.weapon === w_minigun && s_result._notify == "weapon_melee")
	{
		self thread zm_audio::create_and_play_dialog(#"hero_level_3", #"minigun");
	}
}

