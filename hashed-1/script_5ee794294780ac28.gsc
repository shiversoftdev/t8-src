// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_919f68ad;

/*
	Name: function_89f2df9
	Namespace: namespace_919f68ad
	Checksum: 0xE185A5EC
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
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
	zm_trial::register_challenge(#"hash_2bec904229ece9ed", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_919f68ad
	Checksum: 0x2F1DEB66
	Offset: 0x150
	Size: 0x104
	Parameters: 1
	Flags: Private
*/
function private function_d1de6a85(var_49106f6b)
{
	level.var_60aa7ebf = zm_trial::function_5769f26a(var_49106f6b);
	foreach(player in getplayers())
	{
		player.var_e47444a5 = [];
		player namespace_b22c99a5::function_2190356a(0);
		player namespace_b22c99a5::function_c2cd0cba(level.var_60aa7ebf);
	}
	callback::on_ai_killed(&on_ai_killed);
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_919f68ad
	Checksum: 0x383329EB
	Offset: 0x260
	Size: 0x1D0
	Parameters: 1
	Flags: Private
*/
function private function_9e7b3f4d(round_reset)
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
		player namespace_b22c99a5::function_f3aacffb();
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
			w_root = getweapon(#"hash_c78156ba6aeda14");
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
			player namespace_b22c99a5::function_63060af4(1);
		}
		else
		{
			player namespace_b22c99a5::function_2190356a(player.var_e47444a5.size);
			player namespace_b22c99a5::function_c2cd0cba(level.var_60aa7ebf);
		}
	}
}

