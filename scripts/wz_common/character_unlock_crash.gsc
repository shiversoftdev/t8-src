// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_170a9c130859c688;
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\mp_common\teams\teams.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;

#namespace character_unlock_crash;

/*
	Name: __init__system__
	Namespace: character_unlock_crash
	Checksum: 0xB209B07B
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_crash", &__init__, undefined, #"character_unlock_crash_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_crash
	Checksum: 0xF9691128
	Offset: 0xF0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"crash_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_crash
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
		callback::add_callback(#"on_drop_item", &on_drop_item);
		callback::add_callback(#"hash_4b1a02a87458f191", &function_4ac25840);
		callback::on_item_pickup(&on_item_pickup);
		callback::on_item_use(&on_item_use);
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
	Namespace: character_unlock_crash
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
		if(self character_unlock::function_f0406288(#"crash_unlock"))
		{
			var_4862d883 = self function_687146d();
			if(var_4862d883 >= 15)
			{
				self character_unlock::function_c8beca5e(#"crash_unlock", #"hash_7ccc9c0240fd010e", 1);
			}
			var_c503939b = globallogic::function_e9e52d05();
			if(var_c503939b <= function_c816ea5b())
			{
				if(self character_unlock::function_f0406288(#"crash_unlock"))
				{
					self character_unlock::function_c8beca5e(#"crash_unlock", #"hash_7ccc9b0240fcff5b", 1);
				}
			}
		}
	}
}

/*
	Name: on_drop_item
	Namespace: character_unlock_crash
	Checksum: 0xADF214B7
	Offset: 0x440
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function on_drop_item(params)
{
	if(!isplayer(self))
	{
		return;
	}
	var_a6762160 = params.item.var_a6762160;
	deathstash = params.item.deathstash;
	if(isdefined(deathstash) && deathstash)
	{
		return;
	}
	if(isdefined(var_a6762160) && var_a6762160.itemtype === #"health")
	{
		if(self character_unlock::function_f0406288(#"crash_unlock"))
		{
			var_4862d883 = self function_687146d();
			if(var_4862d883 < 15)
			{
				self character_unlock::function_c8beca5e(#"crash_unlock", #"hash_7ccc9c0240fd010e", 0);
			}
		}
	}
}

/*
	Name: on_item_pickup
	Namespace: character_unlock_crash
	Checksum: 0x41F669A3
	Offset: 0x570
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function on_item_pickup(params)
{
	var_a6762160 = params.item.var_a6762160;
	if(isdefined(var_a6762160) && var_a6762160.itemtype === #"health")
	{
		if(self character_unlock::function_f0406288(#"crash_unlock"))
		{
			var_4862d883 = self function_687146d();
			if(var_4862d883 >= 15)
			{
				self character_unlock::function_c8beca5e(#"crash_unlock", #"hash_7ccc9c0240fd010e", 1);
			}
		}
	}
}

/*
	Name: on_item_use
	Namespace: character_unlock_crash
	Checksum: 0xD0260CCA
	Offset: 0x658
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function on_item_use(params)
{
	var_a6762160 = params.item.var_a6762160;
	if(isdefined(var_a6762160) && var_a6762160.itemtype === #"health")
	{
		if(self character_unlock::function_f0406288(#"crash_unlock"))
		{
			var_4862d883 = self function_687146d();
			if(var_4862d883 < 15)
			{
				self character_unlock::function_c8beca5e(#"crash_unlock", #"hash_7ccc9c0240fd010e", 0);
			}
		}
	}
}

/*
	Name: function_687146d
	Namespace: character_unlock_crash
	Checksum: 0x508EBB24
	Offset: 0x738
	Size: 0xF0
	Parameters: 0
	Flags: Linked, Private
*/
function private function_687146d()
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
	Namespace: character_unlock_crash
	Checksum: 0x5D3AC5DA
	Offset: 0x830
	Size: 0x1E2
	Parameters: 1
	Flags: Linked
*/
function function_4ac25840(dead_team)
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
			if(teams::function_9dd75dad(team) && !teams::is_all_dead(team))
			{
				players = getplayers(team);
				foreach(player in players)
				{
					if(player character_unlock::function_f0406288(#"crash_unlock"))
					{
						player character_unlock::function_c8beca5e(#"crash_unlock", #"hash_7ccc9b0240fcff5b", 1);
					}
				}
			}
		}
		level.var_6d75024c = 1;
	}
}

/*
	Name: function_c816ea5b
	Namespace: character_unlock_crash
	Checksum: 0x2BE49EB0
	Offset: 0xA20
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
			return 3;
		}
		case 5:
		{
			return 3;
		}
	}
}

