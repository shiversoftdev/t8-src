// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace namespace_34a41f6b;

/*
	Name: function_89f2df9
	Namespace: namespace_34a41f6b
	Checksum: 0xE9377090
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5393b5cb8b30a8ef", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_34a41f6b
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
	Namespace: namespace_34a41f6b
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
		zm_perks::register_perk_basic_info(#"hash_66e6fbe3cc2aff65", #"hash_5952e08594e632f7", 1500, #"hash_7db4db936bc2abe6", getweapon("zombie_perk_bottle_mystery"), getweapon("zombie_perk_vapor_juggernaut"), #"hash_179ae09979e80714");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"hash_66e6fbe3cc2aff65", #"hash_5952e08594e632f7", 1500, #"hash_66729a440fb1a452", getweapon("zombie_perk_bottle_mystery"), getweapon("zombie_perk_vapor_juggernaut"), #"hash_179ae09979e80714");
	}
	zm_perks::function_7f42e14e(#"hash_23c63c9a3acb397", "perk_mod_mystery", #"hash_5952e08594e632f7", #"hash_66e6fbe3cc2aff65", 2500);
}

