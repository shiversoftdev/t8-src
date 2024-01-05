// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_towers_crowd.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\flag_shared.gsc;

#namespace namespace_8a476bc7;

/*
	Name: __init__system__
	Namespace: namespace_8a476bc7
	Checksum: 0x25C71C39
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_48f50c5660fa9f4c", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_8a476bc7
	Checksum: 0xA7A77724
	Offset: 0xD8
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
	zm_trial::register_challenge(#"hash_1fd6f58939deba71", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_8a476bc7
	Checksum: 0x80F724D1
	Offset: 0x140
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
function private on_begin()
{
}

/*
	Name: on_end
	Namespace: namespace_8a476bc7
	Checksum: 0xDE4B9AEA
	Offset: 0x150
	Size: 0x144
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	if(!round_reset)
	{
		var_acba5af0 = array();
		foreach(e_player in level.players)
		{
			if(!e_player zm_towers_crowd::function_aa0b6eb())
			{
				if(!isdefined(var_acba5af0))
				{
					var_acba5af0 = [];
				}
				else if(!isarray(var_acba5af0))
				{
					var_acba5af0 = array(var_acba5af0);
				}
				if(!isinarray(var_acba5af0, e_player))
				{
					var_acba5af0[var_acba5af0.size] = e_player;
				}
			}
		}
		if(var_acba5af0.size)
		{
			zm_trial::fail(#"hash_746c876308278b16", var_acba5af0);
		}
	}
}

