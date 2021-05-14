// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_spawner.gsc;

#namespace namespace_d6ef1c07;

/*
	Name: function_89f2df9
	Namespace: namespace_d6ef1c07
	Checksum: 0x44FD71B8
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_413d188382cb271f", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d6ef1c07
	Checksum: 0xF0AB0F9D
	Offset: 0xE0
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
	zm_trial::register_challenge(#"hash_2af7adc2570e0a8e", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_d6ef1c07
	Checksum: 0x71A23571
	Offset: 0x148
	Size: 0x1FC
	Parameters: 4
	Flags: Linked, Private
*/
private function function_d1de6a85(var_2a54eca1, var_b3fc75a6, var_40988d98, var_968ac18f)
{
	switch(getplayers().size)
	{
		case 1:
		{
			level.var_5a9bcbe4 = zm_trial::function_5769f26a(var_2a54eca1);
			break;
		}
		case 2:
		{
			level.var_5a9bcbe4 = zm_trial::function_5769f26a(var_b3fc75a6);
			break;
		}
		case 3:
		{
			level.var_5a9bcbe4 = zm_trial::function_5769f26a(var_40988d98);
			break;
		}
		case 4:
		{
			level.var_5a9bcbe4 = zm_trial::function_5769f26a(var_968ac18f);
			break;
		}
	}
	foreach(player in getplayers())
	{
		player.var_5a9bcbe4 = 0;
		player namespace_b22c99a5::function_c2cd0cba(level.var_5a9bcbe4);
		player namespace_b22c99a5::function_2190356a(player.var_5a9bcbe4, 1);
		player thread function_7f62f098(level);
	}
	zm_spawner::register_zombie_death_event_callback(&function_138aec8e);
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_d6ef1c07
	Checksum: 0x36821D0C
	Offset: 0x350
	Size: 0x22C
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
			if(player.var_5a9bcbe4 < level.var_5a9bcbe4)
			{
				array::add(var_57807cdc, player, 0);
			}
		}
		if(var_57807cdc.size == 1)
		{
			zm_trial::fail(#"hash_788ffc8d7448f05", var_57807cdc);
		}
		else if(var_57807cdc.size > 1)
		{
			zm_trial::fail(#"hash_2bf9eb58ed3ac518", var_57807cdc);
		}
	}
	foreach(player in getplayers())
	{
		player.var_5a9bcbe4 = undefined;
	}
	zm_spawner::deregister_zombie_death_event_callback(&function_138aec8e);
}

/*
	Name: function_7f62f098
	Namespace: namespace_d6ef1c07
	Checksum: 0x609BEDB0
	Offset: 0x588
	Size: 0x12E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7f62f098(challenge)
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	while(true)
	{
		var_96936cca = self.var_5a9bcbe4;
		if(var_96936cca < 0)
		{
			var_96936cca = 0;
		}
		else if(var_96936cca > challenge.var_5a9bcbe4)
		{
			var_96936cca = challenge.var_5a9bcbe4;
		}
		self namespace_b22c99a5::function_2190356a(var_96936cca, 1);
		if(var_96936cca < challenge.var_5a9bcbe4)
		{
			self namespace_b22c99a5::function_c2cd0cba(challenge.var_5a9bcbe4);
			self namespace_b22c99a5::function_2190356a(var_96936cca, 1);
		}
		if(var_96936cca == challenge.var_5a9bcbe4)
		{
			self namespace_b22c99a5::function_63060af4(1, 1);
		}
		waitframe(1);
	}
}

/*
	Name: function_138aec8e
	Namespace: namespace_d6ef1c07
	Checksum: 0xC831A75A
	Offset: 0x6C0
	Size: 0xD4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_138aec8e(attacker)
{
	if(isdefined(self.var_6e2628f7) && self.var_6e2628f7)
	{
		if(isdefined(self.nuked) && self.nuked)
		{
			foreach(player in getplayers())
			{
				player.var_5a9bcbe4++;
			}
			return;
		}
		if(isplayer(attacker))
		{
			attacker.var_5a9bcbe4++;
		}
	}
}

