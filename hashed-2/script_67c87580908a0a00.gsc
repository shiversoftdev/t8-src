// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace activecamo;

/*
	Name: function_385ef18d
	Namespace: activecamo
	Checksum: 0x7E1B849A
	Offset: 0x68
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function function_385ef18d(camoweapon)
{
	/#
		assert(isdefined(camoweapon));
	#/
	var_e69cf15d = function_3786d342(camoweapon);
	if(isdefined(var_e69cf15d) && var_e69cf15d != level.weaponnone)
	{
		camoweapon = var_e69cf15d;
	}
	return camoweapon;
}

/*
	Name: function_c14cb514
	Namespace: activecamo
	Checksum: 0xC3DFC3D6
	Offset: 0xE0
	Size: 0x106
	Parameters: 1
	Flags: Linked
*/
function function_c14cb514(weapon)
{
	if(isdefined(level.var_f06de157))
	{
		return [[level.var_f06de157]](weapon);
	}
	if(isdefined(weapon))
	{
		if(level.weaponnone != weapon)
		{
			var_7c3192e1 = function_385ef18d(weapon);
			if(var_7c3192e1.isaltmode)
			{
				if(isdefined(var_7c3192e1.altweapon) && level.weaponnone != var_7c3192e1.altweapon)
				{
					var_7c3192e1 = var_7c3192e1.altweapon;
				}
			}
			if(isdefined(var_7c3192e1.rootweapon) && level.weaponnone != var_7c3192e1.rootweapon)
			{
				return var_7c3192e1.rootweapon;
			}
			return var_7c3192e1;
		}
	}
	return weapon;
}

