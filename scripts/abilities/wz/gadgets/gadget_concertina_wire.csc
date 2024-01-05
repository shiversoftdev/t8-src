// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\abilities\gadgets\gadget_concertina_wire.csc;
#using scripts\core_common\system_shared.csc;

#namespace concertina_wire;

/*
	Name: __init__system__
	Namespace: concertina_wire
	Checksum: 0xE7FE3BA3
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"gadget_concertina_wire", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: concertina_wire
	Checksum: 0x7C67C230
	Offset: 0xE0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared("concertina_wire_settings_wz");
}

