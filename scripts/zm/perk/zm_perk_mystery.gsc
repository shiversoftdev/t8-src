// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_perks.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

#namespace zm_perk_mystery;

/*
	Name: __init__system__
	Namespace: zm_perk_mystery
	Checksum: 0xE9377090
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mystery", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mystery
	Checksum: 0x34C97978
	Offset: 0x118
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_27473e44();
}

/*
	Name: function_27473e44
	Namespace: zm_perk_mystery
	Checksum: 0x975F7CDF
	Offset: 0x138
	Size: 0x16C
	Parameters: 0
	Flags: Linked
*/
function function_27473e44()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"specialty_mystery", #"perk_mystery", 1500, #"hash_7db4db936bc2abe6", getweapon("zombie_perk_bottle_mystery"), getweapon("zombie_perk_vapor_juggernaut"), #"zmperkssecretsauce");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"specialty_mystery", #"perk_mystery", 1500, #"zombie/perk_mystery", getweapon("zombie_perk_bottle_mystery"), getweapon("zombie_perk_vapor_juggernaut"), #"zmperkssecretsauce");
	}
	zm_perks::register_perk_mod_basic_info(#"hash_23c63c9a3acb397", "perk_mod_mystery", #"perk_mystery", #"specialty_mystery", 2500);
}

