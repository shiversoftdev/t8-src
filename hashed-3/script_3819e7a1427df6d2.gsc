// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_178024232e91b0a1;
#using script_3aa0f32b70d4f7cb;

#namespace aiutility;

/*
	Name: registerbehaviorscriptfunctions
	Namespace: aiutility
	Checksum: 0x3DA2E92C
	Offset: 0x358
	Size: 0x4E4
	Parameters: 0
	Flags: AutoExec
*/
function autoexec registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&explosivekilled));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"explosivekilled", &explosivekilled);
	/#
		assert(isscriptfunctionptr(&electrifiedkilled));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"electrifiedkilled", &electrifiedkilled);
	/#
		assert(isscriptfunctionptr(&burnedkilled));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"burnedkilled", &burnedkilled);
	/#
		assert(isscriptfunctionptr(&rapskilled));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"rapskilled", &rapskilled);
	/#
		assert(isscriptfunctionptr(&tookflashbangdamage));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"tookflashbangdamage", &tookflashbangdamage);
	/#
		assert(isscriptfunctionptr(&function_95482e2b));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5b6a2e66dc5bf7a7", &function_95482e2b);
	/#
		assert(isscriptfunctionptr(&function_f9a1ea10));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7e18cc452c8ecce8", &function_f9a1ea10);
	/#
		assert(isscriptfunctionptr(&function_ebf05a38));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_2bb2abb5b247ba91", &function_ebf05a38);
	/#
		assert(isscriptfunctionptr(&function_d63ff497));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_49371f9efa84972e", &function_d63ff497);
	/#
		assert(isscriptfunctionptr(&function_26b6e27e));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7c8fbf66eeb51ccb", &function_26b6e27e);
	/#
		assert(isscriptfunctionptr(&function_603389de));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1b92b6b5f1705db3", &function_603389de);
	/#
		assert(isscriptfunctionptr(&function_13b0963e));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_62a8709f08c68d60", &function_13b0963e);
}

/*
	Name: function_95482e2b
	Namespace: aiutility
	Checksum: 0x55EF5CFA
	Offset: 0x848
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function function_95482e2b(entity)
{
	shitloc = entity.damagelocation;
	if(isdefined(shitloc))
	{
		return isinarray(array("helmet", "head", "neck"), shitloc);
	}
	return 0;
}

/*
	Name: function_f9a1ea10
	Namespace: aiutility
	Checksum: 0x14FB7164
	Offset: 0x8B8
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function function_f9a1ea10(entity)
{
	shitloc = entity.damagelocation;
	if(isdefined(shitloc))
	{
		return isinarray(array("torso_upper", "torso_mid"), shitloc) || isinarray(array("torso_lower", "groin"), shitloc);
	}
	return 0;
}

/*
	Name: function_ebf05a38
	Namespace: aiutility
	Checksum: 0x3E28C973
	Offset: 0x958
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function function_ebf05a38(entity)
{
	shitloc = entity.damagelocation;
	if(isdefined(shitloc))
	{
		return isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc);
	}
	return 0;
}

/*
	Name: function_d63ff497
	Namespace: aiutility
	Checksum: 0x51C025E8
	Offset: 0x9D0
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function function_d63ff497(entity)
{
	shitloc = entity.damagelocation;
	if(isdefined(shitloc))
	{
		return isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc);
	}
	return 0;
}

/*
	Name: function_26b6e27e
	Namespace: aiutility
	Checksum: 0x4410687
	Offset: 0xA40
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function function_26b6e27e(entity)
{
	shitloc = entity.damagelocation;
	if(isdefined(shitloc))
	{
		return isinarray(array("torso_lower", "groin"), shitloc);
	}
	return 0;
}

/*
	Name: function_603389de
	Namespace: aiutility
	Checksum: 0x83AC418A
	Offset: 0xAA8
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function function_603389de(entity)
{
	shitloc = entity.damagelocation;
	if(isdefined(shitloc))
	{
		return isinarray(array("right_leg_upper", "right_leg_lower", "right_foot"), shitloc);
	}
	return 0;
}

/*
	Name: function_13b0963e
	Namespace: aiutility
	Checksum: 0x90EAD30C
	Offset: 0xB18
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function function_13b0963e(entity)
{
	shitloc = entity.damagelocation;
	if(isdefined(shitloc))
	{
		return isinarray(array("left_leg_upper", "left_leg_lower", "left_foot"), shitloc);
	}
	return 0;
}

/*
	Name: explosivekilled
	Namespace: aiutility
	Checksum: 0x745A3CAF
	Offset: 0xB88
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function explosivekilled(entity)
{
	if(entity getblackboardattribute("_damage_weapon_class") == "explosive")
	{
		return true;
	}
	return false;
}

/*
	Name: electrifiedkilled
	Namespace: aiutility
	Checksum: 0x6F3278F9
	Offset: 0xBD0
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function electrifiedkilled(entity)
{
	if(entity.damageweapon.rootweapon.name == "shotgun_pump_taser")
	{
		return true;
	}
	if(entity getblackboardattribute("_damage_mod") == "mod_electrocuted")
	{
		return true;
	}
	return false;
}

/*
	Name: burnedkilled
	Namespace: aiutility
	Checksum: 0xF96B527C
	Offset: 0xC40
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function burnedkilled(entity)
{
	if(entity getblackboardattribute("_damage_mod") == "mod_burned")
	{
		return true;
	}
	return false;
}

/*
	Name: rapskilled
	Namespace: aiutility
	Checksum: 0x86E047C8
	Offset: 0xC88
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function rapskilled(entity)
{
	if(isdefined(self.attacker) && isdefined(self.attacker.archetype) && self.attacker.archetype == #"raps")
	{
		return true;
	}
	return false;
}

/*
	Name: function_e2010f4c
	Namespace: aiutility
	Checksum: 0xAFEA95D3
	Offset: 0xCF0
	Size: 0xCE
	Parameters: 2
	Flags: Linked
*/
function function_e2010f4c(entity, var_515373f2)
{
	if(isdefined(entity) && isdefined(var_515373f2.durations) && var_515373f2.durations.size > 0)
	{
		foreach(var_4e73c1e in var_515373f2.durations)
		{
			if(var_4e73c1e.archetype === entity.archetype)
			{
				return var_4e73c1e;
			}
		}
	}
}

