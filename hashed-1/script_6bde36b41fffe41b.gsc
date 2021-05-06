// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_170a9c130859c688;
#using script_3affe3aaa3f22cb0;
#using script_71e26f08f03b7a7a;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;

#namespace namespace_b7ee637a;

/*
	Name: function_89f2df9
	Namespace: namespace_b7ee637a
	Checksum: 0x83F8CE7A
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_7710b10c0110b17", &__init__, undefined, #"hash_5d70c94021e00856");
}

/*
	Name: __init__
	Namespace: namespace_b7ee637a
	Checksum: 0x5714F9EE
	Offset: 0xF0
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if((isdefined(getgametypesetting(#"hash_6fb11b1e304d533c")) ? getgametypesetting(#"hash_6fb11b1e304d533c") : 0))
	{
		namespace_b0722f43::function_e70fa91c(#"hash_1edbe1c283127e19", #"hash_122a0d1e67363704", 3);
		namespace_3d2704b3::function_f0297225(#"hash_122a0d1e67363704", 1, 3);
	}
}

