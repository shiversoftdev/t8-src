// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_3f9e0dc8454d98e1;
#using script_6021ce59143452c3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_c1466447;

/*
	Name: function_89f2df9
	Namespace: namespace_c1466447
	Checksum: 0xD377626A
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_2f326252a6b5175", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_c1466447
	Checksum: 0xB37AF210
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
	namespace_f551babc::register_challenge(#"hash_322751dde777c910", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_c1466447
	Checksum: 0xACF263A
	Offset: 0x170
	Size: 0xD8
	Parameters: 2
	Flags: Private
*/
private function function_d1de6a85(var_c8a36f90, var_16e6b8ea)
{
	level.var_a96e21f8 = (isdefined(var_c8a36f90) ? var_c8a36f90 : "movement");
	var_16e6b8ea = namespace_f551babc::function_5769f26a(var_16e6b8ea);
	foreach(player in getplayers())
	{
		player thread function_1633056a(var_16e6b8ea);
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_c1466447
	Checksum: 0x6A945766
	Offset: 0x250
	Size: 0x16
	Parameters: 1
	Flags: Private
*/
private function function_9e7b3f4d(round_reset)
{
	level.var_a96e21f8 = undefined;
}

/*
	Name: function_1633056a
	Namespace: namespace_c1466447
	Checksum: 0xD338651C
	Offset: 0x270
	Size: 0xE4
	Parameters: 1
	Flags: Private
*/
private function function_1633056a(var_16e6b8ea = 10)
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	while(true)
	{
		if(isalive(self) && !self laststand::player_is_in_laststand() && self function_c81cdba2())
		{
			self playsoundtoplayer(#"hash_6df374d848ba6a60", self);
			self dodamage(var_16e6b8ea, self.origin);
			wait(1);
		}
		waitframe(1);
	}
}

/*
	Name: function_c81cdba2
	Namespace: namespace_c1466447
	Checksum: 0x73B7F9B8
	Offset: 0x360
	Size: 0x1AC
	Parameters: 0
	Flags: Private
*/
private function function_c81cdba2()
{
	switch(level.var_a96e21f8)
	{
		case "ads":
		{
			var_389b3ef1 = self playerads();
			if(self adsbuttonpressed() && var_389b3ef1 > 0)
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
		case "crouch":
		{
			if(self getstance() === "crouch")
			{
				return 1;
			}
			return 0;
		}
		case "sprint":
		{
			if(self issprinting())
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

