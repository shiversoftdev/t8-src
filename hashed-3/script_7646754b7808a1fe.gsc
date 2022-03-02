// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_170a9c130859c688;
#using script_3affe3aaa3f22cb0;
#using script_3f9e54c7a9a7e1e2;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;

#namespace namespace_55bde9ea;

/*
	Name: function_89f2df9
	Namespace: namespace_55bde9ea
	Checksum: 0xBBB30659
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_6accb974878ca75c", &__init__, undefined, #"hash_3aded3fedbbfc401");
}

/*
	Name: __init__
	Namespace: namespace_55bde9ea
	Checksum: 0x531F34BC
	Offset: 0xF0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_35708904c4af42d0", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_55bde9ea
	Checksum: 0x1071BED2
	Offset: 0x130
	Size: 0x14C
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::function_955a779c(&function_a2877194);
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
		callback::add_callback(#"hash_4b1a02a87458f191", &function_4ac25840);
		if(isdefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659"))
		{
			namespace_b0722f43::function_e70fa91c(#"hash_5d3928f724e1cadf", #"hash_2b1e613a3cc4bf97", 2);
		}
		else
		{
			namespace_b0722f43::function_e70fa91c(#"hash_5d3928f724e1cadf", #"hash_2b1e613a3cc4bf97", 6);
		}
	}
}

/*
	Name: function_1c4b5097
	Namespace: namespace_55bde9ea
	Checksum: 0xA78D0808
	Offset: 0x288
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"hash_400a089fa8ccd917")
	{
		self.var_cadd241b = 1;
		var_c503939b = globallogic::function_e9e52d05();
		if(var_c503939b <= function_c816ea5b())
		{
			if(self character_unlock::function_f0406288(#"hash_35708904c4af42d0"))
			{
				self character_unlock::function_c8beca5e(#"hash_35708904c4af42d0", #"hash_b47463756c6a60f", 1);
			}
		}
	}
}

/*
	Name: function_a2877194
	Namespace: namespace_55bde9ea
	Checksum: 0xB6613B47
	Offset: 0x378
	Size: 0x16C
	Parameters: 1
	Flags: Linked
*/
function function_a2877194(params)
{
	if(!(isdefined(self.var_cadd241b) && self.var_cadd241b))
	{
		return;
	}
	if(!self character_unlock::function_f0406288(#"hash_35708904c4af42d0"))
	{
		return;
	}
	item_name = params.item.var_a6762160.name;
	if(item_name === #"hash_14b578e446580ad5")
	{
		if(!isdefined(self.var_41ae08e8))
		{
			self.var_41ae08e8 = 0;
		}
		self.var_41ae08e8++;
		if(self.var_41ae08e8 == 2)
		{
			self character_unlock::function_c8beca5e(#"hash_35708904c4af42d0", #"hash_a9ec4883fd0293d", 1);
		}
	}
	else if(item_name === #"hash_2b06a3f530395182")
	{
		if(!isdefined(self.var_c0bc1135))
		{
			self.var_c0bc1135 = 0;
		}
		self.var_c0bc1135++;
		if(self.var_c0bc1135 == 1)
		{
			self character_unlock::function_c8beca5e(#"hash_35708904c4af42d0", #"hash_3843c83850f09a08", 1);
		}
	}
}

/*
	Name: function_4ac25840
	Namespace: namespace_55bde9ea
	Checksum: 0xF62CAB56
	Offset: 0x4F0
	Size: 0x1E2
	Parameters: 1
	Flags: Linked
*/
function function_4ac25840(var_d32e67b4)
{
	if(isdefined(level.var_93eb15f7) && level.var_93eb15f7)
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
					if(player character_unlock::function_f0406288(#"hash_35708904c4af42d0"))
					{
						player character_unlock::function_c8beca5e(#"hash_35708904c4af42d0", #"hash_b47463756c6a60f", 1);
					}
				}
			}
		}
		level.var_93eb15f7 = 1;
	}
}

/*
	Name: function_c816ea5b
	Namespace: namespace_55bde9ea
	Checksum: 0x16A3C628
	Offset: 0x6E0
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
			return 30;
		}
		case 2:
		{
			return 15;
		}
		case 4:
		default:
		{
			return 7;
		}
		case 5:
		{
			return 7;
		}
	}
}

