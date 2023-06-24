// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_powerups.csc;

#namespace zm_powerup_hero_weapon_power;

/*
	Name: __init__system__
	Namespace: zm_powerup_hero_weapon_power
	Checksum: 0xCF6BFDC
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_powerup_hero_weapon_power", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_hero_weapon_power
	Checksum: 0x6B30E786
	Offset: 0xE0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::include_zombie_powerup("hero_weapon_power");
	zm_powerups::add_zombie_powerup("hero_weapon_power");
}

