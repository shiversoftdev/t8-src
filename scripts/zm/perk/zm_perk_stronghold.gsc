// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_armor.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\core_common\player\player_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

#namespace zm_perk_stronghold;

/*
	Name: __init__system__
	Namespace: zm_perk_stronghold
	Checksum: 0xF85C4923
	Offset: 0x1A0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_stronghold", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_stronghold
	Checksum: 0x7E854E83
	Offset: 0x1F0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_stronghold_perk_for_level();
	zm_armor::register(#"stronghold_armor", 0);
}

/*
	Name: __main__
	Namespace: zm_perk_stronghold
	Checksum: 0x80F724D1
	Offset: 0x230
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: enable_stronghold_perk_for_level
	Namespace: zm_perk_stronghold
	Checksum: 0x6CB78A41
	Offset: 0x240
	Size: 0x23C
	Parameters: 0
	Flags: Linked
*/
function enable_stronghold_perk_for_level()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"specialty_camper", #"perk_stronghold", 2500, #"hash_cd87686e9c80e75", getweapon("zombie_perk_bottle_stronghold"), getweapon("zombie_perk_totem_stronghold"), #"hash_5690c4dcc61973ec");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"specialty_camper", #"perk_stronghold", 2500, #"zombie/perk_stronghold", getweapon("zombie_perk_bottle_stronghold"), getweapon("zombie_perk_totem_stronghold"), #"hash_5690c4dcc61973ec");
	}
	zm_perks::register_perk_precache_func(#"specialty_camper", &function_e03779ee);
	zm_perks::register_perk_clientfields(#"specialty_camper", &function_356a31cb, &function_721cc6dc);
	zm_perks::register_perk_machine(#"specialty_camper", &function_f15d3355, &init_stronghold);
	zm_perks::register_perk_threads(#"specialty_camper", &function_1dd08a86, &function_9a3871b7);
	zm_perks::register_actor_damage_override(#"specialty_camper", &function_11154900);
}

/*
	Name: init_stronghold
	Namespace: zm_perk_stronghold
	Checksum: 0x80F724D1
	Offset: 0x488
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function init_stronghold()
{
}

/*
	Name: function_e03779ee
	Namespace: zm_perk_stronghold
	Checksum: 0xC251B800
	Offset: 0x498
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function function_e03779ee()
{
	if(isdefined(level.var_a51702ef))
	{
		[[level.var_a51702ef]]();
		return;
	}
	level._effect[#"divetonuke_light"] = #"hash_2225287695ddf9c9";
	level.machine_assets[#"specialty_camper"] = spawnstruct();
	level.machine_assets[#"specialty_camper"].weapon = getweapon("zombie_perk_bottle_stronghold");
	level.machine_assets[#"specialty_camper"].off_model = "p7_zm_vending_nuke";
	level.machine_assets[#"specialty_camper"].on_model = "p7_zm_vending_nuke";
}

/*
	Name: function_356a31cb
	Namespace: zm_perk_stronghold
	Checksum: 0xE5D75B42
	Offset: 0x5B0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_356a31cb()
{
	clientfield::register("toplayer", "" + #"hash_24e322568c9492c5", 1, 1, "int");
}

/*
	Name: function_721cc6dc
	Namespace: zm_perk_stronghold
	Checksum: 0xFF41F720
	Offset: 0x600
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_721cc6dc(state)
{
}

/*
	Name: function_f15d3355
	Namespace: zm_perk_stronghold
	Checksum: 0x4462D83A
	Offset: 0x618
	Size: 0xB6
	Parameters: 4
	Flags: Linked
*/
function function_f15d3355(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_phd_jingle";
	use_trigger.script_string = "divetonuke_perk";
	use_trigger.script_label = "mus_perks_phd_sting";
	use_trigger.target = "vending_divetonuke";
	perk_machine.script_string = "divetonuke_perk";
	perk_machine.targetname = "vending_divetonuke";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "divetonuke_perk";
	}
}

/*
	Name: function_1dd08a86
	Namespace: zm_perk_stronghold
	Checksum: 0xF0BCC693
	Offset: 0x6D8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_1dd08a86()
{
	self thread function_7424eebb();
}

/*
	Name: function_9a3871b7
	Namespace: zm_perk_stronghold
	Checksum: 0x29FBB24B
	Offset: 0x700
	Size: 0x54
	Parameters: 4
	Flags: Linked
*/
function function_9a3871b7(b_pause, str_perk, str_result, n_slot)
{
	self notify(#"specialty_camper" + "_take");
	self function_7b5fc171();
}

/*
	Name: function_7424eebb
	Namespace: zm_perk_stronghold
	Checksum: 0xBDDDC9C6
	Offset: 0x760
	Size: 0x1E8
	Parameters: 0
	Flags: Linked
*/
function function_7424eebb()
{
	self endon(#"specialty_camper" + "_take", #"disconnect");
	while(true)
	{
		if(!self laststand::player_is_in_laststand() && !self util::is_spectating() && !level flag::get("round_reset"))
		{
			v_current = self.origin;
			if(!isdefined(self.var_3748ec02))
			{
				self.var_3748ec02 = v_current;
			}
			n_dist = distance(self.var_3748ec02, v_current);
			if(n_dist <= 65 && (!(isdefined(self.var_7d0e99f3) && self.var_7d0e99f3)) || (n_dist <= 130 && (isdefined(self.var_7d0e99f3) && self.var_7d0e99f3)) && (!(isdefined(self.var_16735873) && self.var_16735873)) && !scene::is_igc_active())
			{
				if(!isdefined(self.var_7ffce6e0))
				{
					self.var_7ffce6e0 = 0;
				}
				self.var_7ffce6e0++;
				self thread function_a84fcb78(self.var_7ffce6e0);
			}
			else
			{
				self function_7b5fc171();
			}
		}
		else
		{
			self function_7b5fc171();
		}
		wait(0.25);
	}
}

/*
	Name: function_7b5fc171
	Namespace: zm_perk_stronghold
	Checksum: 0x7B16F7DF
	Offset: 0x950
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function function_7b5fc171()
{
	self clientfield::set_to_player("" + #"hash_24e322568c9492c5", 0);
	self zm_armor::remove(#"stronghold_armor", 1);
	self.var_3748ec02 = undefined;
	self.var_807f94d7 = undefined;
	self.var_7ffce6e0 = undefined;
	self.var_7d0e99f3 = undefined;
}

/*
	Name: function_a84fcb78
	Namespace: zm_perk_stronghold
	Checksum: 0x7875B35F
	Offset: 0x9D0
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_a84fcb78(var_3a553e99)
{
	var_cf385861 = int(3 / 0.25);
	if(var_3a553e99 == var_cf385861)
	{
		self.var_7d0e99f3 = 1;
		self.var_3748ec02 = self.origin;
		self clientfield::set_to_player("" + #"hash_24e322568c9492c5", 1);
	}
	if((var_3a553e99 % var_cf385861) == 0)
	{
		self add_armor();
		self function_c25b980c();
	}
}

/*
	Name: add_armor
	Namespace: zm_perk_stronghold
	Checksum: 0x18AF00EA
	Offset: 0xAB0
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function add_armor()
{
	self zm_armor::add(#"stronghold_armor", 5, 50, #"");
}

/*
	Name: function_c25b980c
	Namespace: zm_perk_stronghold
	Checksum: 0xE7F3C346
	Offset: 0xAF8
	Size: 0x5A
	Parameters: 0
	Flags: Linked
*/
function function_c25b980c()
{
	if(!isdefined(self.var_807f94d7))
	{
		self.var_807f94d7 = 0;
	}
	self.var_807f94d7 = self.var_807f94d7 + 1;
	self.var_807f94d7 = math::clamp(self.var_807f94d7, 0, 15);
}

/*
	Name: function_11154900
	Namespace: zm_perk_stronghold
	Checksum: 0x8F4A6873
	Offset: 0xB60
	Size: 0x98
	Parameters: 12
	Flags: Linked
*/
function function_11154900(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isdefined(attacker.var_807f94d7))
	{
		damage = damage + (damage * (attacker.var_807f94d7 / 100));
	}
	return damage;
}

