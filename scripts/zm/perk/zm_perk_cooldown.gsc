// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\zombie_utility.gsc;
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

#namespace zm_perk_cooldown;

/*
	Name: __init__system__
	Namespace: zm_perk_cooldown
	Checksum: 0x37D0CC64
	Offset: 0x178
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_cooldown", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_cooldown
	Checksum: 0x7B7A7177
	Offset: 0x1C8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_cooldown_perk_for_level();
}

/*
	Name: __main__
	Namespace: zm_perk_cooldown
	Checksum: 0x80F724D1
	Offset: 0x1E8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: enable_cooldown_perk_for_level
	Namespace: zm_perk_cooldown
	Checksum: 0x20BD7A96
	Offset: 0x1F8
	Size: 0x23C
	Parameters: 0
	Flags: Linked
*/
function enable_cooldown_perk_for_level()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"specialty_cooldown", #"perk_cooldown", 1500, #"hash_1bf5482d3d2bee30", getweapon("zombie_perk_bottle_cooldown"), getweapon("zombie_perk_totem_timeslip"), #"zmperkscooldown");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"specialty_cooldown", #"perk_cooldown", 1500, #"zombie/perk_cooldown", getweapon("zombie_perk_bottle_cooldown"), getweapon("zombie_perk_totem_timeslip"), #"zmperkscooldown");
	}
	zm_perks::register_perk_precache_func(#"specialty_cooldown", &function_14afd300);
	zm_perks::register_perk_clientfields(#"specialty_cooldown", &function_eaa4f1a1, &function_bfc02d23);
	zm_perks::register_perk_machine(#"specialty_cooldown", &function_cf203b00, &init_cooldown);
	zm_perks::register_perk_host_migration_params(#"specialty_cooldown", "p7_zm_vending_nuke", "divetonuke_light");
	zm_perks::register_perk_threads(#"specialty_cooldown", &function_44cf89d3, &function_d0623d8c);
}

/*
	Name: init_cooldown
	Namespace: zm_perk_cooldown
	Checksum: 0x80F724D1
	Offset: 0x440
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function init_cooldown()
{
}

/*
	Name: function_14afd300
	Namespace: zm_perk_cooldown
	Checksum: 0x5FC47951
	Offset: 0x450
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function function_14afd300()
{
	if(isdefined(level.var_8ba0e035))
	{
		[[level.var_8ba0e035]]();
		return;
	}
	level._effect[#"divetonuke_light"] = #"hash_2225287695ddf9c9";
	level.machine_assets[#"specialty_cooldown"] = spawnstruct();
	level.machine_assets[#"specialty_cooldown"].weapon = getweapon("zombie_perk_bottle_cooldown");
	level.machine_assets[#"specialty_cooldown"].off_model = "p7_zm_vending_nuke";
	level.machine_assets[#"specialty_cooldown"].on_model = "p7_zm_vending_nuke";
}

/*
	Name: function_eaa4f1a1
	Namespace: zm_perk_cooldown
	Checksum: 0x80F724D1
	Offset: 0x568
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_eaa4f1a1()
{
}

/*
	Name: function_bfc02d23
	Namespace: zm_perk_cooldown
	Checksum: 0x2D9D8B63
	Offset: 0x578
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_bfc02d23(state)
{
}

/*
	Name: function_cf203b00
	Namespace: zm_perk_cooldown
	Checksum: 0xF703117C
	Offset: 0x590
	Size: 0xB6
	Parameters: 4
	Flags: Linked
*/
function function_cf203b00(use_trigger, perk_machine, bump_trigger, collision)
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
	Name: function_8ba0e035
	Namespace: zm_perk_cooldown
	Checksum: 0x98F65B8F
	Offset: 0x650
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function function_8ba0e035()
{
	level._effect[#"divetonuke_light"] = #"hash_2225287695ddf9c9";
}

/*
	Name: function_44cf89d3
	Namespace: zm_perk_cooldown
	Checksum: 0x80F724D1
	Offset: 0x690
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_44cf89d3()
{
}

/*
	Name: function_d0623d8c
	Namespace: zm_perk_cooldown
	Checksum: 0x2A783576
	Offset: 0x6A0
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function function_d0623d8c(b_pause, str_perk, str_result, n_slot)
{
}

