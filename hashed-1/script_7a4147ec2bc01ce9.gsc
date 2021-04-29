// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;

#namespace zm_bgb_power_keg;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_power_keg
	Checksum: 0x479C0B0D
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_bgb_power_keg", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_power_keg
	Checksum: 0xA3548BC8
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
	bgb::register(#"zm_bgb_power_keg", "activated", 1, undefined, undefined, &validation, &activation);
}

/*
	Name: activation
	Namespace: zm_bgb_power_keg
	Checksum: 0x7FBCA705
	Offset: 0x168
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self thread bgb::function_c6cd71d5("hero_weapon_power", undefined, 96);
}

/*
	Name: validation
	Namespace: zm_bgb_power_keg
	Checksum: 0xF8B6BF29
	Offset: 0x198
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	return self bgb::function_9d8118f5();
}

