// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace clientids;

/*
	Name: function_89f2df9
	Namespace: clientids
	Checksum: 0x1C08112C
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"clientids", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: clientids
	Checksum: 0x77175F0E
	Offset: 0xC0
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function __init__()
{
	callback::on_start_gametype(&init);
	callback::on_connect(&on_player_connect);
}

/*
	Name: init
	Namespace: clientids
	Checksum: 0x6F31350B
	Offset: 0x110
	Size: 0x12
	Parameters: 0
	Flags: None
*/
function init()
{
	level.clientid = 0;
}

/*
	Name: on_player_connect
	Namespace: clientids
	Checksum: 0x494D5936
	Offset: 0x130
	Size: 0x9C
	Parameters: 0
	Flags: None
*/
function on_player_connect()
{
	self.clientid = matchrecordnewplayer(self);
	if(!isdefined(self.clientid) || self.clientid == -1)
	{
		self.clientid = level.clientid;
		level.clientid++;
	}
	/#
		println((("" + self.name) + "") + self.clientid);
	#/
}

