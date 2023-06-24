// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\abilities\gadgets\gadget_concertina_wire.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace concertina_wire;

/*
	Name: __init__system__
	Namespace: concertina_wire
	Checksum: 0x954867F1
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"concertina_wire", &__init__, undefined, #"weapons");
}

/*
	Name: __init__
	Namespace: concertina_wire
	Checksum: 0xD3E428B0
	Offset: 0xE8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared("concertina_wire_settings_wz");
	function_c5f0b9e7(&function_6230d238);
}

/*
	Name: function_6230d238
	Namespace: concertina_wire
	Checksum: 0xA241BBD2
	Offset: 0x130
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_6230d238(concertinawire)
{
}

