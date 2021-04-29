// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_11abec5a;

/*
	Name: function_89f2df9
	Namespace: namespace_11abec5a
	Checksum: 0xCBF90966
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_53a5a75770adb550", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_11abec5a
	Checksum: 0xD7C83D40
	Offset: 0x108
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!namespace_f551babc::function_b47f6aba())
	{
		return;
	}
	namespace_f551babc::register_challenge(#"hash_53a5a75770adb550", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_11abec5a
	Checksum: 0xC3944B8C
	Offset: 0x170
	Size: 0x3B8
	Parameters: 7
	Flags: Private
*/
private function function_d1de6a85(var_8a72a00b, var_49d8a02c, var_325ff213, var_dd2fad64, var_873a1b70, var_957937ee, var_9c56c5a9)
{
	switch(getplayers().size)
	{
		case 1:
		{
			level.var_b4a6cec6 = namespace_f551babc::function_5769f26a(var_8a72a00b);
			break;
		}
		case 2:
		{
			level.var_b4a6cec6 = namespace_f551babc::function_5769f26a(var_49d8a02c);
			break;
		}
		case 3:
		{
			level.var_b4a6cec6 = namespace_f551babc::function_5769f26a(var_325ff213);
			break;
		}
		case 4:
		{
			level.var_b4a6cec6 = namespace_f551babc::function_5769f26a(var_dd2fad64);
			break;
		}
	}
	if(isdefined(var_873a1b70))
	{
		if(!isdefined(level.var_692c062e))
		{
			level.var_692c062e = [];
		}
		else if(!isarray(level.var_692c062e))
		{
			level.var_692c062e = array(level.var_692c062e);
		}
		level.var_692c062e[level.var_692c062e.size] = getweapon(var_873a1b70);
	}
	if(isdefined(var_957937ee))
	{
		if(!isdefined(level.var_692c062e))
		{
			level.var_692c062e = [];
		}
		else if(!isarray(level.var_692c062e))
		{
			level.var_692c062e = array(level.var_692c062e);
		}
		level.var_692c062e[level.var_692c062e.size] = getweapon(var_957937ee);
	}
	if(isdefined(var_9c56c5a9))
	{
		if(!isdefined(level.var_692c062e))
		{
			level.var_692c062e = [];
		}
		else if(!isarray(level.var_692c062e))
		{
			level.var_692c062e = array(level.var_692c062e);
		}
		level.var_692c062e[level.var_692c062e.size] = getweapon(var_9c56c5a9);
	}
	callback::on_ai_killed(&on_ai_killed);
	foreach(player in getplayers())
	{
		player.var_b4a6cec6 = 0;
		player namespace_b22c99a5::function_c2cd0cba(level.var_b4a6cec6);
		player namespace_b22c99a5::function_2190356a(player.var_b4a6cec6);
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_11abec5a
	Checksum: 0xF0B1FBF7
	Offset: 0x530
	Size: 0x1C2
	Parameters: 1
	Flags: Private
*/
private function function_9e7b3f4d(round_reset)
{
	callback::remove_on_ai_killed(&on_ai_killed);
	if(!round_reset)
	{
		var_696c3b4 = [];
		foreach(player in getplayers())
		{
			if(player.var_b4a6cec6 < level.var_b4a6cec6)
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
			namespace_f551babc::fail(#"hash_73f632514ab7d15", var_696c3b4);
		}
	}
	foreach(player in getplayers())
	{
		player namespace_b22c99a5::function_f3aacffb();
	}
	level.var_b4a6cec6 = undefined;
}

/*
	Name: on_ai_killed
	Namespace: namespace_11abec5a
	Checksum: 0xBCE16EDD
	Offset: 0x700
	Size: 0x1BC
	Parameters: 1
	Flags: Private
*/
private function on_ai_killed(params)
{
	w_root = zm_weapons::function_386dacbc(params.weapon);
	b_valid_weapon = 0;
	if(isinarray(level.var_692c062e, w_root))
	{
		b_valid_weapon = 1;
	}
	else if(w_root === getweapon(#"zhield_zpear_dw") && (params.smeansofdeath === "MOD_PROJECTILE" || params.smeansofdeath === "MOD_PROJECTILE_SPLASH"))
	{
		b_valid_weapon = 1;
	}
	if(isplayer(params.eattacker) && b_valid_weapon)
	{
		params.eattacker.var_b4a6cec6++;
		if(params.eattacker.var_b4a6cec6 < level.var_b4a6cec6)
		{
			params.eattacker namespace_b22c99a5::function_c2cd0cba(level.var_b4a6cec6);
			params.eattacker namespace_b22c99a5::function_2190356a(params.eattacker.var_b4a6cec6);
		}
		if(params.eattacker.var_b4a6cec6 == level.var_b4a6cec6)
		{
			params.eattacker namespace_b22c99a5::function_63060af4(1);
		}
	}
}

/*
	Name: is_active
	Namespace: namespace_11abec5a
	Checksum: 0x1A12C0F4
	Offset: 0x8C8
	Size: 0x96
	Parameters: 1
	Flags: None
*/
function is_active(var_a75461b4)
{
	s_challenge = namespace_f551babc::function_a36e8c38(#"hash_53a5a75770adb550");
	if(isdefined(var_a75461b4))
	{
		if(isdefined(s_challenge) && isarray(level.var_692c062e) && isinarray(level.var_692c062e, var_a75461b4))
		{
			return 1;
		}
		return 0;
	}
	return isdefined(s_challenge);
}

