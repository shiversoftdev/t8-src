// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_919f68ad;

/*
	Name: __init__system__
	Namespace: namespace_919f68ad
	Checksum: 0xE185A5EC
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_37398b26e502cdde", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_919f68ad
	Checksum: 0x980E22B3
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
	zm_trial::register_challenge(#"hash_2bec904229ece9ed", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_919f68ad
	Checksum: 0x2F1DEB66
	Offset: 0x150
	Size: 0x104
	Parameters: 1
	Flags: Private
*/
function private on_begin(var_49106f6b)
{
	level.var_60aa7ebf = zm_trial::function_5769f26a(var_49106f6b);
	foreach(player in getplayers())
	{
		player.var_e47444a5 = [];
		player zm_trial_util::function_2190356a(0);
		player zm_trial_util::function_c2cd0cba(level.var_60aa7ebf);
	}
	callback::on_ai_killed(&on_ai_killed);
}

/*
	Name: on_end
	Namespace: namespace_919f68ad
	Checksum: 0x383329EB
	Offset: 0x260
	Size: 0x1D0
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	if(!round_reset)
	{
		var_696c3b4 = [];
		foreach(player in getplayers())
		{
			if(player.var_e47444a5.size < level.var_60aa7ebf)
			{
				if(!isdefined(var_696c3b4))
				{
					var_696c3b4 = [];
				}
				else if(!isarray(var_696c3b4))
				{
					var_696c3b4 = array(var_696c3b4);
				}
				var_696c3b4[var_696c3b4.size] = player;
			}
		}
		if(var_696c3b4.size)
		{
			zm_trial::fail(#"hash_2ad223a26dff12a0", var_696c3b4);
		}
	}
	callback::remove_on_ai_killed(&on_ai_killed);
	level.var_60aa7ebf = undefined;
	foreach(player in getplayers())
	{
		player zm_trial_util::function_f3aacffb();
	}
}

/*
	Name: is_active
	Namespace: namespace_919f68ad
	Checksum: 0xF342E355
	Offset: 0x438
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	challenge = zm_trial::function_a36e8c38(#"hash_2bec904229ece9ed");
	return isdefined(challenge);
}

/*
	Name: on_ai_killed
	Namespace: namespace_919f68ad
	Checksum: 0x18707BD0
	Offset: 0x478
	Size: 0x2C4
	Parameters: 1
	Flags: Private
*/
function private on_ai_killed(params)
{
	if(isplayer(params.eattacker))
	{
		player = params.eattacker;
	}
	else if(isplayer(params.einflictor))
	{
		player = params.einflictor;
	}
	if(!isdefined(player) || isai(params.einflictor))
	{
		return;
	}
	if(player.var_e47444a5.size >= level.var_60aa7ebf)
	{
		return;
	}
	if(zm_utility::is_mini_turret(params.weapon, 1))
	{
		w_root = getweapon(#"mini_turret");
	}
	else
	{
		if(zm_utility::function_850e7499(params.weapon, 1))
		{
			w_root = getweapon(#"eq_wraith_fire");
		}
		else
		{
			w_root = zm_weapons::function_93cd8e76(params.weapon, 1);
		}
	}
	if(isdefined(level.var_a601d6a6))
	{
		w_root = player [[level.var_a601d6a6]](w_root);
	}
	if(!isinarray(player.var_e47444a5, w_root))
	{
		if(!isdefined(player.var_e47444a5))
		{
			player.var_e47444a5 = [];
		}
		else if(!isarray(player.var_e47444a5))
		{
			player.var_e47444a5 = array(player.var_e47444a5);
		}
		player.var_e47444a5[player.var_e47444a5.size] = w_root;
		if(player.var_e47444a5.size == level.var_60aa7ebf)
		{
			player zm_trial_util::function_63060af4(1);
		}
		else
		{
			player zm_trial_util::function_2190356a(player.var_e47444a5.size);
			player zm_trial_util::function_c2cd0cba(level.var_60aa7ebf);
		}
	}
}

