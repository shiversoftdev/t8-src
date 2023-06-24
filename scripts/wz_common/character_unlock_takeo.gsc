// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\mp_common\item_drop.gsc;
#using scripts\mp_common\teams\teams.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\mp_common\item_world.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;

#namespace character_unlock_takeo;

/*
	Name: __init__system__
	Namespace: character_unlock_takeo
	Checksum: 0xD6FD166F
	Offset: 0xC8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_takeo", &__init__, undefined, #"character_unlock_takeo_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_takeo
	Checksum: 0x714E680B
	Offset: 0x118
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"takeo_unlock", &function_2613aeec);
	callback::on_finalize_initialization(&on_finalize_initialization);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_takeo
	Checksum: 0xA0DA2AB3
	Offset: 0x178
	Size: 0x174
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::on_item_use(&on_item_use);
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
		callback::add_callback(#"hash_4b1a02a87458f191", &function_4ac25840);
		a_dynents = getdynentarray(#"hash_7b220e1de3a2000d");
		if(isdefined(a_dynents) && isarray(a_dynents))
		{
			foreach(ent in a_dynents)
			{
				ent.onuse = &function_d5cd583a;
			}
		}
	}
	else
	{
		level thread function_279880b1();
	}
}

/*
	Name: on_finalize_initialization
	Namespace: character_unlock_takeo
	Checksum: 0xC1AC5180
	Offset: 0x2F8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function on_finalize_initialization()
{
	waitframe(1);
	level function_552910e9();
}

/*
	Name: function_279880b1
	Namespace: character_unlock_takeo
	Checksum: 0x17882275
	Offset: 0x328
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_279880b1()
{
	item_world::function_4de3ca98();
	level function_552910e9();
}

/*
	Name: function_552910e9
	Namespace: character_unlock_takeo
	Checksum: 0x79E225F3
	Offset: 0x360
	Size: 0xC8
	Parameters: 0
	Flags: Linked
*/
function function_552910e9()
{
	a_dynents = getdynentarray(#"hash_7b220e1de3a2000d");
	if(isdefined(a_dynents) && isarray(a_dynents))
	{
		foreach(dynent in a_dynents)
		{
			setdynentenabled(dynent, 0);
		}
	}
}

/*
	Name: function_d5cd583a
	Namespace: character_unlock_takeo
	Checksum: 0xD9F13F61
	Offset: 0x430
	Size: 0x136
	Parameters: 3
	Flags: Linked
*/
function function_d5cd583a(activator, laststate, state)
{
	if(!level character_unlock::function_b3681acb())
	{
		return;
	}
	if(level.inprematchperiod)
	{
		return;
	}
	spawnpos = struct::get(self.target, "targetname");
	if(!isdefined(spawnpos))
	{
		return;
	}
	point = function_4ba8fde(#"hash_12d0b662134986e2");
	if(isdefined(point) && isdefined(point.var_a6762160))
	{
		dropitem = self item_drop::drop_item(point.var_a6762160.weapon, 1, point.var_a6762160.amount, point.id, spawnpos.origin, spawnpos.angles);
	}
}

/*
	Name: function_1c4b5097
	Namespace: character_unlock_takeo
	Checksum: 0xF10AD1FC
	Offset: 0x570
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"hash_12d0b662134986e2")
	{
		if(self character_unlock::function_f0406288(#"takeo_unlock"))
		{
			self function_895b40e4();
			self character_unlock::function_c8beca5e(#"takeo_unlock", #"hash_56b5eb94fb75cbed", 1);
			self.var_b5d833a4 = 1;
			var_c503939b = globallogic::function_e9e52d05();
			if(var_c503939b <= function_c816ea5b())
			{
				self character_unlock::function_c8beca5e(#"takeo_unlock", #"hash_56b5e894fb75c6d4", 1);
			}
		}
	}
}

/*
	Name: on_item_use
	Namespace: character_unlock_takeo
	Checksum: 0x51CF489A
	Offset: 0x6A8
	Size: 0xFA
	Parameters: 1
	Flags: Linked
*/
function on_item_use(params)
{
	if(!(isdefined(self.var_b5d833a4) && self.var_b5d833a4))
	{
		return;
	}
	if(isdefined(self.var_979273e3) && self.var_979273e3)
	{
		return;
	}
	item = params.item;
	if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"equipment")
	{
		if(self character_unlock::function_c70bcc7a(#"takeo_unlock"))
		{
			self character_unlock::function_c8beca5e(#"takeo_unlock", #"hash_56b5eb94fb75cbed", 2);
			self.var_979273e3 = 1;
		}
	}
}

/*
	Name: function_4ac25840
	Namespace: character_unlock_takeo
	Checksum: 0x7EDEC844
	Offset: 0x7B0
	Size: 0x1E2
	Parameters: 1
	Flags: Linked
*/
function function_4ac25840(dead_team)
{
	if(isdefined(level.var_2dd7bbb7) && level.var_2dd7bbb7)
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
					if(player character_unlock::function_f0406288(#"takeo_unlock"))
					{
						player character_unlock::function_c8beca5e(#"takeo_unlock", #"hash_56b5e894fb75c6d4", 1);
					}
				}
			}
		}
		level.var_2dd7bbb7 = 1;
	}
}

/*
	Name: function_c816ea5b
	Namespace: character_unlock_takeo
	Checksum: 0xCCC5836F
	Offset: 0x9A0
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

/*
	Name: function_895b40e4
	Namespace: character_unlock_takeo
	Checksum: 0x99E31A61
	Offset: 0xA88
	Size: 0x24
	Parameters: 0
	Flags: Linked, Private
*/
function private function_895b40e4()
{
	self playsoundtoplayer(#"hash_1c5c27cafefddb2f", self);
}

