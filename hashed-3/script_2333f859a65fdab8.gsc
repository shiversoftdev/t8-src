// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
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

#namespace namespace_4a218d9b;

/*
	Name: function_89f2df9
	Namespace: namespace_4a218d9b
	Checksum: 0x37D0CC64
	Offset: 0x178
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_186f6603cca1bed7", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_4a218d9b
	Checksum: 0x7B7A7177
	Offset: 0x1C8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_482ec336();
}

/*
	Name: __main__
	Namespace: namespace_4a218d9b
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
	Name: function_482ec336
	Namespace: namespace_4a218d9b
	Checksum: 0x20BD7A96
	Offset: 0x1F8
	Size: 0x23C
	Parameters: 0
	Flags: Linked
*/
function function_482ec336()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"hash_37aa3a5919757781", #"hash_69fcf7d746edeeaf", 1500, #"hash_1bf5482d3d2bee30", getweapon("zombie_perk_bottle_cooldown"), getweapon("zombie_perk_totem_timeslip"), #"hash_1e9fb2463e6eee58");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"hash_37aa3a5919757781", #"hash_69fcf7d746edeeaf", 1500, #"hash_69b90ae1434aa7bc", getweapon("zombie_perk_bottle_cooldown"), getweapon("zombie_perk_totem_timeslip"), #"hash_1e9fb2463e6eee58");
	}
	zm_perks::register_perk_precache_func(#"hash_37aa3a5919757781", &function_14afd300);
	zm_perks::register_perk_clientfields(#"hash_37aa3a5919757781", &function_eaa4f1a1, &function_bfc02d23);
	zm_perks::register_perk_machine(#"hash_37aa3a5919757781", &function_cf203b00, &function_a2d341cc);
	zm_perks::register_perk_host_migration_params(#"hash_37aa3a5919757781", "p7_zm_vending_nuke", "divetonuke_light");
	zm_perks::register_perk_threads(#"hash_37aa3a5919757781", &function_44cf89d3, &function_d0623d8c);
}

/*
	Name: function_a2d341cc
	Namespace: namespace_4a218d9b
	Checksum: 0x80F724D1
	Offset: 0x440
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_a2d341cc()
{
}

/*
	Name: function_14afd300
	Namespace: namespace_4a218d9b
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
	level.machine_assets[#"hash_37aa3a5919757781"] = spawnstruct();
	level.machine_assets[#"hash_37aa3a5919757781"].weapon = getweapon("zombie_perk_bottle_cooldown");
	level.machine_assets[#"hash_37aa3a5919757781"].off_model = "p7_zm_vending_nuke";
	level.machine_assets[#"hash_37aa3a5919757781"].on_model = "p7_zm_vending_nuke";
}

/*
	Name: function_eaa4f1a1
	Namespace: namespace_4a218d9b
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
	Namespace: namespace_4a218d9b
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
	Namespace: namespace_4a218d9b
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
	Namespace: namespace_4a218d9b
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
	Namespace: namespace_4a218d9b
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
	Namespace: namespace_4a218d9b
	Checksum: 0x2A783576
	Offset: 0x6A0
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function function_d0623d8c(b_pause, str_perk, str_result, var_bcd1c2ff)
{
}

