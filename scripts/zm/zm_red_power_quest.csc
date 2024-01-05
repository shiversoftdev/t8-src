// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\perk\zm_perk_electric_cherry.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\beam_shared.csc;
#using scripts\core_common\array_shared.csc;

#namespace zm_red_power_quest;

/*
	Name: init
	Namespace: zm_red_power_quest
	Checksum: 0xC9459725
	Offset: 0x1C8
	Size: 0x8F2
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("actor", "" + #"zombie_breakout", 16000, 1, "counter", &zombie_breakout_func, 0, 0);
	clientfield::register("actor", "" + #"zombie_delete", 16000, 1, "counter", &function_638482f6, 0, 0);
	clientfield::register("actor", "" + #"hash_6d5686b05e69fcb0", 16000, 1, "counter", &function_988637e5, 0, 0);
	clientfield::register("actor", "" + #"pegasus_beam", 16000, 2, "int", &pegasus_beam_fx, 0, 0);
	if(!zm_utility::is_trials())
	{
		clientfield::register("scriptmover", "" + #"hash_440ca00839d907a8", -17000, 1, "int", &function_785a67c5, 0, 0);
	}
	clientfield::register("scriptmover", "" + #"hash_2a586a321116326c", 16000, 1, "int", &function_cca9b50e, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_3ec0452110ea5621", 16000, 1, "int", &function_8d9ce264, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_5da65e20d966c63f", 16000, 1, "counter", &function_cb64dcb1, 0, 0);
	clientfield::register("scriptmover", "" + #"artifact_glow", 16000, 1, "int", &artifact_fx, 0, 0);
	clientfield::register("scriptmover", "" + #"perseus_teleport", 16000, 1, "counter", &function_bc717eee, 0, 0);
	clientfield::register("scriptmover", "" + #"pegasus_teleport", 16000, 1, "int", &function_7993c728, 0, 0);
	clientfield::register("scriptmover", "" + #"pegasus_ambient", 16000, 1, "int", &function_ee7e8a00, 0, 0);
	clientfield::register("vehicle", "" + #"hash_5da65e20d966c63f", 16000, 1, "counter", &function_cb64dcb1, 0, 0);
	clientfield::register("vehicle", "" + #"hash_463ff879b8d656bb", 16000, 1, "int", &function_c96c5397, 0, 0);
	clientfield::register("vehicle", "" + #"perseus_energy", 16000, 1, "int", &function_192be936, 0, 0);
	clientfield::register("world", "" + #"amphi_blood", 16000, 1, "int", &function_5f8c1946, 0, 0);
	level._effect[#"hash_6d5686b05e69fcb0"] = #"zombie/fx_spawn_body_cp_zmb";
	level._effect[#"hash_440ca00839d907a8"] = #"hash_4c14004cd89a0d66";
	level._effect[#"hash_2a586a321116326c"] = #"hash_7770e29dfcabc1cb";
	level._effect[#"hash_3ec0452110ea5621"] = #"hash_28e306b2b1b0a110";
	level._effect[#"hash_5da65e20d966c63f"] = #"hash_54b810af1fb36d6d";
	level._effect[#"hash_463ff879b8d656bb"] = #"hash_57817f8de95527cd";
	level._effect[#"artifact_glow"] = #"hash_4c14004cd89a0d66";
	level._effect[#"zombie_delete"] = #"maps/zm_office/fx8_teleporter_destination";
	level._effect[#"chaos_breakout"] = #"hash_7e6fa9ad6b551a7d";
	level._effect[#"perseus_teleport"] = #"hash_230a59dd0d0f7361";
	level._effect[#"perseus_energy"] = #"hash_6009053e911b946a";
	level._effect[#"zombie_shock"] = #"zm_ai/fx8_elec_shock_eyes";
	level._effect[#"pegasus_teleport"] = #"hash_5f7d8c231fbcf09e";
	level._effect[#"hash_672766c8e292cfbf"] = #"hash_1615f2a383a626ca";
	level._effect[#"hash_67277cc8e292f521"] = #"hash_16460aa383cf7354";
	level._effect[#"hash_33d5355e9824552e"] = #"hash_4368d718964d6faf";
	level._effect[#"hash_33d51f5e98242fcc"] = #"hash_4362bf189648db39";
	level._effect[#"shield_gegenees"] = #"hash_1807ad62ba867a20";
}

/*
	Name: function_ee7e8a00
	Namespace: zm_red_power_quest
	Checksum: 0x37F974AE
	Offset: 0xAC8
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_ee7e8a00(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		util::playfxontag(localclientnum, level._effect[#"shield_gegenees"], self, "tag_origin");
	}
}

/*
	Name: function_5f8c1946
	Namespace: zm_red_power_quest
	Checksum: 0xA53705E7
	Offset: 0xB58
	Size: 0x248
	Parameters: 7
	Flags: Linked
*/
function function_5f8c1946(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	a_n_decals = findvolumedecalindexarray("event_stairs_blood");
	var_7a5e182b = findvolumedecalindexarray("event_after_chaos_floor");
	foreach(var_157cdddc in var_7a5e182b)
	{
		hidevolumedecal(var_157cdddc);
	}
	if(newval == 1)
	{
		foreach(n_decal in a_n_decals)
		{
			hidevolumedecal(n_decal);
		}
		foreach(var_157cdddc in var_7a5e182b)
		{
			unhidevolumedecal(var_157cdddc);
		}
	}
	else
	{
		foreach(n_decal in a_n_decals)
		{
			unhidevolumedecal(n_decal);
		}
	}
}

