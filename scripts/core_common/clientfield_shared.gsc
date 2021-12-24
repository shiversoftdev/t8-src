// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.gsc;

#namespace clientfield;

/*
	Name: register
	Namespace: clientfield
	Checksum: 0x75BAACC0
	Offset: 0x98
	Size: 0x54
	Parameters: 5
	Flags: Linked
*/
function register(str_pool_name, str_name, n_version, n_bits, str_type)
{
	registerclientfield(str_pool_name, str_name, n_version, n_bits, str_type);
}

/*
	Name: function_a8bbc967
	Namespace: clientfield
	Checksum: 0x47C4A28D
	Offset: 0xF8
	Size: 0x54
	Parameters: 5
	Flags: Linked
*/
function function_a8bbc967(str_name, n_version, n_bits, str_type, var_59f69872)
{
	registerclientfield("clientuimodel", str_name, n_version, n_bits, str_type, var_59f69872);
}

/*
	Name: function_346f95ba
	Namespace: clientfield
	Checksum: 0xB3ABB931
	Offset: 0x158
	Size: 0x74
	Parameters: 6
	Flags: Linked
*/
function function_346f95ba(var_a832fdfa, field_name, n_version, n_bits, str_type, var_59f69872)
{
	registerclientfield("clientuimodel", (("luielement." + var_a832fdfa) + ".") + field_name, n_version, n_bits, str_type, var_59f69872);
}

/*
	Name: function_78175813
	Namespace: clientfield
	Checksum: 0xC2706AC
	Offset: 0x1D8
	Size: 0x54
	Parameters: 5
	Flags: Linked
*/
function function_78175813(poolname, var_b693fec6, uniqueid, version, var_59f69872)
{
	function_3ff577e6(poolname, var_b693fec6, uniqueid, version, var_59f69872);
}

/*
	Name: set
	Namespace: clientfield
	Checksum: 0x43BDAD39
	Offset: 0x238
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function set(str_field_name, n_value)
{
	if(!isdefined(str_field_name))
	{
		/#
			/#
				assertmsg("");
			#/
		#/
		return;
	}
	if(self == level)
	{
		codesetworldclientfield(str_field_name, n_value);
	}
	else
	{
		codesetclientfield(self, str_field_name, n_value);
	}
}

/*
	Name: function_6b3b55da
	Namespace: clientfield
	Checksum: 0xF8B41E42
	Offset: 0x2C8
	Size: 0x22
	Parameters: 2
	Flags: Linked
*/
function function_6b3b55da(str_field_name, n_value)
{
	return function_26b3a620();
}

/*
	Name: set_to_player
	Namespace: clientfield
	Checksum: 0x8324B1E
	Offset: 0x2F8
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function set_to_player(str_field_name, n_value)
{
	/#
		/#
			assert(isplayer(self), "");
		#/
	#/
	if(isplayer(self))
	{
		codesetplayerstateclientfield(self, str_field_name, n_value);
	}
}

/*
	Name: set_player_uimodel
	Namespace: clientfield
	Checksum: 0x95984F53
	Offset: 0x388
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function set_player_uimodel(str_field_name, n_value)
{
	codesetuimodelclientfield(self, str_field_name, n_value);
}

/*
	Name: function_9bf78ef8
	Namespace: clientfield
	Checksum: 0x5A63C238
	Offset: 0x3C0
	Size: 0x4C
	Parameters: 3
	Flags: Linked
*/
function function_9bf78ef8(var_a832fdfa, str_field_name, n_value)
{
	codesetuimodelclientfield(self, (("luielement." + var_a832fdfa) + ".") + str_field_name, n_value);
}

