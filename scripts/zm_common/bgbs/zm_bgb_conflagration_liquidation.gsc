// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\flag_shared.gsc;

#namespace zm_bgb_conflagration_liquidation;

/*
	Name: __init__system__
	Namespace: zm_bgb_conflagration_liquidation
	Checksum: 0xE6068022
	Offset: 0xB8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_conflagration_liquidation", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_conflagration_liquidation
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
	bgb::register(#"zm_bgb_conflagration_liquidation", "activated", 1, undefined, undefined, &function_fe4e9412, &activation);
}

/*
	Name: activation
	Namespace: zm_bgb_conflagration_liquidation
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
	Namespace: zm_bgb_conflagration_liquidation
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
		return false;
	}
	return true;
}