/*
	Name: function_bc717eee
	Namespace: zm_red_power_quest
	Checksum: 0xE1A193F3
	Offset: 0xDA8
	Size: 0x104
	Parameters: 7
	Flags: Linked
*/
function function_bc717eee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self gettagorigin("j_spine4")))
	{
		playfx(localclientnum, level._effect[#"perseus_teleport"], self gettagorigin("j_spine4"), anglestoup(self.angles));
		playsound(localclientnum, #"hash_20e6275c6513eb95", self gettagorigin("j_spine4"));
	}
}

/*
	Name: function_7993c728
	Namespace: zm_red_power_quest
	Checksum: 0xB2B1D048
	Offset: 0xEB8
	Size: 0x1FE
	Parameters: 7
	Flags: Linked
*/
function function_7993c728(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(!isdefined(self.var_f252bba1))
		{
			self.var_f252bba1 = playfx(localclientnum, level._effect[#"pegasus_teleport"], self gettagorigin("j_h_chest"), self gettagangles("j_h_chest"));
		}
		util::playfxontag(localclientnum, level._effect[#"hash_672766c8e292cfbf"], self, "j_winghumerus_le");
		util::playfxontag(localclientnum, level._effect[#"hash_67277cc8e292f521"], self, "j_winghumerus_ri");
		util::playfxontag(localclientnum, level._effect[#"hash_33d5355e9824552e"], self, "j_wingulna_le");
		util::playfxontag(localclientnum, level._effect[#"hash_33d51f5e98242fcc"], self, "j_wingulna_ri");
		forcestreamxmodel(#"c_t8_zmb_dlc2_pegasus_fb");
	}
	else if(isdefined(self.var_f252bba1))
	{
		stopfx(localclientnum, self.var_f252bba1);
		self.var_f252bba1 = undefined;
	}
}

/*
	Name: zombie_breakout_func
	Namespace: zm_red_power_quest
	Checksum: 0x648F446D
	Offset: 0x10C0
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function zombie_breakout_func(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"chaos_breakout"], self, "tag_origin");
	playsound(localclientnum, #"hash_496f85c0590828ba", self.origin + vectorscale((0, 0, 1), 25));
}

/*
	Name: pegasus_beam_fx
	Namespace: zm_red_power_quest
	Checksum: 0xF26EE52B
	Offset: 0x1178
	Size: 0x1AC
	Parameters: 7
	Flags: Linked
*/
function pegasus_beam_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	var_10d4f67d = level.var_1c8295a8;
	if(!isdefined(var_10d4f67d))
	{
		return;
	}
	str_tag = self zm_utility::function_467efa7b();
	if(!isdefined(str_tag))
	{
		return;
	}
	if(newval == 1)
	{
		if(isdefined(var_10d4f67d gettagorigin("j_feather_le_10")))
		{
			var_30d0dc85 = "j_feather_le_10";
		}
		else
		{
			var_30d0dc85 = "tag_origin";
		}
	}
	else if(newval == 2)
	{
		var_30d0dc85 = "j_feather_ri_10";
	}
	level beam::launch(var_10d4f67d, var_30d0dc85, self, str_tag, "beam8_zm_red_peg_lightning_strike", 1);
	self playsound(localclientnum, #"hash_61c057ffadb7a5af");
	level thread chaos_explosion(localclientnum);
	wait(0.3);
	level beam::kill(var_10d4f67d, var_30d0dc85, self, str_tag, "beam8_zm_red_peg_lightning_strike");
}

/*
	Name: chaos_explosion
	Namespace: zm_red_power_quest
	Checksum: 0xF481587D
	Offset: 0x1330
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function chaos_explosion(localclientnum)
{
	s_chaos = array::random(struct::get_array("chaos_exp"));
	wait(randomfloatrange(0.2, 1));
	playfx(localclientnum, level._effect[#"chaos_breakout"], s_chaos.origin);
}

/*
	Name: artifact_fx
	Namespace: zm_red_power_quest
	Checksum: 0x83A405BC
	Offset: 0x13D0
	Size: 0xC6
	Parameters: 7
	Flags: Linked
*/
function artifact_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.n_fx = util::playfxontag(localclientnum, level._effect[#"artifact_glow"], self, "tag_origin");
	}
	else if(isdefined(self.n_fx))
	{
		stopfx(localclientnum, self.n_fx);
		self.n_fx = undefined;
	}
}

/*
	Name: function_638482f6
	Namespace: zm_red_power_quest
	Checksum: 0x1F47C5C3
	Offset: 0x14A0
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_638482f6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"zombie_delete"], self, "tag_origin");
}

/*
	Name: function_988637e5
	Namespace: zm_red_power_quest
	Checksum: 0x1D96DF07
	Offset: 0x1520
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_988637e5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	playfx(localclientnum, level._effect[#"hash_6d5686b05e69fcb0"], self.origin);
}

/*
	Name: function_785a67c5
	Namespace: zm_red_power_quest
	Checksum: 0x12732DE7
	Offset: 0x15A0
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_785a67c5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_bf45a811 = util::playfxontag(localclientnum, level._effect[#"hash_440ca00839d907a8"], self, "tag_origin");
	}
	else if(isdefined(self.var_bf45a811))
	{
		stopfx(localclientnum, self.var_bf45a811);
		self.var_bf45a811 = undefined;
	}
}

/*
	Name: function_8d9ce264
	Namespace: zm_red_power_quest
	Checksum: 0xE6670930
	Offset: 0x1668
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_8d9ce264(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_7697647a = util::playfxontag(localclientnum, level._effect[#"hash_3ec0452110ea5621"], self, "tag_origin");
	}
	else if(isdefined(self.var_7697647a))
	{
		stopfx(localclientnum, self.var_7697647a);
		self.var_7697647a = undefined;
	}
}

/*
	Name: function_cca9b50e
	Namespace: zm_red_power_quest
	Checksum: 0x5F7FAA3B
	Offset: 0x1730
	Size: 0x1EE
	Parameters: 7
	Flags: Linked
*/
function function_cca9b50e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_bf45a811 = util::playfxontag(localclientnum, level._effect[#"hash_440ca00839d907a8"], self, "tag_origin");
		mdl_fx = util::spawn_model(localclientnum, #"tag_origin", self.origin);
		self.var_6ec79371 = mdl_fx;
		self.staff_fallen = util::playfxontag(localclientnum, level._effect[#"hash_2a586a321116326c"], mdl_fx, "tag_origin");
		mdl_fx thread function_7152ba7c(self);
		mdl_fx thread function_1bad7fac(localclientnum);
	}
	else
	{
		if(isdefined(self.var_bf45a811))
		{
			stopfx(localclientnum, self.var_bf45a811);
			self.var_bf45a811 = undefined;
		}
		if(isdefined(self.var_6ec79371))
		{
			self.var_6ec79371 unlink();
			self.var_6ec79371 delete();
			self.var_6ec79371 = undefined;
		}
		if(isdefined(self.staff_fallen))
		{
			stopfx(localclientnum, self.staff_fallen);
			self.staff_fallen = undefined;
		}
	}
}

/*
	Name: function_7152ba7c
	Namespace: zm_red_power_quest
	Checksum: 0xCC300322
	Offset: 0x1928
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function function_7152ba7c(mdl_artifact)
{
	self endon(#"death");
	mdl_artifact endon(#"death");
	while(true)
	{
		self.origin = mdl_artifact.origin;
		waitframe(1);
	}
}

/*
	Name: function_1bad7fac
	Namespace: zm_red_power_quest
	Checksum: 0xAFE96925
	Offset: 0x1988
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_1bad7fac(localclientnum)
{
	self endon(#"death");
	while(true)
	{
		e_player = function_5c10bd79(localclientnum);
		if(isdefined(e_player))
		{
			v_angles = vectortoangles(e_player.origin - self.origin);
			self.angles = v_angles;
		}
		waitframe(1);
	}
}

/*
	Name: function_cb64dcb1
	Namespace: zm_red_power_quest
	Checksum: 0x171F534C
	Offset: 0x1A28
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_cb64dcb1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_5da65e20d966c63f"], self, "tag_origin");
}

/*
	Name: function_c96c5397
	Namespace: zm_red_power_quest
	Checksum: 0x70CC62F3
	Offset: 0x1AA8
	Size: 0x134
	Parameters: 7
	Flags: Linked
*/
function function_c96c5397(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(!isdefined(self.n_fx))
		{
			self.n_fx = util::playfxontag(localclientnum, level._effect[#"hash_463ff879b8d656bb"], self, "tag_origin");
		}
		if(!isdefined(self.n_sfx))
		{
			self.n_sfx = self playloopsound(#"hash_6d3093fa5bbbbe2f");
		}
	}
	else
	{
		if(isdefined(self.n_fx))
		{
			stopfx(localclientnum, self.n_fx);
			self.n_fx = undefined;
		}
		if(isdefined(self.n_sfx))
		{
			self stoploopsound(self.n_sfx);
		}
	}
}

/*
	Name: function_192be936
	Namespace: zm_red_power_quest
	Checksum: 0x323EC426
	Offset: 0x1BE8
	Size: 0x15C
	Parameters: 7
	Flags: Linked
*/
function function_192be936(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(!isdefined(self.var_576a8cab))
		{
			self.var_576a8cab = util::playfxontag(localclientnum, level._effect[#"perseus_energy"], self, "tag_origin");
		}
		if(!isdefined(self.var_fc40818b))
		{
			self playsound(localclientnum, #"hash_10f7dee939554f61");
			self.var_fc40818b = self playloopsound(#"hash_474d2ea03ea86530");
		}
	}
	else
	{
		if(isdefined(self.var_576a8cab))
		{
			stopfx(localclientnum, self.var_576a8cab);
			self.var_576a8cab = undefined;
		}
		if(isdefined(self.var_fc40818b))
		{
			self stoploopsound(self.var_fc40818b);
		}
	}
}