/*
	Name: tookflashbangdamage
	Namespace: aiutility
	Checksum: 0xF531BB0D
	Offset: 0xDC8
	Size: 0x110
	Parameters: 1
	Flags: Linked, Private
*/
function private tookflashbangdamage(entity)
{
	if(isdefined(entity.damageweapon) && isdefined(entity.damagemod))
	{
		weapon = entity.damageweapon;
		return entity.damagemod == "MOD_GRENADE_SPLASH" && isdefined(weapon.rootweapon) && (weapon.rootweapon.name == #"flash_grenade" || weapon.rootweapon.name == #"concussion_grenade" || weapon.rootweapon.name == #"proximity_grenade") || (isdefined(self.var_40543c03) && self.var_40543c03 == "foam");
	}
	return 0;
}

/*
	Name: bb_getdamagedirection
	Namespace: aiutility
	Checksum: 0x84D3A8C3
	Offset: 0xEE0
	Size: 0xEE
	Parameters: 0
	Flags: Linked
*/
function bb_getdamagedirection()
{
	/#
		if(isdefined(level._debug_damage_direction))
		{
			return level._debug_damage_direction;
		}
	#/
	if(self.damageyaw > 135 || self.damageyaw <= -135)
	{
		self.damage_direction = "front";
		return "front";
	}
	if(self.damageyaw > 45 && self.damageyaw <= 135)
	{
		self.damage_direction = "right";
		return "right";
	}
	if(self.damageyaw > -45 && self.damageyaw <= 45)
	{
		self.damage_direction = "back";
		return "back";
	}
	self.damage_direction = "left";
	return "left";
}

/*
	Name: function_7e269d82
	Namespace: aiutility
	Checksum: 0x56019B35
	Offset: 0xFD8
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function function_7e269d82()
{
	if(isdefined(self.var_40543c03))
	{
		return self.var_40543c03;
	}
	return "normal";
}

/*
	Name: bb_actorgetdamagelocation
	Namespace: aiutility
	Checksum: 0x6629D55B
	Offset: 0x1000
	Size: 0x368
	Parameters: 0
	Flags: Linked
*/
function bb_actorgetdamagelocation()
{
	/#
		if(isdefined(level._debug_damage_pain_location))
		{
			return level._debug_damage_pain_location;
		}
	#/
	shitloc = self.damagelocation;
	possiblehitlocations = array();
	if(isdefined(shitloc) && shitloc != "none")
	{
		if(isinarray(array("helmet", "head", "neck"), shitloc))
		{
			possiblehitlocations[possiblehitlocations.size] = "head";
		}
		else
		{
			if(isinarray(array("torso_upper", "torso_mid"), shitloc))
			{
				possiblehitlocations[possiblehitlocations.size] = "chest";
			}
			else
			{
				if(isinarray(array("torso_lower", "groin"), shitloc))
				{
					possiblehitlocations[possiblehitlocations.size] = "groin";
				}
				else
				{
					if(isinarray(array("torso_lower", "groin"), shitloc))
					{
						possiblehitlocations[possiblehitlocations.size] = "legs";
					}
					else
					{
						if(isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc))
						{
							possiblehitlocations[possiblehitlocations.size] = "left_arm";
						}
						else
						{
							if(isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc))
							{
								possiblehitlocations[possiblehitlocations.size] = "right_arm";
							}
							else if(isinarray(array("right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot"), shitloc))
							{
								possiblehitlocations[possiblehitlocations.size] = "legs";
							}
						}
					}
				}
			}
		}
	}
	if(possiblehitlocations.size == 0)
	{
		possiblehitlocations[possiblehitlocations.size] = "chest";
		possiblehitlocations[possiblehitlocations.size] = "groin";
	}
	/#
		assert(possiblehitlocations.size > 0, possiblehitlocations.size);
	#/
	damagelocation = possiblehitlocations[randomint(possiblehitlocations.size)];
	return damagelocation;
}

