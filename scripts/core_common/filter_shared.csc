// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace filter;

/*
	Name: init_filter_indices
	Namespace: filter
	Checksum: 0x3AD97E57
	Offset: 0x218
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function init_filter_indices()
{
	util::function_89a98f85();
}

/*
	Name: map_material_helper_by_localclientnum
	Namespace: filter
	Checksum: 0xF3F7C5C1
	Offset: 0x238
	Size: 0x3E
	Parameters: 2
	Flags: Linked
*/
function map_material_helper_by_localclientnum(localclientnum, materialname)
{
	level.filter_matid[materialname] = mapmaterialindex(localclientnum, materialname);
}

/*
	Name: map_material_if_undefined
	Namespace: filter
	Checksum: 0x3C8A506A
	Offset: 0x280
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function map_material_if_undefined(localclientnum, materialname)
{
	if(isdefined(mapped_material_id(materialname)))
	{
		return;
	}
	map_material_helper_by_localclientnum(localclientnum, materialname);
}

/*
	Name: map_material_helper
	Namespace: filter
	Checksum: 0xE8E03BFC
	Offset: 0x2D8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function map_material_helper(player, materialname)
{
	if(!isdefined(player))
	{
		return;
	}
	map_material_helper_by_localclientnum(player.localclientnum, materialname);
}

/*
	Name: mapped_material_id
	Namespace: filter
	Checksum: 0xD9CD106F
	Offset: 0x320
	Size: 0x38
	Parameters: 1
	Flags: Linked
*/
function mapped_material_id(materialname)
{
	if(!isdefined(level.filter_matid))
	{
		level.filter_matid = [];
	}
	return level.filter_matid[materialname];
}

/*
	Name: function_74649ba9
	Namespace: filter
	Checksum: 0x6B60CCF2
	Offset: 0x360
	Size: 0xB4
	Parameters: 4
	Flags: Linked
*/
function function_74649ba9(player, filterid, pass, enable)
{
	if(!isdefined(player))
	{
		return;
	}
	util::function_89a98f85();
	if(isdefined(player) && isplayer(player) && isalive(player))
	{
		num = player.localclientnum;
		setfilterpassenabled(num, filterid, pass, enable);
	}
}

/*
	Name: function_83a54227
	Namespace: filter
	Checksum: 0x44BAA5D4
	Offset: 0x420
	Size: 0x54
	Parameters: 4
	Flags: Linked
*/
function function_83a54227(var_c0105b9a, filterid, pass, enable)
{
	util::function_89a98f85();
	setfilterpassenabled(var_c0105b9a, filterid, pass, enable);
}

/*
	Name: init_filter_vehicle_damage
	Namespace: filter
	Checksum: 0xA0759DCD
	Offset: 0x480
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function init_filter_vehicle_damage(player, materialname)
{
	init_filter_indices();
	if(!isdefined(level.filter_matid[materialname]))
	{
		map_material_helper(player, materialname);
	}
}

/*
	Name: set_filter_vehicle_damage_amount
	Namespace: filter
	Checksum: 0x61836CC1
	Offset: 0x4E0
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_vehicle_damage_amount(player, filterid, amount)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

/*
	Name: set_filter_vehicle_sun_position
	Namespace: filter
	Checksum: 0x7B81425C
	Offset: 0x530
	Size: 0x74
	Parameters: 4
	Flags: Linked
*/
function set_filter_vehicle_sun_position(player, filterid, x, y)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 4, x);
	setfilterpassconstant(player.localclientnum, filterid, 0, 5, y);
}

/*
	Name: enable_filter_vehicle_damage
	Namespace: filter
	Checksum: 0x9C1D0ADF
	Offset: 0x5B0
	Size: 0x84
	Parameters: 3
	Flags: Linked
*/
function enable_filter_vehicle_damage(player, filterid, materialname)
{
	if(isdefined(level.filter_matid[materialname]))
	{
		setfilterpassmaterial(player.localclientnum, filterid, 0, level.filter_matid[materialname]);
		function_74649ba9(player, filterid, 0, 1);
	}
}

