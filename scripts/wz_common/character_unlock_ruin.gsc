// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\mp_common\item_world.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace character_unlock_ruin;

/*
	Name: __init__system__
	Namespace: character_unlock_ruin
	Checksum: 0x849BF37C
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_ruin", &__init__, undefined, #"character_unlock_ruin_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_ruin
	Checksum: 0xAC1AC890
	Offset: 0xF0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"ruin_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_ruin
	Checksum: 0x52DF74C
	Offset: 0x130
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::on_player_killed(&on_player_killed);
		level thread function_cb514c8b();
	}
}

/*
	Name: function_cb514c8b
	Namespace: character_unlock_ruin
	Checksum: 0xAD249D5E
	Offset: 0x188
	Size: 0x13A
	Parameters: 0
	Flags: Linked
*/
function function_cb514c8b()
{
	item_world::function_4de3ca98();
	var_885c7eef = function_91b29d2a(#"hash_527c48a52cb157d");
	if(!isdefined(var_885c7eef[0]))
	{
		return;
	}
	var_885c7eef = array::randomize(var_885c7eef);
	var_8a9122c8 = var_885c7eef[0];
	var_5901fe7f = 0;
	for(x = 1; x < var_885c7eef.size; x++)
	{
		if(isdefined(var_5901fe7f) && var_5901fe7f)
		{
			item_world::function_7730442c(var_885c7eef[x]);
			continue;
		}
		if(distance2d(var_885c7eef[x].origin, var_8a9122c8.origin) < 4000)
		{
			item_world::function_7730442c(var_885c7eef[x]);
			continue;
		}
		var_5901fe7f = 1;
	}
}

/*
	Name: on_player_killed
	Namespace: character_unlock_ruin
	Checksum: 0x5580879
	Offset: 0x2D0
	Size: 0x154
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
	if(!attacker character_unlock::function_f0406288(#"ruin_unlock"))
	{
		return;
	}
	dist_to_target_sq = distancesquared(attacker.origin, self.origin);
	if(dist_to_target_sq > 196.85 * 196.85)
	{
		return;
	}
	if(!isdefined(attacker.var_faf1dae6))
	{
		attacker.var_faf1dae6 = 0;
	}
	attacker.var_faf1dae6++;
	if(attacker.var_faf1dae6 == 1)
	{
		attacker character_unlock::function_c8beca5e(#"ruin_unlock", #"hash_4e9ba934add76371", 1);
	}
}

