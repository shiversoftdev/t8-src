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

#namespace zm_perk_deadshot;

/*
	Name: function_89f2df9
	Namespace: zm_perk_deadshot
	Checksum: 0xE5D62835
	Offset: 0x198
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_perk_deadshot", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_deadshot
	Checksum: 0xEE6DF852
	Offset: 0x1E0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_deadshot_perk_for_level();
}

/*
	Name: enable_deadshot_perk_for_level
	Namespace: zm_perk_deadshot
	Checksum: 0x10E40B07
	Offset: 0x200
	Size: 0x22C
	Parameters: 0
	Flags: Linked
*/
function enable_deadshot_perk_for_level()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"specialty_deadshot", #"perk_dead_shot", 2000, #"hash_29881d32839ebaa1", getweapon("zombie_perk_bottle_deadshot"), getweapon("zombie_perk_totem_deadshot"), #"hash_26407356b81a1957");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"specialty_deadshot", #"perk_dead_shot", 2000, #"hash_3ac784b3888e0dab", getweapon("zombie_perk_bottle_deadshot"), getweapon("zombie_perk_totem_deadshot"), #"hash_26407356b81a1957");
	}
	zm_perks::register_perk_precache_func(#"specialty_deadshot", &deadshot_precache);
	zm_perks::register_perk_clientfields(#"specialty_deadshot", &deadshot_register_clientfield, &deadshot_set_clientfield);
	zm_perks::register_perk_machine(#"specialty_deadshot", &deadshot_perk_machine_setup);
	zm_perks::register_perk_threads(#"specialty_deadshot", &give_deadshot_perk, &take_deadshot_perk);
	zm_perks::register_perk_host_migration_params(#"specialty_deadshot", "vending_deadshot", "deadshot_light");
}

/*
	Name: deadshot_precache
	Namespace: zm_perk_deadshot
	Checksum: 0xA86E0D55
	Offset: 0x438
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function deadshot_precache()
{
	if(isdefined(level.deadshot_precache_override_func))
	{
		[[level.deadshot_precache_override_func]]();
		return;
	}
	level._effect[#"deadshot_light"] = #"hash_2225287695ddf9c9";
	level.machine_assets[#"specialty_deadshot"] = spawnstruct();
	level.machine_assets[#"specialty_deadshot"].weapon = getweapon("zombie_perk_bottle_deadshot");
	level.machine_assets[#"specialty_deadshot"].off_model = "p7_zm_vending_ads";
	level.machine_assets[#"specialty_deadshot"].on_model = "p7_zm_vending_ads";
}

/*
	Name: deadshot_register_clientfield
	Namespace: zm_perk_deadshot
	Checksum: 0x4553153C
	Offset: 0x550
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function deadshot_register_clientfield()
{
	clientfield::register("toplayer", "deadshot_perk", 1, 1, "int");
}

/*
	Name: deadshot_set_clientfield
	Namespace: zm_perk_deadshot
	Checksum: 0x98B4773D
	Offset: 0x590
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function deadshot_set_clientfield(state)
{
}

/*
	Name: deadshot_perk_machine_setup
	Namespace: zm_perk_deadshot
	Checksum: 0x9669AF76
	Offset: 0x5A8
	Size: 0xB6
	Parameters: 4
	Flags: Linked
*/
function deadshot_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_deadshot_jingle";
	use_trigger.script_string = "deadshot_perk";
	use_trigger.script_label = "mus_perks_deadshot_sting";
	use_trigger.target = "vending_deadshot";
	perk_machine.script_string = "deadshot_vending";
	perk_machine.targetname = "vending_deadshot";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "deadshot_vending";
	}
}

/*
	Name: give_deadshot_perk
	Namespace: zm_perk_deadshot
	Checksum: 0xD7EC959C
	Offset: 0x668
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function give_deadshot_perk()
{
	self clientfield::set_to_player("deadshot_perk", 1);
}

/*
	Name: take_deadshot_perk
	Namespace: zm_perk_deadshot
	Checksum: 0x4FDB25E1
	Offset: 0x698
	Size: 0x44
	Parameters: 4
	Flags: Linked
*/
function take_deadshot_perk(b_pause, str_perk, str_result, n_slot)
{
	self clientfield::set_to_player("deadshot_perk", 0);
}

