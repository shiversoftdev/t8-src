// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2255a7ad3edc838f;
#using script_6158278c8647d8a9;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_f93dec91;

/*
	Name: function_89f2df9
	Namespace: namespace_f93dec91
	Checksum: 0xC8C6BC1
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_65b58f40e5cccbce", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_f93dec91
	Checksum: 0x44F01833
	Offset: 0xC8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_b20b4885::function_e9e03d6f(#"hash_8d7d6c68a4e0ec3", &function_eef95251);
	namespace_b20b4885::function_e9e03d6f(#"hash_15b1d6f5448dc185", &function_eecaf17c);
	namespace_b20b4885::function_e9e03d6f(#"hash_27560b4cbc3c3443", &function_ff38b7b);
}

/*
	Name: function_eef95251
	Namespace: namespace_f93dec91
	Checksum: 0x4A5DDB5D
	Offset: 0x168
	Size: 0x3A
	Parameters: 2
	Flags: Linked
*/
function function_eef95251(params, tacbundle)
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}
	return namespace_b20b4885::function_d0cf287b(params, tacbundle);
}

/*
	Name: function_eecaf17c
	Namespace: namespace_f93dec91
	Checksum: 0x6ABDFEE6
	Offset: 0x1B0
	Size: 0x3A
	Parameters: 2
	Flags: Linked
*/
function function_eecaf17c(params, tacbundle)
{
	if(isdefined(self.enemy))
	{
		return 0;
	}
	return namespace_b20b4885::function_d0cf287b(params, tacbundle);
}

/*
	Name: function_ff38b7b
	Namespace: namespace_f93dec91
	Checksum: 0x74478A7A
	Offset: 0x1F8
	Size: 0x4AA
	Parameters: 2
	Flags: Linked
*/
function function_ff38b7b(params, tacbundle)
{
	if(!isarray(level.dogtags) || level.dogtags.size == 0)
	{
		return false;
	}
	if(self bot::has_visible_enemy())
	{
		return false;
	}
	if(!isdefined(level.var_6679b27c))
	{
		difficulty = getdvarint(#"bot_difficulty", 1);
		if(difficulty == 0)
		{
			level.var_6679b27c = 202500;
		}
		else
		{
			if(difficulty == 1)
			{
				level.var_6679b27c = 360000;
			}
			else
			{
				if(difficulty == 2)
				{
					level.var_6679b27c = 640000;
				}
				else if(difficulty == 3)
				{
					level.var_6679b27c = 1000000;
				}
			}
		}
	}
	var_ff07f341 = [];
	foreach(player in level.players)
	{
		if(isdefined(player) && isalive(player) && player != self && player.team == self.team)
		{
			if(!isdefined(var_ff07f341))
			{
				var_ff07f341 = [];
			}
			else if(!isarray(var_ff07f341))
			{
				var_ff07f341 = array(var_ff07f341);
			}
			var_ff07f341[var_ff07f341.size] = player;
		}
	}
	nearestdistsq = -1;
	var_117c149c = undefined;
	foreach(dogtag in level.dogtags)
	{
		if(!isdefined(dogtag.visuals[0]) || dogtag.visuals[0] ishidden())
		{
			continue;
		}
		if(!ispointonnavmesh(dogtag.origin, self))
		{
			continue;
		}
		var_6acc1296 = distancesquared(self.origin, dogtag.origin);
		if(var_6acc1296 > 65536)
		{
			var_3e398697 = 0;
			foreach(ally in var_ff07f341)
			{
				var_2c4028d8 = distancesquared(ally.origin, dogtag.origin);
				if(var_2c4028d8 <= 65536)
				{
					var_3e398697 = 1;
					break;
				}
			}
			if(var_3e398697)
			{
				continue;
			}
		}
		if(nearestdistsq < 0 || var_6acc1296 < nearestdistsq)
		{
			nearestdistsq = var_6acc1296;
			var_117c149c = dogtag.origin;
		}
	}
	if(isdefined(var_117c149c) && nearestdistsq < level.var_6679b27c)
	{
		self namespace_b20b4885::set_position(var_117c149c);
		self.bot.var_2ee077ff = gettime() + 500;
		return true;
	}
	return false;
}

