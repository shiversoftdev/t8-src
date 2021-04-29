// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_35d655b3a0e4a949;
#using script_51b0fb46d4a05f60;
#using script_687c5fa24f83e902;
#using script_6b418dbafc965acc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace smart_cover;

/*
	Name: function_89f2df9
	Namespace: smart_cover
	Checksum: 0x38CFC11D
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_1fb0b26684caee0f", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: smart_cover
	Checksum: 0x320A6F89
	Offset: 0xF8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
}

