// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_spawner.gsc;

#namespace namespace_ea9baedf;

/*
	Name: function_89f2df9
	Namespace: namespace_ea9baedf
	Checksum: 0x4C70B33B
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_c25f006b5e1726d", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ea9baedf
	Checksum: 0xCCB6DCC5
	Offset: 0xE0
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
	namespace_f551babc::register_challenge(#"hash_7735a2dc4298e55c", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_ea9baedf
	Checksum: 0x4EF89EC8
	Offset: 0x148
	Size: 0x174
	Parameters: 1
	Flags: Private
*/
private function function_d1de6a85(kill_count)
{
	self.kill_count = namespace_f551babc::function_5769f26a(kill_count);
	foreach(player in getplayers())
	{
		player.var_c957540c = 0;
	}
	zm_spawner::register_zombie_death_event_callback(&function_138aec8e);
	namespace_b22c99a5::function_c2cd0cba(self.kill_count);
	foreach(player in getplayers())
	{
		player thread function_7f62f098(self);
	}
	level thread function_69c5df45(self);
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_ea9baedf
	Checksum: 0x782F7331
	Offset: 0x2C8
	Size: 0x22C
	Parameters: 1
	Flags: Private
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
			if(player.var_c957540c < self.kill_count)
			{
				array::add(var_57807cdc, player, 0);
			}
		}
		if(var_57807cdc.size == 1)
		{
			namespace_f551babc::fail(#"hash_788ffc8d7448f05", var_57807cdc);
		}
		else if(var_57807cdc.size > 1)
		{
			namespace_f551babc::fail(#"hash_2bf9eb58ed3ac518", var_57807cdc);
		}
	}
	foreach(player in getplayers())
	{
		player.var_c957540c = undefined;
	}
	zm_spawner::deregister_zombie_death_event_callback(&function_138aec8e);
}

/*
	Name: function_7f62f098
	Namespace: namespace_ea9baedf
	Checksum: 0xFDED20E
	Offset: 0x500
	Size: 0xA6
	Parameters: 1
	Flags: Private
*/
private function function_7f62f098(challenge)
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	while(true)
	{
		var_96936cca = self.var_c957540c;
		if(var_96936cca < 0)
		{
			var_96936cca = 0;
		}
		else if(var_96936cca > challenge.kill_count)
		{
			var_96936cca = challenge.kill_count;
		}
		self namespace_b22c99a5::function_2190356a(var_96936cca);
		waitframe(1);
	}
}

/*
	Name: function_69c5df45
	Namespace: namespace_ea9baedf
	Checksum: 0x318F332A
	Offset: 0x5B0
	Size: 0x18E
	Parameters: 1
	Flags: Private
*/
private function function_69c5df45(challenge)
{
	level endon(#"hash_7646638df88a3656");
	while(true)
	{
		/#
			assert(isdefined(challenge));
		#/
		end_round = 1;
		foreach(player in getplayers())
		{
			if(player.var_c957540c < challenge.kill_count)
			{
				end_round = 0;
			}
		}
		if(end_round)
		{
			enemies = getaiteamarray(level.zombie_team);
			if(isdefined(enemies))
			{
				for(i = 0; i < enemies.size; i++)
				{
					enemies[i] dodamage(enemies[i].health + 666, enemies[i].origin);
				}
			}
			level.zombie_total = 0;
			return;
		}
		waitframe(1);
	}
}

/*
	Name: function_138aec8e
	Namespace: namespace_ea9baedf
	Checksum: 0xCA60014D
	Offset: 0x748
	Size: 0xBC
	Parameters: 1
	Flags: Private
*/
private function function_138aec8e(attacker)
{
	if(isdefined(self.nuked) && self.nuked)
	{
		foreach(player in getplayers())
		{
			player.var_c957540c++;
		}
		return;
	}
	if(isplayer(attacker))
	{
		attacker.var_c957540c++;
	}
}

