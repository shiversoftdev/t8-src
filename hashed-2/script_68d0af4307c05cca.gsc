// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_talisman.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_e45694cd;

/*
	Name: function_89f2df9
	Namespace: namespace_e45694cd
	Checksum: 0xCFBDE237
	Offset: 0x110
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_12e90c9606123e96", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_e45694cd
	Checksum: 0x2028F879
	Offset: 0x158
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_talisman::function_88a60d36("talisman_box_guarantee_box_only", &function_fd7e329b);
}

/*
	Name: function_fd7e329b
	Namespace: namespace_e45694cd
	Checksum: 0xB20D7ECE
	Offset: 0x190
	Size: 0x26
	Parameters: 0
	Flags: Linked
*/
function function_fd7e329b()
{
	self.var_afb3ba4e = &function_543a48f0;
	self.var_c21099c0 = 1;
}

/*
	Name: function_543a48f0
	Namespace: namespace_e45694cd
	Checksum: 0x27E8ACE1
	Offset: 0x1C0
	Size: 0x1EA
	Parameters: 1
	Flags: Linked
*/
function function_543a48f0(a_keys)
{
	var_5dfcc1de = array();
	a_valid = array();
	var_52fb84b5 = [];
	var_52fb84b5 = struct::get_array("weapon_upgrade", "targetname");
	var_52fb84b5 = arraycombine(var_52fb84b5, struct::get_array("buildable_wallbuy", "targetname"), 1, 0);
	for(i = 0; i < var_52fb84b5.size; i++)
	{
		var_38e724e6 = getweapon(var_52fb84b5[i].zombie_weapon_upgrade);
		array::add(var_5dfcc1de, var_38e724e6);
	}
	foreach(var_e64c7df8 in a_keys)
	{
		if(!zm_weapons::is_wonder_weapon(var_e64c7df8))
		{
			array::add(a_valid, var_e64c7df8);
		}
	}
	a_keys = array::exclude(a_valid, var_5dfcc1de);
	a_keys = array::randomize(a_keys);
	self.var_afb3ba4e = undefined;
	self.var_c21099c0 = undefined;
	return a_keys;
}

