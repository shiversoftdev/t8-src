// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_399c912938783695;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_ea4e2c95;

/*
	Name: function_89f2df9
	Namespace: namespace_ea4e2c95
	Checksum: 0xF122812
	Offset: 0x130
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"bowie_knife", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ea4e2c95
	Checksum: 0xE113D4E9
	Offset: 0x180
	Size: 0x24
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	zm_loadout::register_melee_weapon_for_level(#"bowie_knife");
}

/*
	Name: __main__
	Namespace: namespace_ea4e2c95
	Checksum: 0x627FBF5F
	Offset: 0x1B0
	Size: 0x19E
	Parameters: 0
	Flags: Linked, Private
*/
private function __main__()
{
	if(isdefined(level.bowie_cost))
	{
		cost = level.bowie_cost;
	}
	else
	{
		cost = 3000;
	}
	if(function_8b1a219a())
	{
		prompt = #"hash_2791ecebb85142c4";
	}
	else
	{
		prompt = #"hash_60606b68e93a29c8";
	}
	level.var_8e4168e9 = "bowie_knife";
	level.var_63af3e00 = "bowie_flourish";
	var_57858dd5 = "zombie_fists_bowie";
	if(namespace_cb7cafc3::function_166646a6() == 1)
	{
		level.var_8e4168e9 = "bowie_knife_story_1";
		level.var_63af3e00 = "bowie_flourish_story_1";
		var_57858dd5 = "zombie_fists_bowie_story_1";
	}
	zm_melee_weapon::init(level.var_8e4168e9, level.var_63af3e00, cost, "bowie_upgrade", prompt, "bowie", undefined);
	zm_melee_weapon::set_fallback_weapon(level.var_8e4168e9, var_57858dd5);
	level.var_1c0d76f8 = getweapon(hash(level.var_8e4168e9));
}

/*
	Name: init
	Namespace: namespace_ea4e2c95
	Checksum: 0x80F724D1
	Offset: 0x358
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function init()
{
}

