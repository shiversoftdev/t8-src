// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_3f9e0dc8454d98e1;
#using script_6021ce59143452c3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_ab88201b;

/*
	Name: function_89f2df9
	Namespace: namespace_ab88201b
	Checksum: 0x77C4AF91
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_77812dea54caab85", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ab88201b
	Checksum: 0x990342CA
	Offset: 0x120
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
	zm_trial::register_challenge(#"hash_6840f605489bddc2", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_ab88201b
	Checksum: 0x90248AE2
	Offset: 0x188
	Size: 0xB0
	Parameters: 1
	Flags: Private
*/
private function function_d1de6a85(var_c8a36f90)
{
	level.var_2bd4c60 = (isdefined(var_c8a36f90) ? var_c8a36f90 : "movement");
	foreach(player in getplayers())
	{
		player thread function_1633056a();
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_ab88201b
	Checksum: 0x45E1F0B3
	Offset: 0x240
	Size: 0xB0
	Parameters: 1
	Flags: Private
*/
private function function_9e7b3f4d(round_reset)
{
	level.var_2bd4c60 = undefined;
	foreach(player in getplayers())
	{
		player val::reset(#"hash_10a425ccc9bbccad", "health_regen");
	}
}

/*
	Name: function_1633056a
	Namespace: namespace_ab88201b
	Checksum: 0x48A173A7
	Offset: 0x2F8
	Size: 0xE6
	Parameters: 0
	Flags: Private
*/
private function function_1633056a()
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	while(true)
	{
		if(self function_26f124d8() && !self.heal.enabled)
		{
			self val::reset(#"hash_10a425ccc9bbccad", "health_regen");
		}
		else if(!self function_26f124d8() && self.heal.enabled)
		{
			self val::set(#"hash_10a425ccc9bbccad", "health_regen", 0);
		}
		waitframe(1);
	}
}

/*
	Name: function_26f124d8
	Namespace: namespace_ab88201b
	Checksum: 0x455F4FF6
	Offset: 0x3E8
	Size: 0x1D4
	Parameters: 0
	Flags: Private
*/
private function function_26f124d8()
{
	switch(level.var_2bd4c60)
	{
		case "ads":
		{
			if(self playerads() == 1)
			{
				return 1;
			}
			return 0;
		}
		case "jump":
		{
			if(self zm_utility::is_jumping())
			{
				return 1;
			}
			return 0;
		}
		case "slide":
		{
			if(self issliding())
			{
				return 1;
			}
			return 0;
		}
		case "hash_6c6c8f6b349b8751":
		{
			if(self zm_utility::is_jumping() || self issliding())
			{
				return 1;
			}
			return 0;
		}
		case "crouch":
		{
			if(self getstance() === "crouch")
			{
				return 1;
			}
			return 0;
		}
		case "prone":
		{
			if(self getstance() === "prone")
			{
				return 1;
			}
			return 0;
		}
		case "movement":
		default:
		{
			v_velocity = self getvelocity();
			if(length(v_velocity) != 0)
			{
				return 1;
			}
			return 0;
		}
	}
	return 0;
}

