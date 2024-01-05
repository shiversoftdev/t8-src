// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\ai\zombie_death.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_powerup_shield_charge;

/*
	Name: __init__system__
	Namespace: zm_powerup_shield_charge
	Checksum: 0x8EA1B145
	Offset: 0x128
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
	Checksum: 0x3288D9B7
	Offset: 0x170
	Size: 0xB4
	Parameters: 0
	Flags: None
*/
function __init__()
{
	zm_powerups::register_powerup("shield_charge", &grab_shield_charge);
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("shield_charge", "p7_zm_zod_nitrous_tank", #"hash_3f5e4aa38f9aeba5", &func_drop_when_players_own, 1, 0, 0);
		zm_powerups::powerup_set_statless_powerup("shield_charge");
	}
	/#
		thread shield_devgui();
	#/
}

/*
	Name: func_drop_when_players_own
	Namespace: zm_powerup_shield_charge
	Checksum: 0x9C45CCE1
	Offset: 0x230
	Size: 0x6
	Parameters: 0
	Flags: None
*/
function func_drop_when_players_own()
{
	return false;
}

/*
	Name: grab_shield_charge
	Namespace: zm_powerup_shield_charge
	Checksum: 0xFC544DC0
	Offset: 0x240
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function grab_shield_charge(player)
{
	level thread shield_charge_powerup(self, player);
}

/*
	Name: shield_charge_powerup
	Namespace: zm_powerup_shield_charge
	Checksum: 0x6B11869E
	Offset: 0x270
	Size: 0x74
	Parameters: 2
	Flags: None
*/
function shield_charge_powerup(item, player)
{
	if(isdefined(player.hasriotshield) && player.hasriotshield)
	{
		player givestartammo(player.weaponriotshield);
	}
	level thread shield_on_hud(item, player.team);
}

/*
	Name: shield_on_hud
	Namespace: zm_powerup_shield_charge
	Checksum: 0xB6498025
	Offset: 0x2F0
	Size: 0x13C
	Parameters: 2
	Flags: None
*/
function shield_on_hud(drop_item, player_team)
{
	/#
		self endon(#"disconnect");
		hudelem = hud::function_f5a689d("", 2);
		hudelem hud::setpoint("", undefined, 0, zombie_utility::function_d2dfacfd(#"zombie_timer_offset") - (zombie_utility::function_d2dfacfd(#"zombie_timer_offset_interval") * 2));
		hudelem.sort = 0.5;
		hudelem.alpha = 0;
		hudelem fadeovertime(0.5);
		hudelem.alpha = 1;
		if(isdefined(drop_item))
		{
			hudelem.label = drop_item.hint;
		}
		hudelem thread full_ammo_move_hud(player_team);
	#/
}

/*
	Name: full_ammo_move_hud
	Namespace: zm_powerup_shield_charge
	Checksum: 0x3774E09D
	Offset: 0x438
	Size: 0xD4
	Parameters: 1
	Flags: None
*/
function full_ammo_move_hud(player_team)
{
	/#
		players = getplayers(player_team);
		players[0] playsoundtoteam("", player_team);
		wait(0.5);
		move_fade_time = 1.5;
		self fadeovertime(move_fade_time);
		self moveovertime(move_fade_time);
		self.y = 270;
		self.alpha = 0;
		wait(move_fade_time);
		self destroy();
	#/
}

/*
	Name: shield_devgui
	Namespace: zm_powerup_shield_charge
	Checksum: 0x90F8231F
	Offset: 0x518
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function shield_devgui()
{
	/#
		level flagsys::wait_till("");
		wait(1);
		zm_devgui::add_custom_devgui_callback(&shield_devgui_callback);
		adddebugcommand("");
		adddebugcommand("");
	#/
}

/*
	Name: shield_devgui_callback
	Namespace: zm_powerup_shield_charge
	Checksum: 0xF02270A
	Offset: 0x5A0
	Size: 0xC6
	Parameters: 1
	Flags: None
*/
function shield_devgui_callback(cmd)
{
	/#
		players = getplayers();
		retval = 0;
		switch(cmd)
		{
			case "shield_charge":
			{
				zm_devgui::zombie_devgui_give_powerup(cmd, 1);
				break;
			}
			case "next_shield_charge":
			{
				zm_devgui::zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
				break;
			}
		}
		return retval;
	#/
}

