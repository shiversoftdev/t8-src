// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_6fe6fb00;

/*
	Name: function_89f2df9
	Namespace: namespace_6fe6fb00
	Checksum: 0xC9C7635E
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_4b0893282c45ca4", &__init__, undefined, #"hash_29467933d0da473b");
}

/*
	Name: __init__
	Namespace: namespace_6fe6fb00
	Checksum: 0x7890E537
	Offset: 0xD0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level thread function_b2801783();
}

/*
	Name: function_b2801783
	Namespace: namespace_6fe6fb00
	Checksum: 0x433256F
	Offset: 0xF8
	Size: 0x13E
	Parameters: 0
	Flags: Linked
*/
function function_b2801783()
{
	level._effect[#"hash_33fd6545401e3622"] = #"hash_6eaa36cff74df726";
	level._effect[#"hash_55d6ab2c7eecbad4"] = #"hash_3fb91b6cfc622661";
	level._effect[#"hash_808a86715bfac90"] = #"hash_646b3a4c74c5e3d4";
	level._effect[#"hash_5e4d4083a69396b8"] = #"hash_156305f099f6dd2c";
	level._effect[#"hash_63f497890003547"] = #"hash_643c87c938e4616b";
	level._effect[#"dog_gib"] = #"hash_669db3df31d185d4";
	level.var_17c4823f = #"hash_6a3a7714a2c454fb";
}