/*
	Name: disable_filter_vehicle_damage
	Namespace: filter
	Checksum: 0xA4CE1FFF
	Offset: 0x640
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function disable_filter_vehicle_damage(player, filterid)
{
	util::function_89a98f85();
	function_74649ba9(player, filterid, 0, 0);
}

/*
	Name: init_filter_oob
	Namespace: filter
	Checksum: 0x90848AA8
	Offset: 0x690
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function init_filter_oob(player)
{
	init_filter_indices();
	map_material_helper(player, "generic_filter_out_of_bounds");
}

/*
	Name: enable_filter_oob
	Namespace: filter
	Checksum: 0xCD83980D
	Offset: 0x6D8
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function enable_filter_oob(localclientnum, filterid)
{
	setfilterpassmaterial(localclientnum, filterid, 0, mapped_material_id("generic_filter_out_of_bounds"));
	function_83a54227(localclientnum, filterid, 0, 1);
}

/*
	Name: disable_filter_oob
	Namespace: filter
	Checksum: 0xAB923349
	Offset: 0x748
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function disable_filter_oob(localclientnum, filterid)
{
	function_83a54227(localclientnum, filterid, 0, 0);
}

/*
	Name: init_filter_tactical
	Namespace: filter
	Checksum: 0x25336B4
	Offset: 0x788
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function init_filter_tactical(player)
{
	init_filter_indices();
	map_material_helper(player, "generic_filter_tactical_damage");
}

/*
	Name: enable_filter_tactical
	Namespace: filter
	Checksum: 0x2C4F2776
	Offset: 0x7D0
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function enable_filter_tactical(player, filterid)
{
	setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_tactical_damage"));
	function_74649ba9(player, filterid, 0, 1);
}

/*
	Name: set_filter_tactical_amount
	Namespace: filter
	Checksum: 0x397879D4
	Offset: 0x848
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_tactical_amount(player, filterid, amount)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

/*
	Name: disable_filter_tactical
	Namespace: filter
	Checksum: 0x886C2F37
	Offset: 0x898
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function disable_filter_tactical(player, filterid)
{
	function_74649ba9(player, filterid, 0, 0);
}

/*
	Name: init_filter_water_sheeting
	Namespace: filter
	Checksum: 0x424CC1E2
	Offset: 0x8D8
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function init_filter_water_sheeting(player)
{
	init_filter_indices();
	map_material_helper(player, "generic_filter_water_sheeting");
}

/*
	Name: enable_filter_water_sheeting
	Namespace: filter
	Checksum: 0x1C30AF9C
	Offset: 0x920
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function enable_filter_water_sheeting(player, filterid)
{
	setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_water_sheeting"));
	setfilterpassenabled(player.localclientnum, filterid, 0, 1, 0, 1);
}

/*
	Name: set_filter_water_sheet_reveal
	Namespace: filter
	Checksum: 0x54EDC419
	Offset: 0x9A8
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_water_sheet_reveal(player, filterid, amount)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

/*
	Name: set_filter_water_sheet_speed
	Namespace: filter
	Checksum: 0x326866F2
	Offset: 0x9F8
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_water_sheet_speed(player, filterid, amount)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

/*
	Name: set_filter_water_sheet_rivulet_reveal
	Namespace: filter
	Checksum: 0xDC1F0355
	Offset: 0xA48
	Size: 0xA4
	Parameters: 5
	Flags: Linked
*/
function set_filter_water_sheet_rivulet_reveal(player, filterid, riv1, riv2, riv3)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 2, riv1);
	setfilterpassconstant(player.localclientnum, filterid, 0, 3, riv2);
	setfilterpassconstant(player.localclientnum, filterid, 0, 4, riv3);
}

