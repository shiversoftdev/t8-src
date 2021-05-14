// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using script_3f9e54c7a9a7e1e2;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;

#namespace namespace_f4988da6;

/*
	Name: function_89f2df9
	Namespace: namespace_f4988da6
	Checksum: 0xC6BD971F
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_432d2ed90d4221b9", &__init__, undefined, #"hash_d23efe71e585b90");
}

/*
	Name: __init__
	Namespace: namespace_f4988da6
	Checksum: 0xBD4B4364
	Offset: 0xE8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_518e05d31b55dfe7", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_f4988da6
	Checksum: 0xCCF13011
	Offset: 0x128
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
		callback::add_callback(#"hash_27e13b9438e33053", &function_36daf16b);
		callback::add_callback(#"hash_4b1a02a87458f191", &function_4ac25840);
	}
}

/*
	Name: function_1c4b5097
	Namespace: namespace_f4988da6
	Checksum: 0xED3ACA5E
	Offset: 0x1D8
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	if(isdefined(item.var_a6762160) && item.var_a6762160.name === #"hash_3fd471201d49cc19")
	{
		var_c503939b = globallogic::function_e9e52d05();
		if(var_c503939b <= function_c816ea5b())
		{
			if(self character_unlock::function_f0406288(#"hash_518e05d31b55dfe7"))
			{
				self character_unlock::function_c8beca5e(#"hash_518e05d31b55dfe7", #"hash_9eef458b72b750d", 1);
			}
		}
	}
}

/*
	Name: function_36daf16b
	Namespace: namespace_f4988da6
	Checksum: 0x3A9E516
	Offset: 0x2B8
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_36daf16b(player)
{
	if(!isplayer(player))
	{
		return;
	}
	if(!player character_unlock::function_f0406288(#"hash_518e05d31b55dfe7"))
	{
		return;
	}
	if(!isdefined(player.var_e598921d))
	{
		player.var_e598921d = 0;
	}
	player.var_e598921d++;
	if(player.var_e598921d == 5)
	{
		player character_unlock::function_c8beca5e(#"hash_518e05d31b55dfe7", #"hash_9eef158b72b6ff4", 1);
	}
}

/*
	Name: function_4ac25840
	Namespace: namespace_f4988da6
	Checksum: 0x6EA45E33
	Offset: 0x388
	Size: 0x1E2
	Parameters: 1
	Flags: Linked
*/
function function_4ac25840(var_d32e67b4)
{
	if(isdefined(level.var_6a1f6a43) && level.var_6a1f6a43)
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
					if(player character_unlock::function_f0406288(#"hash_518e05d31b55dfe7"))
					{
						player character_unlock::function_c8beca5e(#"hash_518e05d31b55dfe7", #"hash_9eef458b72b750d", 1);
					}
				}
			}
		}
		level.var_6a1f6a43 = 1;
	}
}

/*
	Name: function_c816ea5b
	Namespace: namespace_f4988da6
	Checksum: 0x7D9DB1DB
	Offset: 0x578
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
			return 30;
		}
		case 2:
		{
			return 15;
		}
		case 4:
		default:
		{
			return 8;
		}
		case 5:
		{
			return 8;
		}
	}
}

