// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6e3c826b1814cab6;
#using script_7224d61ed502ea07;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_6cc2ce5b;

/*
	Name: function_89f2df9
	Namespace: namespace_6cc2ce5b
	Checksum: 0x4D2FD287
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_4a6b297c85fafec1", &__init__, undefined, "bgb");
}

/*
	Name: __init__
	Namespace: namespace_6cc2ce5b
	Checksum: 0xDF5D1E69
	Offset: 0xE8
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"hash_4a6b297c85fafec1", "time", 30, &enable, &disable, &validation, undefined);
}

/*
	Name: enable
	Namespace: namespace_6cc2ce5b
	Checksum: 0xC2738FFE
	Offset: 0x178
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	zm_wallbuy::function_c047c228(&function_84832f40);
	zm_wallbuy::function_33023da5(&function_84832f40);
	zm_wallbuy::function_48f914bd(&override_ammo_cost);
}

/*
	Name: disable
	Namespace: namespace_6cc2ce5b
	Checksum: 0xB73CAB53
	Offset: 0x1E8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function disable()
{
	zm_wallbuy::function_a6889c(&function_84832f40);
	zm_wallbuy::function_782e8955(&function_84832f40);
	zm_wallbuy::function_99911dae(&override_ammo_cost);
}

/*
	Name: validation
	Namespace: namespace_6cc2ce5b
	Checksum: 0x41034431
	Offset: 0x258
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	if(!namespace_59ff1d6c::function_901b751c(#"hash_51a2cf319e12d9ae"))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_84832f40
	Namespace: namespace_6cc2ce5b
	Checksum: 0x3F0F46FB
	Offset: 0x290
	Size: 0x18
	Parameters: 2
	Flags: Linked
*/
function function_84832f40(var_38e724e6, var_2b6f3563)
{
	return 10;
}

/*
	Name: override_ammo_cost
	Namespace: namespace_6cc2ce5b
	Checksum: 0xCBF163D0
	Offset: 0x2B0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function override_ammo_cost(var_38e724e6, stub)
{
	if(self zm_weapons::has_upgrade(var_38e724e6))
	{
		return 500;
	}
	return 10;
}

