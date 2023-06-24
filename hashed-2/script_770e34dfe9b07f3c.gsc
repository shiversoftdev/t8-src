// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_841de7df;

/*
	Name: __init__system__
	Namespace: namespace_841de7df
	Checksum: 0xEC9D1703
	Offset: 0x100
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_4ef9c479ac8da304", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_841de7df
	Checksum: 0xDF31DA7B
	Offset: 0x148
	Size: 0x9C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	clientfield::register("zbarrier", "" + #"hash_100f180bf5d2a517", 14000, 1, "int");
	zm_trial::register_challenge(#"hash_28d1b9857e2ca681", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_841de7df
	Checksum: 0x46CA33E9
	Offset: 0x1F0
	Size: 0x150
	Parameters: 2
	Flags: Private
*/
function private on_begin(var_c4da4541, var_93a137cd)
{
	level.var_6f6736a8 = zm_trial::function_5769f26a(var_c4da4541);
	if(isdefined(var_93a137cd))
	{
		self.var_93a137cd = zm_trial::function_5769f26a(var_93a137cd);
	}
	level thread function_c3996268();
	if(isdefined(self.var_93a137cd) && self.var_93a137cd)
	{
		level.var_41d5077e = 0;
		level thread function_c33c2895();
	}
	else
	{
		zm_trial_util::function_c2cd0cba(level.var_6f6736a8);
		foreach(player in getplayers())
		{
			player thread function_a14072bf();
		}
	}
}

/*
	Name: on_end
	Namespace: namespace_841de7df
	Checksum: 0x232F4764
	Offset: 0x348
	Size: 0x2A6
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	foreach(player in getplayers())
	{
		player.var_14361e0c = undefined;
		player zm_trial_util::function_f3aacffb();
	}
	if(isdefined(self.var_93a137cd) && self.var_93a137cd)
	{
		if(!round_reset && level.var_41d5077e < level.var_6f6736a8)
		{
			if(zm_utility::get_story() === 1)
			{
				zm_trial::fail(#"hash_11dba2735866a0f6");
			}
			else
			{
				zm_trial::fail(#"hash_aaf7fedbbd0fd9");
			}
		}
		zm_trial_util::function_f3dbeda7();
		level.var_41d5077e = undefined;
	}
	else
	{
		var_ef7fbb73 = [];
		foreach(player in getplayers())
		{
			if(player.var_41d5077e < level.var_6f6736a8)
			{
				if(!isdefined(var_ef7fbb73))
				{
					var_ef7fbb73 = [];
				}
				else if(!isarray(var_ef7fbb73))
				{
					var_ef7fbb73 = array(var_ef7fbb73);
				}
				var_ef7fbb73[var_ef7fbb73.size] = player;
			}
		}
		if(!round_reset && var_ef7fbb73.size)
		{
			if(zm_utility::get_story() === 1)
			{
				zm_trial::fail(#"hash_11dba2735866a0f6", var_ef7fbb73);
			}
			else
			{
				zm_trial::fail(#"hash_aaf7fedbbd0fd9", var_ef7fbb73);
			}
		}
	}
	level.var_6f6736a8 = undefined;
}

/*
	Name: function_c3996268
	Namespace: namespace_841de7df
	Checksum: 0xD7FBC9A4
	Offset: 0x5F8
	Size: 0x140
	Parameters: 0
	Flags: Private
*/
function private function_c3996268()
{
	level endon(#"hash_7646638df88a3656", #"end_game");
	while(true)
	{
		var_4c755588 = function_34835ec7();
		var_4c755588 flag::wait_till_clear("pap_waiting_for_user");
		if(var_4c755588.pack_player.var_41d5077e === level.var_6f6736a8)
		{
			var_4c755588 flag::wait_till("pap_waiting_for_user");
			continue;
		}
		var_4c755588 clientfield::set("" + #"hash_100f180bf5d2a517", 1);
		var_4c755588 waittill(#"pap_taken", #"pap_timeout");
		var_4c755588 clientfield::set("" + #"hash_100f180bf5d2a517", 0);
	}
}

/*
	Name: function_34835ec7
	Namespace: namespace_841de7df
	Checksum: 0xE73733F7
	Offset: 0x740
	Size: 0xE2
	Parameters: 0
	Flags: Private
*/
function private function_34835ec7()
{
	level endon(#"hash_7646638df88a3656", #"end_game");
	while(true)
	{
		var_4d8e32c8 = getentarray("zm_pack_a_punch", "targetname");
		foreach(var_5e879929 in var_4d8e32c8)
		{
			if(var_5e879929 zm_pack_a_punch::is_on())
			{
				return var_5e879929;
			}
		}
		wait(1);
	}
}

/*
	Name: function_a14072bf
	Namespace: namespace_841de7df
	Checksum: 0x25089376
	Offset: 0x830
	Size: 0xFA
	Parameters: 0
	Flags: Private
*/
function private function_a14072bf()
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	self.var_41d5077e = 0;
	self.var_14361e0c = 0.1;
	while(true)
	{
		self zm_trial_util::function_2190356a(self.var_41d5077e);
		self waittill(#"pap_timeout");
		self.var_41d5077e++;
		if(isdefined(level.var_22dfe858))
		{
			self playsoundtoplayer(level.var_22dfe858, self);
		}
		if(self.var_41d5077e === level.var_6f6736a8)
		{
			self.var_14361e0c = undefined;
			self zm_trial_util::function_63060af4(1);
			return;
		}
	}
}

/*
	Name: function_c33c2895
	Namespace: namespace_841de7df
	Checksum: 0x2F6266DF
	Offset: 0x938
	Size: 0xDA
	Parameters: 0
	Flags: Private
*/
function private function_c33c2895()
{
	level endon(#"hash_7646638df88a3656");
	zm_trial_util::function_2976fa44(level.var_6f6736a8);
	while(true)
	{
		zm_trial_util::function_dace284(level.var_41d5077e);
		level waittill(#"pap_timeout");
		level.var_41d5077e++;
		if(isdefined(level.var_22dfe858))
		{
			level thread util::playsoundonplayers(level.var_22dfe858);
		}
		if(level.var_41d5077e === level.var_6f6736a8)
		{
			zm_trial_util::function_7d32b7d0(1);
			return;
		}
	}
}

/*
	Name: is_active
	Namespace: namespace_841de7df
	Checksum: 0x76ACD2C4
	Offset: 0xA20
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	challenge = zm_trial::function_a36e8c38(#"hash_28d1b9857e2ca681");
	return isdefined(challenge);
}

