// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;

#namespace namespace_25a84595;

/*
	Name: function_89f2df9
	Namespace: namespace_25a84595
	Checksum: 0xE6068022
	Offset: 0xB8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_465c22731c18755c", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: namespace_25a84595
	Checksum: 0xA8982B72
	Offset: 0x108
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"hash_465c22731c18755c", "activated", 1, undefined, undefined, &function_fe4e9412, &activation);
}

/*
	Name: activation
	Namespace: namespace_25a84595
	Checksum: 0x7F7822A7
	Offset: 0x188
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self thread bgb::function_c6cd71d5("bonfire_sale", undefined, 96);
}

/*
	Name: function_fe4e9412
	Namespace: namespace_25a84595
	Checksum: 0x76B5CBBE
	Offset: 0x1B8
	Size: 0x9A
	Parameters: 0
	Flags: Linked
*/
function function_fe4e9412()
{
	if(!level flag::get("pap_machine_active") || zombie_utility::function_d2dfacfd(#"zombie_powerup_bonfire_sale_on") === 1 || (isdefined(level.var_56cb3d3a) && level.var_56cb3d3a) || !self bgb::function_9d8118f5())
	{
		return 0;
	}
	return 1;
}

