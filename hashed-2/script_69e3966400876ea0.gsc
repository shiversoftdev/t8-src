// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2595527427ea71eb;
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm\zm_towers_pap_quest.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_bd742265;

/*
	Name: function_89f2df9
	Namespace: namespace_bd742265
	Checksum: 0xF7078363
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_ce997e4989de9ae", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_bd742265
	Checksum: 0xF6AC6FC8
	Offset: 0xF0
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
	zm_trial::register_challenge(#"hash_479148f4e9b409d5", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_bd742265
	Checksum: 0x1CB91BC5
	Offset: 0x158
	Size: 0x44
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d1de6a85(var_a84ac7c8)
{
	self.var_a84ac7c8 = var_a84ac7c8;
	namespace_2ea65b04::function_57d79cac();
	self thread function_8cd2421c();
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_bd742265
	Checksum: 0xCFDEDAFF
	Offset: 0x1A8
	Size: 0xEC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9e7b3f4d(round_reset)
{
	namespace_b22c99a5::function_f3dbeda7();
	self notify(#"hash_16943eddd89aa5b8");
	if(!round_reset)
	{
		if(!level flag::get(#"hash_3d833ecc64915d8d") || !level flag::get(#"hash_d38ff215be3a4fc") || !level flag::get(#"hash_4142472dec557d03") || !level flag::get(#"hash_45b6b1ee5d5038b4"))
		{
			zm_trial::fail(self.var_a84ac7c8);
		}
	}
}

/*
	Name: function_8cd2421c
	Namespace: namespace_bd742265
	Checksum: 0x37123F74
	Offset: 0x2A0
	Size: 0xBC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_8cd2421c()
{
	namespace_b22c99a5::function_2976fa44(4);
	namespace_b22c99a5::function_dace284(0);
	self.var_cd6e44b6 = 0;
	self thread function_199e5524(#"hash_3d833ecc64915d8d");
	self thread function_199e5524(#"hash_d38ff215be3a4fc");
	self thread function_199e5524(#"hash_4142472dec557d03");
	self thread function_199e5524(#"hash_45b6b1ee5d5038b4");
}

/*
	Name: function_199e5524
	Namespace: namespace_bd742265
	Checksum: 0x96A5D3B0
	Offset: 0x368
	Size: 0x64
	Parameters: 1
	Flags: Linked, Private
*/
function private function_199e5524(str_flag)
{
	self endon(#"hash_16943eddd89aa5b8");
	level flag::wait_till(str_flag);
	self.var_cd6e44b6++;
	namespace_b22c99a5::function_dace284(self.var_cd6e44b6);
}

