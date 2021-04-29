// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace namespace_e1e7cabf;

/*
	Name: function_89f2df9
	Namespace: namespace_e1e7cabf
	Checksum: 0x831764C8
	Offset: 0x178
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_31eaab29298885c6", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_e1e7cabf
	Checksum: 0xD77F1669
	Offset: 0x1C8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_7a04ad0d();
}

/*
	Name: __main__
	Namespace: namespace_e1e7cabf
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
	Name: function_7a04ad0d
	Namespace: namespace_e1e7cabf
	Checksum: 0x6234173C
	Offset: 0x1F8
	Size: 0x23C
	Parameters: 0
	Flags: Linked
*/
function function_7a04ad0d()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"hash_5706909bc1db0f85", #"hash_53548db163b3a77e", 2000, #"hash_237b1e920f98800b", getweapon("zombie_perk_bottle_death_perception"), getweapon("zombie_perk_totem_death_perception"), #"hash_7d2a55a87f693582");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"hash_5706909bc1db0f85", #"hash_53548db163b3a77e", 2000, #"hash_44056ea72a6d4fd5", getweapon("zombie_perk_bottle_death_perception"), getweapon("zombie_perk_totem_death_perception"), #"hash_7d2a55a87f693582");
	}
	zm_perks::register_perk_precache_func(#"hash_5706909bc1db0f85", &function_f9d745da);
	zm_perks::register_perk_clientfields(#"hash_5706909bc1db0f85", &function_14ab8b5c, &function_a19424cd);
	zm_perks::register_perk_machine(#"hash_5706909bc1db0f85", &function_6bdb193c, &function_9b484511);
	zm_perks::register_perk_host_migration_params(#"hash_5706909bc1db0f85", "p7_zm_vending_nuke", "divetonuke_light");
	zm_perks::register_perk_threads(#"hash_5706909bc1db0f85", &function_79d54e51, &function_86a6368e);
}

/*
	Name: function_9b484511
	Namespace: namespace_e1e7cabf
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
	Namespace: namespace_e1e7cabf
	Checksum: 0x6D04443F
	Offset: 0x450
	Size: 0xBE
	Parameters: 0
	Flags: Linked
*/
function function_f9d745da()
{
	level.machine_assets[#"hash_5706909bc1db0f85"] = spawnstruct();
	level.machine_assets[#"hash_5706909bc1db0f85"].weapon = getweapon("zombie_perk_bottle_death_perception");
	level.machine_assets[#"hash_5706909bc1db0f85"].off_model = "p7_zm_vending_nuke";
	level.machine_assets[#"hash_5706909bc1db0f85"].on_model = "p7_zm_vending_nuke";
}

/*
	Name: function_14ab8b5c
	Namespace: namespace_e1e7cabf
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
	Namespace: namespace_e1e7cabf
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
	Namespace: namespace_e1e7cabf
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
	Namespace: namespace_e1e7cabf
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
	Namespace: namespace_e1e7cabf
	Checksum: 0xBEA11A1A
	Offset: 0x660
	Size: 0x44
	Parameters: 4
	Flags: Linked
*/
function function_86a6368e(b_pause, str_perk, str_result, var_bcd1c2ff)
{
	self clientfield::set_to_player("perk_death_perception_visuals", 0);
}

