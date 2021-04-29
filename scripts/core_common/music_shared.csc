// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace music;

/*
	Name: function_89f2df9
	Namespace: music
	Checksum: 0xE55F10D0
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"music", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: music
	Checksum: 0xD7A7A6EE
	Offset: 0xD0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.activemusicstate = "";
	level.nextmusicstate = "";
	level.musicstates = [];
	util::register_system(#"musiccmd", &musiccmdhandler);
}

/*
	Name: musiccmdhandler
	Namespace: music
	Checksum: 0x6ECD3CF2
	Offset: 0x140
	Size: 0x64
	Parameters: 3
	Flags: Linked
*/
function musiccmdhandler(clientnum, state, oldstate)
{
	if(state != "death")
	{
		level._lastmusicstate = state;
	}
	state = tolower(state);
	soundsetmusicstate(state);
}

