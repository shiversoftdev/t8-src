// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using scripts\core_common\system_shared.csc;

#namespace namespace_165a141c;

/*
	Name: function_89f2df9
	Namespace: namespace_165a141c
	Checksum: 0x2D51427A
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_7a6bd16c1773964b", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_165a141c
	Checksum: 0x3C9F6F0C
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_7993541af41c24ec", #"hash_66b69b90a30bcc88", #"hash_206ddd5a88e8c7c1", &function_d95e620c, #"hash_418312990213bc41");
}

/*
	Name: function_d95e620c
	Namespace: namespace_165a141c
	Checksum: 0x6CF10383
	Offset: 0x138
	Size: 0x102
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_5d6be844 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_19667f3338ed6b1f")) ? getgametypesetting(#"hash_19667f3338ed6b1f") : 0) && (isdefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0);
	return var_5d6be844;
}

