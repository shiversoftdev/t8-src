// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_powerups.csc;

#namespace zm_powerup_bonfire_sale;

/*
	Name: __init__system__
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0xCCD42947
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_powerup_bonfire_sale", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0xBD945E3F
	Offset: 0xF0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::include_zombie_powerup("bonfire_sale");
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("bonfire_sale", "powerup_bon_fire");
	}
}
