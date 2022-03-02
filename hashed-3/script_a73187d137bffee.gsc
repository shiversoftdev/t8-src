// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_b8821044;

/*
	Name: function_89f2df9
	Namespace: namespace_b8821044
	Checksum: 0xDF4E7CFC
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_5487d35db80fc14", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b8821044
	Checksum: 0xC69902C8
	Offset: 0xE0
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
	zm_trial::register_challenge(#"hash_29065f0efd8d6ff3", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_b8821044
	Checksum: 0xD3E63BCA
	Offset: 0x148
	Size: 0x134
	Parameters: 1
	Flags: Private
*/
function private function_d1de6a85(var_b3d469ae)
{
	level.var_21c2f32a = zm_trial::function_5769f26a(var_b3d469ae);
	level.var_943b6e2b = array();
	foreach(player in getplayers())
	{
		player namespace_b22c99a5::function_c2cd0cba(level.var_21c2f32a);
		player namespace_b22c99a5::function_2190356a(0);
		level.var_943b6e2b[player.clientid] = array();
	}
	level thread wallbuy_watcher();
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_b8821044
	Checksum: 0xCF2771C2
	Offset: 0x288
	Size: 0x220
	Parameters: 1
	Flags: Private
*/
function private function_9e7b3f4d(round_reset)
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
			zm_trial::fail(#"hash_75977ef6e92a8fb9", var_696c3b4);
		}
		else if(var_696c3b4.size > 1)
		{
			zm_trial::fail(#"hash_b877496afcd42c8", var_696c3b4);
		}
	}
	level.var_21c2f32a = undefined;
	level.var_943b6e2b = undefined;
	level notify(#"hash_31c14df051f6c165");
	foreach(player in getplayers())
	{
		player namespace_b22c99a5::function_f3aacffb();
	}
}

/*
	Name: is_active
	Namespace: namespace_b8821044
	Checksum: 0xF4E7A359
	Offset: 0x4B0
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	challenge = zm_trial::function_a36e8c38(#"hash_29065f0efd8d6ff3");
	return isdefined(challenge);
}

/*
	Name: wallbuy_watcher
	Namespace: namespace_b8821044
	Checksum: 0xE0DCE62B
	Offset: 0x4F0
	Size: 0x1E0
	Parameters: 0
	Flags: Private
*/
function private wallbuy_watcher()
{
	level endon(#"hash_31c14df051f6c165", #"game_ended");
	while(true)
	{
		s_notify = undefined;
		s_notify = level waittill(#"weapon_bought");
		e_player = s_notify.player;
		if(!isinarray(level.var_943b6e2b[e_player.clientid], s_notify.weapon))
		{
			if(!isdefined(level.var_943b6e2b[e_player.clientid]))
			{
				level.var_943b6e2b[e_player.clientid] = [];
			}
			else if(!isarray(level.var_943b6e2b[e_player.clientid]))
			{
				level.var_943b6e2b[e_player.clientid] = array(level.var_943b6e2b[e_player.clientid]);
			}
			level.var_943b6e2b[e_player.clientid][level.var_943b6e2b[e_player.clientid].size] = s_notify.weapon;
		}
		if(level.var_943b6e2b[e_player.clientid].size <= level.var_21c2f32a)
		{
			e_player namespace_b22c99a5::function_2190356a(level.var_943b6e2b[e_player.clientid].size);
		}
	}
}

