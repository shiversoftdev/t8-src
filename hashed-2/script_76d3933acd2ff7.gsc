// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_1fe29ca6;

/*
	Name: function_89f2df9
	Namespace: namespace_1fe29ca6
	Checksum: 0x45EEF792
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5f58ed4c79d56e3d", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: namespace_1fe29ca6
	Checksum: 0x388594C6
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_f1156c5f8b9f0e8", #"hash_677a722d85cbd06", #"hash_2662e8abf5c359e7", &function_d95e620c, #"hash_1493c49bbdfb17ad");
}

/*
	Name: function_d95e620c
	Namespace: namespace_1fe29ca6
	Checksum: 0x36458ADE
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_bda4e460 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_4547b7ecb49469f0")) ? getgametypesetting(#"hash_4547b7ecb49469f0") : 0);
	return var_bda4e460;
}

