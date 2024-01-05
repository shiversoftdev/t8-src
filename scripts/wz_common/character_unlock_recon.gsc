// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world_fixup.gsc;
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\mp_common\teams\teams.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace character_unlock_recon;

/*
	Name: __init__system__
	Namespace: character_unlock_recon
	Checksum: 0xD14C767E
	Offset: 0xB8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_recon", &__init__, undefined, #"character_unlock_recon_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_recon
	Checksum: 0x77353022
	Offset: 0x108
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"recon_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_recon
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
		callback::add_callback(#"on_team_eliminated", &function_4ac25840);
		if(isdefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659"))
		{
			item_world_fixup::function_e70fa91c(#"hash_2e8c8c85b6034ab3", #"hash_d245e711188e065", 1);
		}
		else
		{
			item_world_fixup::function_e70fa91c(#"supply_stash_parent_dlc1", #"hash_d245e711188e065", 6);
		}
	}
}

/*
	Name: function_1c4b5097
	Namespace: character_unlock_recon
	Checksum: 0x4FCE896A
	Offset: 0x2A0
	Size: 0x1A4
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"cu04_item")
	{
		if(self character_unlock::function_f0406288(#"recon_unlock"))
		{
			self character_unlock::function_c8beca5e(#"recon_unlock", #"hash_91d5ea7b26a8aca", 1);
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
				self character_unlock::function_c8beca5e(#"recon_unlock", #"hash_91d5da7b26a8917", 1);
			}
		}
	}
}

/*
	Name: function_4ac25840
	Namespace: character_unlock_recon
	Checksum: 0xE6D497DA
	Offset: 0x450
	Size: 0x27A
	Parameters: 1
	Flags: Linked
*/
function function_4ac25840(dead_team)
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
					if(player character_unlock::function_f0406288(#"recon_unlock"))
					{
						player character_unlock::function_c8beca5e(#"recon_unlock", #"hash_91d5da7b26a8917", 1);
					}
				}
			}
		}
		level.var_72429ca6 = 1;
	}
}

/*
	Name: on_player_damage
	Namespace: character_unlock_recon
	Checksum: 0xBDBFCB5B
	Offset: 0x6D8
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function on_player_damage(params)
{
	if(params.smeansofdeath == "MOD_DEATH_CIRCLE" && self character_unlock::function_c70bcc7a(#"recon_unlock"))
	{
		self character_unlock::function_c8beca5e(#"recon_unlock", #"hash_91d5ea7b26a8aca", 2);
	}
}

/*
	Name: function_c816ea5b
	Namespace: character_unlock_recon
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

