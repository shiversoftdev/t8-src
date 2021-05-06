// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_170a9c130859c688;
#using script_3affe3aaa3f22cb0;
#using script_3f9e54c7a9a7e1e2;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;

#namespace namespace_76be6fb6;

/*
	Name: function_89f2df9
	Namespace: namespace_76be6fb6
	Checksum: 0xB209B07B
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_70b1180bdd22bf41", &__init__, undefined, #"hash_3c720bfdc5ea4ee8");
}

/*
	Name: __init__
	Namespace: namespace_76be6fb6
	Checksum: 0xF9691128
	Offset: 0xF0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_6c2a3baefe289e35", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_76be6fb6
	Checksum: 0xE718012D
	Offset: 0x130
	Size: 0x19C
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
		callback::add_callback(#"hash_4d3e34c3c8f8bb2a", &function_155ab49c);
		callback::add_callback(#"hash_4b1a02a87458f191", &function_4ac25840);
		callback::function_10a4dd0a(&function_10a4dd0a);
		callback::function_955a779c(&function_955a779c);
		if(isdefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659"))
		{
			namespace_b0722f43::function_e70fa91c(#"hash_34dde6670d802e92", #"hash_336749f373d0fbf7", 3);
		}
		else
		{
			namespace_b0722f43::function_e70fa91c(#"hash_34dde6670d802e92", #"hash_336749f373d0fbf7", 10);
		}
	}
}

/*
	Name: function_1c4b5097
	Namespace: namespace_76be6fb6
	Checksum: 0x841BD559
	Offset: 0x2D8
	Size: 0x15C
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"hash_6e170d3f9454d08a")
	{
		if(self character_unlock::function_f0406288(#"hash_6c2a3baefe289e35"))
		{
			var_4862d883 = self function_687146d();
			if(var_4862d883 >= 15)
			{
				self character_unlock::function_c8beca5e(#"hash_6c2a3baefe289e35", #"hash_7ccc9c0240fd010e", 1);
			}
			var_c503939b = globallogic::function_e9e52d05();
			if(var_c503939b <= function_c816ea5b())
			{
				if(self character_unlock::function_f0406288(#"hash_6c2a3baefe289e35"))
				{
					self character_unlock::function_c8beca5e(#"hash_6c2a3baefe289e35", #"hash_7ccc9b0240fcff5b", 1);
				}
			}
		}
	}
}

/*
	Name: function_155ab49c
	Namespace: namespace_76be6fb6
	Checksum: 0xADF214B7
	Offset: 0x440
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_155ab49c(params)
{
	if(!isplayer(self))
	{
		return;
	}
	var_a6762160 = params.item.var_a6762160;
	var_4961f577 = params.item.var_4961f577;
	if(isdefined(var_4961f577) && var_4961f577)
	{
		return;
	}
	if(isdefined(var_a6762160) && var_a6762160.itemtype === #"health")
	{
		if(self character_unlock::function_f0406288(#"hash_6c2a3baefe289e35"))
		{
			var_4862d883 = self function_687146d();
			if(var_4862d883 < 15)
			{
				self character_unlock::function_c8beca5e(#"hash_6c2a3baefe289e35", #"hash_7ccc9c0240fd010e", 0);
			}
		}
	}
}

/*
	Name: function_10a4dd0a
	Namespace: namespace_76be6fb6
	Checksum: 0x41F669A3
	Offset: 0x570
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_10a4dd0a(params)
{
	var_a6762160 = params.item.var_a6762160;
	if(isdefined(var_a6762160) && var_a6762160.itemtype === #"health")
	{
		if(self character_unlock::function_f0406288(#"hash_6c2a3baefe289e35"))
		{
			var_4862d883 = self function_687146d();
			if(var_4862d883 >= 15)
			{
				self character_unlock::function_c8beca5e(#"hash_6c2a3baefe289e35", #"hash_7ccc9c0240fd010e", 1);
			}
		}
	}
}

/*
	Name: function_955a779c
	Namespace: namespace_76be6fb6
	Checksum: 0xD0260CCA
	Offset: 0x658
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_955a779c(params)
{
	var_a6762160 = params.item.var_a6762160;
	if(isdefined(var_a6762160) && var_a6762160.itemtype === #"health")
	{
		if(self character_unlock::function_f0406288(#"hash_6c2a3baefe289e35"))
		{
			var_4862d883 = self function_687146d();
			if(var_4862d883 < 15)
			{
				self character_unlock::function_c8beca5e(#"hash_6c2a3baefe289e35", #"hash_7ccc9c0240fd010e", 0);
			}
		}
	}
}

/*
	Name: function_687146d
	Namespace: namespace_76be6fb6
	Checksum: 0x508EBB24
	Offset: 0x738
	Size: 0xF0
	Parameters: 0
	Flags: Linked, Private
*/
private function function_687146d()
{
	var_4862d883 = 0;
	if(isdefined(self.inventory) && isdefined(self.inventory.items))
	{
		foreach(item in self.inventory.items)
		{
			if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"health")
			{
				var_4862d883 = var_4862d883 + item.count;
			}
		}
	}
	return var_4862d883;
}

/*
	Name: function_4ac25840
	Namespace: namespace_76be6fb6
	Checksum: 0x5D3AC5DA
	Offset: 0x830
	Size: 0x1E2
	Parameters: 1
	Flags: Linked
*/
function function_4ac25840(var_d32e67b4)
{
	if(isdefined(level.var_6d75024c) && level.var_6d75024c)
	{
		return;
	}
	var_c503939b = globallogic::function_e9e52d05();
	if(var_c503939b <= function_c816ea5b())
	{
		foreach(team in level.teams)
		{
			if(teams::function_9dd75dad(team) && !teams::function_6ce0360d(team))
			{
				players = getplayers(team);
				foreach(player in players)
				{
					if(player character_unlock::function_f0406288(#"hash_6c2a3baefe289e35"))
					{
						player character_unlock::function_c8beca5e(#"hash_6c2a3baefe289e35", #"hash_7ccc9b0240fcff5b", 1);
					}
				}
			}
		}
		level.var_6d75024c = 1;
	}
}

/*
	Name: function_c816ea5b
	Namespace: namespace_76be6fb6
	Checksum: 0x2BE49EB0
	Offset: 0xA20
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
			return 15;
		}
		case 2:
		{
			return 8;
		}
		case 4:
		default:
		{
			return 3;
		}
		case 5:
		{
			return 3;
		}
	}
}

