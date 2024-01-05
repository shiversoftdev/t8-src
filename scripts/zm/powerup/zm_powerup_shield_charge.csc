// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_powerups.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\struct.csc;

#namespace zm_powerup_shield_charge;

/*
	Name: __init__system__
	Namespace: zm_powerup_shield_charge
	Checksum: 0x39231A08
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_powerup_shield_charge", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_shield_charge
	Checksum: 0x2AE5030E
	Offset: 0xD8
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function __init__()
{
	zm_powerups::include_zombie_powerup("shield_charge");
	zm_powerups::add_zombie_powerup("shield_charge");
}

