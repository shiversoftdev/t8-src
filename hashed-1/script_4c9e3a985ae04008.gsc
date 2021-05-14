// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27ba6748d83412fd;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_1846c963;

/*
	Name: init
	Namespace: namespace_1846c963
	Checksum: 0xDC57F79C
	Offset: 0x5B8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_fx();
	function_3ad8c656();
	main();
}

/*
	Name: main
	Namespace: namespace_1846c963
	Checksum: 0x9AC208E2
	Offset: 0x5F8
	Size: 0x29C
	Parameters: 0
	Flags: Linked
*/
function main()
{
	num = getdvarint(#"splitscreen_playercount", 0);
	if(num < 1)
	{
		num = 1;
	}
	for(localclientnum = 0; localclientnum < num; localclientnum++)
	{
		util::waitforclient(localclientnum);
	}
	level._effect[#"fasttravel_end"] = #"tools/fx_null";
	if(!isdefined(level.var_22677da8))
	{
		level.var_22677da8 = [];
	}
	else if(!isarray(level.var_22677da8))
	{
		level.var_22677da8 = array(level.var_22677da8);
	}
	var_63fca02d = struct::get_array("white_portal");
	a_e_players = getlocalplayers();
	foreach(s_portal in var_63fca02d)
	{
		level.var_22677da8[s_portal.script_noteworthy] = s_portal;
		if(!isdefined(s_portal.var_9d387dd5))
		{
			s_portal.var_9d387dd5 = [];
		}
		else if(!isarray(s_portal.var_9d387dd5))
		{
			s_portal.var_9d387dd5 = array(s_portal.var_9d387dd5);
		}
		for(i = 0; i < a_e_players.size; i++)
		{
			s_portal.var_9d387dd5[i] = util::spawn_model(i, "tag_origin", s_portal.origin, s_portal.angles);
		}
	}
}

/*
	Name: init_clientfields
	Namespace: namespace_1846c963
	Checksum: 0x735AACC8
	Offset: 0x8A0
	Size: 0x94C
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "portal_dest_fx", 20000, 3, "int", &function_e4ea441, 0, 0);
	clientfield::register("toplayer", "PORTAL_YELLOW_BACKYARD", 20000, 2, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "PORTAL_YELLOW_HOUSE", 20000, 2, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "PORTAL_RED_HOUSE", 20000, 2, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "PORTAL_GREEN_HOUSE", 20000, 2, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "PORTAL_GREEN_BACKYARD", 20000, 2, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "PORTAL_STREET_MID", 20000, 2, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "PORTAL_STREET_START", 20000, 2, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "PORTAL_PRISONER_HOLDING", 20000, 2, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "PORTAL_OPERATIONS", 20000, 2, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "PORTAL_TRANSFUSION_FACILITY", 20000, 2, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "PORTAL_APD_INTERROGATION", 20000, 2, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "PORTAL_DINER", 20000, 2, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "PORTAL_BEDS", 20000, 2, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "PORTAL_LOUNGE", 20000, 2, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "PORTAL_POWER", 20000, 2, "int", &portal_ready_fx, 0, 0);
	clientfield::register("toplayer", "PORTAL_STORAGE", 20000, 2, "int", &portal_ready_fx, 0, 0);
	clientfield::register("actor", "crawler_portal_spawn_fx", 20000, 1, "counter", &crawler_portal_spawn_fx, 0, 0);
	clientfield::register("toplayer", "teleporter_transition", 20000, 1, "counter", &function_38a241a1, 0, 0);
	clientfield::register("toplayer", "teleporter_depart", 20000, 1, "counter", &function_69108708, 0, 0);
	clientfield::register("toplayer", "teleporter_arrive", 20000, 1, "counter", &function_98cff177, 0, 0);
	clientfield::register("world", "portal_maps_clear_lights", 20000, 1, "int", &portal_maps_clear_lights, 0, 0);
	clientfield::register("world", "portal_maps_initialize_lights", 20000, 1, "int", &portal_maps_initialize_lights, 0, 0);
	clientfield::register("world", "portal_map_indicator_green_house_backyard", 20000, 1, "int", &portal_map_indicator_green_house_backyard, 0, 0);
	clientfield::register("world", "portal_map_indicator_red_house", 20000, 1, "int", &portal_map_indicator_red_house, 0, 0);
	clientfield::register("world", "portal_map_indicator_yellow_house", 20000, 1, "int", &portal_map_indicator_yellow_house, 0, 0);
	clientfield::register("world", "portal_map_indicator_prisoner_holding", 20000, 1, "int", &portal_map_indicator_prisoner_holding, 0, 0);
	clientfield::register("world", "portal_map_indicator_street_middle", 20000, 1, "int", &portal_map_indicator_street_middle, 0, 0);
	clientfield::register("world", "portal_map_indicator_transfusion_facility", 20000, 1, "int", &portal_map_indicator_transfusion_facility, 0, 0);
	clientfield::register("world", "portal_map_indicator_diner", 20000, 1, "int", &portal_map_indicator_diner, 0, 0);
	clientfield::register("world", "portal_map_indicator_beds", 20000, 1, "int", &portal_map_indicator_beds, 0, 0);
	clientfield::register("world", "portal_map_indicator_power", 20000, 1, "int", &portal_map_indicator_power, 0, 0);
	clientfield::register("world", "portal_map_indicator_storage", 20000, 1, "int", &portal_map_indicator_storage, 0, 0);
}

/*
	Name: init_fx
	Namespace: namespace_1846c963
	Checksum: 0x7C91154E
	Offset: 0x11F8
	Size: 0x242
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
	level._effect[#"portal_ready"] = #"maps/zm_office/fx8_teleporter_ready";
	level._effect[#"hash_3095132b48d216f5"] = #"hash_7793c4c65b08e6ed";
	level._effect[#"hash_32b0f959e6b81272"] = #"hash_4860741425dc1daa";
	level._effect[#"hash_44687d6082f9a0a4"] = #"hash_a4954ed961d6327";
	level._effect[#"hash_2e43973bc23c661d"] = #"hash_28fc28160d26395e";
	level._effect[#"hash_69091fb60c4fb574"] = #"hash_35e8a88a4a4563b4";
	level._effect[#"hash_690922b60c4fba8d"] = #"hash_205d49f043463dd2";
	level._effect[#"hash_690921b60c4fb8da"] = #"hash_19301646fb93e04c";
	level._effect[#"hash_3ae2cb0d50ae8e3e"] = #"hash_2cafcfa899f12c0";
	level._effect[#"hash_61fb06e6b1e29b45"] = #"hash_1a6b5072e162ccd4";
	level._effect[#"hash_692bbec56d4f9a18"] = #"hash_50655ac7dc942305";
	level._effect[#"hash_60f315ee53fe374f"] = #"hash_62d58a4d86948967";
}

/*
	Name: function_3ad8c656
	Namespace: namespace_1846c963
	Checksum: 0xBA66D52E
	Offset: 0x1448
	Size: 0x116
	Parameters: 0
	Flags: Linked
*/
function function_3ad8c656()
{
	level.var_12cfa40a[0] = "tag_green_house_backyard";
	level.var_12cfa40a[1] = "tag_red_house";
	level.var_12cfa40a[2] = "tag_yellow_house";
	level.var_12cfa40a[3] = "tag_prisoner_holding";
	level.var_12cfa40a[4] = "tag_street_middle";
	level.var_12cfa40a[5] = "tag_transfusion_facility";
	level.var_12cfa40a[6] = "tag_diner";
	level.var_12cfa40a[7] = "tag_beds";
	level.var_12cfa40a[8] = "tag_power";
	level.var_12cfa40a[9] = "tag_storage";
}

/*
	Name: function_38a241a1
	Namespace: namespace_1846c963
	Checksum: 0x48FB6073
	Offset: 0x1568
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_38a241a1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	/#
		println("", localclientnum);
	#/
	self thread postfx::playpostfxbundle("pstfx_zm_office_teleporter");
}

/*
	Name: function_69108708
	Namespace: namespace_1846c963
	Checksum: 0x9DFC7A42
	Offset: 0x15F0
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function function_69108708(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	/#
		println("", localclientnum);
	#/
	util::playfxontag(localclientnum, level._effect[#"hash_61fb06e6b1e29b45"], self, "tag_origin");
}

/*
	Name: function_98cff177
	Namespace: namespace_1846c963
	Checksum: 0xDC300939
	Offset: 0x1690
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function function_98cff177(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	/#
		println("", localclientnum);
	#/
	util::playfxontag(localclientnum, level._effect[#"hash_692bbec56d4f9a18"], self, "tag_origin");
}

/*
	Name: function_e4ea441
	Namespace: namespace_1846c963
	Checksum: 0x4220772B
	Offset: 0x1730
	Size: 0x29A
	Parameters: 7
	Flags: Linked
*/
function function_e4ea441(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.effect_id))
	{
		deletefx(localclientnum, self.effect_id);
	}
	switch(newval)
	{
		case 1:
		{
			self.effect_id = util::playfxontag(localclientnum, level._effect[#"hash_69091fb60c4fb574"], self, "tag_origin");
			self.var_81884612 = self playloopsound(#"evt_teleporter_loop", 1.75);
			break;
		}
		case 2:
		{
			self.effect_id = util::playfxontag(localclientnum, level._effect[#"hash_690922b60c4fba8d"], self, "tag_origin");
			self.var_81884612 = self playloopsound(#"evt_teleporter_loop", 1.75);
			break;
		}
		case 3:
		{
			self.effect_id = util::playfxontag(localclientnum, level._effect[#"hash_690921b60c4fb8da"], self, "tag_origin");
			self.var_81884612 = self playloopsound(#"evt_teleporter_loop", 1.75);
			break;
		}
		case 4:
		{
			self.effect_id = util::playfxontag(localclientnum, level._effect[#"hash_44687d6082f9a0a4"], self, "tag_origin");
			break;
		}
		case 5:
		{
			self.effect_id = util::playfxontag(localclientnum, level._effect[#"hash_2e43973bc23c661d"], self, "tag_origin");
			break;
		}
	}
}

/*
	Name: portal_ready_fx
	Namespace: namespace_1846c963
	Checksum: 0x181647F2
	Offset: 0x19D8
	Size: 0x15E
	Parameters: 7
	Flags: Linked
*/
function portal_ready_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	while(!isdefined(level.var_22677da8))
	{
		waitframe(1);
	}
	var_dabe3ecb = level.var_22677da8[fieldname].var_9d387dd5[localclientnum];
	if(isdefined(var_dabe3ecb) && isdefined(var_dabe3ecb.effect_id))
	{
		deletefx(localclientnum, var_dabe3ecb.effect_id);
	}
	if(newval > 1)
	{
		var_dabe3ecb.effect_id = util::playfxontag(localclientnum, level._effect[#"portal_ready"], var_dabe3ecb, "tag_origin");
	}
	else if(newval == 1)
	{
		var_dabe3ecb.effect_id = util::playfxontag(localclientnum, level._effect[#"hash_3095132b48d216f5"], var_dabe3ecb, "tag_origin");
	}
}

/*
	Name: crawler_portal_spawn_fx
	Namespace: namespace_1846c963
	Checksum: 0xA1B7DFE5
	Offset: 0x1B40
	Size: 0xC4
	Parameters: 7
	Flags: Linked
*/
function crawler_portal_spawn_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	warmup_fx = util::playfxontag(localclientnum, "maps/zm_office/fx8_teleporter_ready", self, "j_spine2");
	wait(1.5);
	if(isdefined(warmup_fx))
	{
		deletefx(localclientnum, warmup_fx);
	}
	util::playfxontag(localclientnum, "maps/zm_office/fx8_teleporter_destination", self, "j_spine2");
}

/*
	Name: portal_maps_clear_lights
	Namespace: namespace_1846c963
	Checksum: 0x26E63D44
	Offset: 0x1C10
	Size: 0xE0
	Parameters: 7
	Flags: Linked
*/
function portal_maps_clear_lights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		return;
	}
	level function_1b1de62b(localclientnum);
	foreach(var_9a586299 in level.var_31feb02b)
	{
		var_9a586299 thread function_bae44e14(localclientnum);
	}
}

/*
	Name: function_bae44e14
	Namespace: namespace_1846c963
	Checksum: 0x74298774
	Offset: 0x1CF8
	Size: 0xE8
	Parameters: 1
	Flags: Linked
*/
function function_bae44e14(localclientnum)
{
	self util::waittill_dobj(localclientnum);
	foreach(var_73d65850 in level.var_12cfa40a)
	{
		self hidepart(localclientnum, var_73d65850 + "_on");
		self hidepart(localclientnum, var_73d65850 + "_active");
		self hidepart(localclientnum, "tag_nuked_lights");
	}
}

/*
	Name: portal_maps_initialize_lights
	Namespace: namespace_1846c963
	Checksum: 0x58E14D02
	Offset: 0x1DE8
	Size: 0x16C
	Parameters: 7
	Flags: Linked
*/
function portal_maps_initialize_lights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		return;
	}
	level function_1b1de62b(localclientnum);
	foreach(var_9a586299 in level.var_31feb02b)
	{
		var_9a586299 util::waittill_dobj(localclientnum);
		foreach(var_73d65850 in level.var_12cfa40a)
		{
			var_9a586299 showpart(localclientnum, var_73d65850 + "_on");
		}
	}
}

/*
	Name: portal_map_indicator_green_house_backyard
	Namespace: namespace_1846c963
	Checksum: 0x8708A374
	Offset: 0x1F60
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function portal_map_indicator_green_house_backyard(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		function_8353316a(localclientnum, "tag_green_house_backyard");
	}
	else if(newval == 1)
	{
		level function_af29dda9(localclientnum, "tag_green_house_backyard");
	}
}

/*
	Name: portal_map_indicator_red_house
	Namespace: namespace_1846c963
	Checksum: 0xDED00C12
	Offset: 0x2000
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function portal_map_indicator_red_house(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		function_8353316a(localclientnum, "tag_red_house");
	}
	else if(newval == 1)
	{
		level function_af29dda9(localclientnum, "tag_red_house");
	}
}

/*
	Name: portal_map_indicator_yellow_house
	Namespace: namespace_1846c963
	Checksum: 0x3379BD45
	Offset: 0x20A0
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function portal_map_indicator_yellow_house(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		function_8353316a(localclientnum, "tag_yellow_house");
	}
	else if(newval == 1)
	{
		level function_af29dda9(localclientnum, "tag_yellow_house");
	}
}

/*
	Name: portal_map_indicator_prisoner_holding
	Namespace: namespace_1846c963
	Checksum: 0xE5F0CC4F
	Offset: 0x2140
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function portal_map_indicator_prisoner_holding(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		function_8353316a(localclientnum, "tag_prisoner_holding");
	}
	else if(newval == 1)
	{
		level function_af29dda9(localclientnum, "tag_prisoner_holding");
	}
}

/*
	Name: portal_map_indicator_street_middle
	Namespace: namespace_1846c963
	Checksum: 0x21F07A14
	Offset: 0x21E0
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function portal_map_indicator_street_middle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		function_8353316a(localclientnum, "tag_street_middle");
	}
	else if(newval == 1)
	{
		level function_af29dda9(localclientnum, "tag_street_middle");
	}
}

/*
	Name: portal_map_indicator_transfusion_facility
	Namespace: namespace_1846c963
	Checksum: 0xFFC99845
	Offset: 0x2280
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function portal_map_indicator_transfusion_facility(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		function_8353316a(localclientnum, "tag_transfusion_facility");
	}
	else if(newval == 1)
	{
		level function_af29dda9(localclientnum, "tag_transfusion_facility");
	}
}

/*
	Name: portal_map_indicator_diner
	Namespace: namespace_1846c963
	Checksum: 0xB75580A2
	Offset: 0x2320
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function portal_map_indicator_diner(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		function_8353316a(localclientnum, "tag_diner");
	}
	else if(newval == 1)
	{
		level function_af29dda9(localclientnum, "tag_diner");
	}
}

/*
	Name: portal_map_indicator_beds
	Namespace: namespace_1846c963
	Checksum: 0xCE151E84
	Offset: 0x23C0
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function portal_map_indicator_beds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		function_8353316a(localclientnum, "tag_beds");
	}
	else if(newval == 1)
	{
		level function_af29dda9(localclientnum, "tag_beds");
	}
}

/*
	Name: portal_map_indicator_power
	Namespace: namespace_1846c963
	Checksum: 0x2F282B33
	Offset: 0x2460
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function portal_map_indicator_power(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		function_8353316a(localclientnum, "tag_power");
	}
	else if(newval == 1)
	{
		level function_af29dda9(localclientnum, "tag_power");
	}
}

/*
	Name: portal_map_indicator_storage
	Namespace: namespace_1846c963
	Checksum: 0x10427DBC
	Offset: 0x2500
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function portal_map_indicator_storage(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 0)
	{
		function_8353316a(localclientnum, "tag_storage");
	}
	else if(newval == 1)
	{
		level function_af29dda9(localclientnum, "tag_storage");
	}
}

/*
	Name: function_af29dda9
	Namespace: namespace_1846c963
	Checksum: 0x539B2DB5
	Offset: 0x25A0
	Size: 0xF8
	Parameters: 2
	Flags: Linked
*/
function function_af29dda9(localclientnum, var_54d8a03c)
{
	level function_1b1de62b(localclientnum);
	foreach(portal_map in level.var_31feb02b)
	{
		portal_map util::waittill_dobj(localclientnum);
		portal_map hidepart(localclientnum, var_54d8a03c + "_on");
		portal_map showpart(localclientnum, var_54d8a03c + "_active");
	}
}

/*
	Name: function_8353316a
	Namespace: namespace_1846c963
	Checksum: 0xA9FA257D
	Offset: 0x26A0
	Size: 0xF8
	Parameters: 2
	Flags: Linked
*/
function function_8353316a(localclientnum, var_54d8a03c)
{
	level function_1b1de62b(localclientnum);
	foreach(portal_map in level.var_31feb02b)
	{
		portal_map util::waittill_dobj(localclientnum);
		portal_map showpart(localclientnum, var_54d8a03c + "_on");
		portal_map hidepart(localclientnum, var_54d8a03c + "_active");
	}
}

/*
	Name: function_1b1de62b
	Namespace: namespace_1846c963
	Checksum: 0x1A14B06B
	Offset: 0x27A0
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function function_1b1de62b(localclientnum)
{
	if(!isdefined(level.var_31feb02b))
	{
		level.var_31feb02b = getentarray(localclientnum, "portal_map", "targetname");
	}
}

/*
	Name: function_73460c84
	Namespace: namespace_1846c963
	Checksum: 0x4AA05CB4
	Offset: 0x27F8
	Size: 0x48
	Parameters: 1
	Flags: None
*/
function function_73460c84(var_4749e403)
{
	for(var_455a6779 = 0; var_455a6779 < var_4749e403; var_455a6779++)
	{
		if(isdefined(self.model))
		{
			break;
		}
		waitframe(1);
	}
}

