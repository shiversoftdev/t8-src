// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace zm_trial_limited_hits;

/*
	Name: __init__system__
	Namespace: zm_trial_limited_hits
	Checksum: 0x9F735110
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_limited_hits", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_limited_hits
	Checksum: 0xACCB983C
	Offset: 0xE0
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"limited_hits", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_limited_hits
	Checksum: 0x32E39B0D
	Offset: 0x148
	Size: 0xD4
	Parameters: 2
	Flags: Private
*/
function private on_begin(var_85af3be4, var_752d90ad)
{
	if(getplayers().size == 1)
	{
		level.var_b529249b = zm_trial::function_5769f26a(var_752d90ad);
	}
	else
	{
		level.var_b529249b = zm_trial::function_5769f26a(var_85af3be4);
	}
	level.var_4b9163d5 = 0;
	zm_trial_util::function_2976fa44(level.var_b529249b);
	zm_trial_util::function_dace284(level.var_b529249b, 1);
	callback::on_player_damage(&on_player_damage);
}

/*
	Name: on_end
	Namespace: zm_trial_limited_hits
	Checksum: 0xE57531A3
	Offset: 0x228
	Size: 0x54
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	zm_trial_util::function_f3dbeda7();
	level.var_b529249b = undefined;
	level.var_4b9163d5 = undefined;
	callback::remove_on_player_damage(&on_player_damage);
}

/*
	Name: is_active
	Namespace: zm_trial_limited_hits
	Checksum: 0xB8AA7329
	Offset: 0x288
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	challenge = zm_trial::function_a36e8c38(#"limited_hits");
	return isdefined(challenge);
}

/*
	Name: on_player_damage
	Namespace: zm_trial_limited_hits
	Checksum: 0x880A4432
	Offset: 0x2C8
	Size: 0xA4
	Parameters: 1
	Flags: Private
*/
function private on_player_damage(params)
{
	if(params.idamage >= 0)
	{
		level.var_4b9163d5++;
		zm_trial_util::function_dace284(level.var_b529249b - level.var_4b9163d5);
		if(level.var_4b9163d5 >= level.var_b529249b)
		{
			zm_trial::fail(#"hash_404865fbf8dd5cc2", array(self));
		}
	}
}

