// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_170a9c130859c688;
#using script_3affe3aaa3f22cb0;
#using script_3f9e54c7a9a7e1e2;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;

#namespace namespace_f364fbe7;

/*
	Name: function_89f2df9
	Namespace: namespace_f364fbe7
	Checksum: 0xD14C767E
	Offset: 0xB8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_39f483eb35f789a1", &__init__, undefined, #"hash_5f346d1d9a7b2a08");
}

/*
	Name: __init__
	Namespace: namespace_f364fbe7
	Checksum: 0x77353022
	Offset: 0x108
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_772c78d5db0889f1", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_f364fbe7
	Checksum: 0x5137B5DE
	Offset: 0x148
	Size: 0x14C
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
		callback::on_player_damage(&on_player_damage);
		callback::add_callback(#"hash_4b1a02a87458f191", &function_4ac25840);
		if(isdefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659"))
		{
			namespace_b0722f43::function_e70fa91c(#"hash_2e8c8c85b6034ab3", #"hash_d245e711188e065", 1);
		}
		else
		{
			namespace_b0722f43::function_e70fa91c(#"hash_4bfbb656e63b17ae", #"hash_d245e711188e065", 6);
		}
	}
}

/*
	Name: function_1c4b5097
	Namespace: namespace_f364fbe7
	Checksum: 0x4FCE896A
	Offset: 0x2A0
	Size: 0x1A4
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"hash_9e0be370fa2d311")
	{
		if(self character_unlock::function_f0406288(#"hash_772c78d5db0889f1"))
		{
			self character_unlock::function_c8beca5e(#"hash_772c78d5db0889f1", #"hash_91d5ea7b26a8aca", 1);
			var_f63b894c = 0;
			foreach(team in level.teams)
			{
				if(teams::function_9dd75dad(team))
				{
					var_f63b894c++;
				}
			}
			var_c503939b = globallogic::function_e9e52d05();
			if(var_f63b894c > 0 && var_c503939b <= function_c816ea5b())
			{
				self character_unlock::function_c8beca5e(#"hash_772c78d5db0889f1", #"hash_91d5da7b26a8917", 1);
			}
		}
	}
}

/*
	Name: function_4ac25840
	Namespace: namespace_f364fbe7
	Checksum: 0xE6D497DA
	Offset: 0x450
	Size: 0x27A
	Parameters: 1
	Flags: Linked
*/
function function_4ac25840(var_d32e67b4)
{
	if(isdefined(level.var_72429ca6) && level.var_72429ca6)
	{
		return;
	}
	var_f63b894c = 0;
	foreach(team in level.teams)
	{
		if(teams::function_9dd75dad(team))
		{
			var_f63b894c++;
		}
	}
	var_c503939b = globallogic::function_e9e52d05();
	if(var_f63b894c > 0 && var_c503939b <= function_c816ea5b())
	{
		foreach(team in level.teams)
		{
			if(teams::function_9dd75dad(team) && !teams::is_all_dead(team))
			{
				players = getplayers(team);
				foreach(player in players)
				{
					if(player character_unlock::function_f0406288(#"hash_772c78d5db0889f1"))
					{
						player character_unlock::function_c8beca5e(#"hash_772c78d5db0889f1", #"hash_91d5da7b26a8917", 1);
					}
				}
			}
		}
		level.var_72429ca6 = 1;
	}
}

/*
	Name: on_player_damage
	Namespace: namespace_f364fbe7
	Checksum: 0xBDBFCB5B
	Offset: 0x6D8
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function on_player_damage(params)
{
	if(params.smeansofdeath == "MOD_DEATH_CIRCLE" && self character_unlock::function_c70bcc7a(#"hash_772c78d5db0889f1"))
	{
		self character_unlock::function_c8beca5e(#"hash_772c78d5db0889f1", #"hash_91d5ea7b26a8aca", 2);
	}
}

/*
	Name: function_c816ea5b
	Namespace: namespace_f364fbe7
	Checksum: 0xAC5EC841
	Offset: 0x760
	Size: 0xDA
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c816ea5b()
{
	maxteamplayers = (isdefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1);
	switch(maxteamplayers)
	{
		case 1:
		{
			return 30;
		}
		case 2:
		{
			return 15;
		}
		case 4:
		default:
		{
			return 7;
		}
		case 5:
		{
			return 7;
		}
	}
}

