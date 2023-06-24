// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace zm_perk_ethereal_razor;

/*
	Name: __init__system__
	Namespace: zm_perk_ethereal_razor
	Checksum: 0x467CE9DC
	Offset: 0x168
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_ethereal_razor", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_ethereal_razor
	Checksum: 0x91D0A9E6
	Offset: 0x1B0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_ethereal_razor_perk_for_level();
}

/*
	Name: enable_ethereal_razor_perk_for_level
	Namespace: zm_perk_ethereal_razor
	Checksum: 0xF0A0ED45
	Offset: 0x1D0
	Size: 0x254
	Parameters: 0
	Flags: Linked
*/
function enable_ethereal_razor_perk_for_level()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"specialty_etherealrazor", #"perk_ethereal_razor", 4000, #"hash_1e8ce5bc6963fb34", getweapon("zombie_perk_bottle_ethereal_razor"), getweapon("zombie_perk_totem_ethereal_razor"), #"zmperksetherealrazor");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"specialty_etherealrazor", #"perk_ethereal_razor", 4000, #"zombie/perk_ethereal_razor", getweapon("zombie_perk_bottle_ethereal_razor"), getweapon("zombie_perk_totem_ethereal_razor"), #"zmperksetherealrazor");
	}
	zm_perks::register_perk_precache_func(#"specialty_etherealrazor", &function_ee114cab);
	zm_perks::register_perk_clientfields(#"specialty_etherealrazor", &function_f20b4260, &function_f3043027);
	zm_perks::register_perk_host_migration_params(#"specialty_etherealrazor", "vending_ethereal_razor", "ethereal_razor_light");
	zm_perks::register_perk_threads(#"specialty_etherealrazor", &function_c38b0ce4, &function_6cedb75c);
	if(isdefined(level.var_f32d2a34) && level.var_f32d2a34)
	{
		level thread [[level.var_f32d2a34]]();
	}
	callback::on_spawned(&on_spawned);
}

/*
	Name: on_spawned
	Namespace: zm_perk_ethereal_razor
	Checksum: 0xA08C2A75
	Offset: 0x430
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_spawned()
{
	self function_5b0f2cc5();
}

/*
	Name: function_ee114cab
	Namespace: zm_perk_ethereal_razor
	Checksum: 0xE476B1F
	Offset: 0x458
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function function_ee114cab()
{
	if(isdefined(level.electric_cherry_precache_override_func))
	{
		[[level.electric_cherry_precache_override_func]]();
		return;
	}
	level._effect[#"ethereal_razor_light"] = #"hash_1442db17b83460ad";
	level.machine_assets[#"specialty_etherealrazor"] = spawnstruct();
	level.machine_assets[#"specialty_etherealrazor"].weapon = getweapon("zombie_perk_bottle_ethereal_razor");
	level.machine_assets[#"specialty_etherealrazor"].off_model = "p7_zm_vending_nuke";
	level.machine_assets[#"specialty_etherealrazor"].on_model = "p7_zm_vending_nuke";
}

/*
	Name: function_f20b4260
	Namespace: zm_perk_ethereal_razor
	Checksum: 0xD6A427AB
	Offset: 0x570
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_f20b4260()
{
	clientfield::register("actor", "" + #"hash_29c26fb019da89f3", 13000, 1, "counter");
	clientfield::register("allplayers", "" + #"hash_450d9f824068dcc2", 13000, 1, "counter");
	clientfield::register("allplayers", "" + #"hash_4de2dbcd551f1fb7", 13000, 1, "counter");
}

/*
	Name: function_f3043027
	Namespace: zm_perk_ethereal_razor
	Checksum: 0x3CA09178
	Offset: 0x640
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_f3043027(state)
{
}

/*
	Name: function_c38b0ce4
	Namespace: zm_perk_ethereal_razor
	Checksum: 0xEFE8E0C0
	Offset: 0x658
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_c38b0ce4()
{
	self endon(#"disconnect", #"specialty_etherealrazor" + "_take");
	self thread function_f86e4c3d();
	self function_5b0f2cc5();
	callback::on_ai_damage(&on_ai_damage);
	callback::on_ai_killed(&on_ai_killed);
}

/*
	Name: function_6cedb75c
	Namespace: zm_perk_ethereal_razor
	Checksum: 0x18B87EC7
	Offset: 0x700
	Size: 0x94
	Parameters: 4
	Flags: Linked
*/
function function_6cedb75c(b_pause, str_perk, str_result, n_slot)
{
	self notify(#"specialty_etherealrazor" + "_take");
	self function_5b0f2cc5();
	callback::remove_on_ai_damage(&on_ai_damage);
	callback::remove_on_ai_killed(&on_ai_killed);
}

/*
	Name: function_f86e4c3d
	Namespace: zm_perk_ethereal_razor
	Checksum: 0xE1CFB5FE
	Offset: 0x7A0
	Size: 0x1A8
	Parameters: 0
	Flags: Linked
*/
function function_f86e4c3d()
{
	self endon(#"disconnect", #"specialty_etherealrazor" + "_take");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"weapon_melee", #"weapon_melee_charge");
		w_melee = waitresult.weapon;
		var_c34665fc = waitresult._notify;
		if(self hasperk(#"specialty_etherealrazor") && function_866130c7(w_melee))
		{
			if(w_melee === level.w_bowie_knife)
			{
				self clientfield::increment("" + #"hash_4de2dbcd551f1fb7");
			}
			else
			{
				self clientfield::increment("" + #"hash_450d9f824068dcc2");
			}
			if(var_c34665fc === #"weapon_melee_charge")
			{
				self function_1f7c6bb9(w_melee, 20, 40, 1);
			}
			else
			{
				self function_1f7c6bb9(w_melee, 50, 10);
			}
		}
	}
}

/*
	Name: function_1f7c6bb9
	Namespace: zm_perk_ethereal_razor
	Checksum: 0x9D3737D8
	Offset: 0x950
	Size: 0x5BC
	Parameters: 4
	Flags: Linked
*/
function function_1f7c6bb9(w_melee, var_2b9d3880, var_48e9b3cc, is_lunge = 0)
{
	self endon(#"disconnect");
	var_2ed6f142 = self getplayercamerapos();
	v_angles = self getplayerangles();
	v_norm = vectornormalize(anglestoforward(v_angles));
	a_e_targets = function_fa63958c();
	a_e_targets = arraysortclosest(a_e_targets, self.origin);
	var_5f96a3db = 0;
	var_cf912c82 = 0;
	n_base_damage = int(500);
	var_9c0b2bd5 = (is_lunge ? 1 : 3);
	if(self function_da33f286() && is_lunge)
	{
		if(isdefined(self.var_ec2fa29e) && self.var_ec2fa29e)
		{
			var_48e9b3cc = 30;
			self.health = math::clamp(self.health + var_48e9b3cc, 0, self.var_66cb03ad);
			self function_5b0f2cc5();
			return;
		}
	}
	else if(isdefined(self.var_53b8e41f) && self.var_53b8e41f)
	{
		self function_5b0f2cc5();
		return;
	}
	foreach(e_target in a_e_targets)
	{
		if(!isalive(e_target))
		{
			continue;
		}
		test_origin = e_target getcentroid();
		n_dist_sq = distancesquared(var_2ed6f142, test_origin);
		if(n_dist_sq > 10000 && !is_lunge)
		{
			continue;
		}
		var_c04cadc7 = e_target sightconetrace(var_2ed6f142, self, v_norm, var_2b9d3880);
		if(var_c04cadc7 == 0 && !isdefined(e_target.var_39c64392))
		{
			continue;
		}
		if(isdefined(e_target.var_39c64392))
		{
			n_total_damage = n_base_damage;
		}
		else
		{
			n_total_damage = n_base_damage + w_melee.meleedamage;
		}
		if(is_lunge)
		{
			if(self hasperk(#"specialty_mod_etherealrazor") && (e_target.var_6f84b820 === #"basic" || e_target.var_6f84b820 === #"popcorn" || e_target.var_6f84b820 === #"enhanced"))
			{
				n_total_damage = e_target.health + 666;
			}
			else
			{
				if(self hasperk(#"specialty_mod_etherealrazor"))
				{
					n_total_damage = n_total_damage + 4000;
				}
				else
				{
					n_total_damage = n_total_damage + 1000;
				}
			}
		}
		e_target.var_39c64392 = undefined;
		e_target dodamage(n_total_damage, self.origin, self, undefined, e_target.var_39c64392, "MOD_MELEE", 0, w_melee);
		e_target playsound(#"hash_444f738bd1d3fd8");
		if(isactor(e_target))
		{
			e_target clientfield::increment("" + #"hash_29c26fb019da89f3");
		}
		var_5f96a3db++;
		if(var_cf912c82 < 1 && self function_da33f286() && (!(isdefined(self.var_ec2fa29e) && self.var_ec2fa29e)))
		{
			self.health = math::clamp(self.health + var_48e9b3cc, 0, self.var_66cb03ad);
			var_cf912c82++;
		}
		if(var_5f96a3db >= var_9c0b2bd5)
		{
			self function_5b0f2cc5();
			return;
		}
	}
	self function_5b0f2cc5();
}

/*
	Name: function_5b0f2cc5
	Namespace: zm_perk_ethereal_razor
	Checksum: 0x64A05AF
	Offset: 0xF18
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function function_5b0f2cc5()
{
	self.var_53b8e41f = undefined;
	self.var_ec2fa29e = undefined;
}

/*
	Name: function_fa63958c
	Namespace: zm_perk_ethereal_razor
	Checksum: 0x2C217614
	Offset: 0xF38
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_fa63958c()
{
	var_25e2354 = function_4d8c71ce();
	var_72714481 = getaispeciesarray(level.zombie_team, "all");
	a_e_targets = arraycombine(var_72714481, var_25e2354, 0, 0);
	var_f7c84239 = [];
	foreach(target in a_e_targets)
	{
		if(1)
		{
			array::add(var_f7c84239, target);
		}
	}
	return var_f7c84239;
}

/*
	Name: function_866130c7
	Namespace: zm_perk_ethereal_razor
	Checksum: 0xF7DFC48C
	Offset: 0x1040
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function function_866130c7(w_melee)
{
	if(!(isdefined(w_melee.isriotshield) && w_melee.isriotshield) && !zm_loadout::is_hero_weapon(w_melee) && (!(isdefined(w_melee.isbulletweapon) && w_melee.isbulletweapon)) && (!(isdefined(w_melee.isprimary) && w_melee.isprimary) || w_melee.isballisticknife))
	{
		return true;
	}
	return false;
}

/*
	Name: function_da33f286
	Namespace: zm_perk_ethereal_razor
	Checksum: 0xE3A9BE9D
	Offset: 0x10F8
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function function_da33f286()
{
	if(isdefined(self.var_eb319d10) && self.var_eb319d10 || self.n_regen_rate === 0 || !self.heal.enabled)
	{
		return false;
	}
	return true;
}

/*
	Name: on_ai_killed
	Namespace: zm_perk_ethereal_razor
	Checksum: 0xA82B937A
	Offset: 0x1150
	Size: 0x152
	Parameters: 1
	Flags: Linked
*/
function on_ai_killed(s_params)
{
	player = s_params.eattacker;
	w_melee = s_params.weapon;
	if(!isdefined(w_melee) || s_params.smeansofdeath !== "MOD_MELEE")
	{
		return;
	}
	if(isplayer(player) && player hasperk(#"specialty_etherealrazor") && function_866130c7(w_melee) && isdefined(self.var_39c64392) && isplayer(s_params.einflictor))
	{
		if(player function_da33f286())
		{
			player.health = math::clamp(player.health + 10, 0, player.var_66cb03ad);
			player.var_ec2fa29e = 1;
		}
		else
		{
			player.var_53b8e41f = 1;
		}
	}
}

/*
	Name: on_ai_damage
	Namespace: zm_perk_ethereal_razor
	Checksum: 0xFB4C52BC
	Offset: 0x12B0
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function on_ai_damage(s_params)
{
	player = s_params.eattacker;
	w_melee = s_params.weapon;
	if(!isdefined(w_melee) || s_params.smeansofdeath !== "MOD_MELEE")
	{
		return;
	}
	if(isplayer(player) && player hasperk(#"specialty_etherealrazor") && function_866130c7(w_melee) && isplayer(s_params.einflictor))
	{
		self.var_39c64392 = s_params.shitloc;
	}
}