/*
	Name: disable_filter_water_sheeting
	Namespace: filter
	Checksum: 0x55DEC83B
	Offset: 0xAF8
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function disable_filter_water_sheeting(player, filterid)
{
	function_74649ba9(player, filterid, 0, 0);
}

/*
	Name: init_filter_water_dive
	Namespace: filter
	Checksum: 0xE1E42774
	Offset: 0xB38
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function init_filter_water_dive(player)
{
	init_filter_indices();
	map_material_helper(player, "generic_filter_water_dive");
}

/*
	Name: enable_filter_water_dive
	Namespace: filter
	Checksum: 0x7382B237
	Offset: 0xB80
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function enable_filter_water_dive(player, filterid)
{
	setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_water_dive"));
	setfilterpassenabled(player.localclientnum, filterid, 0, 1, 0, 1);
}

/*
	Name: disable_filter_water_dive
	Namespace: filter
	Checksum: 0x81CC8375
	Offset: 0xC08
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function disable_filter_water_dive(player, filterid)
{
	function_74649ba9(player, filterid, 0, 0);
}

/*
	Name: set_filter_water_dive_bubbles
	Namespace: filter
	Checksum: 0x2441A477
	Offset: 0xC48
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_water_dive_bubbles(player, filterid, amount)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

/*
	Name: set_filter_water_scuba_bubbles
	Namespace: filter
	Checksum: 0xFAD7C1EE
	Offset: 0xC98
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_water_scuba_bubbles(player, filterid, amount)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

/*
	Name: set_filter_water_scuba_dive_speed
	Namespace: filter
	Checksum: 0xC0C2077E
	Offset: 0xCE8
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_water_scuba_dive_speed(player, filterid, amount)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 2, amount);
}

/*
	Name: set_filter_water_scuba_bubble_attitude
	Namespace: filter
	Checksum: 0x2B43B5C8
	Offset: 0xD38
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_water_scuba_bubble_attitude(player, filterid, amount)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 3, amount);
}

/*
	Name: set_filter_water_wash_reveal_dir
	Namespace: filter
	Checksum: 0xCB4F96CB
	Offset: 0xD88
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_water_wash_reveal_dir(player, filterid, dir)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 4, dir);
}

/*
	Name: set_filter_water_wash_color
	Namespace: filter
	Checksum: 0xB4FF092D
	Offset: 0xDD8
	Size: 0xA4
	Parameters: 5
	Flags: Linked
*/
function set_filter_water_wash_color(player, filterid, red, green, blue)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 5, red);
	setfilterpassconstant(player.localclientnum, filterid, 0, 6, green);
	setfilterpassconstant(player.localclientnum, filterid, 0, 7, blue);
}

/*
	Name: settransported
	Namespace: filter
	Checksum: 0xEB7843E2
	Offset: 0xE88
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function settransported(player)
{
	player thread postfx::playpostfxbundle(#"zm_teleporter");
}

/*
	Name: init_filter_ev_interference
	Namespace: filter
	Checksum: 0x71F60CA
	Offset: 0xEC0
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function init_filter_ev_interference(player)
{
	init_filter_indices();
	map_material_helper(player, "generic_filter_ev_interference");
}

/*
	Name: enable_filter_ev_interference
	Namespace: filter
	Checksum: 0x4CA9E6DA
	Offset: 0xF08
	Size: 0x94
	Parameters: 2
	Flags: None
*/
function enable_filter_ev_interference(player, filterid)
{
	map_material_if_undefined(player.localclientnum, "generic_filter_ev_interference");
	setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_ev_interference"));
	function_74649ba9(player, filterid, 0, 1);
}

/*
	Name: set_filter_ev_interference_amount
	Namespace: filter
	Checksum: 0x14F965DF
	Offset: 0xFA8
	Size: 0x44
	Parameters: 3
	Flags: None
*/
function set_filter_ev_interference_amount(player, filterid, amount)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

/*
	Name: disable_filter_ev_interference
	Namespace: filter
	Checksum: 0x4499378A
	Offset: 0xFF8
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function disable_filter_ev_interference(player, filterid)
{
	function_74649ba9(player, filterid, 0, 0);
}

/*
	Name: init_filter_vehicle_hijack_oor
	Namespace: filter
	Checksum: 0x7431AF38
	Offset: 0x1038
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function init_filter_vehicle_hijack_oor(player)
{
	init_filter_indices();
	map_material_helper(player, "generic_filter_vehicle_out_of_range");
}

/*
	Name: enable_filter_vehicle_hijack_oor
	Namespace: filter
	Checksum: 0xC362EE96
	Offset: 0x1080
	Size: 0x12C
	Parameters: 2
	Flags: None
*/
function enable_filter_vehicle_hijack_oor(player, filterid)
{
	setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_vehicle_out_of_range"));
	function_74649ba9(player, filterid, 0, 1);
	setfilterpassconstant(player.localclientnum, filterid, 0, 1, 0);
	setfilterpassconstant(player.localclientnum, filterid, 0, 2, 1);
	setfilterpassconstant(player.localclientnum, filterid, 0, 3, 0);
	setfilterpassconstant(player.localclientnum, filterid, 0, 4, -1);
}

