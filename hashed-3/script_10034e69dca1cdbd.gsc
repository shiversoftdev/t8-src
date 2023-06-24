// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_d579463e;

/*
	Name: __init__system__
	Namespace: namespace_d579463e
	Checksum: 0xB096C212
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
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
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_4803a4a42dd83650", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_d579463e
	Checksum: 0xD55A76D1
	Offset: 0x140
	Size: 0x3C
	Parameters: 1
	Flags: Private
*/
function private on_begin(weapon_name)
{
	zm_trial_util::function_7d32b7d0(0);
	level thread function_83b71e7c();
}

/*
	Name: on_end
	Namespace: namespace_d579463e
	Checksum: 0x30DA6CB5
	Offset: 0x188
	Size: 0xAC
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	zm_trial_util::function_f3dbeda7();
	if(!round_reset)
	{
		if(!level flag::get(level.var_5bfd847e))
		{
			if(zm_utility::get_story() == 1)
			{
				zm_trial::fail(#"hash_ad3c47f53414b85");
			}
			else
			{
				zm_trial::fail(#"hash_765b6a6e9523c15a");
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
function private function_83b71e7c()
{
	level endon(#"hash_7646638df88a3656");
	self endon(#"death");
	while(true)
	{
		level flag::wait_till(level.var_5bfd847e);
		zm_trial_util::function_7d32b7d0(1);
		level flag::wait_till_clear(level.var_5bfd847e);
		zm_trial_util::function_7d32b7d0(0);
	}
}

