// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2595527427ea71eb;
#using scripts\zm\zm_towers_pap_quest.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\flag_shared.gsc;

#namespace namespace_bd742265;

/*
	Name: __init__system__
	Namespace: namespace_bd742265
	Checksum: 0xF7078363
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
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
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_479148f4e9b409d5", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_bd742265
	Checksum: 0x1CB91BC5
	Offset: 0x158
	Size: 0x44
	Parameters: 1
	Flags: Linked, Private
*/
function private on_begin(var_a84ac7c8)
{
	self.var_a84ac7c8 = var_a84ac7c8;
	zm_towers_pap_quest::pap_quest_restart();
	self thread function_8cd2421c();
}

/*
	Name: on_end
	Namespace: namespace_bd742265
	Checksum: 0xCFDEDAFF
	Offset: 0x1A8
	Size: 0xEC
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	zm_trial_util::function_f3dbeda7();
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
	zm_trial_util::function_2976fa44(4);
	zm_trial_util::function_dace284(0);
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
	zm_trial_util::function_dace284(self.var_cd6e44b6);
}

