// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_perk_staminup;

/*
	Name: function_89f2df9
	Namespace: zm_perk_staminup
	Checksum: 0xFC9E3120
	Offset: 0x198
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_perk_staminup", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_staminup
	Checksum: 0xD6BE5F95
	Offset: 0x1E0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_staminup_perk_for_level();
}

/*
	Name: enable_staminup_perk_for_level
	Namespace: zm_perk_staminup
	Checksum: 0x1DBA9ADD
	Offset: 0x200
	Size: 0x1EC
	Parameters: 0
	Flags: Linked
*/
function enable_staminup_perk_for_level()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"specialty_staminup", #"perk_staminup", 2000, #"hash_26af21c3b4413875", getweapon("zombie_perk_bottle_marathon"), getweapon("zombie_perk_totem_staminup"), #"hash_3a15ddcc25d689f6");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"specialty_staminup", #"perk_staminup", 2000, #"hash_7ef29d7842460907", getweapon("zombie_perk_bottle_marathon"), getweapon("zombie_perk_totem_staminup"), #"hash_3a15ddcc25d689f6");
	}
	zm_perks::register_perk_precache_func(#"specialty_staminup", &staminup_precache);
	zm_perks::register_perk_clientfields(#"specialty_staminup", &staminup_register_clientfield, &staminup_set_clientfield);
	zm_perks::register_perk_machine(#"specialty_staminup", &staminup_perk_machine_setup);
	zm_perks::register_perk_host_migration_params(#"specialty_staminup", "vending_marathon", "marathon_light");
}

/*
	Name: staminup_precache
	Namespace: zm_perk_staminup
	Checksum: 0x18C16E5B
	Offset: 0x3F8
	Size: 0x106
	Parameters: 0
	Flags: Linked
*/
function staminup_precache()
{
	if(isdefined(level.staminup_precache_override_func))
	{
		[[level.staminup_precache_override_func]]();
		return;
	}
	level._effect[#"marathon_light"] = "zombie/fx_perk_stamin_up_zmb";
	level.machine_assets[#"specialty_staminup"] = spawnstruct();
	level.machine_assets[#"specialty_staminup"].weapon = getweapon("zombie_perk_bottle_marathon");
	level.machine_assets[#"specialty_staminup"].off_model = "p7_zm_vending_marathon";
	level.machine_assets[#"specialty_staminup"].on_model = "p7_zm_vending_marathon";
}

/*
	Name: staminup_register_clientfield
	Namespace: zm_perk_staminup
	Checksum: 0x80F724D1
	Offset: 0x508
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function staminup_register_clientfield()
{
}

/*
	Name: staminup_set_clientfield
	Namespace: zm_perk_staminup
	Checksum: 0x81D75C1E
	Offset: 0x518
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function staminup_set_clientfield(state)
{
}

/*
	Name: staminup_perk_machine_setup
	Namespace: zm_perk_staminup
	Checksum: 0xACE3498B
	Offset: 0x530
	Size: 0xB6
	Parameters: 4
	Flags: Linked
*/
function staminup_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_stamin_jingle";
	use_trigger.script_string = "marathon_perk";
	use_trigger.script_label = "mus_perks_stamin_sting";
	use_trigger.target = "vending_marathon";
	perk_machine.script_string = "marathon_perk";
	perk_machine.targetname = "vending_marathon";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "marathon_perk";
	}
}

