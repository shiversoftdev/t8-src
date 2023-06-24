// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\globallogic\globallogic_player.gsc;
#using scripts\weapons\weaponobjects.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace tracker;

/*
	Name: init_shared
	Namespace: tracker
	Checksum: 0x78AFEB72
	Offset: 0xD8
	Size: 0x8C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	register_clientfields();
	level.trackerperk = spawnstruct();
	level.var_c8241070 = &function_c8241070;
	thread function_a7e7bda0();
	level.trackerperk.var_75492b09 = [];
	callback::on_spawned(&onplayerspawned);
}

/*
	Name: register_clientfields
	Namespace: tracker
	Checksum: 0xB0AD8CCE
	Offset: 0x170
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function register_clientfields()
{
	clientfield::register("clientuimodel", "huditems.isExposedOnMinimap", 1, 1, "int");
}

/*
	Name: onplayerspawned
	Namespace: tracker
	Checksum: 0xF667125B
	Offset: 0x1B0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function onplayerspawned()
{
	self clientfield::set_player_uimodel("huditems.isExposedOnMinimap", 0);
}

/*
	Name: function_c8241070
	Namespace: tracker
	Checksum: 0xDCCDE482
	Offset: 0x1E0
	Size: 0x186
	Parameters: 2
	Flags: None
*/
function function_c8241070(player, weapon)
{
	if(!isdefined(level.trackerperk.var_75492b09[player.clientid]))
	{
		level.trackerperk.var_75492b09[player.clientid] = spawnstruct();
	}
	level.trackerperk.var_75492b09[player.clientid].var_80ec1137 = gettime();
	level.trackerperk.var_75492b09[player.clientid].var_2e0b3c25 = player.origin;
	level.trackerperk.var_75492b09[player.clientid].var_2672a259 = weapon;
	level.trackerperk.var_75492b09[player.clientid].var_851de005 = player;
	level.trackerperk.var_75492b09[player.clientid].expiretime = gettime() + (float(getdvarint(#"hash_6f3f10e68d2fedba", 0)) / 1000);
}

/*
	Name: function_43084f6c
	Namespace: tracker
	Checksum: 0x6A61390F
	Offset: 0x370
	Size: 0x18A
	Parameters: 1
	Flags: None
*/
function function_43084f6c(player)
{
	if(level.teambased)
	{
		otherteam = util::getotherteam(player.team);
		foreach(var_f53fe24c in getplayers(otherteam))
		{
			if(var_f53fe24c function_d210981e(player.origin))
			{
				return true;
			}
		}
	}
	else
	{
		enemies = getplayers();
		foreach(enemy in enemies)
		{
			if(enemy == player)
			{
				continue;
			}
			if(enemy function_d210981e(player.origin))
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: function_2c77961d
	Namespace: tracker
	Checksum: 0xB40B09EF
	Offset: 0x508
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function function_2c77961d(player)
{
	if(!isdefined(level.trackerperk.var_75492b09[player.clientid]))
	{
		return false;
	}
	if(gettime() > level.trackerperk.var_75492b09[player.clientid].expiretime)
	{
		return false;
	}
	return true;
}

/*
	Name: function_796e0334
	Namespace: tracker
	Checksum: 0xAA6FE56E
	Offset: 0x578
	Size: 0xB0
	Parameters: 1
	Flags: None
*/
function function_796e0334(player)
{
	if(1 && globallogic_player::function_eddea888(player))
	{
		return true;
	}
	if(1 && globallogic_player::function_43084f6c(player))
	{
		return true;
	}
	if(1 && function_2c77961d(player))
	{
		return true;
	}
	if(1 && globallogic_player::function_ce33e204(player))
	{
		return true;
	}
	return false;
}

/*
	Name: function_a7e7bda0
	Namespace: tracker
	Checksum: 0x3047D9B5
	Offset: 0x630
	Size: 0x1C0
	Parameters: 0
	Flags: None
*/
function function_a7e7bda0()
{
	if(getgametypesetting(#"hardcoremode"))
	{
		return;
	}
	while(true)
	{
		foreach(player in level.players)
		{
			if(!isdefined(player))
			{
				continue;
			}
			if(!player hasperk(#"hash_82d803aeee9cafb"))
			{
				continue;
			}
			if(function_796e0334(player))
			{
				if(!isdefined(player.var_7241f6e3))
				{
					player.var_7241f6e3 = gettime() + 100;
				}
				if(player.var_7241f6e3 <= gettime())
				{
					player clientfield::set_player_uimodel("huditems.isExposedOnMinimap", 1);
					player.var_99811216 = gettime() + 100;
				}
				continue;
			}
			if(isdefined(player.var_99811216) && gettime() > player.var_99811216 && player clientfield::get_player_uimodel("huditems.isExposedOnMinimap"))
			{
				player clientfield::set_player_uimodel("huditems.isExposedOnMinimap", 0);
				player.var_7241f6e3 = undefined;
			}
		}
		wait(0.1);
	}
}

