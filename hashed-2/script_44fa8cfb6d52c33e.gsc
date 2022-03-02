// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_powerups.csc;

#namespace zm_powerup_double_points;

/*
	Name: function_89f2df9
	Namespace: zm_powerup_double_points
	Checksum: 0xBB265338
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_powerup_double_points", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_double_points
	Checksum: 0xC4457043
	Offset: 0xF0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::include_zombie_powerup("double_points");
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("double_points", "powerup_double_points");
	}
}

