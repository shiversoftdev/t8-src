// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.gsc;
#using scripts\core_common\weapons_shared.gsc;

#namespace killstreak_bundles;

/*
	Name: register_killstreak_bundle
	Namespace: killstreak_bundles
	Checksum: 0xF9D028C1
	Offset: 0x1F8
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function register_killstreak_bundle(type)
{
	level.killstreakbundle[type] = struct::get_script_bundle("killstreak", "killstreak_" + type);
	level.killstreakbundle["inventory_" + type] = level.killstreakbundle[type];
	level.killstreakmaxhealthfunction = &get_max_health;
	/#
		assert(isdefined(level.killstreakbundle[type]));
	#/
}

/*
	Name: function_25ce781d
	Namespace: killstreak_bundles
	Checksum: 0x7BB645C
	Offset: 0x2B0
	Size: 0x6C
	Parameters: 2
	Flags: None
*/
function function_25ce781d(type, bundle)
{
	level.killstreakbundle[type] = bundle;
	level.killstreakmaxhealthfunction = &get_max_health;
	/#
		assert(isdefined(level.killstreakbundle[type]));
	#/
}

/*
	Name: get_bundle
	Namespace: killstreak_bundles
	Checksum: 0xD604CB83
	Offset: 0x328
	Size: 0xA8
	Parameters: 1
	Flags: None
*/
function get_bundle(killstreak)
{
	if(killstreak.archetype === "raps")
	{
		return level.killstreakbundle[#"raps_drone"];
	}
	if(killstreak.killstreaktype === "drone_squadron" && sessionmodeiscampaigngame())
	{
		return level.killstreakbundle["drone_squadron" + "_cp"];
	}
	return level.killstreakbundle[killstreak.killstreaktype];
}

/*
	Name: spawned
	Namespace: killstreak_bundles
	Checksum: 0x8E94A788
	Offset: 0x3E0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function spawned(bundle)
{
	self.var_22a05c26 = bundle;
}

/*
	Name: function_48e9536e
	Namespace: killstreak_bundles
	Checksum: 0x26B9E3D3
	Offset: 0x408
	Size: 0xA
	Parameters: 0
	Flags: None
*/
function function_48e9536e()
{
	return self.var_22a05c26;
}

/*
	Name: get_hack_timeout
	Namespace: killstreak_bundles
	Checksum: 0x6FD1D0C3
	Offset: 0x420
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function get_hack_timeout()
{
	return get_bundle(self).kshacktimeout;
}

/*
	Name: get_hack_protection
	Namespace: killstreak_bundles
	Checksum: 0x48312667
	Offset: 0x450
	Size: 0x48
	Parameters: 0
	Flags: None
*/
function get_hack_protection()
{
	return (isdefined(get_bundle(self).kshackprotection) ? get_bundle(self).kshackprotection : 0);
}

/*
	Name: get_hack_tool_inner_time
	Namespace: killstreak_bundles
	Checksum: 0x474AC5D3
	Offset: 0x4A0
	Size: 0x4A
	Parameters: 0
	Flags: None
*/
function get_hack_tool_inner_time()
{
	return (isdefined(get_bundle(self).kshacktoolinnertime) ? get_bundle(self).kshacktoolinnertime : 10000);
}

/*
	Name: get_hack_tool_outer_time
	Namespace: killstreak_bundles
	Checksum: 0xEB9C0C41
	Offset: 0x4F8
	Size: 0x4A
	Parameters: 0
	Flags: None
*/
function get_hack_tool_outer_time()
{
	return (isdefined(get_bundle(self).kshacktooloutertime) ? get_bundle(self).kshacktooloutertime : 10000);
}

/*
	Name: get_hack_tool_inner_radius
	Namespace: killstreak_bundles
	Checksum: 0xDFE8B08D
	Offset: 0x550
	Size: 0x4A
	Parameters: 0
	Flags: None
*/
function get_hack_tool_inner_radius()
{
	return (isdefined(get_bundle(self).kshacktoolinnerradius) ? get_bundle(self).kshacktoolinnerradius : 10000);
}

/*
	Name: get_hack_tool_outer_radius
	Namespace: killstreak_bundles
	Checksum: 0x407E7325
	Offset: 0x5A8
	Size: 0x4A
	Parameters: 0
	Flags: None
*/
function get_hack_tool_outer_radius()
{
	return (isdefined(get_bundle(self).kshacktoolouterradius) ? get_bundle(self).kshacktoolouterradius : 10000);
}

/*
	Name: get_lost_line_of_sight_limit_msec
	Namespace: killstreak_bundles
	Checksum: 0x1454A4B9
	Offset: 0x600
	Size: 0x4A
	Parameters: 0
	Flags: None
*/
function get_lost_line_of_sight_limit_msec()
{
	return (isdefined(get_bundle(self).kshacktoollostlineofsightlimitms) ? get_bundle(self).kshacktoollostlineofsightlimitms : 1000);
}

/*
	Name: get_hack_tool_no_line_of_sight_time
	Namespace: killstreak_bundles
	Checksum: 0x74E48ABB
	Offset: 0x658
	Size: 0x4A
	Parameters: 0
	Flags: None
*/
function get_hack_tool_no_line_of_sight_time()
{
	return (isdefined(get_bundle(self).kshacktoolnolineofsighttime) ? get_bundle(self).kshacktoolnolineofsighttime : 1000);
}

/*
	Name: get_hack_scoreevent
	Namespace: killstreak_bundles
	Checksum: 0x87BD2C7E
	Offset: 0x6B0
	Size: 0x48
	Parameters: 0
	Flags: None
*/
function get_hack_scoreevent()
{
	return (isdefined(get_bundle(self).kshackscoreevent) ? get_bundle(self).kshackscoreevent : undefined);
}

/*
	Name: get_hack_fx
	Namespace: killstreak_bundles
	Checksum: 0x3D7E30F7
	Offset: 0x700
	Size: 0x4E
	Parameters: 0
	Flags: None
*/
function get_hack_fx()
{
	return (isdefined(get_bundle(self).kshackfx) ? get_bundle(self).kshackfx : "");
}

/*
	Name: get_hack_loop_fx
	Namespace: killstreak_bundles
	Checksum: 0x63695AFE
	Offset: 0x758
	Size: 0x4E
	Parameters: 0
	Flags: None
*/
function get_hack_loop_fx()
{
	return (isdefined(get_bundle(self).kshackloopfx) ? get_bundle(self).kshackloopfx : "");
}

/*
	Name: get_max_health
	Namespace: killstreak_bundles
	Checksum: 0xC5A49F1C
	Offset: 0x7B0
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function get_max_health(killstreaktype)
{
	return level.killstreakbundle[killstreaktype].kshealth;
}

/*
	Name: get_low_health
	Namespace: killstreak_bundles
	Checksum: 0xB713CC4
	Offset: 0x7E0
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function get_low_health(killstreaktype)
{
	return level.killstreakbundle[killstreaktype].kslowhealth;
}

/*
	Name: get_hacked_health
	Namespace: killstreak_bundles
	Checksum: 0x3C517396
	Offset: 0x810
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function get_hacked_health(killstreaktype)
{
	return level.killstreakbundle[killstreaktype].kshackedhealth;
}

/*
	Name: get_shots_to_kill
	Namespace: killstreak_bundles
	Checksum: 0xC5547D50
	Offset: 0x840
	Size: 0x694
	Parameters: 3
	Flags: None
*/
function get_shots_to_kill(weapon, meansofdeath, bundle)
{
	shotstokill = undefined;
	baseweapon = weapons::getbaseweapon(weapon);
	if(baseweapon === level.var_9e188c0b && weaponhasattachment(weapon, "uber"))
	{
		if(bundle.var_d3413870 === "swat_team" || bundle.var_d3413870 === "overwatch_helicopter")
		{
			if(isactor(self))
			{
				shotstokill = bundle.var_3020f1b2;
			}
			else
			{
				shotstokill = bundle.var_5682dc25;
			}
		}
		else
		{
			shotstokill = bundle.var_3020f1b2;
		}
		return (isdefined(shotstokill) ? shotstokill : 0);
	}
	if(baseweapon === level.weaponspecialcrossbow)
	{
		if(bundle.var_d3413870 === "swat_team" || bundle.var_d3413870 === "overwatch_helicopter")
		{
			if(isactor(self))
			{
				shotstokill = bundle.var_1de74ef1;
			}
			else
			{
				shotstokill = bundle.var_63c68981;
			}
		}
		else
		{
			shotstokill = bundle.var_1de74ef1;
		}
		return (isdefined(shotstokill) ? shotstokill : 0);
	}
	switch(weapon.rootweapon.name)
	{
		case "remote_missile_missile":
		{
			shotstokill = bundle.ksremote_missile_missile;
			break;
		}
		case "hero_annihilator":
		{
			shotstokill = bundle.kshero_annihilator;
			break;
		}
		case "hero_bowlauncher2":
		case "hero_bowlauncher3":
		case "hero_bowlauncher4":
		case "hash_1d2a0f56220e6ff6":
		case "hash_1d2a1056220e71a9":
		case "hash_1d2a1156220e735c":
		case "hash_1d2a1256220e750f":
		case "hash_40380537847df901":
		case "hero_bowlauncher":
		{
			if(meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_GRENADE_SPLASH")
			{
				shotstokill = bundle.kshero_bowlauncher;
			}
			else
			{
				shotstokill = -1;
			}
			break;
		}
		case "hash_4bb2d7f789b561eb":
		{
			shotstokill = bundle.kshero_gravityspikes;
			break;
		}
		case "shock_rifle":
		{
			shotstokill = bundle.var_4be7d629;
			break;
		}
		case "hero_minigun":
		{
			shotstokill = bundle.kshero_minigun;
			break;
		}
		case "hero_pineapple_grenade":
		case "hero_pineapplegun":
		{
			shotstokill = bundle.kshero_pineapplegun;
			break;
		}
		case "hero_firefly_swarm":
		{
			shotstokill = (isdefined(bundle.kshero_firefly_swarm) ? bundle.kshero_firefly_swarm : 0) * 4;
			break;
		}
		case "dart_blade":
		case "dart_turret":
		{
			shotstokill = bundle.ksdartstokill;
			break;
		}
		case "recon_car":
		{
			shotstokill = bundle.var_8eca21ba;
			break;
		}
		case "ability_dog":
		{
			shotstokill = bundle.var_a758f9e6;
			break;
		}
		case "planemortar":
		{
			shotstokill = bundle.var_843b7bd3;
			break;
		}
		case "gadget_heat_wave":
		{
			shotstokill = bundle.kshero_heatwave;
			break;
		}
		case "hero_flamethrower":
		{
			if(isdefined(bundle.var_2db988a0) && bundle.var_2db988a0)
			{
				shotstokill = 1;
			}
			else
			{
				shotstokill = bundle.var_2e48926e;
			}
			break;
		}
		case "eq_concertina_wire":
		{
			if(isdefined(bundle.var_ab14c65a) && bundle.var_ab14c65a)
			{
				shotstokill = 1;
			}
			break;
		}
		case "ability_smart_cover":
		{
			if(isdefined(bundle.var_4de0b9db) && bundle.var_4de0b9db)
			{
				shotstokill = 1;
			}
			else
			{
				shotstokill = bundle.var_9efbc14a;
			}
			break;
		}
		case "hash_17df39d53492b0bf":
		{
			shotstokill = bundle.var_605815a6;
			break;
		}
		case "hash_7b24d0d0d2823bca":
		{
			shotstokill = bundle.var_50c51e5;
			break;
		}
		case "hash_721bd01efec90239":
		{
			shotstokill = bundle.var_676a4c7;
			break;
		}
		case "eq_tripwire":
		{
			shotstokill = bundle.var_8f65bc5d;
			break;
		}
		case "hatchet":
		{
			shotstokill = bundle.var_8ca2602b;
			break;
		}
		case "hash_21b346649d376bf3":
		{
			shotstokill = bundle.ksempgrenadestokill;
			break;
		}
		case "sig_blade":
		{
			shotstokill = bundle.var_5789ac76;
			break;
		}
	}
	return (isdefined(shotstokill) ? shotstokill : 0);
}

/*
	Name: get_emp_grenade_damage
	Namespace: killstreak_bundles
	Checksum: 0xA114BD40
	Offset: 0xEE0
	Size: 0xB8
	Parameters: 2
	Flags: None
*/
function get_emp_grenade_damage(killstreaktype, maxhealth)
{
	emp_weapon_damage = undefined;
	if(isdefined(level.killstreakbundle[killstreaktype]))
	{
		bundle = level.killstreakbundle[killstreaktype];
		empgrenadestokill = (isdefined(bundle.ksempgrenadestokill) ? bundle.ksempgrenadestokill : 0);
		if(empgrenadestokill == 0)
		{
		}
		else if(empgrenadestokill > 0)
		{
			emp_weapon_damage = maxhealth / empgrenadestokill + 1;
		}
		else
		{
			emp_weapon_damage = 0;
		}
	}
	return emp_weapon_damage;
}

/*
	Name: function_daad16b8
	Namespace: killstreak_bundles
	Checksum: 0xDD0E7E1E
	Offset: 0xFA0
	Size: 0x6E
	Parameters: 3
	Flags: None
*/
function function_daad16b8(maxhealth, weapon_damage, var_8cef04)
{
	var_8cef04 = (isdefined(var_8cef04) ? var_8cef04 : 0);
	if(var_8cef04 == 0)
	{
	}
	else if(var_8cef04 > 0)
	{
		weapon_damage = maxhealth / var_8cef04 + 1;
	}
	else
	{
		weapon_damage = 0;
	}
	return weapon_damage;
}

/*
	Name: function_14bd8ba5
	Namespace: killstreak_bundles
	Checksum: 0xD6173B3A
	Offset: 0x1018
	Size: 0x56
	Parameters: 2
	Flags: None
*/
function function_14bd8ba5(damage, damage_multiplier)
{
	damage_multiplier = (isdefined(damage_multiplier) ? damage_multiplier : 0);
	if(damage_multiplier == 0)
	{
		return undefined;
	}
	if(damage_multiplier > 0)
	{
		return damage * damage_multiplier;
	}
	return 0;
}

/*
	Name: function_6bacfedc
	Namespace: killstreak_bundles
	Checksum: 0x49A83CCA
	Offset: 0x1078
	Size: 0x5A
	Parameters: 2
	Flags: None
*/
function function_6bacfedc(weapon, var_5f29de13)
{
	return isdefined(var_5f29de13) && weapon.statname == var_5f29de13.statname && var_5f29de13.statname != level.weaponnone.statname;
}

/*
	Name: function_90509610
	Namespace: killstreak_bundles
	Checksum: 0x1DDE0B49
	Offset: 0x10E0
	Size: 0x5A
	Parameters: 2
	Flags: None
*/
function function_90509610(weapon, var_5f29de13)
{
	return isdefined(var_5f29de13) && weapon.name == var_5f29de13.name && var_5f29de13.statname != level.weaponnone.statname;
}

/*
	Name: get_weapon_damage
	Namespace: killstreak_bundles
	Checksum: 0x7B269847
	Offset: 0x1148
	Size: 0xBA
	Parameters: 8
	Flags: None
*/
function get_weapon_damage(killstreaktype, maxhealth, attacker, weapon, type, damage, flags, chargeshotlevel)
{
	weapon_damage = undefined;
	if(isdefined(level.killstreakbundle[killstreaktype]))
	{
		bundle = level.killstreakbundle[killstreaktype];
		weapon_damage = function_dd7587e4(bundle, maxhealth, attacker, weapon, type, damage, flags, chargeshotlevel);
	}
	return weapon_damage;
}

/*
	Name: function_dd7587e4
	Namespace: killstreak_bundles
	Checksum: 0x95FDE4E1
	Offset: 0x1210
	Size: 0x6AA
	Parameters: 8
	Flags: None
*/
function function_dd7587e4(bundle, maxhealth, attacker, weapon, type, damage, flags, chargeshotlevel)
{
	weapon_damage = undefined;
	if(isdefined(bundle))
	{
		if(isdefined(weapon))
		{
			shotstokill = get_shots_to_kill(weapon, type, bundle);
			if(shotstokill == 0)
			{
			}
			else if(shotstokill > 0)
			{
				if(isdefined(chargeshotlevel) && chargeshotlevel > 0)
				{
					shotstokill = shotstokill / chargeshotlevel;
				}
				weapon_damage = maxhealth / shotstokill + 1;
			}
			else
			{
				weapon_damage = 0;
			}
		}
		if(!isdefined(weapon_damage))
		{
			if(type == "MOD_RIFLE_BULLET" || type == "MOD_PISTOL_BULLET" || type == "MOD_HEAD_SHOT")
			{
				hasarmorpiercing = isdefined(attacker) && isplayer(attacker) && attacker hasperk(#"specialty_armorpiercing");
				clipstokill = (isdefined(bundle.ksclipstokill) ? bundle.ksclipstokill : 0);
				if(clipstokill == -1)
				{
					weapon_damage = 0;
				}
				else if(hasarmorpiercing && self.aitype !== "spawner_bo3_robot_grunt_assault_mp_escort")
				{
					weapon_damage = damage + int(damage * level.cac_armorpiercing_data);
				}
				if(weapon.weapclass == "spread")
				{
					ksshotgunmultiplier = (isdefined(bundle.ksshotgunmultiplier) ? bundle.ksshotgunmultiplier : 1);
					if(ksshotgunmultiplier == 0)
					{
					}
					else if(ksshotgunmultiplier > 0)
					{
						weapon_damage = (isdefined(weapon_damage) ? weapon_damage : damage) * ksshotgunmultiplier;
					}
				}
			}
			else if(type == "MOD_IMPACT" && (isdefined(level.var_1b72f911) && function_6bacfedc(weapon, level.var_1b72f911)))
			{
				var_108f064f = (isdefined(bundle.var_4be7d629) ? bundle.var_4be7d629 : 0);
				if(var_108f064f == 0)
				{
				}
				else if(var_108f064f > 0)
				{
					weapon_damage = maxhealth / var_108f064f + 1;
				}
				else
				{
					weapon_damage = 0;
				}
			}
			else if(type == "MOD_PROJECTILE" || type == "MOD_EXPLOSIVE" || (type == "MOD_PROJECTILE_SPLASH" && bundle.var_38de4989 === 1) && (!isdefined(weapon.isempkillstreak) || !weapon.isempkillstreak) && (!isdefined(level.weaponpistolenergy) || weapon.statname != level.weaponpistolenergy.statname || level.weaponpistolenergy.statname == level.weaponnone.statname) && (!isdefined(level.weaponspecialcrossbow) || weapon.statname != level.weaponspecialcrossbow.statname || level.weaponspecialcrossbow.statname == level.weaponnone.statname) && weapon.rootweapon.name != #"trophy_system")
			{
				if(function_6bacfedc(weapon, level.weaponshotgunenergy))
				{
					weapon_damage = function_daad16b8(maxhealth, weapon_damage, bundle.ksshotgunenergytokill);
				}
				else
				{
					rocketstokill = (isdefined(bundle.ksrocketstokill) ? bundle.ksrocketstokill : 0);
					if(level.var_71c35c9f && isdefined(bundle.var_b744074b) && bundle.var_b744074b != 0)
					{
						rocketstokill = bundle.var_b744074b;
					}
					if(rocketstokill == 0)
					{
					}
					else if(rocketstokill > 0)
					{
						if(weapon.rootweapon.name == "launcher_multi")
						{
							rocketstokill = rocketstokill * 2;
						}
						weapon_damage = maxhealth / rocketstokill + 1;
					}
					else
					{
						weapon_damage = 0;
					}
				}
			}
			else if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" && (!isdefined(weapon.isempkillstreak) || !weapon.isempkillstreak))
			{
				weapon_damage = function_14bd8ba5(damage, bundle.ksgrenadedamagemultiplier);
			}
			else if(type == "MOD_MELEE_WEAPON_BUTT" || type == "MOD_MELEE")
			{
				weapon_damage = function_14bd8ba5(damage, bundle.ksmeleedamagemultiplier);
			}
			else if(type == "MOD_PROJECTILE_SPLASH")
			{
				weapon_damage = function_14bd8ba5(damage, bundle.ksprojectilespashmultiplier);
			}
		}
	}
	return weapon_damage;
}

