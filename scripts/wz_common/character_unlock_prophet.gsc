// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using script_71e26f08f03b7a7a;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace character_unlock_prophet;

/*
	Name: __init__system__
	Namespace: character_unlock_prophet
	Checksum: 0x7BAC539B
	Offset: 0xB0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_prophet", &__init__, undefined, #"character_unlock_prophet_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_prophet
	Checksum: 0x5A266336
	Offset: 0x100
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"prophet_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_prophet
	Checksum: 0x4B2664B0
	Offset: 0x140
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
		callback::add_callback(#"on_last_alive", &function_4ac25840);
		callback::add_callback(#"on_drop_item", &on_drop_item);
		character_unlock::function_d2294476(#"hash_2b1b5d3a3cc282f4", 2, 3);
	}
}

/*
	Name: function_1c4b5097
	Namespace: character_unlock_prophet
	Checksum: 0x22095C88
	Offset: 0x218
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"cu10_item")
	{
		self thread function_798820a9(item);
	}
}

/*
	Name: on_drop_item
	Namespace: character_unlock_prophet
	Checksum: 0x815D8E5
	Offset: 0x278
	Size: 0xCE
	Parameters: 1
	Flags: Linked
*/
function on_drop_item(params)
{
	if(!isplayer(self))
	{
		return;
	}
	if(isdefined(params.item) && isdefined(params.item.var_a6762160))
	{
		var_a6762160 = params.item.var_a6762160;
		if(var_a6762160.name === #"cu10_item" && !self character_unlock::function_f0406288(#"prophet_unlock"))
		{
			self notify(#"dropped_prophet_item");
		}
	}
}

/*
	Name: function_798820a9
	Namespace: character_unlock_prophet
	Checksum: 0x6CF27334
	Offset: 0x350
	Size: 0x17E
	Parameters: 1
	Flags: Linked
*/
function function_798820a9(item)
{
	self notify("3da3c6e1687182e2");
	self endon("3da3c6e1687182e2");
	self endon(#"hash_249a493b6d9b422c", #"dropped_prophet_item", #"hash_4518b55c281baa0c", #"death");
	if(!isplayer(self))
	{
		return;
	}
	player = self;
	while(isdefined(player))
	{
		if(isdefined(player.inventory) && isdefined(player.inventory.consumed))
		{
			if((isdefined(player.inventory.inventory.consumed.size) ? player.inventory.consumed.size : 0) >= 3)
			{
				player character_unlock::function_c8beca5e(#"prophet_unlock", #"hash_63b7bd67a959fc47", 1);
			}
			else
			{
				player character_unlock::function_c8beca5e(#"prophet_unlock", #"hash_63b7bd67a959fc47", 0);
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_4ac25840
	Namespace: character_unlock_prophet
	Checksum: 0x1286263E
	Offset: 0x4D8
	Size: 0x160
	Parameters: 1
	Flags: Linked
*/
function function_4ac25840(params)
{
	foreach(team in params.teams_alive)
	{
		players = getplayers(team);
		foreach(player in players)
		{
			if(player character_unlock::function_f0406288(#"prophet_unlock"))
			{
				player character_unlock::function_c8beca5e(#"prophet_unlock", #"hash_63b7be67a959fdfa", 1);
				player notify(#"hash_249a493b6d9b422c");
			}
		}
	}
}

