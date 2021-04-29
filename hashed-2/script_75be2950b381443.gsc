// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_aa9b5883;

/*
	Name: function_89f2df9
	Namespace: namespace_aa9b5883
	Checksum: 0xB42A983
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5d8ecf2f8dffda0d", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_aa9b5883
	Checksum: 0xB2E94A96
	Offset: 0xD8
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.platoon = {#max_players:0, #assignment:(isdefined(getgametypesetting(#"hash_1fb467bbf02b5835")) ? getgametypesetting(#"hash_1fb467bbf02b5835") : 0), #count:(isdefined(getgametypesetting(#"hash_9dc52c75197d173")) ? getgametypesetting(#"hash_9dc52c75197d173") : 0)};
	level.platoon.max_players = function_bb1ab64b();
	if(level.platoon.count)
	{
		level.platoon.max_players = level.platoon.max_players / level.platoon.count;
	}
	callback::on_start_gametype(&on_start_gametype);
}

/*
	Name: function_382a49e0
	Namespace: namespace_aa9b5883
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
	Namespace: namespace_aa9b5883
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
	Namespace: namespace_aa9b5883
	Checksum: 0xC2A6E14D
	Offset: 0x298
	Size: 0xCC
	Parameters: 0
	Flags: Linked, Private
*/
private function on_start_gametype()
{
	level.var_aa9b5883 = [];
	for(var_aada11e0 = 1; var_aada11e0 <= level.platoon.count; var_aada11e0++)
	{
		var_39e16cb3 = "platoon_" + var_aada11e0;
		level.var_aa9b5883[hash("platoon_" + var_aada11e0)] = {#player_count:0, #hash_9dd75dad:0, #eliminated:0, #name:var_39e16cb3};
	}
}

/*
	Name: function_334c4bec
	Namespace: namespace_aa9b5883
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
	Namespace: namespace_aa9b5883
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
			platoon = function_22448d6c(team);
			if(platoon != #"none" && platoon != #"invalid" && level.var_aa9b5883[platoon].var_9dd75dad == 0)
			{
				level.var_aa9b5883[platoon].var_9dd75dad = gettime();
			}
		}
	}
}

