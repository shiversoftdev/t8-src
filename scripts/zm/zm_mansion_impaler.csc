// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_weapons.csc;
#using scripts\zm_common\zm_wallbuy.csc;
#using scripts\zm_common\zm_utility.csc;
#using script_624a704d0f6bf28d;
#using scripts\zm_common\zm_pack_a_punch.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\load.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace mansion_impaler;

/*
	Name: init_clientfields
	Namespace: mansion_impaler
	Checksum: 0x7EECD214
	Offset: 0x128
	Size: 0x3E2
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"candle_light", 8000, 1, "int", &function_7b2555da, 0, 0);
	clientfield::register("scriptmover", "" + #"monolith_water", 8000, 1, "int", &function_5755829d, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_4d45dc65a8307183", 8000, 1, "counter", &function_7fb1dad8, 0, 0);
	clientfield::register("actor", "" + #"soul_possess", 8000, 1, "int", &function_46354b9d, 0, 0);
	clientfield::register("toplayer", "" + #"hash_3d7d4c5e6ed616e9", 8000, 1, "int", &function_5790d8f, 0, 1);
	clientfield::register("scriptmover", "" + #"jewelry_dropped", 8000, 1, "int", &function_4e782d34, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_3d5a64bed5e39d24", 8000, 1, "int", &function_3f039efc, 0, 0);
	clientfield::register("world", "" + #"hash_73123721764d7374", 8000, 1, "int", &function_12852d1a, 0, 0);
	level._effect[#"candle_light"] = #"hash_7c3ce9a7a1d0be65";
	level._effect[#"candle_extinguish"] = #"hash_46177358e1ae4e80";
	level._effect[#"monolith_water"] = #"hash_4290601f9ae7b873";
	level._effect[#"hash_4d45dc65a8307183"] = #"hash_59977c4c851916e0";
	level._effect[#"soul_possess"] = #"hash_5ea48c095e439dd3";
	level._effect[#"jewelry_dropped"] = #"hash_69fe2bd378e08226";
}

/*
	Name: function_7b2555da
	Namespace: mansion_impaler
	Checksum: 0x90665AE2
	Offset: 0x518
	Size: 0x19E
	Parameters: 7
	Flags: Linked
*/
function function_7b2555da(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(!isdefined(self.var_55e883de))
		{
			self.var_55e883de = playfx(localclientnum, level._effect[#"candle_light"], self.origin + vectorscale((0, 0, 1), 2.7), anglestoforward(self.angles), anglestoup(self.angles));
		}
	}
	else if(isdefined(self.var_55e883de))
	{
		killfx(localclientnum, self.var_55e883de);
		playfx(localclientnum, level._effect[#"candle_extinguish"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
		playsound(localclientnum, #"hash_50692f39387dddd", self.origin);
		self.var_55e883de = undefined;
	}
}

/*
	Name: function_5755829d
	Namespace: mansion_impaler
	Checksum: 0xF3C3BB8A
	Offset: 0x6C0
	Size: 0xFE
	Parameters: 7
	Flags: Linked
*/
function function_5755829d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(!isdefined(self.var_b064082f))
		{
			self.var_b064082f = playfx(localclientnum, level._effect[#"monolith_water"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
		}
	}
	else if(isdefined(self.var_b064082f))
	{
		stopfx(localclientnum, self.var_b064082f);
		self.var_b064082f = undefined;
	}
}

/*
	Name: function_46354b9d
	Namespace: mansion_impaler
	Checksum: 0x1E6057F2
	Offset: 0x7C8
	Size: 0x11E
	Parameters: 7
	Flags: Linked
*/
function function_46354b9d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(!isdefined(self.var_c3a33b28))
		{
			self.var_c3a33b28 = util::playfxontag(localclientnum, level._effect[#"soul_possess"], self, "j_spine4");
			self playsound(localclientnum, #"hash_4826261b01f96036");
			zmb_soul = self playloopsound(#"hash_298631572be3dd79");
		}
	}
	else if(isdefined(self.var_c3a33b28))
	{
		stopfx(localclientnum, self.var_c3a33b28);
		self.var_c3a33b28 = undefined;
	}
}

/*
	Name: function_7fb1dad8
	Namespace: mansion_impaler
	Checksum: 0xE9C03897
	Offset: 0x8F0
	Size: 0xC6
	Parameters: 7
	Flags: Linked
*/
function function_7fb1dad8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_4d45dc65a8307183"], self, "tag_origin");
	self playsound(localclientnum, #"hash_72a28324d62874cc");
	var_3e97d494 = self playloopsound(#"hash_298631572be3dd79");
}

/*
	Name: function_5790d8f
	Namespace: mansion_impaler
	Checksum: 0x918D89B2
	Offset: 0x9C0
	Size: 0x146
	Parameters: 7
	Flags: Linked
*/
function function_5790d8f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self thread postfx::playpostfxbundle(#"hash_68521343993746c2");
		if(!isdefined(self.var_ab7bde88))
		{
			self playsound(localclientnum, #"hash_397f465deff1747b");
			self.var_ab7bde88 = self playloopsound(#"hash_29b43b594c795551");
		}
	}
	else
	{
		self postfx::stoppostfxbundle(#"hash_68521343993746c2");
		if(isdefined(self.var_ab7bde88))
		{
			self stoploopsound(self.var_ab7bde88);
			self playsound(localclientnum, #"hash_45d8c3fdcaaf772a");
			self.var_ab7bde88 = undefined;
		}
	}
}

/*
	Name: function_4e782d34
	Namespace: mansion_impaler
	Checksum: 0xC364A96C
	Offset: 0xB10
	Size: 0x1FE
	Parameters: 7
	Flags: Linked
*/
function function_4e782d34(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		if(!isdefined(self.var_dd761cc9))
		{
			self.var_dd761cc9 = util::playfxontag(localclientnum, level._effect[#"jewelry_dropped"], self, "tag_origin");
			playsound(localclientnum, #"hash_6dda9e544bcd6f0d", self.origin);
			if(self.model == #"p8_zm_man_watch_pocket_gold")
			{
				var_a0cc5b31 = self playloopsound(#"hash_5354467970ab7b00");
			}
			if(self.model == #"p8_zm_man_jewelry_ring")
			{
				var_a0cc5b31 = self playloopsound(#"hash_1555e7c9f5c441db");
			}
			if(self.model == #"p8_zm_man_jewelry_necklace")
			{
				var_a0cc5b31 = self playloopsound(#"hash_21148ffbe9af801d");
			}
			if(self.model == #"p8_zm_man_jewelry_bracelet")
			{
				var_a0cc5b31 = self playloopsound(#"hash_35715829aad8de55");
			}
		}
	}
	else if(isdefined(self.var_dd761cc9))
	{
		stopfx(localclientnum, self.var_6f41492);
		self.var_6f41492 = undefined;
	}
}

/*
	Name: function_3f039efc
	Namespace: mansion_impaler
	Checksum: 0xAB49447
	Offset: 0xD18
	Size: 0xFC
	Parameters: 7
	Flags: Linked
*/
function function_3f039efc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self stoprenderoverridebundle(#"hash_3b7b44b7a440e5f");
		self playrenderoverridebundle(#"hash_3d9f08ef1b60239e");
		if(self.model == #"hash_2b87b734e194ea79")
		{
			level notify(#"hash_5a1a7e205b6f5b88");
		}
	}
	else
	{
		self stoprenderoverridebundle(#"hash_3d9f08ef1b60239e");
		self playrenderoverridebundle(#"hash_3b7b44b7a440e5f");
	}
}

/*
	Name: function_12852d1a
	Namespace: mansion_impaler
	Checksum: 0x257656C2
	Offset: 0xE20
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function function_12852d1a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	function_a5777754(localclientnum, "cemetery_area_01");
}

