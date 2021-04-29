// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_ac6a30f1991e105;
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\animation_shared.csc;
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_5c160465;

/*
	Name: init
	Namespace: namespace_5c160465
	Checksum: 0xF1A26BC3
	Offset: 0x480
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level._effect[#"hash_4404445ebccbb611"] = "maps/zm_white/fx8_toxic_gas_lg";
	level._effect[#"hash_1ee21c0a6ac389df"] = "maps/zm_white/fx8_toxic_gas_venting_lg";
	level._effect[#"hash_3f8ce63d1f7bf5d0"] = "maps/zm_towers/fx8_special_round_green_gas_md";
	level._effect[#"hash_670acb2528e7f014"] = #"hash_67f59250cb33cc07";
	function_aa1e486e();
}

/*
	Name: register_clientfields
	Namespace: namespace_5c160465
	Checksum: 0xDBEC50D5
	Offset: 0x548
	Size: 0x404
	Parameters: 0
	Flags: Linked
*/
function register_clientfields()
{
	clientfield::register("scriptmover", "white_event_gas_lg_clientfield", 1, 1, "int", &function_e54e60de, 0, 0);
	clientfield::register("scriptmover", "white_event_gas_MD_clientfield", 1, 1, "int", &function_32acf82a, 0, 0);
	clientfield::register("scriptmover", "white_event_gas_lg_vent_clientfield", 1, 1, "int", &function_a9b5240b, 0, 0);
	clientfield::register("world", "portal_map_gas_indicators_init", 1, 1, "int", &portal_map_gas_indicators_init, 0, 0);
	clientfield::register("world", "portal_map_gas_indicator_green_house", 1, 1, "int", &portal_map_gas_indicator_green_house, 0, 0);
	clientfield::register("world", "portal_map_gas_indicator_hammond_house", 1, 1, "int", &portal_map_gas_indicator_hammond_house, 0, 0);
	clientfield::register("world", "portal_map_gas_indicator_hoggatt_house", 1, 1, "int", &portal_map_gas_indicator_hoggatt_house, 0, 0);
	clientfield::register("world", "portal_map_gas_indicator_obrien_house", 1, 1, "int", &portal_map_gas_indicator_obrien_house, 0, 0);
	clientfield::register("world", "portal_map_gas_indicator_reinsel_house", 1, 1, "int", &portal_map_gas_indicator_reinsel_house, 0, 0);
	clientfield::register("world", "portal_map_gas_indicator_yellow_house", 1, 1, "int", &portal_map_gas_indicator_yellow_house, 0, 0);
	clientfield::register("world", "portal_map_gas_indicator_generators", 1, 1, "int", &portal_map_gas_indicator_generators, 0, 0);
	clientfield::register("world", "generator_sound_sweetner", 1, 1, "int", &function_2496442c, 0, 0);
	clientfield::register("world", "" + #"hash_1c11f70bb8445095", 1, 3, "int", &function_88991669, 0, 0);
	clientfield::register("toplayer", "vent_interact_feedback", 20000, 1, "counter", &vent_interact_feedback, 0, 0);
}

/*
	Name: function_e54e60de
	Namespace: namespace_5c160465
	Checksum: 0xBFF2C56C
	Offset: 0x958
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_e54e60de(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_4404445ebccbb611"], self, "tag_origin");
}

/*
	Name: function_a9b5240b
	Namespace: namespace_5c160465
	Checksum: 0x557851FA
	Offset: 0x9D8
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_a9b5240b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_1ee21c0a6ac389df"], self, "tag_origin");
}

/*
	Name: function_32acf82a
	Namespace: namespace_5c160465
	Checksum: 0xB985628B
	Offset: 0xA58
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_32acf82a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_3f8ce63d1f7bf5d0"], self, "tag_origin");
}

/*
	Name: vent_interact_feedback
	Namespace: namespace_5c160465
	Checksum: 0xF70D5713
	Offset: 0xAD8
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function vent_interact_feedback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self playrumbleonentity(localclientnum, "damage_light");
	}
}

/*
	Name: function_aa1e486e
	Namespace: namespace_5c160465
	Checksum: 0x84D868EF
	Offset: 0xB48
	Size: 0xC2
	Parameters: 0
	Flags: Linked
*/
function function_aa1e486e()
{
	level.var_bc3b16f3[0] = "tag_green_house";
	level.var_bc3b16f3[1] = "tag_hammond_house";
	level.var_bc3b16f3[2] = "tag_hoggatt_house";
	level.var_bc3b16f3[3] = "tag_obrien_house";
	level.var_bc3b16f3[4] = "tag_reinsel_house";
	level.var_bc3b16f3[5] = "tag_yellow_house";
	level.var_bc3b16f3[6] = "tag_generators";
}

/*
	Name: portal_map_gas_indicators_init
	Namespace: namespace_5c160465
	Checksum: 0x23E48702
	Offset: 0xC18
	Size: 0x2AA
	Parameters: 7
	Flags: Linked
*/
function portal_map_gas_indicators_init(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		level.var_8f14a19 = getentarray(localclientnum, "portal_map", "targetname");
		foreach(var_35f97c42 in level.var_8f14a19)
		{
			var_35f97c42 util::waittill_dobj(localclientnum);
			foreach(str_tag_name in level.var_bc3b16f3)
			{
				var_35f97c42 hidepart(localclientnum, str_tag_name + "_clear");
				var_35f97c42 hidepart(localclientnum, str_tag_name + "_clogged");
			}
		}
	}
	else if(!isdefined(level.var_8f14a19))
	{
		level.var_8f14a19 = getentarray(localclientnum, "portal_map", "targetname");
	}
	foreach(var_35f97c42 in level.var_8f14a19)
	{
		for(i = 0; i < 6; i++)
		{
			var_35f97c42 util::waittill_dobj(localclientnum);
			var_35f97c42 showpart(localclientnum, level.var_bc3b16f3[i] + "_clear");
		}
	}
}

