// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;

#namespace zm_bgb_immolation_liquidation;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_immolation_liquidation
	Checksum: 0x1E108D55
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_bgb_immolation_liquidation", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_immolation_liquidation
	Checksum: 0x81BFFED4
	Offset: 0xE8
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
	bgb::register(#"zm_bgb_immolation_liquidation", "activated", 1, undefined, undefined, &function_1efaba5e, &activation);
}

/*
	Name: activation
	Namespace: zm_bgb_immolation_liquidation
	Checksum: 0x8A58B5D4
	Offset: 0x168
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self thread bgb::function_c6cd71d5("fire_sale", undefined, 96);
}

/*
	Name: function_1efaba5e
	Namespace: zm_bgb_immolation_liquidation
	Checksum: 0xB9CFC586
	Offset: 0x198
	Size: 0x72
	Parameters: 0
	Flags: Linked
*/
function function_1efaba5e()
{
	if(zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on") === 1 || (isdefined(level.disable_firesale_drop) && level.disable_firesale_drop) || !self bgb::function_9d8118f5())
	{
		return false;
	}
	return true;
}

