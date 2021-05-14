// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace namespace_4cd9c601;

/*
	Name: function_89f2df9
	Namespace: namespace_4cd9c601
	Checksum: 0x8B1639F4
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_567cc170fccd467c", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_4cd9c601
	Checksum: 0xF2E3FF67
	Offset: 0xE0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_additional_primary_weapon_perk_for_level();
}

/*
	Name: enable_additional_primary_weapon_perk_for_level
	Namespace: namespace_4cd9c601
	Checksum: 0xE0BB9A1D
	Offset: 0x100
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function enable_additional_primary_weapon_perk_for_level()
{
	zm_perks::function_7f42e14e(#"hash_5266c7139f9acf56", "mod_additionalprimaryweapon", #"perk_additional_primary_weapon", #"specialty_additionalprimaryweapon", 5000);
	zm_perks::register_perk_threads(#"hash_5266c7139f9acf56", &function_ffa39915, &function_8f205daa);
	zm_perks::function_2ae97a14(#"hash_5266c7139f9acf56", array(#"specialty_fastweaponswitch"));
}

/*
	Name: function_ffa39915
	Namespace: namespace_4cd9c601
	Checksum: 0x722454FC
	Offset: 0x1E0
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function function_ffa39915()
{
	self.var_dd1b11fe = 1;
}

/*
	Name: function_8f205daa
	Namespace: namespace_4cd9c601
	Checksum: 0xC957087A
	Offset: 0x200
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function function_8f205daa(b_pause, str_perk, str_result, n_slot)
{
}

/*
	Name: function_69f490a
	Namespace: namespace_4cd9c601
	Checksum: 0xA4C8B117
	Offset: 0x230
	Size: 0xE6
	Parameters: 1
	Flags: None
*/
function function_69f490a(var_aecb3e98)
{
	if(!isdefined(level.var_2bb81f4b))
	{
		level.var_2bb81f4b = [];
	}
	else if(!isarray(level.var_2bb81f4b))
	{
		level.var_2bb81f4b = array(level.var_2bb81f4b);
	}
	if(!isdefined(var_aecb3e98))
	{
		var_aecb3e98 = [];
	}
	else if(!isarray(var_aecb3e98))
	{
		var_aecb3e98 = array(var_aecb3e98);
	}
	level.var_2bb81f4b = arraycombine(level.var_2bb81f4b, var_aecb3e98, 0, 0);
}

/*
	Name: function_23c3c9db
	Namespace: namespace_4cd9c601
	Checksum: 0x25021B16
	Offset: 0x320
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_23c3c9db(weapon)
{
	if(!isdefined(level.var_2bb81f4b))
	{
		level.var_2bb81f4b = [];
	}
	else if(!isarray(level.var_2bb81f4b))
	{
		level.var_2bb81f4b = array(level.var_2bb81f4b);
	}
	return !isinarray(level.var_2bb81f4b, weapon);
}

