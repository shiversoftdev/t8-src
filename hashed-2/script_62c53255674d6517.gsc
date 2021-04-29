// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_a3cd8b9a;

/*
	Name: function_89f2df9
	Namespace: namespace_a3cd8b9a
	Checksum: 0x6D6ED29C
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_1bab8a0ba811401e", &__init__, undefined, undefined);
}

/*
	Name: precache
	Namespace: namespace_a3cd8b9a
	Checksum: 0x80F724D1
	Offset: 0xD0
	Size: 0x4
	Parameters: 0
	Flags: AutoExec
*/
autoexec function precache()
{
}

/*
	Name: __init__
	Namespace: namespace_a3cd8b9a
	Checksum: 0xFBA5BBC1
	Offset: 0xE0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	ai::add_archetype_spawn_function(#"hash_1bab8a0ba811401e", &function_5608540a);
}

/*
	Name: function_5608540a
	Namespace: namespace_a3cd8b9a
	Checksum: 0x885B959
	Offset: 0x120
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_5608540a(localclientnum)
{
	self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 0, 0, 1);
}

