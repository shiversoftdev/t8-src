// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace weapon_utils;

/*
	Name: ispistol
	Namespace: weapon_utils
	Checksum: 0x4A1AD897
	Offset: 0x128
	Size: 0x1E
	Parameters: 1
	Flags: None
*/
function ispistol(weapon)
{
	return isdefined(level.side_arm_array[weapon]);
}

/*
	Name: isflashorstunweapon
	Namespace: weapon_utils
	Checksum: 0xF83614A9
	Offset: 0x150
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function isflashorstunweapon(weapon)
{
	return weapon.isflash || weapon.isstun;
}

/*
	Name: isflashorstundamage
	Namespace: weapon_utils
	Checksum: 0x618B7EBE
	Offset: 0x180
	Size: 0x50
	Parameters: 2
	Flags: None
*/
function isflashorstundamage(weapon, meansofdeath)
{
	return isflashorstunweapon(weapon) && (meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_GAS");
}

/*
	Name: ismeleemod
	Namespace: weapon_utils
	Checksum: 0xB1AD4896
	Offset: 0x1D8
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function ismeleemod(mod)
{
	return mod === "MOD_MELEE" || mod === "MOD_MELEE_WEAPON_BUTT" || mod === "MOD_MELEE_ASSASSINATE";
}

/*
	Name: isexplosivedamage
	Namespace: weapon_utils
	Checksum: 0x675DA21
	Offset: 0x220
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function isexplosivedamage(meansofdeath)
{
	switch(meansofdeath)
	{
		case "mod_explosive":
		case "mod_grenade":
		case "mod_projectile":
		case "mod_grenade_splash":
		case "mod_projectile_splash":
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: ispunch
	Namespace: weapon_utils
	Checksum: 0x9B79C00F
	Offset: 0x2A0
	Size: 0x3E
	Parameters: 1
	Flags: None
*/
function ispunch(weapon)
{
	return weapon.type == "melee" && weapon.statname == #"bare_hands";
}

/*
	Name: isknife
	Namespace: weapon_utils
	Checksum: 0x6B815C8D
	Offset: 0x2E8
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function isknife(weapon)
{
	return weapon.type == "melee" && weapon.rootweapon.name == #"knife_loadout";
}

/*
	Name: isnonbarehandsmelee
	Namespace: weapon_utils
	Checksum: 0x9A4E62BC
	Offset: 0x338
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function isnonbarehandsmelee(weapon)
{
	return weapon.type == "melee" && weapon.rootweapon.name != #"bare_hands";
}

/*
	Name: isbulletdamage
	Namespace: weapon_utils
	Checksum: 0x36E94F65
	Offset: 0x388
	Size: 0x3E
	Parameters: 1
	Flags: None
*/
function isbulletdamage(meansofdeath)
{
	return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_HEAD_SHOT";
}

/*
	Name: isfiredamage
	Namespace: weapon_utils
	Checksum: 0xE8CCCB66
	Offset: 0x3D0
	Size: 0x78
	Parameters: 2
	Flags: None
*/
function isfiredamage(weapon, meansofdeath)
{
	if(weapon.doesfiredamage && (meansofdeath == "MOD_BURNED" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_DOT"))
	{
		return 1;
	}
	return 0;
}

