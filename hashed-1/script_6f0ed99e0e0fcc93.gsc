// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_ac6a30f1991e105;
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_bc1fae7;

/*
	Name: function_89f2df9
	Namespace: namespace_bc1fae7
	Checksum: 0xF1CCED57
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_78bf0dc450091c57", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_bc1fae7
	Checksum: 0x2F22A50F
	Offset: 0xD8
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
	Namespace: namespace_bc1fae7
	Checksum: 0xE6677B70
	Offset: 0x118
	Size: 0xC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_1caf705e(localclientnum)
{
}

