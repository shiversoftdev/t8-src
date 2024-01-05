// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_powerups.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\struct.csc;

#namespace zm_powerup_full_ammo;

/*
	Name: __init__system__
	Namespace: zm_powerup_full_ammo
	Checksum: 0x47759EC8
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_powerup_full_ammo", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_full_ammo
	Checksum: 0x3407BE70
	Offset: 0xD8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::include_zombie_powerup("full_ammo");
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("full_ammo");
	}
}

