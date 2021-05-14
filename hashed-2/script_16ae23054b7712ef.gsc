// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_76908a4b;

/*
	Name: function_89f2df9
	Namespace: namespace_76908a4b
	Checksum: 0x39F85A6B
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_58e2298d0db8b6aa", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_76908a4b
	Checksum: 0x8DF7C59B
	Offset: 0xD0
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_58e2298d0db8b6aa", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_76908a4b
	Checksum: 0x80F724D1
	Offset: 0x138
	Size: 0x4
	Parameters: 0
	Flags: Private
*/
private function function_d1de6a85()
{
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_76908a4b
	Checksum: 0xEF9EF00F
	Offset: 0x148
	Size: 0x98
	Parameters: 1
	Flags: Private
*/
private function function_9e7b3f4d(round_reset)
{
	if(round_reset)
	{
		foreach(e_player in level.players)
		{
			e_player gadgetpowerset(level.var_a53a05b5, 100);
		}
	}
}

