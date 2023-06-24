// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace killcam;

/*
	Name: __init__system__
	Namespace: killcam
	Checksum: 0x8501FF0E
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"killcam", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: killcam
	Checksum: 0x80F724D1
	Offset: 0xC0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
}

