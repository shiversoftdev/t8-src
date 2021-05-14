// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1254ac024174d9c0;
#using script_3f9e0dc8454d98e1;
#using script_5b18db57724ff7be;
#using script_698dd790cdc4965f;
#using script_6e3c826b1814cab6;
#using script_7133a4d461308099;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zm_pap_util;

/*
	Name: function_a81f02e5
	Namespace: zm_pap_util
	Checksum: 0x39CB9DAF
	Offset: 0x1D0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_a81f02e5()
{
	callback::function_33f0ddd3(&function_33f0ddd3);
}

/*
	Name: init_parameters
	Namespace: zm_pap_util
	Checksum: 0xF6DEB3F5
	Offset: 0x200
	Size: 0x7E
	Parameters: 0
	Flags: Linked
*/
function init_parameters()
{
	if(!isdefined(level.pack_a_punch))
	{
		level.pack_a_punch = spawnstruct();
		level.pack_a_punch.timeout = 15;
		level.pack_a_punch.interaction_height = 35;
		level.pack_a_punch.grabbable_by_anyone = 0;
		level.pack_a_punch.triggers = [];
	}
}

/*
	Name: set_timeout
	Namespace: zm_pap_util
	Checksum: 0x71F8BA0F
	Offset: 0x288
	Size: 0x32
	Parameters: 1
	Flags: None
*/
function set_timeout(n_timeout_s)
{
	init_parameters();
	level.pack_a_punch.timeout = n_timeout_s;
}

/*
	Name: set_interaction_height
	Namespace: zm_pap_util
	Checksum: 0x2AF0D4A9
	Offset: 0x2C8
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function set_interaction_height(n_height)
{
	init_parameters();
	level.pack_a_punch.interaction_height = n_height;
}

/*
	Name: function_11f3a609
	Namespace: zm_pap_util
	Checksum: 0x3EE114D9
	Offset: 0x308
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_11f3a609(n_width)
{
	init_parameters();
	level.pack_a_punch.var_280e196b = n_width;
}

/*
	Name: function_530eb959
	Namespace: zm_pap_util
	Checksum: 0x1A42EEF
	Offset: 0x348
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_530eb959(n_length)
{
	init_parameters();
	level.pack_a_punch.var_c89ce627 = n_length;
}

/*
	Name: set_interaction_trigger_height
	Namespace: zm_pap_util
	Checksum: 0x2FCD3E91
	Offset: 0x388
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function set_interaction_trigger_height(n_height)
{
	init_parameters();
	level.pack_a_punch.interaction_trigger_height = n_height;
}

/*
	Name: function_11fdb083
	Namespace: zm_pap_util
	Checksum: 0xBA8B42F1
	Offset: 0x3C8
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_11fdb083(n_offset)
{
	init_parameters();
	level.pack_a_punch.var_11fdb083 = n_offset;
}

/*
	Name: set_grabbable_by_anyone
	Namespace: zm_pap_util
	Checksum: 0x6732C9F9
	Offset: 0x408
	Size: 0x2A
	Parameters: 0
	Flags: None
*/
function set_grabbable_by_anyone()
{
	init_parameters();
	level.pack_a_punch.grabbable_by_anyone = 1;
}

