// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_1444e236;

/*
	Name: function_89f2df9
	Namespace: namespace_1444e236
	Checksum: 0xF80BE4A1
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_2e41e4e9f22f6589", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_1444e236
	Checksum: 0x122EC45F
	Offset: 0xC8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_23931c40f2cd64a6", #"hash_72350169be9133ae", #"hash_7b4b6ec825eec06f", &function_d95e620c, #"hash_7334970069e5e147", #"hash_7334980069e5e2fa");
}

/*
	Name: function_d95e620c
	Namespace: namespace_1444e236
	Checksum: 0xB5BA2B5F
	Offset: 0x148
	Size: 0x152
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_2fcdec4f = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_20f3ff8fbb8d8295")) ? getgametypesetting(#"hash_20f3ff8fbb8d8295") : 0) && (isdefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isdefined(getgametypesetting(#"hash_24e281e778894ac9")) ? getgametypesetting(#"hash_24e281e778894ac9") : 0);
	return var_2fcdec4f;
}

