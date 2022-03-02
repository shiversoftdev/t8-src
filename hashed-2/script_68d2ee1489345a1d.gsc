// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_56ca01b3b31455b5;
#using scripts\core_common\util_shared.gsc;

#namespace killstreaks;

/*
	Name: switch_to_last_non_killstreak_weapon
	Namespace: killstreaks
	Checksum: 0xE83FDC81
	Offset: 0x78
	Size: 0x3F0
	Parameters: 3
	Flags: Linked
*/
function switch_to_last_non_killstreak_weapon(immediate, awayfromball, gameended)
{
	ball = getweapon(#"ball");
	if(isdefined(ball) && self hasweapon(ball) && (!(isdefined(awayfromball) && awayfromball)))
	{
		self switchtoweaponimmediate(ball);
		self disableweaponcycling();
		self disableoffhandweapons();
	}
	else
	{
		if(isdefined(self.laststand) && self.laststand)
		{
			if(isdefined(self.laststandpistol) && self hasweapon(self.laststandpistol))
			{
				self switchtoweapon(self.laststandpistol);
			}
		}
		else
		{
			if(isdefined(self.lastnonkillstreakweapon) && self hasweapon(self.lastnonkillstreakweapon) && self getcurrentweapon() != self.lastnonkillstreakweapon)
			{
				if(ability_util::is_hero_weapon(self.lastnonkillstreakweapon))
				{
					if(self.lastnonkillstreakweapon.gadget_heroversion_2_0)
					{
						if(self.lastnonkillstreakweapon.isgadget && self getammocount(self.lastnonkillstreakweapon) > 0)
						{
							slot = self gadgetgetslot(self.lastnonkillstreakweapon);
							if(self util::gadget_is_in_use(slot))
							{
								return self switchtoweapon(self.lastnonkillstreakweapon);
							}
							return 1;
						}
					}
					else if(self getammocount(self.lastnonkillstreakweapon) > 0)
					{
						return self switchtoweapon(self.lastnonkillstreakweapon);
					}
					if(isdefined(awayfromball) && awayfromball && isdefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon))
					{
						self switchtoweapon(self.lastdroppableweapon);
					}
					else
					{
						self switchtoweapon();
					}
					return 1;
				}
				if(isdefined(immediate) && immediate)
				{
					self switchtoweaponimmediate(self.lastnonkillstreakweapon, isdefined(gameended) && gameended);
				}
				else
				{
					self switchtoweapon(self.lastnonkillstreakweapon);
				}
			}
			else
			{
				if(isdefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon) && self getcurrentweapon() != self.lastdroppableweapon)
				{
					self switchtoweapon(self.lastdroppableweapon);
				}
				else
				{
					return 0;
				}
			}
		}
	}
	return 1;
}

/*
	Name: hasuav
	Namespace: killstreaks
	Checksum: 0x113B45CE
	Offset: 0x470
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function hasuav(team_or_entnum)
{
	if(!isdefined(level.activeuavs))
	{
		return 1;
	}
	return level.activeuavs[team_or_entnum] > 0;
}

/*
	Name: hassatellite
	Namespace: killstreaks
	Checksum: 0x855AB0AA
	Offset: 0x4B0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function hassatellite(team_or_entnum)
{
	if(!isdefined(level.activesatellites))
	{
		return 1;
	}
	return level.activesatellites[team_or_entnum] > 0;
}

/*
	Name: function_f479a2ff
	Namespace: killstreaks
	Checksum: 0x17C684AA
	Offset: 0x4F0
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_f479a2ff(weapon)
{
	if(isdefined(level.var_3ff1b984) && isdefined(level.var_3ff1b984[weapon]))
	{
		return true;
	}
	return false;
}

/*
	Name: function_e3a30c69
	Namespace: killstreaks
	Checksum: 0x334EAD95
	Offset: 0x538
	Size: 0x8C
	Parameters: 1
	Flags: None
*/
function function_e3a30c69(weapon)
{
	/#
		assert(isdefined(isdefined(level.killstreakweapons[weapon])));
	#/
	killstreak = level.killstreaks[level.killstreakweapons[weapon]];
	return true;
}

/*
	Name: is_killstreak_weapon
	Namespace: killstreaks
	Checksum: 0xB48B45B5
	Offset: 0x5D0
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function is_killstreak_weapon(weapon)
{
	if(weapon == level.weaponnone || weapon.notkillstreak)
	{
		return false;
	}
	if(weapon.isspecificuse || is_weapon_associated_with_killstreak(weapon))
	{
		return true;
	}
	return false;
}

/*
	Name: get_killstreak_weapon
	Namespace: killstreaks
	Checksum: 0x4579EAE4
	Offset: 0x638
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function get_killstreak_weapon(killstreak)
{
	if(!isdefined(killstreak))
	{
		return level.weaponnone;
	}
	/#
		assert(isdefined(level.killstreaks[killstreak]));
	#/
	return level.killstreaks[killstreak].weapon;
}

/*
	Name: is_weapon_associated_with_killstreak
	Namespace: killstreaks
	Checksum: 0xFF9ED894
	Offset: 0x6A0
	Size: 0x30
	Parameters: 1
	Flags: Linked
*/
function is_weapon_associated_with_killstreak(weapon)
{
	return isdefined(level.killstreakweapons) && isdefined(level.killstreakweapons[weapon]);
}

