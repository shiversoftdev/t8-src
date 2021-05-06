// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3a3d4c4130baf173;
#using scripts\core_common\system_shared.csc;

#namespace concertina_wire;

/*
	Name: function_89f2df9
	Namespace: concertina_wire
	Checksum: 0xE7FE3BA3
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_2089d7dfe76d99c6", &__init__, undefined, undefined);
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

