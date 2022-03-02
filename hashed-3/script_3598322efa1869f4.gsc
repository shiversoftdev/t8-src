// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_5cf6d1a;

/*
	Name: function_89f2df9
	Namespace: namespace_5cf6d1a
	Checksum: 0xC6A3A17B
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"ray_gun", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_5cf6d1a
	Checksum: 0xFCC94070
	Offset: 0xF8
	Size: 0x244
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_b21bed72 = [];
	level.var_b21bed72[#"hash_5a4246956faa187e"] = getweapon(#"hash_5a4246956faa187e");
	level.var_b21bed72[#"hash_43989578a576ae26"] = getweapon(#"hash_43989578a576ae26");
	level.var_b21bed72[#"hash_43b39078a58d6d5f"] = getweapon(#"hash_43b39078a58d6d5f");
	arrayremovevalue(level.var_b21bed72, getweapon(#"none"), 1);
	zombie_utility::add_zombie_gib_weapon_callback(#"hash_5a4246956faa187e", &function_215146f5, &function_215146f5);
	zombie_utility::add_zombie_gib_weapon_callback(#"hash_43989578a576ae26", &function_215146f5, &function_215146f5);
	zombie_utility::add_zombie_gib_weapon_callback(#"hash_43b39078a58d6d5f", &function_215146f5, &function_215146f5);
	if(getdvarint(#"raygun_disintegrate", 0))
	{
		callback::on_ai_killed(&on_ai_killed);
	}
	clientfield::register("actor", "raygun_disintegrate", 20000, 1, "counter");
}

/*
	Name: on_ai_killed
	Namespace: namespace_5cf6d1a
	Checksum: 0xEA3AFDF0
	Offset: 0x348
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function on_ai_killed(s_params)
{
	if(is_ray_gun(s_params.weapon))
	{
		self thread ai_disintegrate();
	}
}

/*
	Name: ai_disintegrate
	Namespace: namespace_5cf6d1a
	Checksum: 0xEA5513BC
	Offset: 0x390
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function ai_disintegrate()
{
	self endon(#"death");
	self clientfield::increment("raygun_disintegrate", 1);
	wait(1);
	self delete();
}

/*
	Name: is_ray_gun
	Namespace: namespace_5cf6d1a
	Checksum: 0x7D49BCC3
	Offset: 0x3F8
	Size: 0x36
	Parameters: 1
	Flags: Linked
*/
function is_ray_gun(w_weapon)
{
	if(isdefined(w_weapon))
	{
		return isinarray(level.var_b21bed72, w_weapon);
	}
	return 0;
}

/*
	Name: function_215146f5
	Namespace: namespace_5cf6d1a
	Checksum: 0x94D382FC
	Offset: 0x438
	Size: 0xE
	Parameters: 1
	Flags: Linked
*/
function function_215146f5(damage_percent)
{
	return false;
}

