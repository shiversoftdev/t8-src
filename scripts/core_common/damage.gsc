// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace damage;

/*
	Name: friendlyfirecheck
	Namespace: damage
	Checksum: 0x6B18296E
	Offset: 0x88
	Size: 0x3C8
	Parameters: 3
	Flags: Linked
*/
function friendlyfirecheck(owner, attacker, forcedfriendlyfirerule)
{
	if(!isdefined(owner))
	{
		return true;
	}
	if(!level.teambased)
	{
		return true;
	}
	friendlyfirerule = [[level.figure_out_friendly_fire]](undefined, attacker);
	if(isdefined(forcedfriendlyfirerule))
	{
		friendlyfirerule = forcedfriendlyfirerule;
	}
	if(friendlyfirerule != 0)
	{
		return true;
	}
	if(attacker == owner)
	{
		return true;
	}
	if(isplayer(attacker))
	{
		ownerteam = owner.team;
		if(!isdefined(ownerteam) && isdefined(owner.pers))
		{
			ownerteam = owner.pers[#"team"];
		}
		if(isdefined(attacker.pers) && !isdefined(attacker.pers[#"team"]))
		{
			return true;
		}
		if(isdefined(attacker.pers) && util::function_fbce7263(attacker.pers[#"team"], ownerteam))
		{
			return true;
		}
	}
	else
	{
		if(isactor(attacker))
		{
			ownerteam = owner.team;
			if(!isdefined(ownerteam) && isdefined(owner.pers))
			{
				ownerteam = owner.pers[#"team"];
			}
			if(util::function_fbce7263(attacker.team, ownerteam))
			{
				return true;
			}
		}
		else
		{
			if(isvehicle(attacker))
			{
				if(isdefined(attacker.owner) && isplayer(attacker.owner))
				{
					ownerteam = owner.team;
					if(!isdefined(ownerteam) && isdefined(owner.pers))
					{
						ownerteam = owner.pers[#"team"];
					}
					if(util::function_fbce7263(attacker.owner.pers[#"team"], ownerteam))
					{
						return true;
					}
				}
				else
				{
					occupant_team = attacker vehicle::vehicle_get_occupant_team();
					if(isplayer(owner))
					{
						if(util::function_fbce7263(occupant_team, owner.pers[#"team"]) && occupant_team != #"spectator")
						{
							return true;
						}
					}
					else if(util::function_fbce7263(owner.team, occupant_team))
					{
						return true;
					}
				}
			}
			else if(attacker.classname === "worldspawn")
			{
				return true;
			}
		}
	}
	return false;
}

