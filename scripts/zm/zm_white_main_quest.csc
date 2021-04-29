// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_12282e6b2cc91b42;
#using script_1611421ee9b880d3;
#using script_624a704d0f6bf28d;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\serverfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\load.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_pack_a_punch.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace namespace_4e1a75d3;

/*
	Name: init_clientfields
	Namespace: namespace_4e1a75d3
	Checksum: 0x890C94B0
	Offset: 0x500
	Size: 0x31C
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "fx_steam_lab_dry_ice", 1, 1, "int", &function_9bc657a7, 0, 0);
	clientfield::register("world", "portal_map_to_nuclear_state", 20000, 1, "int", &portal_map_to_nuclear_state, 0, 0);
	clientfield::register("scriptmover", "fx_shard_glow_clientfield", 20000, 1, "int", &function_d2bee3bb, 0, 0);
	clientfield::register("toplayer", "clock_interact_feedback", 20000, 1, "counter", &clock_interact_feedback, 0, 0);
	clientfield::register("toplayer", "server_carry_feedback", 20000, 1, "counter", &server_carry_feedback, 0, 0);
	clientfield::register("toplayer", "server_carry_fail_feedback", 20000, 1, "counter", &server_carry_fail_feedback, 0, 0);
	clientfield::register("toplayer", "server_carry_audio_feedback", 20000, 1, "int", &server_carry_audio_feedback, 0, 0);
	clientfield::register("vehicle", "fx8_power_wisp_lg", 1, 1, "int", &function_4b104fc5, 0, 0);
	clientfield::register("scriptmover", "fx8_quest_mannequin_initial_sparks", 1, 1, "int", &function_a4630e54, 0, 0);
	clientfield::register("scriptmover", "fx8_quest_mannequin_charging", 1, 1, "int", &function_a290f1b0, 0, 0);
	clientfield::register("scriptmover", "fx8_quest_mannequin_explode_main", 1, 1, "int", &function_ac3315e5, 0, 0);
}

/*
	Name: init_fx
	Namespace: namespace_4e1a75d3
	Checksum: 0xAE1B6E3C
	Offset: 0x828
	Size: 0x15A
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
	level._effect[#"hash_51c7bc3539ed5540"] = #"hash_59977c4c851916e0";
	level._effect[#"hash_68213763a7707b92"] = #"hash_1a06427eff8dfe13";
	level._effect[#"fx_steam_lab_dry_ice"] = "_t7/steam/fx_steam_lab_dry_ice";
	level._effect[#"hash_675f4b19e646ca6c"] = #"hash_4310e1cb3f897c7c";
	level._effect[#"fx8_power_wisp_lg"] = "maps/zm_white/fx8_power_wisp_lg";
	level._effect[#"fx8_quest_mannequin_initial_sparks"] = "maps/zm_white/fx8_quest_mannequin_initial_sparks";
	level._effect[#"fx8_quest_mannequin_charging"] = "maps/zm_white/fx8_quest_mannequin_charging";
	level._effect[#"fx8_quest_mannequin_explode_main"] = "maps/zm_white/fx8_quest_mannequin_explode_main";
}

/*
	Name: function_a4630e54
	Namespace: namespace_4e1a75d3
	Checksum: 0x94EC362
	Offset: 0x990
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function function_a4630e54(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self.fx_sparks = util::playfxontag(localclientnum, level._effect[#"fx8_quest_mannequin_initial_sparks"], self, "tag_head");
	}
	else
	{
		stopfx(localclientnum, self.fx_sparks);
	}
}

/*
	Name: function_a290f1b0
	Namespace: namespace_4e1a75d3
	Checksum: 0x1A74B836
	Offset: 0xA48
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function function_a290f1b0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self.var_5059f634 = util::playfxontag(localclientnum, level._effect[#"fx8_quest_mannequin_charging"], self, "tag_origin");
	}
	else
	{
		killfx(localclientnum, self.var_5059f634);
	}
}

/*
	Name: function_ac3315e5
	Namespace: namespace_4e1a75d3
	Checksum: 0xFB176D02
	Offset: 0xB00
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function function_ac3315e5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self.fx = util::playfxontag(localclientnum, level._effect[#"fx8_quest_mannequin_explode_main"], self, "tag_origin");
	}
	else
	{
		stopfx(localclientnum, self.fx);
	}
}

/*
	Name: function_4b104fc5
	Namespace: namespace_4e1a75d3
	Checksum: 0x9A3B6B50
	Offset: 0xBB8
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function function_4b104fc5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self.fx = util::playfxontag(localclientnum, level._effect[#"fx8_power_wisp_lg"], self, "tag_origin");
	}
	else
	{
		stopfx(localclientnum, self.fx);
	}
}

/*
	Name: clock_interact_feedback
	Namespace: namespace_4e1a75d3
	Checksum: 0x637BC217
	Offset: 0xC70
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function clock_interact_feedback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self playrumbleonentity(localclientnum, "damage_light");
	}
}

/*
	Name: server_carry_feedback
	Namespace: namespace_4e1a75d3
	Checksum: 0x8B15FD17
	Offset: 0xCE0
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function server_carry_feedback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self playrumbleonentity(localclientnum, "damage_light");
	}
}

/*
	Name: server_carry_fail_feedback
	Namespace: namespace_4e1a75d3
	Checksum: 0x70535099
	Offset: 0xD50
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function server_carry_fail_feedback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self playrumbleonentity(localclientnum, "damage_heavy");
	}
}

/*
	Name: server_carry_audio_feedback
	Namespace: namespace_4e1a75d3
	Checksum: 0xE562D29B
	Offset: 0xDC0
	Size: 0xAE
	Parameters: 7
	Flags: Linked
*/
function server_carry_audio_feedback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.var_c0f636f9 = self playloopsound(#"hash_54b2fc41dcb6bc56");
	}
	else if(isdefined(self.var_c0f636f9))
	{
		self stoploopsound(self.var_c0f636f9);
		self.var_c0f636f9 = undefined;
	}
}

