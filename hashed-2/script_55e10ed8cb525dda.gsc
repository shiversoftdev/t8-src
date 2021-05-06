// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using script_8210b63db522f15;
#using script_8abfb58852911dd;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_1dcc7454;

/*
	Name: function_89f2df9
	Namespace: namespace_1dcc7454
	Checksum: 0x849BF37C
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_28b50016a1586408", &__init__, undefined, #"hash_1c2ed3083ed241b5");
}

/*
	Name: __init__
	Namespace: namespace_1dcc7454
	Checksum: 0xAC1AC890
	Offset: 0xF0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_58ba46469707a85c", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_1dcc7454
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
	Namespace: namespace_1dcc7454
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
	Namespace: namespace_1dcc7454
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
	if(!attacker character_unlock::function_f0406288(#"hash_58ba46469707a85c"))
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
		attacker character_unlock::function_c8beca5e(#"hash_58ba46469707a85c", #"hash_4e9ba934add76371", 1);
	}
}

