// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\perk\zm_perk_mod_additionalprimaryweapon.gsc;
#using scripts\zm_common\trials\zm_trial_disable_perks.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_perk_additionalprimaryweapon;

/*
	Name: __init__system__
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0xCCDD328A
	Offset: 0x238
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_additionalprimaryweapon", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x15F7869C
	Offset: 0x280
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.additionalprimaryweapon_limit = 3;
	enable_additional_primary_weapon_perk_for_level();
}

/*
	Name: enable_additional_primary_weapon_perk_for_level
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x91A2F2E6
	Offset: 0x2B0
	Size: 0x22C
	Parameters: 0
	Flags: Linked
*/
function enable_additional_primary_weapon_perk_for_level()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"specialty_additionalprimaryweapon", #"perk_additional_primary_weapon", 4000, #"hash_3010c651fdffa112", getweapon("zombie_perk_bottle_additionalprimaryweapon"), getweapon("zombie_perk_totem_mule_kick"), #"zmperksmulekick");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"specialty_additionalprimaryweapon", #"perk_additional_primary_weapon", 4000, #"zombie/perk_additionalprimaryweapon", getweapon("zombie_perk_bottle_additionalprimaryweapon"), getweapon("zombie_perk_totem_mule_kick"), #"zmperksmulekick");
	}
	zm_perks::register_perk_precache_func(#"specialty_additionalprimaryweapon", &additional_primary_weapon_precache);
	zm_perks::register_perk_clientfields(#"specialty_additionalprimaryweapon", &additional_primary_weapon_register_clientfield, &additional_primary_weapon_set_clientfield);
	zm_perks::register_perk_machine(#"specialty_additionalprimaryweapon", &additional_primary_weapon_perk_machine_setup);
	zm_perks::register_perk_threads(#"specialty_additionalprimaryweapon", &give_additional_primary_weapon_perk, &take_additional_primary_weapon_perk);
	zm_perks::register_perk_host_migration_params(#"specialty_additionalprimaryweapon", "vending_additionalprimaryweapon", "additionalprimaryweapon_light");
}

/*
	Name: additional_primary_weapon_precache
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0xB6EED8AC
	Offset: 0x4E8
	Size: 0x106
	Parameters: 0
	Flags: Linked
*/
function additional_primary_weapon_precache()
{
	if(isdefined(level.additional_primary_weapon_precache_override_func))
	{
		[[level.additional_primary_weapon_precache_override_func]]();
		return;
	}
	level._effect[#"additionalprimaryweapon_light"] = "zombie/fx_perk_mule_kick_zmb";
	level.machine_assets[#"specialty_additionalprimaryweapon"] = spawnstruct();
	level.machine_assets[#"specialty_additionalprimaryweapon"].weapon = getweapon("zombie_perk_bottle_additionalprimaryweapon");
	level.machine_assets[#"specialty_additionalprimaryweapon"].off_model = "p7_zm_vending_three_gun";
	level.machine_assets[#"specialty_additionalprimaryweapon"].on_model = "p7_zm_vending_three_gun";
}

/*
	Name: additional_primary_weapon_register_clientfield
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x2DD5BD5A
	Offset: 0x5F8
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function additional_primary_weapon_register_clientfield()
{
	clientfield::register_clientuimodel("hudItems.perks.additional_primary_weapon", 1, 2, "int", 0);
}

/*
	Name: additional_primary_weapon_set_clientfield
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0xD14592B1
	Offset: 0x630
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function additional_primary_weapon_set_clientfield(state)
{
}

/*
	Name: additional_primary_weapon_perk_machine_setup
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0xCCB391F3
	Offset: 0x648
	Size: 0xB6
	Parameters: 4
	Flags: Linked
*/
function additional_primary_weapon_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_mulekick_jingle";
	use_trigger.script_string = "tap_perk";
	use_trigger.script_label = "mus_perks_mulekick_sting";
	use_trigger.target = "vending_additionalprimaryweapon";
	perk_machine.script_string = "tap_perk";
	perk_machine.targetname = "vending_additionalprimaryweapon";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "tap_perk";
	}
}

/*
	Name: give_additional_primary_weapon_perk
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x4F21B11D
	Offset: 0x708
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function give_additional_primary_weapon_perk()
{
	self thread function_1a9f3a91();
	self function_61446ba9();
}

/*
	Name: take_additional_primary_weapon_perk
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0xF2366F2A
	Offset: 0x748
	Size: 0x2E4
	Parameters: 4
	Flags: Linked
*/
function take_additional_primary_weapon_perk(b_pause, str_perk, str_result, n_slot)
{
	self notify(#"hash_4dba2ff9e70127f5");
	if(isdefined(self.laststandpistol))
	{
		self endon(#"disconnect", #"hash_499749b8848c21fd");
		if(self.laststandpistol !== self.var_2a62e678)
		{
			self clientfield::set_player_uimodel("hudItems.perks.additional_primary_weapon", 0);
		}
		self waittill(#"hash_9b426cce825928d");
	}
	if(isdefined(self.var_2a62e678) && self hasweapon(self.var_2a62e678))
	{
		var_3ba4bf7d = self getweaponslistprimaries();
		var_287a8343 = zm_utility::get_player_weapon_limit(self);
		if(var_3ba4bf7d.size > var_287a8343)
		{
			if(zm_perks::function_e56d8ef4(#"specialty_additionalprimaryweapon") && !zm_trial_disable_perks::is_active())
			{
				self clientfield::set_player_uimodel("hudItems.perks.additional_primary_weapon", 0);
				return;
			}
			if(isdefined(self.var_dd1b11fe) && self.var_dd1b11fe && zm_perk_mod_additionalprimaryweapon::function_23c3c9db(self.var_2a62e678))
			{
				self.var_11b895b8 = {#hash_80c3ca2:self.aat[self.var_2a62e678], #hash_2d5dec87:self zm_weapons::get_player_weapondata(self.var_2a62e678)};
				self.var_dd1b11fe = undefined;
			}
			if(self.var_2a62e678 == self getcurrentweapon() && var_3ba4bf7d.size > 1)
			{
				self switchtoweapon();
			}
			self takeweapon(self.var_2a62e678);
		}
	}
	else if(isdefined(self))
	{
		self thread zm_player::function_de3936f8();
	}
	self.var_2a62e678 = undefined;
	self.var_64f51f65 = undefined;
	self clientfield::set_player_uimodel("hudItems.perks.additional_primary_weapon", 0);
}

/*
	Name: function_1a9f3a91
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0xABF7FCDC
	Offset: 0xA38
	Size: 0x2B8
	Parameters: 0
	Flags: Linked
*/
function function_1a9f3a91()
{
	self notify(#"hash_499749b8848c21fd");
	self endon(#"disconnect", #"hash_4dba2ff9e70127f5", #"hash_499749b8848c21fd");
	while(isdefined(self.s_loadout))
	{
		wait(0.05);
	}
	var_3ba4bf7d = self getweaponslistprimaries();
	if(var_3ba4bf7d.size < level.additionalprimaryweapon_limit)
	{
		self.var_2a62e678 = undefined;
		self.var_64f51f65 = undefined;
	}
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"weapon_change", #"hash_29c66728ccd27f03");
		if(isdefined(self.laststandpistol))
		{
			self clientfield::set_player_uimodel("hudItems.perks.additional_primary_weapon", 0);
			continue;
		}
		if(s_result.weapon !== level.weaponnone && !isinarray(var_3ba4bf7d, s_result.weapon))
		{
			var_b13885a = self getweaponslistprimaries();
			if(var_b13885a.size >= level.additionalprimaryweapon_limit)
			{
				if(!isdefined(self.var_2a62e678) && var_b13885a.size > var_3ba4bf7d.size)
				{
					self.var_2a62e678 = s_result.weapon;
				}
				else if(isdefined(self.var_2a62e678) && !isinarray(var_b13885a, self.var_2a62e678))
				{
					self.var_2a62e678 = s_result.weapon;
				}
				if(self.var_67ba1237.size && isinarray(self.var_67ba1237, #"specialty_additionalprimaryweapon"))
				{
					self.var_64f51f65 = self.var_2a62e678;
				}
			}
			var_3ba4bf7d = var_b13885a;
		}
		if(isdefined(self.var_2a62e678) && self.var_2a62e678 == self getcurrentweapon())
		{
			self clientfield::set_player_uimodel("hudItems.perks.additional_primary_weapon", 1);
		}
		else
		{
			self clientfield::set_player_uimodel("hudItems.perks.additional_primary_weapon", 0);
		}
	}
}

/*
	Name: function_61446ba9
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x1E7180CA
	Offset: 0xCF8
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function function_61446ba9()
{
	if(isdefined(self.var_11b895b8))
	{
		var_2d5dec87 = self.var_11b895b8.var_2d5dec87;
		var_80c3ca2 = self.var_11b895b8.var_80c3ca2;
		self.var_11b895b8 = undefined;
		weapon = zm_weapons::weapondata_give(var_2d5dec87);
	}
}

