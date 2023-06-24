// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_ac6a30f1991e105;
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace zm_ai_avogadro;

/*
	Name: __init__system__
	Namespace: zm_ai_avogadro
	Checksum: 0x3D64D8A
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_ai_avogadro", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_ai_avogadro
	Checksum: 0xC7B010FD
	Offset: 0xD0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	ai::add_archetype_spawn_function(#"avogadro", &function_1caf705e);
}

/*
	Name: function_1caf705e
	Namespace: zm_ai_avogadro
	Checksum: 0x66671A8A
	Offset: 0x110
	Size: 0xC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_1caf705e(localclientnum)
{
}

