// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\teams\teams.gsc;
#using scripts\mp_common\item_world.gsc;
#using scripts\wz_common\character_unlock_reznov_fixup.gsc;
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace character_unlock_reznov;

/*
	Name: __init__system__
	Namespace: character_unlock_reznov
	Checksum: 0xD3C07610
	Offset: 0xB8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_reznov", &__init__, undefined, #"character_unlock_reznov_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_reznov
	Checksum: 0xAFD5A732
	Offset: 0x108
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"reznov_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_reznov
	Checksum: 0xA06BCF3A
	Offset: 0x148
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::on_player_killed(&on_player_killed);
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
		callback::add_callback(#"on_team_eliminated", &function_4ac25840);
		level thread function_4f4cf89e();
	}
}

/*
	Name: function_4f4cf89e
	Namespace: character_unlock_reznov
	Checksum: 0x4DB9F6ED
	Offset: 0x200
	Size: 0x13A
	Parameters: 0
	Flags: Linked
*/
function function_4f4cf89e()
{
	item_world::function_4de3ca98();
	var_daed388 = function_91b29d2a(#"hash_718c81ed617c7a64");
	if(!isdefined(var_daed388[0]))
	{
		return;
	}
	var_daed388 = array::randomize(var_daed388);
	var_8a9122c8 = var_daed388[0];
	var_5901fe7f = 0;
	for(x = 1; x < var_daed388.size; x++)
	{
		if(isdefined(var_5901fe7f) && var_5901fe7f)
		{
			item_world::consume_item(var_daed388[x]);
			continue;
		}
		if(distance2d(var_daed388[x].origin, var_8a9122c8.origin) < 500)
		{
			item_world::consume_item(var_daed388[x]);
			continue;
		}
		var_5901fe7f = 1;
	}
}

/*
	Name: on_player_killed
	Namespace: character_unlock_reznov
	Checksum: 0xDADA5109
	Offset: 0x348
	Size: 0x1C4
	Parameters: 0
	Flags: Linked
*/
function on_player_killed()
{
	if(!isdefined(self.laststandparams))
	{
		return;
	}
	attacker = self.laststandparams.attacker;
	if(!isplayer(attacker))
	{
		return;
	}
	if(!attacker util::isenemyteam(self.team))
	{
		return;
	}
	weapon = self.laststandparams.sweapon;
	if(!weapon.isprimary)
	{
		return;
	}
	attacker_origin = self.laststandparams.attackerorigin;
	var_e5b7c28e = self.laststandparams.victimorigin;
	if(!isdefined(attacker_origin) || !isdefined(var_e5b7c28e))
	{
		return;
	}
	if(!attacker character_unlock::function_f0406288(#"reznov_unlock"))
	{
		return;
	}
	dist_to_target_sq = distancesquared(attacker_origin, var_e5b7c28e);
	if(dist_to_target_sq < 7800 * 7800)
	{
		return;
	}
	if(!isdefined(attacker.var_ec8d7cbc))
	{
		attacker.var_ec8d7cbc = 0;
	}
	attacker.var_ec8d7cbc++;
	if(attacker.var_ec8d7cbc == 1)
	{
		attacker character_unlock::function_c8beca5e(#"reznov_unlock", #"hash_1cd3eb5d2d22f647", 1);
	}
}

/*
	Name: function_1c4b5097
	Namespace: character_unlock_reznov
	Checksum: 0x91567650
	Offset: 0x518
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(isdefined(var_a6762160) && var_a6762160.name === #"cu21_item")
	{
		var_c503939b = globallogic::function_e9e52d05();
		if(var_c503939b <= function_c816ea5b())
		{
			if(self character_unlock::function_f0406288(#"reznov_unlock"))
			{
				self character_unlock::function_c8beca5e(#"reznov_unlock", #"hash_1cd3ec5d2d22f7fa", 1);
			}
		}
	}
}

/*
	Name: function_4ac25840
	Namespace: character_unlock_reznov
	Checksum: 0xBFAAEF94
	Offset: 0x600
	Size: 0x1E2
	Parameters: 1
	Flags: Linked
*/
function function_4ac25840(dead_team)
{
	if(isdefined(level.var_34983012) && level.var_34983012)
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
					if(player character_unlock::function_f0406288(#"reznov_unlock"))
					{
						player character_unlock::function_c8beca5e(#"reznov_unlock", #"hash_1cd3ec5d2d22f7fa", 1);
					}
				}
			}
		}
		level.var_34983012 = 1;
	}
}

/*
	Name: function_c816ea5b
	Namespace: character_unlock_reznov
	Checksum: 0x11E82B78
	Offset: 0x7F0
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

