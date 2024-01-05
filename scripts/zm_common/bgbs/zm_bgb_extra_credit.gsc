// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_bgb_extra_credit;

/*
	Name: __init__system__
	Namespace: zm_bgb_extra_credit
	Checksum: 0x1F391117
	Offset: 0xB0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_extra_credit", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_extra_credit
	Checksum: 0x9D869B9
	Offset: 0x100
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
	bgb::register(#"zm_bgb_extra_credit", "activated", 1, undefined, undefined, &validation, &activation);
}

/*
	Name: activation
	Namespace: zm_bgb_extra_credit
	Checksum: 0x3345D61F
	Offset: 0x180
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	powerup_origin = self bgb::get_player_dropped_powerup_origin();
	self thread function_22f934e6(powerup_origin, 96);
}

/*
	Name: function_22f934e6
	Namespace: zm_bgb_extra_credit
	Checksum: 0xE173578C
	Offset: 0x1D0
	Size: 0xB6
	Parameters: 2
	Flags: Linked
*/
function function_22f934e6(origin, var_22a4c702)
{
	self endon(#"disconnect", #"bled_out");
	e_powerup = zm_powerups::specific_powerup_drop("bonus_points_player", origin, undefined, 0.1, undefined, undefined, 1, 1, 1, 1);
	if(isdefined(level.var_5a2df97b))
	{
		e_powerup thread [[level.var_5a2df97b]]();
	}
	e_powerup.bonus_points_powerup_override = &function_19e7d278;
}

/*
	Name: function_19e7d278
	Namespace: zm_bgb_extra_credit
	Checksum: 0xBCAEE8D0
	Offset: 0x290
	Size: 0x10
	Parameters: 1
	Flags: Linked
*/
function function_19e7d278(player)
{
	return 1250;
}

/*
	Name: validation
	Namespace: zm_bgb_extra_credit
	Checksum: 0x2C9529C2
	Offset: 0x2A8
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	return self bgb::function_9d8118f5();
}

