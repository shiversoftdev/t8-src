// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_765ad6b;

/*
	Name: function_89f2df9
	Namespace: namespace_765ad6b
	Checksum: 0x68789E7A
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_2a44818de310b04f", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_765ad6b
	Checksum: 0x621266C2
	Offset: 0xC8
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
	zm_trial::register_challenge(#"hash_4778040558791d02", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_765ad6b
	Checksum: 0x74AF0748
	Offset: 0x130
	Size: 0x12
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d1de6a85()
{
	level.var_2d307e50 = 1;
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_765ad6b
	Checksum: 0x6D8244EB
	Offset: 0x150
	Size: 0x16
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9e7b3f4d(round_reset)
{
	level.var_2d307e50 = undefined;
}

