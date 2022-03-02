// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_820b160b;

/*
	Name: function_89f2df9
	Namespace: namespace_820b160b
	Checksum: 0x7DBD7853
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_323f3675919752ab", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_820b160b
	Checksum: 0xCC3A65C0
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_4dcc9053e0685c94", #"hash_7fc15da2c5864d3c", #"hash_4eb6471e45f165a8", &function_d95e620c, #"hash_7d0b41a17f2e9a9");
}

/*
	Name: function_d95e620c
	Namespace: namespace_820b160b
	Checksum: 0x35775F2E
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_32ce41fd = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_7fc2867a4b8594bf")) ? getgametypesetting(#"hash_7fc2867a4b8594bf") : 0);
	return var_32ce41fd;
}

