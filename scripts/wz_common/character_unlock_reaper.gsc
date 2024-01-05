// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\player\player_stats.gsc;
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\teams\teams.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace character_unlock_reaper;

/*
	Name: __init__system__
	Namespace: character_unlock_reaper
	Checksum: 0x11BB061B
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_reaper", &__init__, undefined, #"character_unlock_reaper_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_reaper
	Checksum: 0x881A5FFA
	Offset: 0xF0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"reaper_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_reaper
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
		callback::add_callback(#"on_team_eliminated", &function_4ac25840);
	}
}

/*
	Name: function_1c4b5097
	Namespace: character_unlock_reaper
	Checksum: 0x46830873
	Offset: 0x1E0
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"cu35_item")
	{
		if(self character_unlock::function_f0406288(#"reaper_unlock"))
		{
			if(self stats::get_stat_global(#"kills_early") >= 115)
			{
				self character_unlock::function_c8beca5e(#"reaper_unlock", #"hash_555c37b28c4a770c", 1);
			}
			var_c503939b = globallogic::function_e9e52d05();
			if(var_c503939b <= function_c816ea5b())
			{
				self character_unlock::function_c8beca5e(#"reaper_unlock", #"hash_555c3ab28c4a7c25", 1);
			}
		}
	}
}

/*
	Name: function_381c1e1d
	Namespace: character_unlock_reaper
	Checksum: 0x992007BE
	Offset: 0x318
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_381c1e1d()
{
	if(self character_unlock::function_f0406288(#"reaper_unlock"))
	{
		if(self stats::get_stat_global(#"kills_early") >= 115)
		{
			self character_unlock::function_c8beca5e(#"reaper_unlock", #"hash_555c37b28c4a770c", 1);
		}
	}
}

/*
	Name: function_4ac25840
	Namespace: character_unlock_reaper
	Checksum: 0xAFA2A3B3
	Offset: 0x3A8
	Size: 0x1E2
	Parameters: 1
	Flags: Linked
*/
function function_4ac25840(dead_team)
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
					if(player character_unlock::function_f0406288(#"reaper_unlock"))
					{
						player character_unlock::function_c8beca5e(#"reaper_unlock", #"hash_555c3ab28c4a7c25", 1);
					}
				}
			}
		}
		level.var_dcd43b16 = 1;
	}
}

/*
	Name: function_c816ea5b
	Namespace: character_unlock_reaper
	Checksum: 0x1A7209D4
	Offset: 0x598
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

