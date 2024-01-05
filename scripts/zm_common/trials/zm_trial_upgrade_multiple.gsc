// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_trial_upgrade_multiple;

/*
	Name: __init__system__
	Namespace: zm_trial_upgrade_multiple
	Checksum: 0x50D04B55
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_upgrade_multiple", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_upgrade_multiple
	Checksum: 0x91BD941
	Offset: 0xF0
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
	zm_trial::register_challenge(#"upgrade_multiple", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_upgrade_multiple
	Checksum: 0x13A8CFB1
	Offset: 0x158
	Size: 0x248
	Parameters: 2
	Flags: Private
*/
function private on_begin(n_count, n_repacks)
{
	/#
		assert(isdefined(level.zombie_weapons_upgraded));
	#/
	level.var_ab9d0ec6 = [];
	foreach(weapon in getarraykeys(level.zombie_weapons_upgraded))
	{
		if(weapon != level.weaponnone)
		{
			if(!isdefined(level.var_ab9d0ec6))
			{
				level.var_ab9d0ec6 = [];
			}
			else if(!isarray(level.var_ab9d0ec6))
			{
				level.var_ab9d0ec6 = array(level.var_ab9d0ec6);
			}
			if(!isinarray(level.var_ab9d0ec6, weapon))
			{
				level.var_ab9d0ec6[level.var_ab9d0ec6.size] = weapon;
			}
		}
	}
	self.var_5ba20db5 = zm_trial::function_5769f26a(n_count);
	if(isdefined(n_repacks))
	{
		self.var_5027af68 = zm_trial::function_5769f26a(n_repacks);
	}
	else
	{
		self.var_5027af68 = 0;
	}
	foreach(player in getplayers())
	{
		player thread function_e73fbbf7(self.var_5ba20db5, self.var_5027af68);
	}
}

/*
	Name: on_end
	Namespace: zm_trial_upgrade_multiple
	Checksum: 0xA2F7A260
	Offset: 0x3A8
	Size: 0x24E
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	foreach(player in getplayers())
	{
		player zm_trial_util::function_f3aacffb();
	}
	/#
		assert(isdefined(level.var_ab9d0ec6));
	#/
	/#
		assert(isdefined(level.var_ab9d0ec6.size > 0));
	#/
	if(!round_reset)
	{
		var_696c3b4 = [];
		foreach(player in getplayers())
		{
			if(player.var_c2490d61 === 0)
			{
				if(!isdefined(var_696c3b4))
				{
					var_696c3b4 = [];
				}
				else if(!isarray(var_696c3b4))
				{
					var_696c3b4 = array(var_696c3b4);
				}
				if(!isinarray(var_696c3b4, player))
				{
					var_696c3b4[var_696c3b4.size] = player;
				}
			}
			player.var_c2490d61 = undefined;
		}
		if(var_696c3b4.size == 1)
		{
			zm_trial::fail(#"hash_753fe45bee19e131", var_696c3b4);
		}
		else if(var_696c3b4.size > 1)
		{
			zm_trial::fail(#"hash_3539a53b7cf9ea2", var_696c3b4);
		}
	}
	self.var_5ba20db5 = undefined;
}

/*
	Name: function_e73fbbf7
	Namespace: zm_trial_upgrade_multiple
	Checksum: 0xDC24C93F
	Offset: 0x600
	Size: 0x1E6
	Parameters: 2
	Flags: Private
*/
function private function_e73fbbf7(var_5ba20db5, var_27f8d634)
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	self.var_c2490d61 = 0;
	var_fa5d7ea0 = 0;
	while(true)
	{
		self function_46feb36d(var_5ba20db5, var_27f8d634);
		w_curr = self getcurrentweapon();
		if(self.var_c2490d61)
		{
			if(!var_fa5d7ea0)
			{
				self zm_trial_util::function_63060af4(1);
				var_fa5d7ea0 = 1;
			}
		}
		else
		{
			if(zm_weapons::weapon_supports_aat(w_curr) && var_27f8d634 > 0)
			{
				self zm_trial_util::function_63060af4(0);
				self zm_trial_util::function_f3aacffb();
				n_repacks = zm_pap_util::function_83c29ddb(w_curr);
				self zm_trial_util::function_c2cd0cba(var_27f8d634);
				self zm_trial_util::function_2190356a(n_repacks);
				var_fa5d7ea0 = 0;
			}
			else
			{
				if(zm_weapons::is_weapon_upgraded(w_curr))
				{
					self zm_trial_util::function_63060af4(1);
				}
				else
				{
					self zm_trial_util::function_63060af4(0);
				}
				var_fa5d7ea0 = 0;
			}
		}
		self waittill(#"weapon_change_complete");
	}
}

/*
	Name: function_46feb36d
	Namespace: zm_trial_upgrade_multiple
	Checksum: 0x2B2196D2
	Offset: 0x7F0
	Size: 0x14E
	Parameters: 2
	Flags: Private
*/
function private function_46feb36d(var_5ba20db5, var_27f8d634)
{
	if(self.sessionstate != "spectator")
	{
		var_6c114dfb = 0;
		self.var_c2490d61 = 0;
		foreach(weapon in level.var_ab9d0ec6)
		{
			if(self hasweapon(weapon, 1))
			{
				if(zm_weapons::weapon_supports_aat(weapon) && zm_pap_util::function_83c29ddb(weapon) >= var_27f8d634 || (!zm_weapons::weapon_supports_aat(weapon) && zm_weapons::is_weapon_upgraded(weapon)))
				{
					var_6c114dfb++;
				}
			}
		}
		if(var_6c114dfb >= var_5ba20db5)
		{
			self.var_c2490d61 = 1;
		}
	}
}

