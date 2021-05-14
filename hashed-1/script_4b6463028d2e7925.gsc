// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_score.gsc;

#namespace namespace_6c76c1da;

/*
	Name: function_89f2df9
	Namespace: namespace_6c76c1da
	Checksum: 0xA5E1122E
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_629e41f2458d532b", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_6c76c1da
	Checksum: 0x8D3C4E98
	Offset: 0xE0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_4afdb00097a95776", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_6c76c1da
	Checksum: 0xD6A8D76B
	Offset: 0x148
	Size: 0x24
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d1de6a85()
{
	level.var_e60b8c3a = undefined;
	level thread function_a543a954();
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_6c76c1da
	Checksum: 0xE9E23EC0
	Offset: 0x178
	Size: 0x76
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	namespace_b22c99a5::function_f3dbeda7();
	if(!round_reset && (!(isdefined(level.var_e60b8c3a) && level.var_e60b8c3a)))
	{
		zm_trial::fail(#"hash_12f3fd15a168901");
	}
	level.var_e60b8c3a = undefined;
}

/*
	Name: function_a543a954
	Namespace: namespace_6c76c1da
	Checksum: 0x6D8B50C2
	Offset: 0x1F8
	Size: 0x6C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a543a954()
{
	level endon(#"hash_7646638df88a3656");
	level waittill(#"hash_5dc448a84a24492", #"hash_38c04d24b5213b00");
	level.var_e60b8c3a = 1;
	namespace_b22c99a5::function_7d32b7d0(1);
}

