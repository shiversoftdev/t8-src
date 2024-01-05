// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\wz_firing_range.gsc;
#using scripts\wz_common\character_unlock_seraph_fixup.gsc;
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\mp_common\teams\teams.gsc;
#using scripts\mp_common\item_world.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace character_unlock_seraph;

/*
	Name: __init__system__
	Namespace: character_unlock_seraph
	Checksum: 0x7900179E
	Offset: 0xE0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_seraph", &__init__, undefined, #"character_unlock_seraph_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_seraph
	Checksum: 0xDEFEE43
	Offset: 0x130
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"seraph_unlock", &function_2613aeec);
	callback::on_finalize_initialization(&on_finalize_initialization);
}

/*
	Name: on_finalize_initialization
	Namespace: character_unlock_seraph
	Checksum: 0xBE611744
	Offset: 0x190
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function on_finalize_initialization()
{
	waitframe(1);
	level function_75097bb5();
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_seraph
	Checksum: 0x3F71D156
	Offset: 0x1C0
	Size: 0xF4
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
		wz_firing_range::init_targets(#"hash_3af83a27a707345a");
		level.var_d27ee2e7 = 1;
		level thread function_211772b5();
	}
	else
	{
		level thread function_1e3aca52();
	}
}

/*
	Name: function_211772b5
	Namespace: character_unlock_seraph
	Checksum: 0x741E4637
	Offset: 0x2C0
	Size: 0x1AE
	Parameters: 0
	Flags: Linked
*/
function function_211772b5()
{
	item_world::function_4de3ca98();
	var_b2425612 = getdynentarray(#"hash_81ef4f75cff4919");
	if(isdefined(var_b2425612) && var_b2425612.size > 1)
	{
		var_65688262 = array::random(var_b2425612);
		arrayremovevalue(var_b2425612, var_65688262);
		foreach(box in var_b2425612)
		{
			if(isdefined(box))
			{
				setdynentenabled(box, 0);
			}
		}
		var_590fbce8 = function_91b29d2a(#"annihilator_spawn");
		if(isdefined(var_590fbce8) && var_590fbce8.size > 1)
		{
			var_590fbce8 = arraysortclosest(var_590fbce8, var_65688262.origin);
			for(i = 1; i < var_590fbce8.size; i++)
			{
				item_world::consume_item(var_590fbce8[i]);
			}
		}
	}
}

/*
	Name: function_1e3aca52
	Namespace: character_unlock_seraph
	Checksum: 0x330FB361
	Offset: 0x478
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_1e3aca52()
{
	item_world::function_4de3ca98();
	level function_75097bb5();
}

/*
	Name: function_75097bb5
	Namespace: character_unlock_seraph
	Checksum: 0x3F4464BA
	Offset: 0x4B0
	Size: 0x100
	Parameters: 0
	Flags: Linked
*/
function function_75097bb5()
{
	var_1c9468df = getdynent(#"hash_3af83a27a707345a");
	if(isdefined(var_1c9468df))
	{
		setdynentenabled(var_1c9468df, 0);
	}
	var_b2425612 = getdynentarray(#"hash_81ef4f75cff4919");
	if(isdefined(var_b2425612))
	{
		foreach(box in var_b2425612)
		{
			if(isdefined(box))
			{
				setdynentenabled(box, 0);
			}
		}
	}
}

/*
	Name: function_209450ae
	Namespace: character_unlock_seraph
	Checksum: 0xB6332976
	Offset: 0x5B8
	Size: 0x2E4
	Parameters: 1
	Flags: Private, Event
*/
event private function_209450ae(eventstruct)
{
	if(!(isdefined(level.var_d27ee2e7) && level.var_d27ee2e7))
	{
		return;
	}
	if(!level character_unlock::function_b3681acb())
	{
		return;
	}
	if(level.inprematchperiod)
	{
		return;
	}
	dynent = eventstruct.ent;
	if(dynent.targetname !== #"hash_3af83a27a707345a")
	{
		return;
	}
	attacker = eventstruct.attacker;
	weapon = eventstruct.weapon;
	position = eventstruct.position;
	direction = eventstruct.dir;
	if(!isplayer(attacker) || !isdefined(weapon) || !isdefined(position) || !isdefined(direction))
	{
		return;
	}
	if(weapon.weapclass != "pistol" && weapon.weapclass != "pistol spread")
	{
		return;
	}
	if(distancesquared(attacker.origin, dynent.origin) < 200 * 200)
	{
		return;
	}
	if(attacker character_unlock::function_d7e6fa92(#"seraph_unlock"))
	{
		return;
	}
	targetangles = dynent.angles + vectorscale((0, 1, 0), 90);
	var_2bbc9717 = anglestoforward(targetangles);
	if(vectordot(var_2bbc9717, direction) >= 0)
	{
		return;
	}
	var_f748425e = dynent.origin + vectorscale((0, 0, 1), 60);
	if(distance2dsquared(var_f748425e, position) > 5 * 5)
	{
		return;
	}
	var_bbe521bc = getdynent(#"hash_81ef4f75cff4919");
	if(function_ffdbe8c2(var_bbe521bc) != 1)
	{
		function_e2a06860(var_bbe521bc, 1);
	}
}

/*
	Name: on_player_killed
	Namespace: character_unlock_seraph
	Checksum: 0x3EDF6764
	Offset: 0x8A8
	Size: 0x10C
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
	weapon = self.laststandparams.sweapon;
	if(!isplayer(attacker) || !isdefined(weapon))
	{
		return;
	}
	if(weapon.name != #"hero_annihilator")
	{
		return;
	}
	if(!attacker util::isenemyteam(self.team))
	{
		return;
	}
	if(!attacker character_unlock::function_f0406288(#"seraph_unlock"))
	{
		return;
	}
	attacker character_unlock::function_c8beca5e(#"seraph_unlock", #"hash_633d185cd2140f1a", 1);
}

/*
	Name: function_1c4b5097
	Namespace: character_unlock_seraph
	Checksum: 0xC025FA7C
	Offset: 0x9C0
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	if(isdefined(item.var_a6762160) && item.var_a6762160.name === #"annihilator_wz_item")
	{
		var_c503939b = globallogic::function_e9e52d05();
		if(var_c503939b <= function_c816ea5b())
		{
			if(self character_unlock::function_f0406288(#"seraph_unlock"))
			{
				self character_unlock::function_c8beca5e(#"seraph_unlock", #"hash_633d175cd2140d67", 1);
			}
		}
	}
}

/*
	Name: function_4ac25840
	Namespace: character_unlock_seraph
	Checksum: 0x1676EBB6
	Offset: 0xAA0
	Size: 0x1E2
	Parameters: 1
	Flags: Linked
*/
function function_4ac25840(dead_team)
{
	if(isdefined(level.var_3227278c) && level.var_3227278c)
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
					if(player character_unlock::function_f0406288(#"seraph_unlock"))
					{
						player character_unlock::function_c8beca5e(#"seraph_unlock", #"hash_633d175cd2140d67", 1);
					}
				}
			}
		}
		level.var_3227278c = 1;
	}
}

/*
	Name: function_c816ea5b
	Namespace: character_unlock_seraph
	Checksum: 0xD7FEA55F
	Offset: 0xC90
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

/*
	Name: function_f6dc1aa9
	Namespace: character_unlock_seraph
	Checksum: 0xF9EFA1BA
	Offset: 0xD78
	Size: 0x5E
	Parameters: 0
	Flags: None
*/
function function_f6dc1aa9()
{
	/#
		while(true)
		{
			var_f748425e = self.origin + vectorscale((0, 0, 1), 60);
			sphere(var_f748425e, 5, (1, 1, 0));
			waitframe(1);
		}
	#/
}