/*
	Name: bb_getdamageweaponclass
	Namespace: aiutility
	Checksum: 0xFC5D408F
	Offset: 0x1370
	Size: 0x186
	Parameters: 0
	Flags: Linked
*/
function bb_getdamageweaponclass()
{
	if(isdefined(self.damagemod))
	{
		if(isinarray(array("mod_rifle_bullet"), tolower(self.damagemod)))
		{
			return "rifle";
		}
		if(isinarray(array("mod_pistol_bullet"), tolower(self.damagemod)))
		{
			return "pistol";
		}
		if(isinarray(array("mod_melee", "mod_melee_assassinate", "mod_melee_weapon_butt"), tolower(self.damagemod)))
		{
			return "melee";
		}
		if(isinarray(array("mod_grenade", "mod_grenade_splash", "mod_projectile", "mod_projectile_splash", "mod_explosive"), tolower(self.damagemod)))
		{
			return "explosive";
		}
	}
	return "rifle";
}

/*
	Name: bb_getdamageweapon
	Namespace: aiutility
	Checksum: 0x6B0BEC77
	Offset: 0x1500
	Size: 0x72
	Parameters: 0
	Flags: Linked
*/
function bb_getdamageweapon()
{
	if(isdefined(self.special_weapon) && isdefined(self.special_weapon.name))
	{
		return self.special_weapon.name;
	}
	if(isdefined(self.damageweapon) && isdefined(self.damageweapon.name))
	{
		return self.damageweapon.name;
	}
	return "unknown";
}

/*
	Name: bb_getdamagemod
	Namespace: aiutility
	Checksum: 0xB2C09694
	Offset: 0x1580
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function bb_getdamagemod()
{
	if(isdefined(self.damagemod))
	{
		return tolower(self.damagemod);
	}
	return "unknown";
}

/*
	Name: bb_getdamagetaken
	Namespace: aiutility
	Checksum: 0xB44F92AF
	Offset: 0x15C0
	Size: 0xEA
	Parameters: 0
	Flags: Linked
*/
function bb_getdamagetaken()
{
	/#
		if(isdefined(level._debug_damage_intensity))
		{
			return level._debug_damage_intensity;
		}
	#/
	damagetaken = self.damagetaken;
	maxhealth = self.maxhealth;
	damagetakentype = "light";
	if(isalive(self))
	{
		ratio = damagetaken / self.maxhealth;
		if(ratio > 0.7)
		{
			damagetakentype = "heavy";
		}
		self.lastdamagetime = gettime();
	}
	else
	{
		ratio = damagetaken / self.maxhealth;
		if(ratio > 0.7)
		{
			damagetakentype = "heavy";
		}
	}
	return damagetakentype;
}

/*
	Name: bb_idgungetdamagedirection
	Namespace: aiutility
	Checksum: 0x48DC7275
	Offset: 0x16B8
	Size: 0x2A
	Parameters: 0
	Flags: Linked
*/
function bb_idgungetdamagedirection()
{
	if(isdefined(self.damage_direction))
	{
		return self.damage_direction;
	}
	return self bb_getdamagedirection();
}

