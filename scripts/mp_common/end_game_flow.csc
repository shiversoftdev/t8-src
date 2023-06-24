// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace end_game_flow;

/*
	Name: __init__system__
	Namespace: end_game_flow
	Checksum: 0xBD05EA20
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"end_game_flow", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: end_game_flow
	Checksum: 0x80F724D1
	Offset: 0xD0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
}

