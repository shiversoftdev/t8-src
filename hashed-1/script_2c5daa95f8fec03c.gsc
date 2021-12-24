// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;

#namespace namespace_81245006;

/*
	Name: initweakpoints
	Namespace: namespace_81245006
	Checksum: 0x2E8347FD
	Offset: 0x70
	Size: 0x240
	Parameters: 2
	Flags: Linked
*/
function initweakpoints(entity, var_97e1b97d)
{
	var_5ace757d = getscriptbundle(var_97e1b97d);
	if(!isdefined(var_5ace757d) || !isdefined(var_5ace757d.weakpoints))
	{
		return;
	}
	entity.var_5ace757d = [];
	foreach(var_dd54fdb1 in var_5ace757d.weakpoints)
	{
		var_7c4db75f = function_2e532eed(var_dd54fdb1);
		var_7c4db75f.currstate = 2;
		if(isdefined(var_dd54fdb1.var_e37acc23) && var_dd54fdb1.var_e37acc23)
		{
			var_7c4db75f.currstate = 1;
		}
		if(!(isdefined(var_dd54fdb1.var_5a93cd2e) && var_dd54fdb1.var_5a93cd2e))
		{
			var_7c4db75f.health = var_dd54fdb1.health * entity.health;
		}
		else
		{
			var_7c4db75f.health = var_dd54fdb1.health;
		}
		var_7c4db75f.maxhealth = var_7c4db75f.health;
		var_7c4db75f.var_d8fa3d82 = [];
		if(isdefined(var_dd54fdb1.var_51e8b151))
		{
			array::add(var_7c4db75f.var_d8fa3d82, var_dd54fdb1.var_51e8b151);
		}
		if(isdefined(var_dd54fdb1.var_910e2f9b))
		{
			array::add(var_7c4db75f.var_d8fa3d82, var_dd54fdb1.var_910e2f9b);
		}
		array::add(entity.var_5ace757d, var_7c4db75f);
	}
}

/*
	Name: function_3131f5dd
	Namespace: namespace_81245006
	Checksum: 0xF981211D
	Offset: 0x2B8
	Size: 0xDA
	Parameters: 3
	Flags: Linked
*/
function function_3131f5dd(entity, hitloc, var_6b0c6fac)
{
	if(!isdefined(hitloc))
	{
		return undefined;
	}
	if(isdefined(entity.var_5ace757d))
	{
		foreach(var_dd54fdb1 in entity.var_5ace757d)
		{
			if(isdefined(var_6b0c6fac) && var_dd54fdb1.currstate !== var_6b0c6fac)
			{
				continue;
			}
			if(var_dd54fdb1.hitloc === hitloc)
			{
				return var_dd54fdb1;
			}
		}
	}
}

/*
	Name: function_73ab4754
	Namespace: namespace_81245006
	Checksum: 0x45A97673
	Offset: 0x3A0
	Size: 0x1E6
	Parameters: 3
	Flags: Linked
*/
function function_73ab4754(entity, point, var_6b0c6fac)
{
	if(!isdefined(point))
	{
		return undefined;
	}
	if(isdefined(entity.var_5ace757d))
	{
		var_e2b4fa2b = undefined;
		var_833f593 = 2147483647;
		foreach(var_dd54fdb1 in entity.var_5ace757d)
		{
			if(isdefined(var_6b0c6fac) && var_dd54fdb1.currstate !== var_6b0c6fac)
			{
				continue;
			}
			if(isdefined(var_dd54fdb1.var_b7fbe51b))
			{
				foreach(var_f16c2276 in var_dd54fdb1.var_d8fa3d82)
				{
					tagorigin = entity gettagorigin(var_f16c2276);
					distsq = distancesquared(point, tagorigin);
					if(distsq <= (var_dd54fdb1.var_b7fbe51b * var_dd54fdb1.var_b7fbe51b) && var_833f593 > distsq)
					{
						var_e2b4fa2b = var_dd54fdb1;
						var_833f593 = distsq;
					}
				}
			}
		}
	}
	return var_e2b4fa2b;
}

