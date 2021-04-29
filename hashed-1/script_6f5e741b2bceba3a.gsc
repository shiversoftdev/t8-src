// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_32db4ab8dcf85b70;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_d9987f47;

/*
	Name: function_89f2df9
	Namespace: namespace_d9987f47
	Checksum: 0xAF059E9C
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_638b17bfdc64795a", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d9987f47
	Checksum: 0xDB05AA0C
	Offset: 0xF0
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
	namespace_f551babc::register_challenge(#"hash_168c1517a89a7cd", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_d9987f47
	Checksum: 0xCFC5877D
	Offset: 0x158
	Size: 0x204
	Parameters: 2
	Flags: Linked, Private
*/
private function function_d1de6a85(var_b3d469ae, var_5cd0152f)
{
	level.var_21c2f32a = namespace_f551babc::function_5769f26a(var_b3d469ae);
	n_cost = namespace_f551babc::function_5769f26a(var_5cd0152f);
	level.var_943b6e2b = array();
	foreach(s_wallbuy in level._spawned_wallbuys)
	{
		s_wallbuy.trigger_stub namespace_92cb027a::function_641f4ec(&namespace_92cb027a::function_91256361, &namespace_92cb027a::function_c6c9b014, n_cost, "discharge_wallbuy");
	}
	foreach(player in getplayers())
	{
		player namespace_b22c99a5::function_c2cd0cba(level.var_21c2f32a);
		player namespace_b22c99a5::function_2190356a(0);
		level.var_943b6e2b[player.clientid] = array();
	}
	level thread function_50297e53();
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_d9987f47
	Checksum: 0x57CFBE08
	Offset: 0x368
	Size: 0x2A0
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	if(!round_reset)
	{
		var_696c3b4 = array();
		foreach(player in getplayers())
		{
			if(level.var_943b6e2b[player.clientid].size < level.var_21c2f32a)
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
		if(var_696c3b4.size == 1)
		{
			namespace_f551babc::fail(#"hash_75977ef6e92a8fb9", var_696c3b4);
		}
		else if(var_696c3b4.size > 1)
		{
			namespace_f551babc::fail(#"hash_b877496afcd42c8", var_696c3b4);
		}
	}
	level.var_21c2f32a = undefined;
	level.var_943b6e2b = undefined;
	level notify(#"hash_31c14df051f6c165");
	foreach(player in getplayers())
	{
		player namespace_b22c99a5::function_f3aacffb();
	}
	foreach(s_wallbuy in level._spawned_wallbuys)
	{
		s_wallbuy.trigger_stub namespace_92cb027a::function_cf62f3c7();
	}
}

/*
	Name: is_active
	Namespace: namespace_d9987f47
	Checksum: 0x1FA42C84
	Offset: 0x610
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	challenge = namespace_f551babc::function_a36e8c38(#"hash_168c1517a89a7cd");
	return isdefined(challenge);
}

/*
	Name: function_50297e53
	Namespace: namespace_d9987f47
	Checksum: 0x2042692E
	Offset: 0x650
	Size: 0x220
	Parameters: 0
	Flags: Linked, Private
*/
private function function_50297e53()
{
	level endon(#"hash_31c14df051f6c165", #"game_ended");
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = level waittill(#"weapon_bought");
		e_player = var_385703b7.player;
		if(!isinarray(level.var_943b6e2b[e_player.clientid], var_385703b7.weapon))
		{
			if(!isdefined(level.var_943b6e2b[e_player.clientid]))
			{
				level.var_943b6e2b[e_player.clientid] = [];
			}
			else if(!isarray(level.var_943b6e2b[e_player.clientid]))
			{
				level.var_943b6e2b[e_player.clientid] = array(level.var_943b6e2b[e_player.clientid]);
			}
			level.var_943b6e2b[e_player.clientid][level.var_943b6e2b[e_player.clientid].size] = var_385703b7.weapon;
		}
		if(level.var_943b6e2b[e_player.clientid].size < level.var_21c2f32a)
		{
			e_player namespace_b22c99a5::function_2190356a(level.var_943b6e2b[e_player.clientid].size);
		}
		if(self.var_943b6e2b[e_player.clientid].size >= level.var_21c2f32a)
		{
			e_player namespace_b22c99a5::function_63060af4(1);
		}
	}
}

