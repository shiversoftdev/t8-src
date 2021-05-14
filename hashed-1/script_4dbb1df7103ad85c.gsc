// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_170a9c130859c688;
#using script_3affe3aaa3f22cb0;
#using script_3f9e54c7a9a7e1e2;
#using script_47fb62300ac0bd60;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;

#namespace namespace_b00551be;

/*
	Name: function_89f2df9
	Namespace: namespace_b00551be
	Checksum: 0x1C210ABD
	Offset: 0xF0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_703ccb93c469794", &__init__, undefined, #"hash_2e41e4e9f22f6589");
}

/*
	Name: __init__
	Namespace: namespace_b00551be
	Checksum: 0xA10B630E
	Offset: 0x140
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("world", "array_broadcast", 1, 1, "int");
	clientfield::register("toplayer", "array_effects", 1, 1, "int");
	namespace_fa6b9ef8::function_90ee7a97(#"hash_23931c40f2cd64a6", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_b00551be
	Checksum: 0x976C483F
	Offset: 0x1E0
	Size: 0x176
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
		callback::add_callback(#"hash_4b1a02a87458f191", &function_4ac25840);
		if(isdefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659"))
		{
			namespace_b0722f43::function_e70fa91c(#"hash_2e8c8c85b6034ab3", #"hash_d215d711186a8db", 1);
		}
		else
		{
			namespace_b0722f43::function_e70fa91c(#"hash_4bfbb656e63b17ae", #"hash_d215d711186a8db", 6);
		}
		dynent = getdynent(#"array_broadcast");
		if(isdefined(dynent))
		{
			dynent.onuse = &function_1e224132;
		}
	}
}

/*
	Name: function_1c4b5097
	Namespace: namespace_b00551be
	Checksum: 0x2676F52
	Offset: 0x360
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(isdefined(var_a6762160) && var_a6762160.name === #"hash_7b4b6ec825eec06f")
	{
		var_c503939b = globallogic::function_e9e52d05();
		if(var_c503939b <= function_c816ea5b())
		{
			if(self character_unlock::function_f0406288(#"hash_23931c40f2cd64a6"))
			{
				self character_unlock::function_c8beca5e(#"hash_23931c40f2cd64a6", #"hash_7334980069e5e2fa", 1);
			}
		}
	}
}

/*
	Name: function_1e224132
	Namespace: namespace_b00551be
	Checksum: 0x260B0C8
	Offset: 0x448
	Size: 0x15C
	Parameters: 3
	Flags: Linked
*/
function function_1e224132(activator, laststate, state)
{
	if(isplayer(activator) && !level.inprematchperiod)
	{
		var_40e2a4c8 = getcharacterassetname(activator getcharacterbodytype(), currentsessionmode());
		if(activator character_unlock::function_f0406288(#"hash_23931c40f2cd64a6"))
		{
			level clientfield::set("array_broadcast", 1);
			activator clientfield::set_to_player("array_effects", 1);
			activator thread function_e3abcf2();
			activator character_unlock::function_c8beca5e(#"hash_23931c40f2cd64a6", #"hash_7334970069e5e147", 1);
		}
		activator stats::function_d40764f3(#"hash_1e2d4099885069b1", 1);
	}
}

/*
	Name: function_e3abcf2
	Namespace: namespace_b00551be
	Checksum: 0xB8B512B
	Offset: 0x5B0
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_e3abcf2()
{
	self endon(#"disconnect", #"game_ended");
	var_70f6f8c = 1;
	while(isplayer(self) && isalive(self) && var_70f6f8c)
	{
		var_70f6f8c = self character_unlock::function_f0406288(#"hash_23931c40f2cd64a6");
		waitframe(1);
	}
	self clientfield::set_to_player("array_effects", 0);
}

/*
	Name: function_4ac25840
	Namespace: namespace_b00551be
	Checksum: 0xACB09955
	Offset: 0x678
	Size: 0x1E2
	Parameters: 1
	Flags: Linked
*/
function function_4ac25840(var_d32e67b4)
{
	if(isdefined(level.var_7733b33f) && level.var_7733b33f)
	{
		return;
	}
	var_c503939b = globallogic::function_e9e52d05();
	if(var_c503939b <= function_c816ea5b())
	{
		foreach(team in level.teams)
		{
			if(teams::function_9dd75dad(team) && !teams::is_all_dead(team))
			{
				players = getplayers(team);
				foreach(player in players)
				{
					if(player character_unlock::function_f0406288(#"hash_23931c40f2cd64a6"))
					{
						player character_unlock::function_c8beca5e(#"hash_23931c40f2cd64a6", #"hash_7334980069e5e2fa", 1);
					}
				}
			}
		}
		level.var_7733b33f = 1;
	}
}

/*
	Name: function_c816ea5b
	Namespace: namespace_b00551be
	Checksum: 0xAC8F231E
	Offset: 0x868
	Size: 0xDA
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c816ea5b()
{
	maxteamplayers = (isdefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1);
	switch(maxteamplayers)
	{
		case 1:
		{
			return 15;
		}
		case 2:
		{
			return 8;
		}
		case 4:
		default:
		{
			return 4;
		}
		case 5:
		{
			return 4;
		}
	}
}

