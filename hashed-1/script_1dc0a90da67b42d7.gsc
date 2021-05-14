// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using script_3f9e54c7a9a7e1e2;
#using script_47fb62300ac0bd60;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;

#namespace namespace_294eb01b;

/*
	Name: function_89f2df9
	Namespace: namespace_294eb01b
	Checksum: 0x11BB061B
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_301398b967b76ddd", &__init__, undefined, #"hash_28852d6f266c0fcc");
}

/*
	Name: __init__
	Namespace: namespace_294eb01b
	Checksum: 0x881A5FFA
	Offset: 0xF0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_64b65ba370766cff", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_294eb01b
	Checksum: 0x3DC87FB7
	Offset: 0x130
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::add_callback(#"hash_22c795c5dddbfc97", &function_381c1e1d);
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
		callback::add_callback(#"hash_4b1a02a87458f191", &function_4ac25840);
	}
}

/*
	Name: function_1c4b5097
	Namespace: namespace_294eb01b
	Checksum: 0x46830873
	Offset: 0x1E0
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"hash_68307ed314684f1d")
	{
		if(self character_unlock::function_f0406288(#"hash_64b65ba370766cff"))
		{
			if(self stats::function_441050ca(#"hash_199467721898923a") >= 115)
			{
				self character_unlock::function_c8beca5e(#"hash_64b65ba370766cff", #"hash_555c37b28c4a770c", 1);
			}
			var_c503939b = globallogic::function_e9e52d05();
			if(var_c503939b <= function_c816ea5b())
			{
				self character_unlock::function_c8beca5e(#"hash_64b65ba370766cff", #"hash_555c3ab28c4a7c25", 1);
			}
		}
	}
}

/*
	Name: function_381c1e1d
	Namespace: namespace_294eb01b
	Checksum: 0x992007BE
	Offset: 0x318
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_381c1e1d()
{
	if(self character_unlock::function_f0406288(#"hash_64b65ba370766cff"))
	{
		if(self stats::function_441050ca(#"hash_199467721898923a") >= 115)
		{
			self character_unlock::function_c8beca5e(#"hash_64b65ba370766cff", #"hash_555c37b28c4a770c", 1);
		}
	}
}

/*
	Name: function_4ac25840
	Namespace: namespace_294eb01b
	Checksum: 0xAFA2A3B3
	Offset: 0x3A8
	Size: 0x1E2
	Parameters: 1
	Flags: Linked
*/
function function_4ac25840(var_d32e67b4)
{
	if(isdefined(level.var_dcd43b16) && level.var_dcd43b16)
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
					if(player character_unlock::function_f0406288(#"hash_64b65ba370766cff"))
					{
						player character_unlock::function_c8beca5e(#"hash_64b65ba370766cff", #"hash_555c3ab28c4a7c25", 1);
					}
				}
			}
		}
		level.var_dcd43b16 = 1;
	}
}

/*
	Name: function_c816ea5b
	Namespace: namespace_294eb01b
	Checksum: 0x1A7209D4
	Offset: 0x598
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
			return 5;
		}
		case 2:
		{
			return 3;
		}
		case 4:
		default:
		{
			return 2;
		}
		case 5:
		{
			return 2;
		}
	}
}

