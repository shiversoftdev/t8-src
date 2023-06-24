// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.gsc;

#namespace zodt8_sound;

/*
	Name: main
	Namespace: zodt8_sound
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
	Namespace: zodt8_sound
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
		case "ww_tricannon_fire_t8":
		case "ww_tricannon_earth_t8":
		case "ww_tricannon_t8_upgraded":
		case "ww_tricannon_air_t8_upgraded":
		case "ww_tricannon_earth_t8_upgraded":
		case "ww_tricannon_fire_t8_upgraded":
		case "ww_tricannon_water_t8_upgraded":
		case "ww_tricannon_water_t8":
		case "ww_tricannon_t8":
		case "ww_tricannon_air_t8":
		{
			str_weapon = "wonder";
			break;
		}
	}
	return str_weapon;
}

