// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_orange_water.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_weap_tundragun;

/*
	Name: __init__system__
	Namespace: zm_weap_tundragun
	Checksum: 0x51DE58DF
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_weap_tundragun", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_tundragun
	Checksum: 0x4CC6789B
	Offset: 0xD8
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.w_tundragun = getweapon(#"tundragun");
	level.w_tundragun_upgraded = getweapon(#"tundragun_upgraded");
}

/*
	Name: __main__
	Namespace: zm_weap_tundragun
	Checksum: 0x1FE7BB9D
	Offset: 0x138
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	zm::function_84d343d(#"tundragun", &actor_damage_override);
	zm::function_84d343d(#"tundragun_upgraded", &actor_damage_override);
}

/*
	Name: actor_damage_override
	Namespace: zm_weap_tundragun
	Checksum: 0x54AAF5BD
	Offset: 0x1A8
	Size: 0xBA
	Parameters: 12
	Flags: Linked
*/
function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(self.var_6f84b820 === #"basic" || self.var_6f84b820 === #"popcorn")
	{
		self.water_damage = 1;
		return self.health + 666;
	}
	return damage;
}

/*
	Name: function_4baa4ca1
	Namespace: zm_weap_tundragun
	Checksum: 0x37E38FBA
	Offset: 0x270
	Size: 0x52
	Parameters: 0
	Flags: Private
*/
function private function_4baa4ca1()
{
	var_648864c9 = 0;
	if(isdefined(self))
	{
		var_648864c9 = self.no_gib;
		self.no_gib = 1;
	}
	wait(0.1);
	if(isdefined(self))
	{
		self.no_gib = var_648864c9;
	}
}

