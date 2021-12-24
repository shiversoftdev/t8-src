// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace loadout;

/*
	Name: is_warlord_perk
	Namespace: loadout
	Checksum: 0x90341517
	Offset: 0x90
	Size: 0xE
	Parameters: 1
	Flags: Linked
*/
function is_warlord_perk(itemindex)
{
	return 0;
}

/*
	Name: is_item_excluded
	Namespace: loadout
	Checksum: 0xD21DA6E3
	Offset: 0xA8
	Size: 0x78
	Parameters: 1
	Flags: Linked
*/
function is_item_excluded(itemindex)
{
	if(!level.onlinegame)
	{
		return 0;
	}
	numexclusions = level.itemexclusions.size;
	for(exclusionindex = 0; exclusionindex < numexclusions; exclusionindex++)
	{
		if(itemindex == level.itemexclusions[exclusionindex])
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: getloadoutitemfromddlstats
	Namespace: loadout
	Checksum: 0x473F1B0B
	Offset: 0x128
	Size: 0x72
	Parameters: 2
	Flags: Linked
*/
function getloadoutitemfromddlstats(customclassnum, loadoutslot)
{
	itemindex = self getloadoutitem(customclassnum, loadoutslot);
	if(is_item_excluded(itemindex) && !is_warlord_perk(itemindex))
	{
		return 0;
	}
	return itemindex;
}

/*
	Name: initweaponattachments
	Namespace: loadout
	Checksum: 0x1540300D
	Offset: 0x1A8
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function initweaponattachments(weapon)
{
	self.currentweaponstarttime = gettime();
	self.currentweapon = weapon;
}

/*
	Name: isprimarydamage
	Namespace: loadout
	Checksum: 0xC149748F
	Offset: 0x1D8
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function isprimarydamage(meansofdeath)
{
	return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET";
}

/*
	Name: cac_modified_vehicle_damage
	Namespace: loadout
	Checksum: 0x791BC692
	Offset: 0x210
	Size: 0x1F2
	Parameters: 6
	Flags: Linked
*/
function cac_modified_vehicle_damage(victim, attacker, damage, meansofdeath, weapon, inflictor)
{
	if(!isdefined(victim) || !isdefined(attacker) || !isplayer(attacker))
	{
		return damage;
	}
	if(!isdefined(damage) || !isdefined(meansofdeath) || !isdefined(weapon))
	{
		return damage;
	}
	old_damage = damage;
	final_damage = damage;
	if(attacker hasperk(#"specialty_bulletdamage") && isprimarydamage(meansofdeath))
	{
		final_damage = (damage * (100 + level.cac_bulletdamage_data)) / 100;
		/#
			if(getdvarint(#"scr_perkdebug", 0))
			{
				println(("" + attacker.name) + "");
			}
		#/
	}
	else
	{
		final_damage = old_damage;
	}
	/#
		if(getdvarint(#"scr_perkdebug", 0))
		{
			println((((("" + (final_damage / old_damage)) + "") + old_damage) + "") + final_damage);
		}
	#/
	return int(final_damage);
}

/*
	Name: function_3ba6ee5d
	Namespace: loadout
	Checksum: 0xD52F46F0
	Offset: 0x410
	Size: 0xB4
	Parameters: 2
	Flags: None
*/
function function_3ba6ee5d(weapon, amount)
{
	if(weapon.iscliponly)
	{
		self setweaponammoclip(weapon, amount);
	}
	else
	{
		self setweaponammoclip(weapon, amount);
		diff = amount - self getweaponammoclip(weapon);
		/#
			assert(diff >= 0);
		#/
		self setweaponammostock(weapon, diff);
	}
}

