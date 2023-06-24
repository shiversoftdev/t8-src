// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\killstreaks\killstreaks_util.gsc;
#using scripts\killstreaks\killstreaks_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace globallogic_player;

/*
	Name: __init__system__
	Namespace: globallogic_player
	Checksum: 0xE6B25151
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"globallogic_player", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: globallogic_player
	Checksum: 0x3FCA48AD
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_aadc08f8 = &function_4b7bb02c;
	callback::on_disconnect(&on_player_disconnect);
}

/*
	Name: function_4b7bb02c
	Namespace: globallogic_player
	Checksum: 0x5F35817D
	Offset: 0x118
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function function_4b7bb02c(weapon)
{
	if(!killstreaks::is_killstreak_weapon(weapon))
	{
		return true;
	}
	if(killstreaks::is_killstreak_weapon_assist_allowed(weapon))
	{
		return true;
	}
	return false;
}

/*
	Name: on_player_disconnect
	Namespace: globallogic_player
	Checksum: 0x64801F10
	Offset: 0x170
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function on_player_disconnect()
{
	if(sessionmodeismultiplayergame())
	{
		uploadstats();
	}
}

