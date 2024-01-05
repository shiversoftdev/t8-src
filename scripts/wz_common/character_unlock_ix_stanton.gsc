// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\teams\teams.gsc;
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace character_unlock_ix_stanton;

/*
	Name: __init__system__
	Namespace: character_unlock_ix_stanton
	Checksum: 0xC6BD971F
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_ix_stanton", &__init__, undefined, #"character_unlock_ix_stanton_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_ix_stanton
	Checksum: 0xBD4B4364
	Offset: 0xE8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"ix_stanton_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_ix_stanton
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
		callback::add_callback(#"on_drop_inventory", &on_use_perk);
		callback::add_callback(#"on_team_eliminated", &function_4ac25840);
	}
}

/*
	Name: function_1c4b5097
	Namespace: character_unlock_ix_stanton
	Checksum: 0xED3ACA5E
	Offset: 0x1D8
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	if(isdefined(item.var_a6762160) && item.var_a6762160.name === #"cu31_item")
	{
		var_c503939b = globallogic::function_e9e52d05();
		if(var_c503939b <= function_c816ea5b())
		{
			if(self character_unlock::function_f0406288(#"ix_stanton_unlock"))
			{
				self character_unlock::function_c8beca5e(#"ix_stanton_unlock", #"hash_9eef458b72b750d", 1);
			}
		}
	}
}

/*
	Name: on_use_perk
	Namespace: character_unlock_ix_stanton
	Checksum: 0x3A9E516
	Offset: 0x2B8
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function on_use_perk(player)
{
	if(!isplayer(player))
	{
		return;
	}
	if(!player character_unlock::function_f0406288(#"ix_stanton_unlock"))
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
		player character_unlock::function_c8beca5e(#"ix_stanton_unlock", #"hash_9eef158b72b6ff4", 1);
	}
}

/*
	Name: function_4ac25840
	Namespace: character_unlock_ix_stanton
	Checksum: 0x6EA45E33
	Offset: 0x388
	Size: 0x1E2
	Parameters: 1
	Flags: Linked
*/
function function_4ac25840(dead_team)
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
					if(player character_unlock::function_f0406288(#"ix_stanton_unlock"))
					{
						player character_unlock::function_c8beca5e(#"ix_stanton_unlock", #"hash_9eef458b72b750d", 1);
					}
				}
			}
		}
		level.var_6a1f6a43 = 1;
	}
}

/*
	Name: function_c816ea5b
	Namespace: character_unlock_ix_stanton
	Checksum: 0x7D9DB1DB
	Offset: 0x578
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
			return 8;
		}
		case 5:
		{
			return 8;
		}
	}
}

