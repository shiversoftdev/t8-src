// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_58c342edd81589fb;
#using script_6021ce59143452c3;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_fd89d870;

/*
	Name: function_89f2df9
	Namespace: namespace_fd89d870
	Checksum: 0x4572C1CA
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_2ef1591c234e8773", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_fd89d870
	Checksum: 0x38872DA7
	Offset: 0xC8
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
	zm_trial::register_challenge(#"hash_6823bfb199f0c884", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_fd89d870
	Checksum: 0x651493B6
	Offset: 0x130
	Size: 0x184
	Parameters: 5
	Flags: Linked, Private
*/
private function function_d1de6a85(enemy_type, var_1f950d4d, var_81dcf087, var_d631185a, var_fe1bdf31)
{
	level.var_1c7412f9 = enemy_type;
	switch(getplayers().size)
	{
		case 1:
		{
			level.var_e34a018e = zm_trial::function_5769f26a(var_1f950d4d);
			break;
		}
		case 2:
		{
			level.var_e34a018e = zm_trial::function_5769f26a(var_81dcf087);
			break;
		}
		case 3:
		{
			level.var_e34a018e = zm_trial::function_5769f26a(var_d631185a);
			break;
		}
		case 4:
		{
			level.var_e34a018e = zm_trial::function_5769f26a(var_fe1bdf31);
			break;
		}
	}
	namespace_c3287616::function_c1571721(&function_51ec9e09);
	namespace_c3287616::function_54fee373(&function_1b1d71e7);
	namespace_c3287616::function_2876740e(level.var_1c7412f9, &function_a7c00976);
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_fd89d870
	Checksum: 0xD07F26D7
	Offset: 0x2C0
	Size: 0x8A
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	namespace_c3287616::function_9bf14a10(level.var_1c7412f9, &function_a7c00976);
	namespace_c3287616::function_510039c1(&function_51ec9e09);
	namespace_c3287616::function_375519eb(&function_1b1d71e7);
	level.var_1c7412f9 = undefined;
	level.var_e34a018e = undefined;
}

/*
	Name: is_active
	Namespace: namespace_fd89d870
	Checksum: 0x19200CA2
	Offset: 0x358
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function is_active(str_archetype)
{
	challenge = zm_trial::function_a36e8c38(#"hash_6823bfb199f0c884");
	if(isdefined(str_archetype))
	{
		return isdefined(challenge) && level.var_1c7412f9 === str_archetype;
	}
	return isdefined(challenge);
}

/*
	Name: function_a7c00976
	Namespace: namespace_fd89d870
	Checksum: 0xE780354E
	Offset: 0x3C8
	Size: 0x10
	Parameters: 1
	Flags: Linked
*/
function function_a7c00976(n_max)
{
	return 999;
}

/*
	Name: function_51ec9e09
	Namespace: namespace_fd89d870
	Checksum: 0xF2E7DBD1
	Offset: 0x3E0
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_51ec9e09(n_points)
{
	if(isdefined(level.var_819e7dfd[level.var_1c7412f9].var_f6a3b5b0))
	{
		var_dbce0c44 = level.var_819e7dfd[level.var_1c7412f9].var_f6a3b5b0 * level.var_e34a018e;
	}
	else
	{
		var_dbce0c44 = 1600;
	}
	return var_dbce0c44;
}

/*
	Name: function_1b1d71e7
	Namespace: namespace_fd89d870
	Checksum: 0xF5EF8996
	Offset: 0x458
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_1b1d71e7(var_8997f0f2)
{
	var_18f3c565 = getarraykeys(var_8997f0f2);
	foreach(str_archetype in var_18f3c565)
	{
		if(str_archetype === level.var_1c7412f9)
		{
			var_8997f0f2[str_archetype] = level.var_e34a018e;
			continue;
		}
		var_8997f0f2[str_archetype] = 0;
	}
	return var_8997f0f2;
}