/*
	Name: set_filter_vehicle_hijack_oor_noblack
	Namespace: filter
	Checksum: 0x6FF92D23
	Offset: 0x11B8
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function set_filter_vehicle_hijack_oor_noblack(player, filterid)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 3, 1);
}

/*
	Name: set_filter_vehicle_hijack_oor_amount
	Namespace: filter
	Checksum: 0xB7B8D65C
	Offset: 0x1208
	Size: 0x6C
	Parameters: 3
	Flags: None
*/
function set_filter_vehicle_hijack_oor_amount(player, filterid, amount)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
	setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

/*
	Name: disable_filter_vehicle_hijack_oor
	Namespace: filter
	Checksum: 0xE979B132
	Offset: 0x1280
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function disable_filter_vehicle_hijack_oor(player, filterid)
{
	function_74649ba9(player, filterid, 0, 0);
}

/*
	Name: init_filter_speed_burst
	Namespace: filter
	Checksum: 0x43946F12
	Offset: 0x12C0
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function init_filter_speed_burst(player)
{
	init_filter_indices();
	map_material_helper(player, "generic_filter_speed_burst");
}

/*
	Name: enable_filter_speed_burst
	Namespace: filter
	Checksum: 0x525FF692
	Offset: 0x1308
	Size: 0x6C
	Parameters: 2
	Flags: None
*/
function enable_filter_speed_burst(player, filterid)
{
	setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_speed_burst"));
	function_74649ba9(player, filterid, 0, 1);
}

/*
	Name: set_filter_speed_burst
	Namespace: filter
	Checksum: 0xFA95D82F
	Offset: 0x1380
	Size: 0x4C
	Parameters: 4
	Flags: None
*/
function set_filter_speed_burst(player, filterid, constantindex, amount)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, constantindex, amount);
}

/*
	Name: disable_filter_speed_burst
	Namespace: filter
	Checksum: 0xAA732581
	Offset: 0x13D8
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function disable_filter_speed_burst(player, filterid)
{
	function_74649ba9(player, filterid, 0, 0);
}

/*
	Name: init_filter_sprite_transition
	Namespace: filter
	Checksum: 0x8D638F62
	Offset: 0x1418
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function init_filter_sprite_transition(player)
{
	init_filter_indices();
	map_material_helper(player, "generic_filter_transition_sprite");
}

/*
	Name: enable_filter_sprite_transition
	Namespace: filter
	Checksum: 0x2D0A4F76
	Offset: 0x1460
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function enable_filter_sprite_transition(player, filterid)
{
	setfilterpassmaterial(player.localclientnum, filterid, 1, mapped_material_id("generic_filter_transition_sprite"));
	function_74649ba9(player, filterid, 1, 1);
	setfilterpassquads(player.localclientnum, filterid, 1, 2048);
}

/*
	Name: set_filter_sprite_transition_octogons
	Namespace: filter
	Checksum: 0xBF16AC78
	Offset: 0x1500
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_sprite_transition_octogons(player, filterid, octos)
{
	setfilterpassconstant(player.localclientnum, filterid, 1, 0, octos);
}

/*
	Name: set_filter_sprite_transition_blur
	Namespace: filter
	Checksum: 0x56C080EC
	Offset: 0x1550
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_sprite_transition_blur(player, filterid, blur)
{
	setfilterpassconstant(player.localclientnum, filterid, 1, 1, blur);
}

/*
	Name: set_filter_sprite_transition_boost
	Namespace: filter
	Checksum: 0x9A55CD6B
	Offset: 0x15A0
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_sprite_transition_boost(player, filterid, boost)
{
	setfilterpassconstant(player.localclientnum, filterid, 1, 2, boost);
}

/*
	Name: set_filter_sprite_transition_move_radii
	Namespace: filter
	Checksum: 0x49DA11B2
	Offset: 0x15F0
	Size: 0x74
	Parameters: 4
	Flags: Linked
*/
function set_filter_sprite_transition_move_radii(player, filterid, inner, outter)
{
	setfilterpassconstant(player.localclientnum, filterid, 1, 24, inner);
	setfilterpassconstant(player.localclientnum, filterid, 1, 25, outter);
}

