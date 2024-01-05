// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_bgb_phoenix_up;

/*
	Name: __init__system__
	Namespace: zm_bgb_phoenix_up
	Checksum: 0x2AA8148A
	Offset: 0xC8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_phoenix_up", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_phoenix_up
	Checksum: 0xA010F53E
	Offset: 0x118
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_phoenix_up", "activated", 1, undefined, undefined, &validation, &activation);
	bgb::register_lost_perk_override(#"zm_bgb_phoenix_up", &lost_perk_override, 1);
}

/*
	Name: validation
	Namespace: zm_bgb_phoenix_up
	Checksum: 0x32764BF1
	Offset: 0x1D0
	Size: 0x10A
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	players = level.players;
	foreach(player in players)
	{
		if(isdefined(player.var_bdeb0f02) && player.var_bdeb0f02)
		{
			return false;
		}
		if(isdefined(level.var_7d8a0369) && self [[level.var_7d8a0369]](player, 1, 1))
		{
			return true;
		}
		if(self zm_laststand::can_revive(player, 1, 1))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: activation
	Namespace: zm_bgb_phoenix_up
	Checksum: 0xA55BC942
	Offset: 0x2E8
	Size: 0x170
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	playsoundatposition(#"zmb_bgb_phoenix_activate", (0, 0, 0));
	players = level.players;
	foreach(player in players)
	{
		can_revive = 0;
		if(isdefined(level.var_7d8a0369) && self [[level.var_7d8a0369]](player, 1, 1))
		{
			can_revive = 1;
		}
		else if(self zm_laststand::can_revive(player, 1, 1))
		{
			can_revive = 1;
		}
		if(can_revive)
		{
			player thread bgb::bgb_revive_watcher();
			player zm_laststand::auto_revive(self);
			self zm_stats::increment_challenge_stat(#"gum_gobbler_phoenix_up");
		}
	}
}

/*
	Name: lost_perk_override
	Namespace: zm_bgb_phoenix_up
	Checksum: 0x5C8421BC
	Offset: 0x460
	Size: 0x66
	Parameters: 3
	Flags: Linked
*/
function lost_perk_override(perk, var_a83ac70f = undefined, var_6c1b825d = undefined)
{
	self thread zm_perks::function_b2dfd295(perk, &bgb::function_bd839f2c);
	return false;
}