/*
	Name: soul_release
	Namespace: namespace_4e1a75d3
	Checksum: 0x492F5282
	Offset: 0xE78
	Size: 0xBC
	Parameters: 7
	Flags: None
*/
function soul_release(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_51c7bc3539ed5540"], self, "tag_origin");
	}
	else
	{
		util::playfxontag(localclientnum, level._effect[#"hash_68213763a7707b92"], self, "tag_origin");
	}
}

/*
	Name: function_9bc657a7
	Namespace: namespace_4e1a75d3
	Checksum: 0x2E75505C
	Offset: 0xF40
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_9bc657a7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	util::playfxontag(localclientnum, level._effect[#"fx_steam_lab_dry_ice"], self, "tag_origin");
}

/*
	Name: function_d2bee3bb
	Namespace: namespace_4e1a75d3
	Checksum: 0xC45B6276
	Offset: 0xFC0
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function function_d2bee3bb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self.fx = util::playfxontag(localclientnum, level._effect[#"hash_675f4b19e646ca6c"], self, "tag_origin");
	}
	else
	{
		stopfx(localclientnum, self.fx);
	}
}

/*
	Name: portal_map_to_nuclear_state
	Namespace: namespace_4e1a75d3
	Checksum: 0xF86B80CB
	Offset: 0x1078
	Size: 0x420
	Parameters: 7
	Flags: Linked
*/
function portal_map_to_nuclear_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	var_c5a72006[0] = "tag_green_house_backyard";
	var_c5a72006[1] = "tag_red_house";
	var_c5a72006[2] = "tag_yellow_house";
	var_c5a72006[3] = "tag_prisoner_holding";
	var_c5a72006[4] = "tag_street_middle";
	var_c5a72006[5] = "tag_transfusion_facility";
	var_9bedcd54[0] = "tag_green_house";
	var_9bedcd54[1] = "tag_yellow_house";
	var_9bedcd54[2] = "tag_obrien_house";
	var_9bedcd54[3] = "tag_reinsel_house";
	var_9bedcd54[4] = "tag_hammond_house";
	var_9bedcd54[5] = "tag_hoggatt_house";
	var_ad6ace0d[0] = "tag_start_chest1";
	var_ad6ace0d[1] = "tag_start_chest2";
	var_ad6ace0d[2] = "tag_green_backyard_chest";
	var_ad6ace0d[3] = "tag_yellow_backyard_chest";
	var_ad6ace0d[4] = "tag_cul_de_sac_chest";
	var_8f14a19 = getentarray(localclientnum, "portal_map", "targetname");
	foreach(var_35f97c42 in var_8f14a19)
	{
		foreach(var_3f45d971 in var_c5a72006)
		{
			var_35f97c42 hidepart(localclientnum, var_3f45d971 + "_active");
			var_35f97c42 hidepart(localclientnum, var_3f45d971 + "_on");
		}
		foreach(var_e2d1b938 in var_9bedcd54)
		{
			var_35f97c42 hidepart(localclientnum, var_e2d1b938 + "_clear");
			var_35f97c42 showpart(localclientnum, var_e2d1b938 + "_clogged");
		}
		foreach(var_8b8b176b in var_ad6ace0d)
		{
			var_35f97c42 hidepart(localclientnum, var_8b8b176b);
		}
		var_35f97c42 showpart(localclientnum, "tag_nuked_lights");
	}
}

