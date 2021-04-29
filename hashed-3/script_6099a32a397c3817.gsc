// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_5bcf4508;

/*
	Name: function_89f2df9
	Namespace: namespace_5bcf4508
	Checksum: 0x8AB58AF2
	Offset: 0xB8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"spknifeork", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_5bcf4508
	Checksum: 0x37F6A7E0
	Offset: 0x108
	Size: 0x7C
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	zm_melee_weapon::init(#"spknifeork", #"hash_682a394b34139cf4", 1000, "spknifeork", undefined, "spknifeork", undefined);
	zm::function_84d343d(#"spknifeork", &function_958c4578);
}

/*
	Name: __main__
	Namespace: namespace_5bcf4508
	Checksum: 0xF4E7FEA8
	Offset: 0x190
	Size: 0x24
	Parameters: 0
	Flags: Linked, Private
*/
private function __main__()
{
	callback::on_connect(&function_3b1ba6c7);
}

/*
	Name: function_3b1ba6c7
	Namespace: namespace_5bcf4508
	Checksum: 0x257EDD45
	Offset: 0x1C0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_3b1ba6c7()
{
	self callback::function_33f0ddd3(&function_c6b2d4d8);
}

/*
	Name: function_c6b2d4d8
	Namespace: namespace_5bcf4508
	Checksum: 0x9807E251
	Offset: 0x1F0
	Size: 0x10C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_c6b2d4d8(s_event)
{
	if(s_event.event === "give_weapon")
	{
		if(s_event.weapon === getweapon(#"golden_knife"))
		{
			level.var_bdba6ee8[s_event.weapon] = 0.1;
			self thread aat::acquire(s_event.weapon);
		}
		else if(s_event.weapon === getweapon(#"spknifeork"))
		{
			level.var_bdba6ee8[s_event.weapon] = 0.2;
			self thread aat::acquire(s_event.weapon);
		}
	}
}

/*
	Name: function_958c4578
	Namespace: namespace_5bcf4508
	Checksum: 0x1198360A
	Offset: 0x308
	Size: 0x6A
	Parameters: 12
	Flags: Linked
*/
function function_958c4578(einflictor, eattacker, idamage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	return 75809;
}