/*
	Name: update_hint_string
	Namespace: zm_pap_util
	Checksum: 0x67CB129A
	Offset: 0x440
	Size: 0x770
	Parameters: 1
	Flags: Linked
*/
function update_hint_string(player)
{
	pap_machine = self.stub.zbarrier;
	if(!pap_machine flag::get("pap_waiting_for_user"))
	{
		if(pap_machine.pack_player === player)
		{
			if(pap_machine flag::get("pap_offering_gun"))
			{
				var_12680c28 = player getcurrentweapon();
				if(var_12680c28 != level.weaponnone)
				{
					if(function_8b1a219a())
					{
						self sethintstring(#"hash_21247f6d4bd72b9");
					}
					else
					{
						self sethintstring(#"hash_51194149fb39a693");
					}
					return 1;
				}
				return 0;
			}
			return 0;
		}
		self sethintstring(#"hash_5b77a8f33d352c37");
		return 1;
	}
	w_current = player getcurrentweapon();
	b_weapon_supports_aat = zm_weapons::weapon_supports_aat(w_current);
	if(pap_machine flag::get("pap_in_retrigger_delay") || !player player_use_can_pack_now(pap_machine) || player bgb::is_active(#"zm_bgb_ephemeral_enhancement"))
	{
		if(zm_utility::is_standard())
		{
			if(!namespace_59ff1d6c::function_901b751c(#"hash_57a5c7a9dcf94d61") || !b_weapon_supports_aat)
			{
				self sethintstringforplayer(player, #"hash_fea06394ae21371");
				return 1;
			}
			if(isdefined(player.var_486c9d59) && player.var_486c9d59)
			{
				return 1;
			}
		}
		return 0;
	}
	if(namespace_497ab7da::is_active())
	{
		self sethintstring(#"hash_55d25caf8f7bbb2f");
		return 1;
	}
	if(namespace_83dc3729::is_active())
	{
		return 0;
	}
	var_cbf27833 = zm_weapons::is_weapon_upgraded(w_current);
	current_cost = pap_machine function_aaf2d8(player, w_current, b_weapon_supports_aat, var_cbf27833);
	if(isdefined(level.var_3e3d6409) && self [[level.var_3e3d6409]](player))
	{
		if(isdefined(player.var_486c9d59) && player.var_486c9d59)
		{
			return 0;
		}
		return 1;
	}
	if(var_cbf27833 && b_weapon_supports_aat)
	{
		if(isdefined(level.var_e4e8d300) && level.var_e4e8d300)
		{
			if(player function_7352d8cc(w_current))
			{
				if(function_8b1a219a())
				{
					self sethintstring(#"hash_1a0df3bc59a8029b");
				}
				else
				{
					self sethintstring(#"hash_11c1749ce5b09c1f");
				}
			}
			else if(function_8b1a219a())
			{
				self sethintstring(#"hash_4614bd9a185769d4");
			}
			else
			{
				self sethintstring(#"hash_3dfc1041d71fc05e");
			}
		}
		else if(isdefined(pap_machine.var_b64e889a) && pap_machine.var_b64e889a)
		{
			if(player function_7352d8cc(w_current))
			{
				if(function_8b1a219a())
				{
					self sethintstring(#"hash_23e352cd04548513", current_cost);
				}
				else
				{
					self sethintstring(#"hash_6cd48e5ddab079ed", current_cost);
				}
			}
			else if(function_8b1a219a())
			{
				self sethintstring(#"hash_6942dfa9737b6ac8", current_cost);
			}
			else
			{
				self sethintstring(#"hash_117f528808767024", current_cost);
			}
		}
		else if(player function_7352d8cc(w_current))
		{
			if(function_8b1a219a())
			{
				self sethintstring(#"hash_7f57747f6802bc18", current_cost);
			}
			else
			{
				self sethintstring(#"hash_673794817f9c09b4", current_cost);
			}
		}
		else if(function_8b1a219a())
		{
			self sethintstring(#"hash_4ded27bb7bc35a8d", current_cost);
		}
		else
		{
			self sethintstring(#"hash_4c9d507af46126af", current_cost);
		}
	}
	else if(isdefined(level.var_e4e8d300) && level.var_e4e8d300)
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_12517f2f23bd1966");
		}
		else
		{
			self sethintstring(#"hash_6c8cfa12133d4a58");
		}
	}
	else if(function_8b1a219a())
	{
		self sethintstring(#"hash_4b18cdd522ca58f7", current_cost);
	}
	else
	{
		self sethintstring(#"hash_a49abfa7ed04929", current_cost);
	}
	return 1;
}

/*
	Name: function_aaf2d8
	Namespace: zm_pap_util
	Checksum: 0x36531C31
	Offset: 0xBB8
	Size: 0x230
	Parameters: 4
	Flags: Linked
*/
function function_aaf2d8(player, weapon, b_weapon_supports_aat, var_a86430cb)
{
	var_6224cea8 = player function_7352d8cc(weapon);
	if(zombie_utility::function_d2dfacfd(#"zombie_powerup_bonfire_sale_on"))
	{
		var_376755db = 1000;
		if(b_weapon_supports_aat && var_a86430cb)
		{
			if(var_6224cea8)
			{
				var_376755db = 300;
			}
			else
			{
				var_376755db = 500;
			}
		}
		if(isdefined(level.var_bceee222))
		{
			var_376755db = int(min(var_376755db, level.var_bceee222));
		}
		return var_376755db;
	}
	if(isdefined(level.var_bceee222))
	{
		var_376755db = level.var_bceee222;
	}
	else
	{
		var_376755db = 5000;
		if(b_weapon_supports_aat && var_a86430cb)
		{
			if(var_6224cea8)
			{
				var_376755db = 1500;
			}
			else
			{
				var_376755db = 2500;
			}
		}
	}
	if(isdefined(player.talisman_weapon_reducepapcost) && player.talisman_weapon_reducepapcost)
	{
		var_376755db = var_376755db - player.talisman_weapon_reducepapcost;
	}
	var_376755db = int(max(10, var_376755db));
	if(isdefined(level.var_66153d2c))
	{
		foreach(var_f403380b in level.var_66153d2c)
		{
			if(var_f403380b === weapon)
			{
				var_376755db = 0;
			}
		}
	}
	return var_376755db;
}

/*
	Name: function_873e8824
	Namespace: zm_pap_util
	Checksum: 0x21ED0A2C
	Offset: 0xDF0
	Size: 0x1C2
	Parameters: 12
	Flags: Linked
*/
function function_873e8824(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(!isplayer(attacker) || !isdefined(weapon) || !isdefined(meansofdeath))
	{
		return damage;
	}
	if(isplayer(inflictor) || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_IMPACT")
	{
		var_f651a2e7 = attacker function_6d45375a(weapon);
		damage = int(damage * var_f651a2e7);
		if(isdefined(attacker.var_b01de37) && isdefined(self.var_d1c70689))
		{
			damage = self [[self.var_d1c70689]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
		}
	}
	return damage;
}

/*
	Name: can_pack_weapon
	Namespace: zm_pap_util
	Checksum: 0x96D47CBE
	Offset: 0xFC0
	Size: 0xFE
	Parameters: 2
	Flags: Linked, Private
*/
private function can_pack_weapon(weapon, pap_machine)
{
	if(weapon.isriotshield)
	{
		return 0;
	}
	if(!pap_machine flag::get("pap_waiting_for_user"))
	{
		return 1;
	}
	if(!(isdefined(level.b_allow_idgun_pap) && level.b_allow_idgun_pap) && isdefined(level.idgun_weapons))
	{
		if(isinarray(level.idgun_weapons, weapon))
		{
			return 0;
		}
	}
	weapon = self zm_weapons::get_nonalternate_weapon(weapon);
	if(!zm_weapons::is_weapon_or_base_included(weapon))
	{
		return 0;
	}
	if(!self zm_weapons::can_upgrade_weapon(weapon))
	{
		return 0;
	}
	return 1;
}

/*
	Name: player_use_can_pack_now
	Namespace: zm_pap_util
	Checksum: 0x2CFFA00A
	Offset: 0x10C8
	Size: 0x122
	Parameters: 1
	Flags: Linked, Private
*/
private function player_use_can_pack_now(pap_machine)
{
	if(self laststand::player_is_in_laststand() || (isdefined(self.intermission) && self.intermission) || self isthrowinggrenade())
	{
		return 0;
	}
	if(!self zm_magicbox::can_buy_weapon(0) || self bgb::is_enabled(#"zm_bgb_disorderly_combat"))
	{
		return 0;
	}
	if(self zm_equipment::hacker_active())
	{
		return 0;
	}
	current_weapon = self getcurrentweapon();
	if(!self can_pack_weapon(current_weapon, pap_machine) && !zm_weapons::weapon_supports_aat(current_weapon))
	{
		return 0;
	}
	return 1;
}

/*
	Name: repack_weapon
	Namespace: zm_pap_util
	Checksum: 0x82F1FE9E
	Offset: 0x11F8
	Size: 0x15C
	Parameters: 2
	Flags: Linked
*/
function repack_weapon(weapon, n_repacks)
{
	if(!isdefined(self.var_2843d3cc))
	{
		self.var_2843d3cc = [];
	}
	else if(!isarray(self.var_2843d3cc))
	{
		self.var_2843d3cc = array(self.var_2843d3cc);
	}
	var_c0bd8719 = weapon;
	weapon = zm_weapons::function_93cd8e76(weapon);
	if(isdefined(n_repacks))
	{
		n_repacks = math::clamp(n_repacks, 0, 4);
		self.var_2843d3cc[weapon] = n_repacks;
	}
	else if(!isdefined(self.var_2843d3cc[weapon]))
	{
		self.var_2843d3cc[weapon] = 0;
	}
	if(self.var_2843d3cc[weapon] < 4)
	{
		self.var_2843d3cc[weapon]++;
	}
	if(self.var_2843d3cc[weapon] == 4)
	{
		self activecamo::function_896ac347(var_c0bd8719, #"hash_300fdf15a515feda", 1);
	}
}

/*
	Name: function_c01d9f22
	Namespace: zm_pap_util
	Checksum: 0x8EFF596C
	Offset: 0x1360
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_c01d9f22(weapon)
{
	var_c0bd8719 = weapon;
	weapon = zm_weapons::function_93cd8e76(weapon);
	if(isdefined(self.var_2843d3cc) && isdefined(self.var_2843d3cc[weapon]))
	{
		self.var_2843d3cc[weapon] = undefined;
		self zm_camos::function_a24c564f(#"hash_bc45c49c8304dc8", weapon);
	}
}

/*
	Name: function_b81da3fd
	Namespace: zm_pap_util
	Checksum: 0x447A4B99
	Offset: 0x13F8
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function function_b81da3fd(weapon)
{
	weapon = zm_weapons::function_93cd8e76(weapon);
	if(isdefined(self.var_2843d3cc) && isdefined(self.var_2843d3cc[weapon]) && self.var_2843d3cc[weapon] > 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_7352d8cc
	Namespace: zm_pap_util
	Checksum: 0x9E702958
	Offset: 0x1468
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_7352d8cc(weapon)
{
	weapon = zm_weapons::function_93cd8e76(weapon);
	if(isdefined(self.var_2843d3cc) && isdefined(self.var_2843d3cc[weapon]) && self.var_2843d3cc[weapon] == 4)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_83c29ddb
	Namespace: zm_pap_util
	Checksum: 0x74299142
	Offset: 0x14D8
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function function_83c29ddb(weapon)
{
	weapon = zm_weapons::function_93cd8e76(weapon);
	if(isdefined(self.var_2843d3cc) && isdefined(self.var_2843d3cc[weapon]))
	{
		return self.var_2843d3cc[weapon];
	}
	return 0;
}

/*
	Name: function_6d45375a
	Namespace: zm_pap_util
	Checksum: 0xCD93662F
	Offset: 0x1538
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function function_6d45375a(weapon)
{
	weapon = zm_weapons::function_93cd8e76(weapon);
	n_multiplier = 1;
	if(isdefined(self.var_2843d3cc) && isdefined(self.var_2843d3cc[weapon]))
	{
		n_multiplier = n_multiplier + 2 - 1 * self.var_2843d3cc[weapon] / 4;
	}
	return n_multiplier;
}

/*
	Name: function_33f0ddd3
	Namespace: zm_pap_util
	Checksum: 0x8C81D713
	Offset: 0x15D0
	Size: 0x54
	Parameters: 1
	Flags: Linked, Private
*/
private function function_33f0ddd3(s_event)
{
	if(s_event.event === "take_weapon" && isdefined(s_event.weapon))
	{
		self function_c01d9f22(s_event.weapon);
	}
}

