// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace namespace_bd02cf1;

/*
	Name: function_385ef18d
	Namespace: namespace_bd02cf1
	Checksum: 0x7E1B849A
	Offset: 0x68
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function function_385ef18d(var_e827f698)
{
	/#
		assert(isdefined(var_e827f698));
	#/
	var_e69cf15d = function_3786d342(var_e827f698);
	if(isdefined(var_e69cf15d) && var_e69cf15d != level.weaponnone)
	{
		var_e827f698 = var_e69cf15d;
	}
	return var_e827f698;
}

/*
	Name: function_c14cb514
	Namespace: namespace_bd02cf1
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

