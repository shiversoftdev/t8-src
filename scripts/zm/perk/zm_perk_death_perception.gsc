// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace zm_perk_death_perception;

/*
	Name: __init__system__
	Namespace: zm_perk_death_perception
	Checksum: 0x831764C8
	Offset: 0x178
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_death_perception", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_death_perception
	Checksum: 0xD77F1669
	Offset: 0x1C8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_death_perception_perk_for_level();
}

/*
	Name: __main__
	Namespace: zm_perk_death_perception
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
	Name: enable_death_perception_perk_for_level
	Namespace: zm_perk_death_perception
	Checksum: 0x6234173C
	Offset: 0x1F8
	Size: 0x23C
	Parameters: 0
	Flags: Linked
*/
function enable_death_perception_perk_for_level()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"specialty_awareness", #"perk_death_perception", 2000, #"hash_237b1e920f98800b", getweapon("zombie_perk_bottle_death_perception"), getweapon("zombie_perk_totem_death_perception"), #"zmperksdeathperception");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"specialty_awareness", #"perk_death_perception", 2000, #"hash_44056ea72a6d4fd5", getweapon("zombie_perk_bottle_death_perception"), getweapon("zombie_perk_totem_death_perception"), #"zmperksdeathperception");
	}
	zm_perks::register_perk_precache_func(#"specialty_awareness", &function_f9d745da);
	zm_perks::register_perk_clientfields(#"specialty_awareness", &function_14ab8b5c, &function_a19424cd);
	zm_perks::register_perk_machine(#"specialty_awareness", &function_6bdb193c, &function_9b484511);
	zm_perks::register_perk_host_migration_params(#"specialty_awareness", "p7_zm_vending_nuke", "divetonuke_light");
	zm_perks::register_perk_threads(#"specialty_awareness", &function_79d54e51, &function_86a6368e);
}

/*
	Name: function_9b484511
	Namespace: zm_perk_death_perception
	Checksum: 0x80F724D1
	Offset: 0x440
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_9b484511()
{
}

/*
	Name: function_f9d745da
	Namespace: zm_perk_death_perception
	Checksum: 0x6D04443F
	Offset: 0x450
	Size: 0xBE
	Parameters: 0
	Flags: Linked
*/
function function_f9d745da()
{
	level.machine_assets[#"specialty_awareness"] = spawnstruct();
	level.machine_assets[#"specialty_awareness"].weapon = getweapon("zombie_perk_bottle_death_perception");
	level.machine_assets[#"specialty_awareness"].off_model = "p7_zm_vending_nuke";
	level.machine_assets[#"specialty_awareness"].on_model = "p7_zm_vending_nuke";
}

/*
	Name: function_14ab8b5c
	Namespace: zm_perk_death_perception
	Checksum: 0x257C8E4D
	Offset: 0x518
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_14ab8b5c()
{
	clientfield::register("toplayer", "perk_death_perception_visuals", 1, 1, "int");
}

/*
	Name: function_a19424cd
	Namespace: zm_perk_death_perception
	Checksum: 0xBD453FA6
	Offset: 0x558
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_a19424cd(state)
{
}

/*
	Name: function_6bdb193c
	Namespace: zm_perk_death_perception
	Checksum: 0xA227D54C
	Offset: 0x570
	Size: 0xB6
	Parameters: 4
	Flags: Linked
*/
function function_6bdb193c(use_trigger, perk_machine, bump_trigger, collision)
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
	Name: function_79d54e51
	Namespace: zm_perk_death_perception
	Checksum: 0x262F20F5
	Offset: 0x630
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_79d54e51()
{
	self clientfield::set_to_player("perk_death_perception_visuals", 1);
}

/*
	Name: function_86a6368e
	Namespace: zm_perk_death_perception
	Checksum: 0xBEA11A1A
	Offset: 0x660
	Size: 0x44
	Parameters: 4
	Flags: Linked
*/
function function_86a6368e(b_pause, str_perk, str_result, n_slot)
{
	self clientfield::set_to_player("perk_death_perception_visuals", 0);
}

