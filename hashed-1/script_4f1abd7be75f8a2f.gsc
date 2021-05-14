// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_aa42e727;

/*
	Name: function_89f2df9
	Namespace: namespace_aa42e727
	Checksum: 0xB83FB1CA
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_49eecaed064bc08d", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_aa42e727
	Checksum: 0xB7486B07
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
	zm_trial::register_challenge(#"hash_49eecaed064bc08d", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_aa42e727
	Checksum: 0xAF9A0F71
	Offset: 0x140
	Size: 0x164
	Parameters: 4
	Flags: Linked, Private
*/
private function function_d1de6a85(var_8a72a00b, var_49d8a02c, var_325ff213, var_dd2fad64)
{
	switch(getplayers().size)
	{
		case 1:
		{
			level.var_b07feb9b = zm_trial::function_5769f26a(var_8a72a00b);
			break;
		}
		case 2:
		{
			level.var_b07feb9b = zm_trial::function_5769f26a(var_49d8a02c);
			break;
		}
		case 3:
		{
			level.var_b07feb9b = zm_trial::function_5769f26a(var_325ff213);
			break;
		}
		case 4:
		{
			level.var_b07feb9b = zm_trial::function_5769f26a(var_dd2fad64);
			break;
		}
	}
	level.var_61541a89 = 0;
	level thread function_c80f40af();
	level namespace_b22c99a5::function_2976fa44(level.var_b07feb9b);
	level namespace_b22c99a5::function_dace284(level.var_61541a89);
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_aa42e727
	Checksum: 0x39A72F4C
	Offset: 0x2B0
	Size: 0xEE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	if(!round_reset)
	{
		if(level.var_61541a89 < level.var_b07feb9b)
		{
			zm_trial::fail(#"hash_73f632514ab7d15", getplayers());
		}
	}
	foreach(player in getplayers())
	{
		player namespace_b22c99a5::function_f3aacffb();
	}
	level.var_b07feb9b = undefined;
	level.var_61541a89 = undefined;
}

/*
	Name: function_c80f40af
	Namespace: namespace_aa42e727
	Checksum: 0xD7B59E9B
	Offset: 0x3A8
	Size: 0x100
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c80f40af()
{
	level endon(#"hash_7646638df88a3656");
	while(level.var_61541a89 < level.var_b07feb9b)
	{
		s_result = undefined;
		s_result = level waittill(#"hash_1ba786f1661e3817");
		level.var_61541a89 = level.var_61541a89 + s_result.var_2ef2374;
		if(level.var_61541a89 < level.var_b07feb9b)
		{
			level namespace_b22c99a5::function_2976fa44(level.var_b07feb9b);
			level namespace_b22c99a5::function_dace284(level.var_61541a89);
		}
		if(level.var_61541a89 >= level.var_b07feb9b)
		{
			level namespace_b22c99a5::function_7d32b7d0(1);
		}
	}
}

