// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace drone_squadron;

/*
	Name: function_89f2df9
	Namespace: drone_squadron
	Checksum: 0xD18364DF
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"drone_squadron", &__init__, undefined, #"killstreaks");
}

/*
	Name: __init__
	Namespace: drone_squadron
	Checksum: 0x80F724D1
	Offset: 0xC8
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function __init__()
{
}