/*
	Name: set_filter_sprite_transition_elapsed
	Namespace: filter
	Checksum: 0xAD0AC43E
	Offset: 0x1670
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_sprite_transition_elapsed(player, filterid, time)
{
	setfilterpassconstant(player.localclientnum, filterid, 1, 28, time);
}

/*
	Name: disable_filter_sprite_transition
	Namespace: filter
	Checksum: 0xF8B6166
	Offset: 0x16C0
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function disable_filter_sprite_transition(player, filterid)
{
	function_74649ba9(player, filterid, 1, 0);
}

/*
	Name: init_filter_frame_transition
	Namespace: filter
	Checksum: 0x65108CAA
	Offset: 0x1700
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function init_filter_frame_transition(player)
{
	init_filter_indices();
	map_material_helper(player, "generic_filter_transition_frame");
}

/*
	Name: enable_filter_frame_transition
	Namespace: filter
	Checksum: 0xBE32D802
	Offset: 0x1748
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function enable_filter_frame_transition(player, filterid)
{
	setfilterpassmaterial(player.localclientnum, filterid, 2, mapped_material_id("generic_filter_transition_frame"));
	function_74649ba9(player, filterid, 2, 1);
}

/*
	Name: set_filter_frame_transition_heavy_hexagons
	Namespace: filter
	Checksum: 0xA0372373
	Offset: 0x17C0
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_frame_transition_heavy_hexagons(player, filterid, hexes)
{
	setfilterpassconstant(player.localclientnum, filterid, 2, 0, hexes);
}

/*
	Name: set_filter_frame_transition_light_hexagons
	Namespace: filter
	Checksum: 0x3B731B63
	Offset: 0x1810
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_frame_transition_light_hexagons(player, filterid, hexes)
{
	setfilterpassconstant(player.localclientnum, filterid, 2, 1, hexes);
}

/*
	Name: set_filter_frame_transition_flare
	Namespace: filter
	Checksum: 0xF6994F4E
	Offset: 0x1860
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_frame_transition_flare(player, filterid, opacity)
{
	setfilterpassconstant(player.localclientnum, filterid, 2, 2, opacity);
}

/*
	Name: set_filter_frame_transition_blur
	Namespace: filter
	Checksum: 0x4B2638AF
	Offset: 0x18B0
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_frame_transition_blur(player, filterid, amount)
{
	setfilterpassconstant(player.localclientnum, filterid, 2, 3, amount);
}

/*
	Name: set_filter_frame_transition_iris
	Namespace: filter
	Checksum: 0xA8BA8562
	Offset: 0x1900
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_frame_transition_iris(player, filterid, opacity)
{
	setfilterpassconstant(player.localclientnum, filterid, 2, 4, opacity);
}

/*
	Name: set_filter_frame_transition_saved_frame_reveal
	Namespace: filter
	Checksum: 0xE77D4304
	Offset: 0x1950
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_frame_transition_saved_frame_reveal(player, filterid, reveal)
{
	setfilterpassconstant(player.localclientnum, filterid, 2, 5, reveal);
}

/*
	Name: set_filter_frame_transition_warp
	Namespace: filter
	Checksum: 0x7A24E83A
	Offset: 0x19A0
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_frame_transition_warp(player, filterid, amount)
{
	setfilterpassconstant(player.localclientnum, filterid, 2, 6, amount);
}

/*
	Name: disable_filter_frame_transition
	Namespace: filter
	Checksum: 0x84BF6021
	Offset: 0x19F0
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function disable_filter_frame_transition(player, filterid)
{
	function_74649ba9(player, filterid, 2, 0);
}

/*
	Name: init_filter_base_frame_transition
	Namespace: filter
	Checksum: 0x698FC320
	Offset: 0x1A30
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function init_filter_base_frame_transition(player)
{
	init_filter_indices();
	map_material_helper(player, "generic_filter_transition_frame_base");
}

/*
	Name: enable_filter_base_frame_transition
	Namespace: filter
	Checksum: 0xAA5A74EA
	Offset: 0x1A78
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function enable_filter_base_frame_transition(player, filterid)
{
	setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_transition_frame_base"));
	function_74649ba9(player, filterid, 0, 1);
}

/*
	Name: set_filter_base_frame_transition_warp
	Namespace: filter
	Checksum: 0xE4E9A851
	Offset: 0x1AF0
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_base_frame_transition_warp(player, filterid, warp)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 0, warp);
}

/*
	Name: set_filter_base_frame_transition_boost
	Namespace: filter
	Checksum: 0xD7A25CD7
	Offset: 0x1B40
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_base_frame_transition_boost(player, filterid, boost)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 1, boost);
}

/*
	Name: set_filter_base_frame_transition_durden
	Namespace: filter
	Checksum: 0xE41A6AC1
	Offset: 0x1B90
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_base_frame_transition_durden(player, filterid, opacity)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 2, opacity);
}

/*
	Name: set_filter_base_frame_transition_durden_blur
	Namespace: filter
	Checksum: 0xE9E452E9
	Offset: 0x1BE0
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_base_frame_transition_durden_blur(player, filterid, blur)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 3, blur);
}

/*
	Name: disable_filter_base_frame_transition
	Namespace: filter
	Checksum: 0x928B3B80
	Offset: 0x1C30
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function disable_filter_base_frame_transition(player, filterid)
{
	function_74649ba9(player, filterid, 0, 0);
}

/*
	Name: function_9ff66ea3
	Namespace: filter
	Checksum: 0xC33F5B57
	Offset: 0x1C70
	Size: 0x44
	Parameters: 4
	Flags: None
*/
function function_9ff66ea3(localclientnum, filterid, passid, opacity)
{
	setfilterpassconstant(localclientnum, filterid, passid, 0, opacity);
}

