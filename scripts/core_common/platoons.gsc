// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace platoons;

/*
	Name: __init__system__
	Namespace: platoons
	Checksum: 0xB42A983
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"platoons", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: platoons
	Checksum: 0xB2E94A96
	Offset: 0xD8
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.platoon = {#max_players:0, #assignment:(isdefined(getgametypesetting(#"platoonassignment")) ? getgametypesetting(#"platoonassignment") : 0), #count:(isdefined(getgametypesetting(#"platooncount")) ? getgametypesetting(#"platooncount") : 0)};
	level.platoon.max_players = function_bb1ab64b();
	if(level.platoon.count)
	{
		level.platoon.max_players = level.platoon.max_players / level.platoon.count;
	}
	callback::on_start_gametype(&on_start_gametype);
}

/*
	Name: function_382a49e0
	Namespace: platoons
	Checksum: 0xFEED0E9D
	Offset: 0x240
	Size: 0x1A
	Parameters: 0
	Flags: None
*/
function function_382a49e0()
{
	return level.platoon.count > 0;
}

/*
	Name: function_bb1ab64b
	Namespace: platoons
	Checksum: 0xD860F112
	Offset: 0x268
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function function_bb1ab64b()
{
	return getdvarint(#"com_maxclients", 0);
}

/*
	Name: on_start_gametype
	Namespace: platoons
	Checksum: 0xC2A6E14D
	Offset: 0x298
	Size: 0xCC
	Parameters: 0
	Flags: Linked, Private
*/
function private on_start_gametype()
{
	level.platoons = [];
	for(var_aada11e0 = 1; var_aada11e0 <= level.platoon.count; var_aada11e0++)
	{
		platoon_name = "platoon_" + var_aada11e0;
		level.platoons[hash("platoon_" + var_aada11e0)] = {#player_count:0, #hash_9dd75dad:0, #eliminated:0, #name:platoon_name};
	}
}

/*
	Name: function_334c4bec
	Namespace: platoons
	Checksum: 0x165144C
	Offset: 0x370
	Size: 0x2C
	Parameters: 2
	Flags: None
*/
function function_334c4bec(team, platoon)
{
	function_909b6ab(platoon, team);
}

/*
	Name: function_596bfb16
	Namespace: platoons
	Checksum: 0xD9D09D66
	Offset: 0x3A8
	Size: 0x11E
	Parameters: 0
	Flags: None
*/
function function_596bfb16()
{
	if(game.state != "playing")
	{
		return;
	}
	foreach(team, _ in level.teams)
	{
		if(game.everexisted[team])
		{
			platoon = getteamplatoon(team);
			if(platoon != #"none" && platoon != #"invalid" && level.platoons[platoon].var_9dd75dad == 0)
			{
				level.platoons[platoon].var_9dd75dad = gettime();
			}
		}
	}
}

