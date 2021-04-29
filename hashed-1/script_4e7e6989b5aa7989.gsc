// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14af1fd264ffe8cc;
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_score.gsc;

#namespace namespace_3e1fd6e6;

/*
	Name: function_89f2df9
	Namespace: namespace_3e1fd6e6
	Checksum: 0xE238CB33
	Offset: 0xC8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_2c97516cc37baa4b", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_3e1fd6e6
	Checksum: 0x5923CC
	Offset: 0x110
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
	namespace_f551babc::register_challenge(#"hash_68f514af0bd7872c", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_3e1fd6e6
	Checksum: 0x20A007BA
	Offset: 0x178
	Size: 0xEC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d1de6a85()
{
	foreach(player in getplayers())
	{
		player thread function_29bcf2f8();
	}
	callback::on_ai_spawned(&on_ai_spawned);
	callback::on_ai_killed(&on_ai_killed);
	level.var_ddd04c77 = 0;
	level thread function_6fa5c86();
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_3e1fd6e6
	Checksum: 0x1786B205
	Offset: 0x270
	Size: 0x1EC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	if(!round_reset)
	{
		var_ef7fbb73 = [];
		foreach(player in getplayers())
		{
			if(!player.var_bfc22435)
			{
				if(!isdefined(var_ef7fbb73))
				{
					var_ef7fbb73 = [];
				}
				else if(!isarray(var_ef7fbb73))
				{
					var_ef7fbb73 = array(var_ef7fbb73);
				}
				var_ef7fbb73[var_ef7fbb73.size] = player;
			}
		}
		if(var_ef7fbb73.size)
		{
			namespace_f551babc::fail(undefined, var_ef7fbb73);
		}
	}
	foreach(player in getplayers())
	{
		player.var_bfc22435 = undefined;
		player namespace_b22c99a5::function_f3aacffb();
	}
	level flag::clear("infinite_round_spawning");
	level.var_ddd04c77 = undefined;
	callback::remove_on_ai_spawned(&on_ai_spawned);
	callback::remove_on_ai_killed(&on_ai_killed);
}

/*
	Name: function_29bcf2f8
	Namespace: namespace_3e1fd6e6
	Checksum: 0x751A87DE
	Offset: 0x468
	Size: 0x23A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_29bcf2f8()
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	self.var_bfc22435 = 0;
	if(isdefined(self.var_7a281a7e))
	{
		self.var_7a281a7e.b_timeout = 1;
	}
	if(isarray(level.var_d1c9bbc4))
	{
		arrayremovevalue(level.var_d1c9bbc4, undefined);
		foreach(var_8c04c69e in level.var_d1c9bbc4)
		{
			var_8c04c69e.b_timeout = 1;
		}
	}
	self notify(#"challenge_reward_timeout");
	self notify(#"spew_reward_picked_up");
	if(isdefined(self.s_tribute_bowl) && isdefined(self.s_tribute_bowl.var_9d32404))
	{
		self.s_tribute_bowl.var_9d32404 clientfield::set("" + #"hash_21f5fab6a3d22093", 0);
	}
	self namespace_f8f28e08::function_71c9ab64(0);
	self namespace_f8f28e08::function_ae2c0ba5();
	self namespace_b22c99a5::function_63060af4(0);
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"hash_24326081081c2468");
		if(var_be17187b.var_9e09931e === 4)
		{
			self.var_bfc22435 = 1;
			self namespace_b22c99a5::function_63060af4(1);
			return;
		}
	}
}

/*
	Name: function_6fa5c86
	Namespace: namespace_3e1fd6e6
	Checksum: 0x58E1A5E3
	Offset: 0x6B0
	Size: 0x128
	Parameters: 0
	Flags: Linked, Private
*/
private function function_6fa5c86()
{
	level endon(#"hash_7646638df88a3656");
	level flag::set("infinite_round_spawning");
	while(true)
	{
		var_84579c01 = 1;
		foreach(player in getplayers())
		{
			if(isalive(player) && (!(isdefined(player.var_bfc22435) && player.var_bfc22435)))
			{
				var_84579c01 = 0;
				break;
			}
		}
		if(var_84579c01)
		{
			level flag::clear("infinite_round_spawning");
			return;
		}
		wait(1);
	}
}

/*
	Name: on_ai_spawned
	Namespace: namespace_3e1fd6e6
	Checksum: 0x799E343D
	Offset: 0x7E0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_ai_spawned()
{
	self thread function_d52378b3();
}

/*
	Name: function_d52378b3
	Namespace: namespace_3e1fd6e6
	Checksum: 0xD641D94
	Offset: 0x808
	Size: 0x84
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d52378b3()
{
	self endon(#"death");
	level endon(#"hash_7646638df88a3656");
	wait(1);
	if(!(isdefined(self.var_12745932) && self.var_12745932))
	{
		level.var_ddd04c77++;
		if(level.var_ddd04c77 >= level.var_38b15968)
		{
			self zm_score::function_acaab828(1);
		}
	}
}

/*
	Name: on_ai_killed
	Namespace: namespace_3e1fd6e6
	Checksum: 0xAB61FE27
	Offset: 0x898
	Size: 0x30
	Parameters: 1
	Flags: Linked
*/
function on_ai_killed(params)
{
	if(isdefined(self.var_c39323b5) && self.var_c39323b5)
	{
		level.var_ddd04c77--;
	}
}

/*
	Name: is_active
	Namespace: namespace_3e1fd6e6
	Checksum: 0x2FE25F04
	Offset: 0x8D0
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function is_active()
{
	s_challenge = namespace_f551babc::function_a36e8c38(#"hash_68f514af0bd7872c");
	return isdefined(s_challenge);
}

