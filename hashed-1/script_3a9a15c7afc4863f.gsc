// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_challenges.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_stats.gsc;

#namespace namespace_b3dc953d;

/*
	Name: function_89f2df9
	Namespace: namespace_b3dc953d
	Checksum: 0x745F7B76
	Offset: 0x158
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_568317e5f219241c", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b3dc953d
	Checksum: 0xB0C3DE43
	Offset: 0x1A0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_82ad2d27();
}

/*
	Name: function_82ad2d27
	Namespace: namespace_b3dc953d
	Checksum: 0xE850ED6D
	Offset: 0x1C0
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_82ad2d27()
{
	zm_perks::function_7f42e14e(#"hash_3eac84d6fe51944b", "mod_electric_cherry", #"perk_electric_cherry", #"specialty_electriccherry", 4000);
	zm_perks::register_perk_threads(#"hash_3eac84d6fe51944b", &function_4b44aa37, &function_cfba6046, &function_b107ce52);
	zm_perks::function_430970f6(#"hash_3eac84d6fe51944b", &function_f6515ba2);
}

/*
	Name: electric_cherry_death_fx
	Namespace: namespace_b3dc953d
	Checksum: 0x81929265
	Offset: 0x2A0
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function electric_cherry_death_fx()
{
	self endon(#"death");
	if(!(isdefined(self.head_gibbed) && self.head_gibbed))
	{
		if(isvehicle(self))
		{
			self clientfield::set("tesla_shock_eyes_fx_veh", 1);
		}
		else
		{
			self clientfield::set("tesla_shock_eyes_fx", 1);
		}
	}
	else if(isvehicle(self))
	{
		self clientfield::set("tesla_death_fx_veh", 1);
	}
	else
	{
		self clientfield::set("tesla_death_fx", 1);
	}
}

/*
	Name: electric_cherry_shock_fx
	Namespace: namespace_b3dc953d
	Checksum: 0xF4461248
	Offset: 0x398
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function electric_cherry_shock_fx()
{
	self endon(#"death");
	if(isvehicle(self))
	{
		self clientfield::set("tesla_shock_eyes_fx_veh", 1);
	}
	else
	{
		self clientfield::set("tesla_shock_eyes_fx", 1);
	}
	self waittill(#"stun_fx_end");
	if(isvehicle(self))
	{
		self clientfield::set("tesla_shock_eyes_fx_veh", 0);
	}
	else
	{
		self clientfield::set("tesla_shock_eyes_fx", 0);
	}
}

/*
	Name: electric_cherry_stun
	Namespace: namespace_b3dc953d
	Checksum: 0x3792EB6D
	Offset: 0x480
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function electric_cherry_stun()
{
	self endon(#"death");
	self notify(#"stun_zombie");
	self endon(#"stun_zombie");
	if(self.health <= 0)
	{
		/#
			iprintln("");
		#/
		return;
	}
	self ai::stun();
	self val::set(#"electric_cherry_stun", "ignoreall", 1);
	wait(4);
	if(isdefined(self))
	{
		self ai::function_62795e55();
		self val::reset(#"electric_cherry_stun", "ignoreall");
		self notify(#"stun_fx_end");
	}
}

/*
	Name: electric_cherry_reload_attack
	Namespace: namespace_b3dc953d
	Checksum: 0x547B102A
	Offset: 0x598
	Size: 0x13A
	Parameters: 0
	Flags: Linked
*/
function electric_cherry_reload_attack()
{
	self endon(#"death", #"hash_3eac84d6fe51944b" + "_take");
	self.consecutive_electric_cherry_attacks = 0;
	self.var_c25a91ee = 0;
	if(!isdefined(self.var_dbaad7dd))
	{
		self.var_dbaad7dd = 10;
	}
	self function_4debd1a8();
	while(true)
	{
		var_adea2587 = undefined;
		var_adea2587 = self waittill(#"reload_start");
		w_current = self getcurrentweapon();
		n_clip_current = self getweaponammoclip(w_current);
		n_clip_max = w_current.clipsize;
		self thread check_for_reload_complete(w_current, n_clip_current, n_clip_max);
		if(isdefined(self))
		{
			self notify(#"hash_54480fc7f7e6f243");
		}
	}
}

/*
	Name: check_for_reload_complete
	Namespace: namespace_b3dc953d
	Checksum: 0x1464B2FC
	Offset: 0x6E0
	Size: 0xD4
	Parameters: 3
	Flags: Linked
*/
function check_for_reload_complete(weapon, n_clip_current, n_clip_max)
{
	self endon(#"death", #"hash_3eac84d6fe51944b" + "_take", "player_lost_weapon_" + weapon.name);
	while(true)
	{
		self waittill(#"reload");
		current_weapon = self getcurrentweapon();
		if(current_weapon == weapon && !weapon.isabilityweapon)
		{
			self thread function_97a7641d(weapon, n_clip_current, n_clip_max);
			break;
		}
	}
}

/*
	Name: function_f6515ba2
	Namespace: namespace_b3dc953d
	Checksum: 0x4FD35A39
	Offset: 0x7C0
	Size: 0x1FE
	Parameters: 12
	Flags: Linked
*/
function function_f6515ba2(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(meansofdeath == "MOD_MELEE" && attacker.var_dbaad7dd > 0)
	{
		if(!attacker.var_c25a91ee)
		{
			attacker thread function_81622feb();
		}
		var_5a8c565a = damage * 3;
		if(self.archetype === #"zombie" || self.archetype === #"catalyst")
		{
			self thread electric_cherry_death_fx();
			/#
				attacker zm_challenges::debug_print("");
			#/
			attacker zm_stats::increment_challenge_stat(#"hash_783ec74bf31f604d");
			return self.health;
		}
		if(self.health <= var_5a8c565a)
		{
			self thread electric_cherry_death_fx();
			/#
				attacker zm_challenges::debug_print("");
			#/
			attacker zm_stats::increment_challenge_stat(#"hash_783ec74bf31f604d");
			return var_5a8c565a;
		}
		self thread electric_cherry_stun();
		self thread electric_cherry_shock_fx();
		return var_5a8c565a;
	}
	return damage;
}

/*
	Name: function_97a7641d
	Namespace: namespace_b3dc953d
	Checksum: 0xA07F3206
	Offset: 0x9C8
	Size: 0x8C
	Parameters: 3
	Flags: Linked
*/
function function_97a7641d(w_current, n_clip_current, n_clip_max)
{
	n_fraction = n_clip_current / n_clip_max;
	if(n_fraction == 0)
	{
		n_time = 10;
	}
	else
	{
		n_time = 10 - (n_fraction * 10);
	}
	if(n_time < 2)
	{
		return;
	}
	self thread function_a2ba8a6c(n_time);
}

/*
	Name: function_a2ba8a6c
	Namespace: namespace_b3dc953d
	Checksum: 0x695B6288
	Offset: 0xA60
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_a2ba8a6c(n_time)
{
	if(self.var_dbaad7dd < n_time)
	{
		self.var_dbaad7dd = n_time;
		self function_4debd1a8();
	}
}

/*
	Name: function_4debd1a8
	Namespace: namespace_b3dc953d
	Checksum: 0x8246D225
	Offset: 0xAA8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_4debd1a8()
{
	self zm_perks::function_c8c7bc5(3, self.var_dbaad7dd > 0, #"perk_electric_cherry");
	n_counter = math::clamp(self.var_dbaad7dd, 0, 10);
	n_counter = n_counter / 10;
	self zm_perks::function_13880aa5(3, n_counter, #"perk_electric_cherry");
}

/*
	Name: function_81622feb
	Namespace: namespace_b3dc953d
	Checksum: 0x74FB91B4
	Offset: 0xB48
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_81622feb()
{
	self notify(#"hash_2e9b55fc4344af57");
	self endon(#"disconnect", #"hash_2e9b55fc4344af57");
	self thread function_857ced89();
	wait(self.var_dbaad7dd);
	self playsoundtoplayer(#"hash_ea37a7d6cf6bfb3", self);
	self notify(#"hash_5435513976a87bce");
	self.var_c25a91ee = 0;
	self zm_perks::function_c8c7bc5(3, 0, #"perk_electric_cherry");
	self.var_dbaad7dd = 0;
	self zm_perks::function_13880aa5(3, 0, #"perk_electric_cherry");
}

/*
	Name: function_4b44aa37
	Namespace: namespace_b3dc953d
	Checksum: 0x1ADC3EF5
	Offset: 0xC40
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_4b44aa37()
{
	self zm_perks::function_f0ac059f(3, 1, #"perk_electric_cherry");
	self thread electric_cherry_reload_attack();
}

/*
	Name: function_857ced89
	Namespace: namespace_b3dc953d
	Checksum: 0xF74D5FE7
	Offset: 0xC90
	Size: 0x190
	Parameters: 0
	Flags: Linked
*/
function function_857ced89()
{
	self endon(#"disconnect", #"hash_1549266f638bd78f", #"hash_5435513976a87bce", #"hash_2e9b55fc4344af57");
	self.var_c25a91ee = 1;
	self playsoundtoplayer(#"hash_2283cbfbc6b9e736", self);
	var_9ade76c0 = self.var_dbaad7dd;
	n_time_left = var_9ade76c0;
	var_8b3ae2d6 = var_9ade76c0 / 10;
	self zm_perks::function_13880aa5(3, var_8b3ae2d6, #"perk_electric_cherry");
	while(true)
	{
		wait(0.1);
		n_time_left = n_time_left - 0.1;
		n_time_left = math::clamp(n_time_left, 0, var_9ade76c0);
		n_percentage = n_time_left / var_9ade76c0;
		n_percentage = n_percentage * var_8b3ae2d6;
		n_percentage = math::clamp(n_percentage, 0.02, var_9ade76c0);
		self zm_perks::function_13880aa5(3, n_percentage, #"perk_electric_cherry");
	}
}

/*
	Name: function_b107ce52
	Namespace: namespace_b3dc953d
	Checksum: 0xCA13CD5C
	Offset: 0xE28
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_b107ce52()
{
	if(!isdefined(self.var_dbaad7dd))
	{
		self.var_dbaad7dd = 0;
	}
	self function_a2ba8a6c(10);
	if(isdefined(self.var_c25a91ee) && self.var_c25a91ee)
	{
		self thread function_81622feb();
	}
}

/*
	Name: function_cfba6046
	Namespace: namespace_b3dc953d
	Checksum: 0x44F40A33
	Offset: 0xE98
	Size: 0xC4
	Parameters: 4
	Flags: Linked
*/
function function_cfba6046(b_pause, str_perk, str_result, n_slot)
{
	self notify(#"hash_3eac84d6fe51944b" + "_take");
	self.var_c25a91ee = undefined;
	self zm_perks::function_c8c7bc5(3, 0, #"perk_electric_cherry");
	self zm_perks::function_f0ac059f(3, 0, #"perk_electric_cherry");
	self zm_perks::function_13880aa5(3, 0, #"perk_electric_cherry");
}

