// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_a7aeae56;

/*
	Name: function_89f2df9
	Namespace: namespace_a7aeae56
	Checksum: 0xCE8E3060
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
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
	if(!namespace_f551babc::function_b47f6aba())
	{
		return;
	}
	namespace_f551babc::register_challenge(#"hash_32bd34ef989ddd03", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_a7aeae56
	Checksum: 0xBB1F17A6
	Offset: 0x148
	Size: 0x100
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d1de6a85(n_count)
{
	callback::function_aebeafc0(&function_aebeafc0);
	level.var_195590fb = namespace_f551babc::function_5769f26a(n_count);
	foreach(player in getplayers())
	{
		player.var_92cd5237 = [];
		player namespace_b22c99a5::function_c2cd0cba(level.var_195590fb);
		player namespace_b22c99a5::function_2190356a(0);
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_a7aeae56
	Checksum: 0xEBA8EDB9
	Offset: 0x250
	Size: 0x1D4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	foreach(player in getplayers())
	{
		player namespace_b22c99a5::function_f3aacffb();
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
			namespace_f551babc::fail(#"hash_6dbd3c476c903f66", var_57807cdc);
		}
		else if(var_57807cdc.size > 1)
		{
			namespace_f551babc::fail(#"hash_59d734dda39935cf", var_57807cdc);
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
private function function_aebeafc0(var_61685cd)
{
	w_base = zm_weapons::get_base_weapon(var_61685cd);
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
		namespace_b22c99a5::function_2190356a(self.var_92cd5237.size);
	}
}

