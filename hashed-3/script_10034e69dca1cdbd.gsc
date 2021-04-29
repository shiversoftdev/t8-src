// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_d579463e;

/*
	Name: function_89f2df9
	Namespace: namespace_d579463e
	Checksum: 0xB096C212
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5993cb43cbe55c17", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d579463e
	Checksum: 0xBA05CCAC
	Offset: 0xD8
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!namespace_f551babc::function_b47f6aba())
	{
		return;
	}
	namespace_f551babc::register_challenge(#"hash_4803a4a42dd83650", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_d579463e
	Checksum: 0xD55A76D1
	Offset: 0x140
	Size: 0x3C
	Parameters: 1
	Flags: Private
*/
private function function_d1de6a85(weapon_name)
{
	namespace_b22c99a5::function_7d32b7d0(0);
	level thread function_83b71e7c();
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_d579463e
	Checksum: 0x30DA6CB5
	Offset: 0x188
	Size: 0xAC
	Parameters: 1
	Flags: Private
*/
private function function_9e7b3f4d(round_reset)
{
	namespace_b22c99a5::function_f3dbeda7();
	if(!round_reset)
	{
		if(!level flag::get(level.var_5bfd847e))
		{
			if(zm_utility::function_166646a6() == 1)
			{
				namespace_f551babc::fail(#"hash_ad3c47f53414b85");
			}
			else
			{
				namespace_f551babc::fail(#"hash_765b6a6e9523c15a");
			}
		}
	}
}

/*
	Name: function_83b71e7c
	Namespace: namespace_d579463e
	Checksum: 0xD5ED0552
	Offset: 0x240
	Size: 0xA8
	Parameters: 0
	Flags: Private
*/
private function function_83b71e7c()
{
	level endon(#"hash_7646638df88a3656");
	self endon(#"death");
	while(true)
	{
		level flag::wait_till(level.var_5bfd847e);
		namespace_b22c99a5::function_7d32b7d0(1);
		level flag::wait_till_clear(level.var_5bfd847e);
		namespace_b22c99a5::function_7d32b7d0(0);
	}
}

