// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_trial_acquire_perks;

/*
	Name: __init__system__
	Namespace: zm_trial_acquire_perks
	Checksum: 0x7D663E10
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_acquire_perks", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_acquire_perks
	Checksum: 0xD8F27F91
	Offset: 0xE8
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
	zm_trial::register_challenge(#"acquire_perks", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_acquire_perks
	Checksum: 0x2B1AA46D
	Offset: 0x150
	Size: 0xD0
	Parameters: 1
	Flags: Private
*/
function private on_begin(perk_count)
{
	/#
		assert(isdefined(level.var_b8be892e));
	#/
	self.var_851a4ca6 = zm_trial::function_5769f26a(perk_count);
	foreach(player in getplayers())
	{
		player thread function_2a5b280f(self);
	}
}

/*
	Name: on_end
	Namespace: zm_trial_acquire_perks
	Checksum: 0xEEE00A74
	Offset: 0x228
	Size: 0x25E
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	foreach(player in getplayers())
	{
		player zm_trial_util::function_f3aacffb();
	}
	if(!round_reset)
	{
		/#
			assert(isdefined(level.var_b8be892e));
		#/
		var_57807cdc = [];
		foreach(player in getplayers())
		{
			/#
				assert(isdefined(player.var_a53b9221));
			#/
			if(player.var_a53b9221 < self.var_851a4ca6)
			{
				array::add(var_57807cdc, player, 0);
			}
		}
		if(var_57807cdc.size == 1)
		{
			zm_trial::fail(#"hash_397117e332ee81a0" + self.var_851a4ca6, var_57807cdc);
		}
		else if(var_57807cdc.size > 1)
		{
			zm_trial::fail(#"hash_4cf7d929e75b3da3" + self.var_851a4ca6, var_57807cdc);
		}
	}
	foreach(player in getplayers())
	{
		player.var_a53b9221 = undefined;
	}
}

/*
	Name: function_c9934172
	Namespace: zm_trial_acquire_perks
	Checksum: 0xDF6B90E0
	Offset: 0x490
	Size: 0xA4
	Parameters: 0
	Flags: Private
*/
function private function_c9934172()
{
	if(self.sessionstate != "spectator")
	{
		self.var_a53b9221 = 0;
		foreach(var_83225a27 in level.var_b8be892e)
		{
			if(self hasperk(var_83225a27))
			{
				self.var_a53b9221++;
			}
		}
	}
}

/*
	Name: function_2a5b280f
	Namespace: zm_trial_acquire_perks
	Checksum: 0x1ED027FE
	Offset: 0x540
	Size: 0xF4
	Parameters: 1
	Flags: Private
*/
function private function_2a5b280f(challenge)
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	self.var_a53b9221 = 0;
	var_fa5d7ea0 = 0;
	self zm_trial_util::function_63060af4(0);
	while(true)
	{
		self function_c9934172();
		if(self.var_a53b9221 >= challenge.var_851a4ca6)
		{
			if(!var_fa5d7ea0)
			{
				self zm_trial_util::function_63060af4(1);
				var_fa5d7ea0 = 1;
			}
		}
		else if(var_fa5d7ea0)
		{
			self zm_trial_util::function_63060af4(0);
			var_fa5d7ea0 = 0;
		}
		waitframe(1);
	}
}

