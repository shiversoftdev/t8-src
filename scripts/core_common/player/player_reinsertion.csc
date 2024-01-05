// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace player_reinsertion;

/*
	Name: __init__system__
	Namespace: player_reinsertion
	Checksum: 0x65EB196D
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"player_reinsertion", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: player_reinsertion
	Checksum: 0x80F724D1
	Offset: 0xC0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
}

