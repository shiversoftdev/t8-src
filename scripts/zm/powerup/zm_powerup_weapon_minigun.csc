// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_powerups.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\struct.csc;

#namespace zm_powerup_weapon_minigun;

/*
	Name: __init__system__
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x925B4749
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_powerup_weapon_minigun", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_weapon_minigun
	Checksum: 0x2D137B4E
	Offset: 0xE8
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	zm_powerups::include_zombie_powerup("minigun");
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("minigun", "powerup_mini_gun");
	}
}