/*
	Name: init_filter_sprite_rain
	Namespace: filter
	Checksum: 0xFB01913D
	Offset: 0x1CC0
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function init_filter_sprite_rain(player)
{
	init_filter_indices();
	map_material_helper(player, "generic_filter_sprite_rain");
}

/*
	Name: enable_filter_sprite_rain
	Namespace: filter
	Checksum: 0xEE3FF934
	Offset: 0x1D08
	Size: 0x94
	Parameters: 2
	Flags: None
*/
function enable_filter_sprite_rain(player, filterid)
{
	setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_sprite_rain"));
	function_74649ba9(player, filterid, 0, 1);
	setfilterpassquads(player.localclientnum, filterid, 0, 2048);
}

/*
	Name: set_filter_sprite_rain_opacity
	Namespace: filter
	Checksum: 0x6C54AE6F
	Offset: 0x1DA8
	Size: 0x44
	Parameters: 3
	Flags: None
*/
function set_filter_sprite_rain_opacity(player, filterid, opacity)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 0, opacity);
}

/*
	Name: set_filter_sprite_rain_seed_offset
	Namespace: filter
	Checksum: 0xB2765D22
	Offset: 0x1DF8
	Size: 0x44
	Parameters: 3
	Flags: None
*/
function set_filter_sprite_rain_seed_offset(player, filterid, offset)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 26, offset);
}

/*
	Name: set_filter_sprite_rain_elapsed
	Namespace: filter
	Checksum: 0xC217F508
	Offset: 0x1E48
	Size: 0x44
	Parameters: 3
	Flags: None
*/
function set_filter_sprite_rain_elapsed(player, filterid, time)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 28, time);
}

/*
	Name: disable_filter_sprite_rain
	Namespace: filter
	Checksum: 0x505CB89D
	Offset: 0x1E98
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function disable_filter_sprite_rain(player, filterid)
{
	function_74649ba9(player, filterid, 0, 0);
}

/*
	Name: init_filter_sprite_dirt
	Namespace: filter
	Checksum: 0xDEDAF4FB
	Offset: 0x1ED8
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function init_filter_sprite_dirt(player)
{
	init_filter_indices();
	map_material_helper(player, "generic_filter_sprite_dirt");
}

/*
	Name: enable_filter_sprite_dirt
	Namespace: filter
	Checksum: 0x8CD46FED
	Offset: 0x1F20
	Size: 0x94
	Parameters: 2
	Flags: None
*/
function enable_filter_sprite_dirt(player, filterid)
{
	setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_sprite_dirt"));
	function_74649ba9(player, filterid, 0, 1);
	setfilterpassquads(player.localclientnum, filterid, 0, 400);
}

