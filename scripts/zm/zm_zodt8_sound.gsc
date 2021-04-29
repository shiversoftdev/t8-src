// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.gsc;

#namespace namespace_89e315a4;

/*
	Name: main
	Namespace: namespace_89e315a4
	Checksum: 0xD26A1F98
	Offset: 0x80
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level.var_45b0f2f3 = &function_45b0f2f3;
}

/*
	Name: function_45b0f2f3
	Namespace: namespace_89e315a4
	Checksum: 0x841A21B0
	Offset: 0xA8
	Size: 0xEE
	Parameters: 1
	Flags: Linked
*/
function function_45b0f2f3(str_weapon_name)
{
	if(!isdefined(str_weapon_name))
	{
		return undefined;
	}
	str_weapon = undefined;
	switch(str_weapon_name)
	{
		case "hash_539f784146391d2":
		case "hash_95dd69e40d99560":
		case "hash_e992907ddf45c9e":
		case "hash_2909dcf2d0d6eed1":
		case "hash_337a0bfc51449d31":
		case "hash_34415d7a97a7d783":
		case "hash_3b5823adc79b4e56":
		case "hash_5004e2171c2be97d":
		case "hash_5b8d1ff4b772bd85":
		case "hash_7d7f0dbb00201240":
		{
			str_weapon = "wonder";
			break;
		}
	}
	return str_weapon;
}

