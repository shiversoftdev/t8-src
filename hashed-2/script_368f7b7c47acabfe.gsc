// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_a7aeae56;

/*
	Name: __init__system__
	Namespace: namespace_a7aeae56
	Checksum: 0xCE8E3060
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_3932b346c9af0dde", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a7aeae56
	Checksum: 0x1A8B2A69
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
	zm_trial::register_challenge(#"hash_32bd34ef989ddd03", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_a7aeae56
	Checksum: 0xBB1F17A6
	Offset: 0x148
	Size: 0x100
	Parameters: 1
	Flags: Linked, Private
*/
function private on_begin(n_count)
{
	callback::function_aebeafc0(&function_aebeafc0);
	level.var_195590fb = zm_trial::function_5769f26a(n_count);
	foreach(player in getplayers())
	{
		player.var_92cd5237 = [];
		player zm_trial_util::function_c2cd0cba(level.var_195590fb);
		player zm_trial_util::function_2190356a(0);
	}
}

/*
	Name: on_end
	Namespace: namespace_a7aeae56
	Checksum: 0xEBA8EDB9
	Offset: 0x250
	Size: 0x1D4
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	foreach(player in getplayers())
	{
		player zm_trial_util::function_f3aacffb();
	}
	if(!round_reset)
	{
		var_57807cdc = [];
		foreach(player in getplayers())
		{
			if(player.var_92cd5237.size < level.var_195590fb)
			{
				array::add(var_57807cdc, player, 0);
			}
			player.var_f8c35ed5 = undefined;
		}
		if(var_57807cdc.size == 1)
		{
			zm_trial::fail(#"hash_6dbd3c476c903f66", var_57807cdc);
		}
		else if(var_57807cdc.size > 1)
		{
			zm_trial::fail(#"hash_59d734dda39935cf", var_57807cdc);
		}
	}
	level.var_195590fb = undefined;
	callback::function_3e2ed898(&function_aebeafc0);
}

/*
	Name: function_aebeafc0
	Namespace: namespace_a7aeae56
	Checksum: 0x7EAB2514
	Offset: 0x430
	Size: 0xF4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_aebeafc0(upgraded_weapon)
{
	w_base = zm_weapons::get_base_weapon(upgraded_weapon);
	if(!isdefined(self.var_92cd5237))
	{
		self.var_92cd5237 = [];
	}
	else if(!isarray(self.var_92cd5237))
	{
		self.var_92cd5237 = array(self.var_92cd5237);
	}
	if(!isinarray(self.var_92cd5237, w_base))
	{
		self.var_92cd5237[self.var_92cd5237.size] = w_base;
	}
	if(self.var_92cd5237.size <= level.var_195590fb)
	{
		zm_trial_util::function_2190356a(self.var_92cd5237.size);
	}
}

