// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47fb62300ac0bd60;
#using scripts\core_common\system_shared.gsc;

#namespace player_role;

/*
	Name: function_89f2df9
	Namespace: player_role
	Checksum: 0xBC5C8B65
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"player_role", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: player_role
	Checksum: 0x9AF5CDA0
	Offset: 0xD8
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(world.var_7407953c))
	{
		world.var_7407953c = [];
	}
}

/*
	Name: get_category_for_index
	Namespace: player_role
	Checksum: 0xBAFC44C9
	Offset: 0x108
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function get_category_for_index(characterindex)
{
	categoryname = getplayerrolecategory(characterindex, currentsessionmode());
	if(isdefined(categoryname))
	{
		categoryinfo = getplayerrolecategoryinfo(categoryname);
		/#
			assert(isdefined(categoryinfo));
		#/
		if(isdefined(categoryinfo.enabled) && categoryinfo.enabled)
		{
			return categoryname;
		}
	}
	return "default";
}

/*
	Name: get_category
	Namespace: player_role
	Checksum: 0x4930935D
	Offset: 0x1C8
	Size: 0xA2
	Parameters: 0
	Flags: None
*/
function get_category()
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	characterindex = player get();
	/#
		assert(is_valid(characterindex));
	#/
	return get_category_for_index(characterindex);
}

/*
	Name: function_c1f61ea2
	Namespace: player_role
	Checksum: 0x93032221
	Offset: 0x278
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_c1f61ea2()
{
	return world.var_7407953c[self getentitynumber()];
}

/*
	Name: is_valid
	Namespace: player_role
	Checksum: 0xFA7EA4CF
	Offset: 0x2A8
	Size: 0x156
	Parameters: 1
	Flags: Linked
*/
function is_valid(index)
{
	if(!isdefined(index))
	{
		return 0;
	}
	if(currentsessionmode() == 0)
	{
		if(isdefined(level.validcharacters))
		{
			return isinarray(level.validcharacters, index);
		}
		return 0;
	}
	if(currentsessionmode() == 2)
	{
		return index >= 0 && index < getplayerroletemplatecount(currentsessionmode());
	}
	/#
		if(getdvarint(#"allowdebugcharacter", 0) == 1)
		{
			return index >= 0 && index < getplayerroletemplatecount(currentsessionmode());
		}
	#/
	return index > 0 && index < getplayerroletemplatecount(currentsessionmode());
}

/*
	Name: get
	Namespace: player_role
	Checksum: 0xC2A14D77
	Offset: 0x408
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function get()
{
	/#
		/#
			assert(isplayer(self));
		#/
	#/
	return self getspecialistindex();
}

/*
	Name: update_fields
	Namespace: player_role
	Checksum: 0x2FC9E381
	Offset: 0x460
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function update_fields()
{
	self.playerrole = self getrolefields();
}

/*
	Name: set
	Namespace: player_role
	Checksum: 0x4B4546F9
	Offset: 0x490
	Size: 0x258
	Parameters: 2
	Flags: Linked
*/
function set(index, force)
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	/#
		assert(is_valid(index));
	#/
	player.pers[#"characterindex"] = index;
	player setspecialistindex(index);
	if(isbot(self) && getdvarint(#"hash_542c037530526acb", 0) && (!(isdefined(force) && force)))
	{
		self botsetrandomcharactercustomization();
	}
	player update_fields();
	world.var_7407953c[self getentitynumber()] = index;
	if(currentsessionmode() == 0)
	{
		customloadoutindex = get_custom_loadout_index(index);
	}
	else if(currentsessionmode() == 2)
	{
		customloadoutindex = self stats::get_stat(#"hash_2a738807be622e31");
	}
	else if(currentsessionmode() == 3)
	{
		customloadoutindex = 0;
	}
	else
	{
		customloadoutindex = self.pers[#"loadoutindex"];
	}
	if(isdefined(customloadoutindex))
	{
		result = self [[level.curclass]]("custom" + customloadoutindex);
		if(!isdefined(result))
		{
			return 1;
		}
		return result;
	}
	return 0;
}

/*
	Name: clear
	Namespace: player_role
	Checksum: 0xD4CAD58E
	Offset: 0x6F0
	Size: 0x7A
	Parameters: 0
	Flags: None
*/
function clear()
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	player setspecialistindex(0);
	player.pers[#"characterindex"] = undefined;
	player.playerrole = undefined;
}

/*
	Name: get_custom_loadout_index
	Namespace: player_role
	Checksum: 0x8DEA3814
	Offset: 0x778
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function get_custom_loadout_index(characterindex)
{
	return getcharacterclassindex(characterindex);
}

/*
	Name: function_97d19493
	Namespace: player_role
	Checksum: 0x6B40B52D
	Offset: 0x7A8
	Size: 0xA6
	Parameters: 1
	Flags: None
*/
function function_97d19493(name)
{
	sessionmode = currentsessionmode();
	playerroletemplatecount = getplayerroletemplatecount(sessionmode);
	for(i = 0; i < playerroletemplatecount; i++)
	{
		var_3c6fd4f7 = function_b14806c6(i, sessionmode);
		if(var_3c6fd4f7 == name)
		{
			return i;
		}
	}
	return undefined;
}