/*
	Name: function_6bb685f0
	Namespace: namespace_81245006
	Checksum: 0xD1C24B2C
	Offset: 0x590
	Size: 0x1A0
	Parameters: 3
	Flags: None
*/
function function_6bb685f0(entity, point, var_6b0c6fac)
{
	if(!isdefined(point))
	{
		return undefined;
	}
	if(isdefined(entity.var_5ace757d))
	{
		foreach(var_dd54fdb1 in entity.var_5ace757d)
		{
			if(isdefined(var_6b0c6fac) && var_dd54fdb1.currstate !== var_6b0c6fac)
			{
				continue;
			}
			if(isdefined(var_dd54fdb1.var_b7fbe51b))
			{
				foreach(var_f16c2276 in var_dd54fdb1.var_d8fa3d82)
				{
					tagorigin = entity gettagorigin(var_f16c2276);
					distsq = distancesquared(point, tagorigin);
					if(distsq <= (var_dd54fdb1.var_b7fbe51b * var_dd54fdb1.var_b7fbe51b))
					{
						return var_dd54fdb1;
					}
				}
			}
		}
	}
}

/*
	Name: function_37e3f011
	Namespace: namespace_81245006
	Checksum: 0xB9BADEA6
	Offset: 0x738
	Size: 0x1F6
	Parameters: 3
	Flags: Linked
*/
function function_37e3f011(entity, bone, var_6b0c6fac)
{
	if(!isdefined(entity))
	{
		return undefined;
	}
	if(isdefined(bone) && !isstring(bone))
	{
		bonename = getpartname(entity, bone);
	}
	else
	{
		bonename = bone;
	}
	if(isdefined(bonename) && isdefined(entity.var_5ace757d))
	{
		/#
			if(getdvarint(#"hash_50608e24a3f5f666", 0) > 0)
			{
				if(!isstring(bone))
				{
					iprintlnbold("" + bonename);
				}
			}
		#/
		foreach(var_dd54fdb1 in entity.var_5ace757d)
		{
			if(isdefined(var_6b0c6fac) && var_dd54fdb1.currstate !== var_6b0c6fac)
			{
				continue;
			}
			foreach(var_f16c2276 in var_dd54fdb1.var_d8fa3d82)
			{
				if(var_f16c2276 == bonename)
				{
					return var_dd54fdb1;
				}
			}
		}
	}
	return undefined;
}

/*
	Name: function_fab3ee3e
	Namespace: namespace_81245006
	Checksum: 0x76BF0A91
	Offset: 0x938
	Size: 0x16
	Parameters: 1
	Flags: Linked
*/
function function_fab3ee3e(entity)
{
	return entity.var_5ace757d;
}

/*
	Name: function_ef87b7e8
	Namespace: namespace_81245006
	Checksum: 0x684CA33A
	Offset: 0x958
	Size: 0x52
	Parameters: 2
	Flags: Linked
*/
function function_ef87b7e8(var_dd54fdb1, damage)
{
	var_dd54fdb1.health = var_dd54fdb1.health - damage;
	if(var_dd54fdb1.health <= 0)
	{
		var_dd54fdb1.currstate = 3;
	}
}

/*
	Name: function_6c64ebd3
	Namespace: namespace_81245006
	Checksum: 0xFB95D6AB
	Offset: 0x9B8
	Size: 0x22
	Parameters: 2
	Flags: Linked
*/
function function_6c64ebd3(var_dd54fdb1, state)
{
	var_dd54fdb1.currstate = state;
}

/*
	Name: function_f29756fe
	Namespace: namespace_81245006
	Checksum: 0xA8C737BF
	Offset: 0x9E8
	Size: 0x16
	Parameters: 1
	Flags: Linked
*/
function function_f29756fe(var_dd54fdb1)
{
	return var_dd54fdb1.currstate;
}

/*
	Name: function_26901d33
	Namespace: namespace_81245006
	Checksum: 0x3937527F
	Offset: 0xA08
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function function_26901d33(var_dd54fdb1)
{
	var_dd54fdb1.currstate = 2;
	if(isdefined(var_dd54fdb1.var_e37acc23) && var_dd54fdb1.var_e37acc23)
	{
		var_dd54fdb1.currstate = 1;
	}
	var_dd54fdb1.health = var_dd54fdb1.maxhealth;
}

/*
	Name: function_6742b846
	Namespace: namespace_81245006
	Checksum: 0xAC6D75A9
	Offset: 0xA78
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_6742b846(entity, var_dd54fdb1)
{
	if(isdefined(entity.var_5ace757d))
	{
		arrayremovevalue(entity.var_5ace757d, var_dd54fdb1, 0);
	}
}

