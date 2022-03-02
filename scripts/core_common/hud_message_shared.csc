// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_61ec16c9c8ab8dcc;
#using scripts\core_common\system_shared.csc;

#namespace hud_message;

/*
	Name: function_89f2df9
	Namespace: hud_message
	Checksum: 0x43A70DD9
	Offset: 0x88
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
	Checksum: 0xAD32A78B
	Offset: 0xD0
	Size: 0x26
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.lower_message = lower_message::register("lower_message");
}