/*
	Name: bb_actorgetfataldamagelocation
	Namespace: aiutility
	Checksum: 0xC0F241D0
	Offset: 0x16F0
	Size: 0x248
	Parameters: 0
	Flags: Linked
*/
function bb_actorgetfataldamagelocation()
{
	/#
		if(isdefined(level._debug_damage_location))
		{
			return level._debug_damage_location;
		}
	#/
	shitloc = self.damagelocation;
	if(isdefined(shitloc))
	{
		if(isinarray(array("helmet", "head", "neck"), shitloc))
		{
			return "head";
		}
		if(isinarray(array("torso_upper", "torso_mid"), shitloc))
		{
			return "chest";
		}
		if(isinarray(array("torso_lower", "groin"), shitloc))
		{
			return "hips";
		}
		if(isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc))
		{
			return "right_arm";
		}
		if(isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc))
		{
			return "left_arm";
		}
		if(isinarray(array("right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot"), shitloc))
		{
			return "legs";
		}
	}
	randomlocs = array("chest", "hips");
	return randomlocs[randomint(randomlocs.size)];
}

/*
	Name: addaioverridedamagecallback
	Namespace: aiutility
	Checksum: 0xAE6A2909
	Offset: 0x1940
	Size: 0x25E
	Parameters: 3
	Flags: Linked
*/
function addaioverridedamagecallback(entity, callback, addtofront)
{
	/#
		assert(isentity(entity));
	#/
	/#
		assert(isfunctionptr(callback));
	#/
	/#
		assert(!isdefined(entity.aioverridedamage) || isarray(entity.aioverridedamage));
	#/
	if(!isdefined(entity.aioverridedamage))
	{
		entity.aioverridedamage = [];
	}
	else if(!isarray(entity.aioverridedamage))
	{
		entity.aioverridedamage = array(entity.aioverridedamage);
	}
	if(isdefined(addtofront) && addtofront)
	{
		damageoverrides = [];
		damageoverrides[damageoverrides.size] = callback;
		foreach(override in entity.aioverridedamage)
		{
			damageoverrides[damageoverrides.size] = override;
		}
		entity.aioverridedamage = damageoverrides;
	}
	else
	{
		if(!isdefined(entity.aioverridedamage))
		{
			entity.aioverridedamage = [];
		}
		else if(!isarray(entity.aioverridedamage))
		{
			entity.aioverridedamage = array(entity.aioverridedamage);
		}
		entity.aioverridedamage[entity.aioverridedamage.size] = callback;
	}
}

/*
	Name: removeaioverridedamagecallback
	Namespace: aiutility
	Checksum: 0xD81DA7CF
	Offset: 0x1BA8
	Size: 0x142
	Parameters: 2
	Flags: Linked
*/
function removeaioverridedamagecallback(entity, callback)
{
	/#
		assert(isentity(entity));
	#/
	/#
		assert(isfunctionptr(callback));
	#/
	/#
		assert(isarray(entity.aioverridedamage));
	#/
	currentdamagecallbacks = entity.aioverridedamage;
	entity.aioverridedamage = [];
	foreach(value in currentdamagecallbacks)
	{
		if(value != callback)
		{
			entity.aioverridedamage[entity.aioverridedamage.size] = value;
		}
	}
}

/*
	Name: clearaioverridedamagecallbacks
	Namespace: aiutility
	Checksum: 0x63BB2ED7
	Offset: 0x1CF8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function clearaioverridedamagecallbacks(entity)
{
	entity.aioverridedamage = [];
}

/*
	Name: addaioverridekilledcallback
	Namespace: aiutility
	Checksum: 0x320F4F62
	Offset: 0x1D20
	Size: 0x12E
	Parameters: 2
	Flags: Linked
*/
function addaioverridekilledcallback(entity, callback)
{
	/#
		assert(isentity(entity));
	#/
	/#
		assert(isfunctionptr(callback));
	#/
	/#
		assert(!isdefined(entity.aioverridekilled) || isarray(entity.aioverridekilled));
	#/
	if(!isdefined(entity.aioverridekilled))
	{
		entity.aioverridekilled = [];
	}
	else if(!isarray(entity.aioverridekilled))
	{
		entity.aioverridekilled = array(entity.aioverridekilled);
	}
	entity.aioverridekilled[entity.aioverridekilled.size] = callback;
}