/*
	Name: set_filter_sprite_dirt_opacity
	Namespace: filter
	Checksum: 0xA5D241F5
	Offset: 0x1FC0
	Size: 0x44
	Parameters: 3
	Flags: None
*/
function set_filter_sprite_dirt_opacity(player, filterid, opacity)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 0, opacity);
}

/*
	Name: set_filter_sprite_dirt_source_position
	Namespace: filter
	Checksum: 0xE6A9B98D
	Offset: 0x2010
	Size: 0xA4
	Parameters: 5
	Flags: None
*/
function set_filter_sprite_dirt_source_position(player, filterid, right, up, distance)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 1, right);
	setfilterpassconstant(player.localclientnum, filterid, 0, 2, up);
	setfilterpassconstant(player.localclientnum, filterid, 0, 3, distance);
}

/*
	Name: set_filter_sprite_dirt_sun_position
	Namespace: filter
	Checksum: 0x32B647CD
	Offset: 0x20C0
	Size: 0x74
	Parameters: 4
	Flags: None
*/
function set_filter_sprite_dirt_sun_position(player, filterid, pitch, yaw)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 4, pitch);
	setfilterpassconstant(player.localclientnum, filterid, 0, 5, yaw);
}

/*
	Name: set_filter_sprite_dirt_seed_offset
	Namespace: filter
	Checksum: 0xA591E17
	Offset: 0x2140
	Size: 0x44
	Parameters: 3
	Flags: None
*/
function set_filter_sprite_dirt_seed_offset(player, filterid, offset)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 26, offset);
}

/*
	Name: set_filter_sprite_dirt_elapsed
	Namespace: filter
	Checksum: 0xC173B107
	Offset: 0x2190
	Size: 0x44
	Parameters: 3
	Flags: None
*/
function set_filter_sprite_dirt_elapsed(player, filterid, time)
{
	setfilterpassconstant(player.localclientnum, filterid, 0, 28, time);
}

/*
	Name: disable_filter_sprite_dirt
	Namespace: filter
	Checksum: 0x1D9E8AA2
	Offset: 0x21E0
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function disable_filter_sprite_dirt(player, filterid)
{
	function_74649ba9(player, filterid, 0, 0);
}

/*
	Name: init_filter_drowning_damage
	Namespace: filter
	Checksum: 0xC69FE601
	Offset: 0x2220
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function init_filter_drowning_damage(localclientnum)
{
	init_filter_indices();
	map_material_helper_by_localclientnum(localclientnum, "generic_filter_drowning");
}

/*
	Name: enable_filter_drowning_damage
	Namespace: filter
	Checksum: 0x29258474
	Offset: 0x2268
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function enable_filter_drowning_damage(localclientnum, passid)
{
	setfilterpassmaterial(localclientnum, 5, passid, mapped_material_id("generic_filter_drowning"));
	setfilterpassenabled(localclientnum, 5, passid, 1, 0, 1);
}

/*
	Name: set_filter_drowning_damage_opacity
	Namespace: filter
	Checksum: 0xD5BB9FEA
	Offset: 0x22E0
	Size: 0x3C
	Parameters: 3
	Flags: Linked
*/
function set_filter_drowning_damage_opacity(localclientnum, passid, opacity)
{
	setfilterpassconstant(localclientnum, 5, passid, 0, opacity);
}

/*
	Name: set_filter_drowning_damage_inner_radius
	Namespace: filter
	Checksum: 0x40527077
	Offset: 0x2328
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_drowning_damage_inner_radius(localclientnum, passid, inner)
{
	setfilterpassconstant(localclientnum, 5, passid, 1, inner);
}

/*
	Name: set_filter_drowning_damage_outer_radius
	Namespace: filter
	Checksum: 0x2AC8A517
	Offset: 0x2378
	Size: 0x44
	Parameters: 3
	Flags: Linked
*/
function set_filter_drowning_damage_outer_radius(localclientnum, passid, outer)
{
	setfilterpassconstant(localclientnum, 5, passid, 2, outer);
}

/*
	Name: disable_filter_drowning_damage
	Namespace: filter
	Checksum: 0x8420B36B
	Offset: 0x23C8
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function disable_filter_drowning_damage(localclientnum, passid)
{
	setfilterpassenabled(localclientnum, 5, passid, 0);
}

