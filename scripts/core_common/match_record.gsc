// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;

#namespace match_record;

/*
	Name: function_d92cb558
	Namespace: match_record
	Checksum: 0x172DC815
	Offset: 0x70
	Size: 0x36
	Parameters: 2
	Flags: None
*/
function function_d92cb558(result, vararg)
{
	/#
		var_2f3fa528 = "";
		return var_2f3fa528;
	#/
}

/*
	Name: get_stat
	Namespace: match_record
	Checksum: 0xC852DE7A
	Offset: 0xB0
	Size: 0x80
	Parameters: 1
	Flags: Linked, Variadic
*/
function get_stat(vararg)
{
	/#
		assert(vararg.size > 0);
	#/
	if(vararg.size == 0)
	{
		return undefined;
	}
	result = function_644a3b03(vararg);
	/#
		function_d92cb558(result, vararg);
	#/
	return result;
}

/*
	Name: set_stat
	Namespace: match_record
	Checksum: 0xE452CC60
	Offset: 0x138
	Size: 0xC0
	Parameters: 1
	Flags: Linked, Variadic
*/
function set_stat(vararg)
{
	/#
		assert(vararg.size > 1);
	#/
	if(vararg.size <= 1)
	{
		return;
	}
	value = vararg[vararg.size - 1];
	arrayremoveindex(vararg, vararg.size - 1);
	result = function_484b4b09(vararg, value);
	/#
		function_d92cb558(result, vararg);
	#/
	return result;
}

/*
	Name: function_7a93acec
	Namespace: match_record
	Checksum: 0x3180A589
	Offset: 0x200
	Size: 0x144
	Parameters: 1
	Flags: Linked, Variadic
*/
function function_7a93acec(vararg)
{
	vec = vararg[vararg.size - 1];
	arrayremoveindex(vararg, vararg.size - 1);
	var_22f1ed01 = set_stat(vararg, 0, int(vec[0]));
	var_531b181 = set_stat(vararg, 1, int(vec[1]));
	var_bea5a46a = set_stat(vararg, 2, int(vec[2]));
	return isdefined(var_22f1ed01) && var_22f1ed01 && (isdefined(var_531b181) && var_531b181) && (isdefined(var_bea5a46a) && var_bea5a46a);
}

/*
	Name: inc_stat
	Namespace: match_record
	Checksum: 0x6228EE8B
	Offset: 0x350
	Size: 0xC0
	Parameters: 1
	Flags: Linked, Variadic
*/
function inc_stat(vararg)
{
	/#
		assert(vararg.size > 1);
	#/
	if(vararg.size <= 1)
	{
		return;
	}
	value = vararg[vararg.size - 1];
	arrayremoveindex(vararg, vararg.size - 1);
	result = function_976e9113(vararg, value);
	/#
		function_d92cb558(result, vararg);
	#/
	return result;
}

/*
	Name: get_player_index
	Namespace: match_record
	Checksum: 0xAE0758A8
	Offset: 0x418
	Size: 0x78
	Parameters: 0
	Flags: None
*/
function get_player_index()
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	if(isplayer(player) && isdefined(player.clientid))
	{
		return player.clientid;
	}
}

/*
	Name: get_player_stat
	Namespace: match_record
	Checksum: 0x6455DD54
	Offset: 0x498
	Size: 0x8C
	Parameters: 1
	Flags: Linked, Variadic
*/
function get_player_stat(vararg)
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	if(isplayer(player))
	{
		return get_stat(#"players", player.clientid, vararg);
	}
}

/*
	Name: set_player_stat
	Namespace: match_record
	Checksum: 0x2708E3BC
	Offset: 0x530
	Size: 0xCC
	Parameters: 1
	Flags: Linked, Variadic
*/
function set_player_stat(vararg)
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	if(isplayer(player))
	{
		value = vararg[vararg.size - 1];
		arrayremoveindex(vararg, vararg.size - 1);
		return set_stat(#"players", player.clientid, vararg, value);
	}
}

/*
	Name: function_ded5f5b6
	Namespace: match_record
	Checksum: 0x9ACEF3DD
	Offset: 0x608
	Size: 0x196
	Parameters: 1
	Flags: Variadic
*/
function function_ded5f5b6(vararg)
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	if(isplayer(player))
	{
		vec = vararg[vararg.size - 1];
		arrayremoveindex(vararg, vararg.size - 1);
		var_22f1ed01 = set_player_stat(vararg, 0, int(vec[0]));
		var_531b181 = set_player_stat(vararg, 1, int(vec[1]));
		var_bea5a46a = set_player_stat(vararg, 2, int(vec[2]));
		return isdefined(var_22f1ed01) && var_22f1ed01 && (isdefined(var_531b181) && var_531b181) && (isdefined(var_bea5a46a) && var_bea5a46a);
	}
}

/*
	Name: function_34800eec
	Namespace: match_record
	Checksum: 0xF4A8584D
	Offset: 0x7A8
	Size: 0xCC
	Parameters: 1
	Flags: Linked, Variadic
*/
function function_34800eec(vararg)
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	if(isplayer(player))
	{
		value = vararg[vararg.size - 1];
		arrayremoveindex(vararg, vararg.size - 1);
		return inc_stat(#"players", player.clientid, vararg, value);
	}
}

