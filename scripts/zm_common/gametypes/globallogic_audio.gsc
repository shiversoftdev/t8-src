// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\gametypes\globallogic_utils.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace globallogic_audio;

/*
	Name: __init__system__
	Namespace: globallogic_audio
	Checksum: 0x49BA0C15
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"globallogic_audio", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: globallogic_audio
	Checksum: 0x80F724D1
	Offset: 0xE0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
}

