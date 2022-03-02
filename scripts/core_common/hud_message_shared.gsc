// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_272c2c9da7e6858;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace hud_message;

/*
	Name: function_89f2df9
	Namespace: hud_message
	Checksum: 0x93C8A1D6
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hud_message", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: hud_message
	Checksum: 0xF9987A60
	Offset: 0xE8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.lower_message = lower_message::register("lower_message");
	callback::on_start_gametype(&init);
}

/*
	Name: init
	Namespace: hud_message
	Checksum: 0x2A3C544A
	Offset: 0x138
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init()
{
	callback::on_connect(&on_player_connect);
}

/*
	Name: on_player_connect
	Namespace: hud_message
	Checksum: 0xF68FF02E
	Offset: 0x168
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self thread lowermessagethink();
}

/*
	Name: playnotifyloop
	Namespace: hud_message
	Checksum: 0xCD7BF43
	Offset: 0x190
	Size: 0x94
	Parameters: 1
	Flags: None
*/
function playnotifyloop(duration)
{
	playnotifyloop = spawn("script_origin", (0, 0, 0));
	playnotifyloop playloopsound(#"uin_notify_data_loop");
	duration = duration - 4;
	if(duration < 1)
	{
		duration = 1;
	}
	wait(duration);
	playnotifyloop delete();
}

/*
	Name: lowermessagethink
	Namespace: hud_message
	Checksum: 0x112BC3B5
	Offset: 0x230
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function lowermessagethink()
{
	self endon(#"disconnect");
	if(!isdefined(level.lower_message) || level.lower_message lower_message::is_open(self))
	{
		return;
	}
	level.lower_message lower_message::open(self, 1);
}

/*
	Name: setlowermessage
	Namespace: hud_message
	Checksum: 0x193A3CDB
	Offset: 0x2A8
	Size: 0x10C
	Parameters: 2
	Flags: Linked
*/
function setlowermessage(text, time)
{
	self notify(#"hash_6ceeeb477ece797b");
	if(!isdefined(level.lower_message))
	{
		return;
	}
	level.lower_message lower_message::function_cd1b9801(self, (isdefined(text) ? text : #""));
	if(isdefined(time) && time > 0)
	{
		level.lower_message lower_message::function_18a028a3(self, int(time));
		level.lower_message lower_message::set_state(self, #"visible");
	}
	else
	{
		level.lower_message lower_message::set_state(self, #"hash_45bfcb1cd8c9b50a");
	}
}

/*
	Name: clearlowermessage
	Namespace: hud_message
	Checksum: 0x341A01D5
	Offset: 0x3C0
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function clearlowermessage()
{
	self endon(#"hash_6ceeeb477ece797b");
	if(!isdefined(level.lower_message) || !isplayer(self))
	{
		return;
	}
	level.lower_message lower_message::set_state(self, #"defaultstate");
	self thread function_fa47c5af();
}

/*
	Name: function_fa47c5af
	Namespace: hud_message
	Checksum: 0xE223CE0F
	Offset: 0x450
	Size: 0x74
	Parameters: 0
	Flags: Linked, Private
*/
function private function_fa47c5af()
{
	self endon(#"hash_6ceeeb477ece797b", #"disconnect");
	wait(1);
	level.lower_message lower_message::function_cd1b9801(self, #"");
	level.lower_message lower_message::function_18a028a3(self, 0);
}

/*
	Name: isintop
	Namespace: hud_message
	Checksum: 0x732B63A4
	Offset: 0x4D0
	Size: 0x64
	Parameters: 2
	Flags: None
*/
function isintop(players, topn)
{
	for(i = 0; i < topn; i++)
	{
		if(isdefined(players[i]) && self == players[i])
		{
			return true;
		}
	}
	return false;
}

