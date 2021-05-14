// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_94d4f09f;

/*
	Name: function_89f2df9
	Namespace: namespace_94d4f09f
	Checksum: 0x11A299E4
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_671231fa368e1829", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_94d4f09f
	Checksum: 0x92A24891
	Offset: 0xD8
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
	zm_trial::register_challenge(#"hash_671231fa368e1829", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_94d4f09f
	Checksum: 0x79EBB4C2
	Offset: 0x140
	Size: 0x16C
	Parameters: 4
	Flags: Linked, Private
*/
private function function_d1de6a85(var_8a72a00b, var_49d8a02c, var_325ff213, var_dd2fad64)
{
	switch(getplayers().size)
	{
		case 1:
		{
			level.var_cad0c0ee = zm_trial::function_5769f26a(var_8a72a00b);
			break;
		}
		case 2:
		{
			level.var_cad0c0ee = zm_trial::function_5769f26a(var_49d8a02c);
			break;
		}
		case 3:
		{
			level.var_cad0c0ee = zm_trial::function_5769f26a(var_325ff213);
			break;
		}
		case 4:
		{
			level.var_cad0c0ee = zm_trial::function_5769f26a(var_dd2fad64);
			break;
		}
	}
	level.var_fb4c4cca = 0;
	callback::on_ai_killed(&on_ai_killed);
	level namespace_b22c99a5::function_2976fa44(level.var_cad0c0ee);
	level namespace_b22c99a5::function_dace284(level.var_fb4c4cca);
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_94d4f09f
	Checksum: 0x7F6E4063
	Offset: 0x2B8
	Size: 0x10E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	callback::remove_on_ai_killed(&on_ai_killed);
	if(!round_reset)
	{
		if(level.var_fb4c4cca < level.var_cad0c0ee)
		{
			zm_trial::fail(#"hash_73f632514ab7d15", getplayers());
		}
	}
	foreach(player in getplayers())
	{
		player namespace_b22c99a5::function_f3aacffb();
	}
	level.var_cad0c0ee = undefined;
	level.var_fb4c4cca = undefined;
}

/*
	Name: on_ai_killed
	Namespace: namespace_94d4f09f
	Checksum: 0xD51F10DC
	Offset: 0x3D0
	Size: 0xAC
	Parameters: 1
	Flags: Linked, Private
*/
private function on_ai_killed(params)
{
	if(self.var_bf8dfaf4 === 1)
	{
		level.var_fb4c4cca++;
		if(level.var_fb4c4cca < level.var_cad0c0ee)
		{
			level namespace_b22c99a5::function_2976fa44(level.var_cad0c0ee);
			level namespace_b22c99a5::function_dace284(level.var_fb4c4cca);
		}
		if(level.var_fb4c4cca == level.var_cad0c0ee)
		{
			level namespace_b22c99a5::function_7d32b7d0(1);
		}
	}
}

/*
	Name: is_active
	Namespace: namespace_94d4f09f
	Checksum: 0x38500643
	Offset: 0x488
	Size: 0x96
	Parameters: 1
	Flags: None
*/
function is_active(var_a75461b4)
{
	s_challenge = zm_trial::function_a36e8c38(#"hash_53a5a75770adb550");
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