/*
	Name: function_bb878fc3
	Namespace: clientfield
	Checksum: 0x917A406C
	Offset: 0x418
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_bb878fc3(var_a832fdfa, str_field_name)
{
	codeincrementuimodelclientfield(self, (("luielement." + var_a832fdfa) + ".") + str_field_name);
}

/*
	Name: get_player_uimodel
	Namespace: clientfield
	Checksum: 0x580A3755
	Offset: 0x468
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function get_player_uimodel(str_field_name)
{
	return codegetuimodelclientfield(self, str_field_name);
}

/*
	Name: function_f7ae6994
	Namespace: clientfield
	Checksum: 0xFFE6398D
	Offset: 0x498
	Size: 0x42
	Parameters: 2
	Flags: None
*/
function function_f7ae6994(var_a832fdfa, str_field_name)
{
	return codegetuimodelclientfield(self, (("luielement." + var_a832fdfa) + ".") + str_field_name);
}

/*
	Name: set_world_uimodel
	Namespace: clientfield
	Checksum: 0xF98EA7FC
	Offset: 0x4E8
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function set_world_uimodel(str_field_name, n_value)
{
	codesetworlduimodelfield(str_field_name, n_value);
}

/*
	Name: get_world_uimodel
	Namespace: clientfield
	Checksum: 0xA85463BB
	Offset: 0x520
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function get_world_uimodel(str_field_name)
{
	return codegetworlduimodelfield(str_field_name);
}

/*
	Name: increment_world_uimodel
	Namespace: clientfield
	Checksum: 0x2A23FA6
	Offset: 0x550
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function increment_world_uimodel(str_field_name)
{
	return codeincrementworlduimodelfield(str_field_name);
}

/*
	Name: increment
	Namespace: clientfield
	Checksum: 0x8D55C4C5
	Offset: 0x580
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function increment(str_field_name, n_increment_count)
{
	self thread _increment(str_field_name, n_increment_count);
}

/*
	Name: _increment
	Namespace: clientfield
	Checksum: 0xFBEA2E95
	Offset: 0x5B8
	Size: 0xDE
	Parameters: 2
	Flags: Linked, Private
*/
private function _increment(str_field_name, n_increment_count = 1)
{
	if(self != level)
	{
		self endon(#"death");
	}
	for(i = 0; i < n_increment_count; i++)
	{
		if(self == level)
		{
			codeincrementworldclientfield(str_field_name);
			continue;
		}
		waittillframeend();
		if(isdefined(self.birthtime) && self.birthtime >= level.var_58bc5d04)
		{
			util::wait_network_frame();
		}
		codeincrementclientfield(self, str_field_name);
	}
}

/*
	Name: increment_uimodel
	Namespace: clientfield
	Checksum: 0xE2F4EE24
	Offset: 0x6A0
	Size: 0x106
	Parameters: 2
	Flags: Linked
*/
function increment_uimodel(str_field_name, n_increment_count = 1)
{
	if(self == level)
	{
		foreach(player in level.players)
		{
			for(i = 0; i < n_increment_count; i++)
			{
				codeincrementuimodelclientfield(player, str_field_name);
			}
		}
	}
	else
	{
		for(i = 0; i < n_increment_count; i++)
		{
			codeincrementuimodelclientfield(self, str_field_name);
		}
	}
}

/*
	Name: increment_to_player
	Namespace: clientfield
	Checksum: 0xD0E04C57
	Offset: 0x7B0
	Size: 0x5E
	Parameters: 2
	Flags: Linked
*/
function increment_to_player(str_field_name, n_increment_count = 1)
{
	for(i = 0; i < n_increment_count; i++)
	{
		codeincrementplayerstateclientfield(self, str_field_name);
	}
}

/*
	Name: get
	Namespace: clientfield
	Checksum: 0x4F448B88
	Offset: 0x818
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function get(str_field_name)
{
	if(self == level)
	{
		return codegetworldclientfield(str_field_name);
	}
	return codegetclientfield(self, str_field_name);
}

/*
	Name: get_to_player
	Namespace: clientfield
	Checksum: 0xD659B299
	Offset: 0x868
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function get_to_player(field_name)
{
	return codegetplayerstateclientfield(self, field_name);
}