/*
	Name: portal_map_gas_indicator_green_house
	Namespace: namespace_5c160465
	Checksum: 0x9C85F3F9
	Offset: 0xED0
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function portal_map_gas_indicator_green_house(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		function_f05553f1(localclientnum, "tag_green_house");
	}
	else if(newval == 1)
	{
		function_a7084ac5(localclientnum, "tag_green_house");
	}
}

/*
	Name: portal_map_gas_indicator_hammond_house
	Namespace: namespace_5c160465
	Checksum: 0xF52E28B5
	Offset: 0xF70
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function portal_map_gas_indicator_hammond_house(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		function_f05553f1(localclientnum, "tag_hammond_house");
	}
	else if(newval == 1)
	{
		function_a7084ac5(localclientnum, "tag_hammond_house");
	}
}

/*
	Name: portal_map_gas_indicator_hoggatt_house
	Namespace: namespace_5c160465
	Checksum: 0x2ECA723B
	Offset: 0x1010
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function portal_map_gas_indicator_hoggatt_house(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		function_f05553f1(localclientnum, "tag_hoggatt_house");
	}
	else if(newval == 1)
	{
		function_a7084ac5(localclientnum, "tag_hoggatt_house");
	}
}

/*
	Name: portal_map_gas_indicator_obrien_house
	Namespace: namespace_5c160465
	Checksum: 0xFDECC262
	Offset: 0x10B0
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function portal_map_gas_indicator_obrien_house(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		function_f05553f1(localclientnum, "tag_obrien_house");
	}
	else if(newval == 1)
	{
		function_a7084ac5(localclientnum, "tag_obrien_house");
	}
}

/*
	Name: portal_map_gas_indicator_reinsel_house
	Namespace: namespace_5c160465
	Checksum: 0xA6D63652
	Offset: 0x1150
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function portal_map_gas_indicator_reinsel_house(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		function_f05553f1(localclientnum, "tag_reinsel_house");
	}
	else if(newval == 1)
	{
		function_a7084ac5(localclientnum, "tag_reinsel_house");
	}
}

/*
	Name: portal_map_gas_indicator_yellow_house
	Namespace: namespace_5c160465
	Checksum: 0x11C87D38
	Offset: 0x11F0
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function portal_map_gas_indicator_yellow_house(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		function_f05553f1(localclientnum, "tag_yellow_house");
	}
	else if(newval == 1)
	{
		function_a7084ac5(localclientnum, "tag_yellow_house");
	}
}

/*
	Name: portal_map_gas_indicator_generators
	Namespace: namespace_5c160465
	Checksum: 0x60906D7F
	Offset: 0x1290
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function portal_map_gas_indicator_generators(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		function_f05553f1(localclientnum, "tag_generators");
	}
	else if(newval == 1)
	{
		function_a7084ac5(localclientnum, "tag_generators");
	}
}

/*
	Name: function_a7084ac5
	Namespace: namespace_5c160465
	Checksum: 0xA1CC5111
	Offset: 0x1330
	Size: 0x120
	Parameters: 2
	Flags: Linked
*/
function function_a7084ac5(localclientnum, tag)
{
	if(!isdefined(level.var_8f14a19))
	{
		level.var_8f14a19 = getentarray(localclientnum, "portal_map", "targetname");
	}
	foreach(var_35f97c42 in level.var_8f14a19)
	{
		var_35f97c42 util::waittill_dobj(localclientnum);
		var_35f97c42 showpart(localclientnum, tag + "_clogged");
		var_35f97c42 hidepart(localclientnum, tag + "_clear");
	}
}

