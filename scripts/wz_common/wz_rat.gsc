// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\laststand_warzone.gsc;
#using scripts\mp_common\item_world.gsc;
#using scripts\core_common\bots\bot.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\rat_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;

#namespace rat;

/*
	Name: __init__system__
	Namespace: rat
	Checksum: 0xDE25B7C6
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	/#
		system::register(#"wz_rat", &__init__, undefined, undefined);
	#/
}

/*
	Name: __init__
	Namespace: rat
	Checksum: 0x679306E2
	Offset: 0xF0
	Size: 0x18C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	/#
		init();
		level.rat.common.gethostplayer = &util::gethostplayer;
		level.rat.deathcount = 0;
		addratscriptcmd("", &function_70f41194);
		addratscriptcmd("", &function_31980089);
		addratscriptcmd("", &function_1251949b);
		addratscriptcmd("", &function_684893c8);
		addratscriptcmd("", &function_7eabbc02);
		addratscriptcmd("", &function_d50abf44);
		addratscriptcmd("", &function_89684f6a);
		setdvar(#"rat_death_count", 0);
	#/
}

/*
	Name: function_d50abf44
	Namespace: rat
	Checksum: 0x1A717484
	Offset: 0x288
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function function_d50abf44(params)
{
	/#
		return level.players.size;
	#/
}

/*
	Name: function_7eabbc02
	Namespace: rat
	Checksum: 0xEDA96BE4
	Offset: 0x2B0
	Size: 0x166
	Parameters: 1
	Flags: None
*/
function function_7eabbc02(params)
{
	/#
		remaining = 0;
		host = [[level.rat.common.gethostplayer]]();
		hostteam = host.team;
		if(isdefined(params.remaining))
		{
			remaining = int(params.remaining);
		}
		if(isdefined(level.players))
		{
			for(i = 0; i < level.players.size; i++)
			{
				if(level.players.size <= remaining)
				{
					break;
				}
				if(!isdefined(level.players[i].bot) || level.players[i].team == hostteam || level.players[i].team == "")
				{
					continue;
				}
				bot::remove_bot(level.players[i]);
			}
		}
	#/
}

/*
	Name: function_684893c8
	Namespace: rat
	Checksum: 0xFD0A82DB
	Offset: 0x420
	Size: 0xB4
	Parameters: 1
	Flags: None
*/
function function_684893c8(params)
{
	/#
		count = 0;
		if(isdefined(level.players))
		{
			foreach(player in level.players)
			{
				if(player laststand::player_is_in_laststand())
				{
					count++;
				}
			}
		}
		return count;
	#/
}

/*
	Name: function_1251949b
	Namespace: rat
	Checksum: 0xF6106324
	Offset: 0x4E0
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function function_1251949b(params)
{
	/#
		player = [[level.rat.common.gethostplayer]]();
		return player laststand::player_is_in_laststand();
	#/
}

/*
	Name: function_70f41194
	Namespace: rat
	Checksum: 0x7AAC4E6
	Offset: 0x538
	Size: 0x4E
	Parameters: 1
	Flags: None
*/
function function_70f41194(params)
{
	/#
		player = [[level.rat.common.gethostplayer]]();
		return player.inventory.var_c212de25;
	#/
}

/*
	Name: function_31980089
	Namespace: rat
	Checksum: 0x21B6307
	Offset: 0x590
	Size: 0x248
	Parameters: 1
	Flags: None
*/
function function_31980089(params)
{
	/#
		player = [[level.rat.common.gethostplayer]]();
		numitems = 1000;
		distance = 1000;
		name = "";
		if(isdefined(params.var_1d978d3))
		{
			numitems = int(params.var_1d978d3);
		}
		if(isdefined(params.distance))
		{
			distance = int(params.distance);
		}
		if(isdefined(params.name))
		{
			name = params.name;
		}
		items = item_world::function_2e3efdda(player.origin, undefined, numitems, distance);
		foreach(item in items)
		{
			if(item.var_a6762160.name == "")
			{
				continue;
			}
			if(isdefined(params.handler))
			{
				if(params.handler != item.var_a6762160.handler && params.handler != "")
				{
					continue;
				}
			}
			if(name == "" || item.var_a6762160.name == name)
			{
				function_55e20e75(params._id, item.origin);
			}
		}
	#/
}

/*
	Name: function_89684f6a
	Namespace: rat
	Checksum: 0x3B323A28
	Offset: 0x7E0
	Size: 0x60
	Parameters: 1
	Flags: None
*/
function function_89684f6a(params)
{
	/#
		player = [[level.rat.common.gethostplayer]]();
		return player.inventory.items[10].var_bd027dd9 != 32767;
	#/
}

