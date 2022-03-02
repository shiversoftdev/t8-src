// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace medals;

/*
	Name: function_89f2df9
	Namespace: medals
	Checksum: 0x13585394
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"medals", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: medals
	Checksum: 0xFC19D224
	Offset: 0xC0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_start_gametype(&init);
}

/*
	Name: init
	Namespace: medals
	Checksum: 0x5A27711B
	Offset: 0xF0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.medalinfo = [];
	level.medalcallbacks = [];
	level.numkills = 0;
	callback::on_connect(&on_player_connect);
}

/*
	Name: on_player_connect
	Namespace: medals
	Checksum: 0xACCE83CD
	Offset: 0x148
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self.lastkilledby = undefined;
}

/*
	Name: setlastkilledby
	Namespace: medals
	Checksum: 0xC32B12A9
	Offset: 0x160
	Size: 0x2E
	Parameters: 2
	Flags: None
*/
function setlastkilledby(attacker, inflictor)
{
	self.lastkilledby = attacker;
	self.var_e78602fc = inflictor;
}

/*
	Name: offenseglobalcount
	Namespace: medals
	Checksum: 0xB645BCF1
	Offset: 0x198
	Size: 0x10
	Parameters: 0
	Flags: None
*/
function offenseglobalcount()
{
	level.globalteammedals++;
}

/*
	Name: defenseglobalcount
	Namespace: medals
	Checksum: 0x9C4C51A8
	Offset: 0x1B0
	Size: 0x10
	Parameters: 0
	Flags: None
*/
function defenseglobalcount()
{
	level.globalteammedals++;
}

/*
	Name: codecallback_medal
	Namespace: medals
	Checksum: 0x18025088
	Offset: 0x1C8
	Size: 0x7C
	Parameters: 1
	Flags: Event
*/
event codecallback_medal(eventstruct)
{
	if(!function_8570168d())
	{
		self luinotifyevent(#"medal_received", 1, eventstruct.medal_index);
		self function_b552ffa9(#"medal_received", 1, eventstruct.medal_index);
	}
}

/*
	Name: function_8570168d
	Namespace: medals
	Checksum: 0x134A4FDF
	Offset: 0x250
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_8570168d()
{
	/#
		if(getdvar(#"hash_49e94b7aefac4f49", 0))
		{
			return true;
		}
	#/
	if(sessionmodeismultiplayergame())
	{
		mode = function_bea73b01();
		if(mode == 4)
		{
			return true;
		}
	}
	return false;
}