/*
	Name: function_f05553f1
	Namespace: namespace_5c160465
	Checksum: 0xD34ED233
	Offset: 0x1458
	Size: 0x120
	Parameters: 2
	Flags: Linked
*/
function function_f05553f1(localclientnum, tag)
{
	if(!isdefined(level.var_8f14a19))
	{
		level.var_8f14a19 = getentarray(localclientnum, "portal_map", "targetname");
	}
	foreach(var_35f97c42 in level.var_8f14a19)
	{
		var_35f97c42 util::waittill_dobj(localclientnum);
		var_35f97c42 showpart(localclientnum, tag + "_clear");
		var_35f97c42 hidepart(localclientnum, tag + "_clogged");
	}
}

/*
	Name: function_88991669
	Namespace: namespace_5c160465
	Checksum: 0xBDC3B5A0
	Offset: 0x1580
	Size: 0x2E6
	Parameters: 7
	Flags: Linked
*/
function function_88991669(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(!isdefined(level.var_41858f75))
	{
		level.var_41858f75 = getent(localclientnum, "pap_control_panel", "targetname");
		level.var_41858f75 util::waittill_dobj(localclientnum);
		if(isdefined(level.var_41858f75))
		{
			for(i = 0; i < 4; i++)
			{
				level.var_41858f75 hidepart(localclientnum, "tag_lt_good_" + string(i));
				util::playfxontag(localclientnum, "maps/zm_white/fx8_lgt_pap_console_green", level.var_41858f75, "tag_lt_good_" + string(i));
				util::playfxontag(localclientnum, "maps/zm_white/fx8_lgt_pap_console_red", level.var_41858f75, "tag_lt_bad_" + string(i));
			}
		}
		return;
	}
	for(i = 0; i < 4; i++)
	{
		level.var_41858f75 hidepart(localclientnum, "tag_lt_good_" + string(i));
		level.var_41858f75 hidepart(localclientnum, "tag_lt_bad_" + string(i));
	}
	for(i = 0; i < newval; i++)
	{
		level.var_41858f75 showpart(localclientnum, "tag_lt_bad_" + string(i));
	}
	for(i = newval; i < 4; i++)
	{
		level.var_41858f75 showpart(localclientnum, "tag_lt_good_" + string(i));
	}
}

/*
	Name: function_2496442c
	Namespace: namespace_5c160465
	Checksum: 0xC0AA3C1D
	Offset: 0x1870
	Size: 0x9C
	Parameters: 7
	Flags: Linked
*/
function function_2496442c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	audio::playloopat(#"hash_3f579b3632b29a2", (-158, -352, -379));
	audio::playloopat(#"hash_3f579b3632b29a2", (86, -345, -367));
}

