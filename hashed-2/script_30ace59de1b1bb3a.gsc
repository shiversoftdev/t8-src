// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_12282e6b2cc91b42;
#using script_1611421ee9b880d3;
#using script_1d99711a5c22bdef;
#using script_624a704d0f6bf28d;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\load.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_pack_a_punch.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace namespace_1bf74f9e;

/*
	Name: init
	Namespace: namespace_1bf74f9e
	Checksum: 0x44786535
	Offset: 0x110
	Size: 0x5A2
	Parameters: 0
	Flags: Linked
*/
function init()
{
	if(namespace_59ff1d6c::function_901b751c(#"hash_541a4d5c476468f4"))
	{
		clientfield::register("scriptmover", "" + #"hash_63ffcbb6c8f4bc11", 8000, 1, "int", &function_41ad73f5, 0, 0);
		clientfield::register("scriptmover", "" + #"hash_62ee80337662b3cd", 8000, 1, "int", &function_3ab850d6, 0, 0);
		clientfield::register("scriptmover", "" + #"hash_7ef82b98770c5c0d", 8000, 1, "int", &function_c08eda18, 0, 0);
		clientfield::register("scriptmover", "" + #"hash_c0e8acbde8dbc06", 8000, 1, "int", &function_9c99bb9c, 0, 0);
		clientfield::register("vehicle", "" + #"hash_6ded20ebb8e016ba", 8000, 1, "int", &function_d19e8c30, 0, 0);
		clientfield::register("scriptmover", "" + #"hash_48c6d058e9587c19", 8000, 1, "int", &function_2a76a74e, 0, 0);
		clientfield::register("world", "" + #"hash_19f5ea0e9b3d47f3", 8000, 1, "int", &function_6bc1e300, 0, 0);
		clientfield::register("scriptmover", "" + #"hash_486960f190957256", 8000, 1, "int", &function_fdbcb111, 0, 0);
		clientfield::register("scriptmover", "" + #"hash_12e4702a9346b3d9", 8000, 1, "int", &function_d96d1ec8, 0, 0);
		clientfield::register("scriptmover", "" + #"ww_lvl3_crafting_table_fx", 8000, 1, "int", &ww_lvl3_crafting_table_fx, 0, 0);
		level._effect[#"hash_63ffcbb6c8f4bc11"] = #"hash_9c1cc9cff68a30b";
		level._effect[#"hash_62ee80337662b3cd"] = #"hash_d49412589217ae5";
		level._effect[#"hash_7ef82b98770c5c0d"] = #"hash_5faeba7ac14ce809";
		level._effect[#"hash_48c6d058e9587c19"] = #"hash_26219308102ab88";
		level._effect[#"hash_1789fef86cd8b57e"] = #"hash_6155f098cde9b5d6";
		level._effect[#"hash_6ded20ebb8e016ba"] = #"hash_12294859753682f";
		level._effect[#"hash_c0e8acbde8dbc06"] = #"hash_3c302e20c7521265";
		level._effect[#"hash_1e5190677354bcbb"] = #"hash_43db5529d30606a4";
		level._effect[#"hash_12e4702a9346b3d9"] = #"hash_6f5790d353dd5caf";
		level._effect[#"hash_486960f190957256"] = #"hash_6c903fa4abc8dbaa";
		level._effect[#"ww_lvl3_crafting_table_fx"] = #"hash_2a894b9650914bb6";
	}
}

/*
	Name: function_41ad73f5
	Namespace: namespace_1bf74f9e
	Checksum: 0xE16DA332
	Offset: 0x6C0
	Size: 0xB2
	Parameters: 7
	Flags: Linked
*/
function function_41ad73f5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_30b1857a))
	{
		stopfx(localclientnum, self.var_30b1857a);
		self.var_30b1857a = undefined;
	}
	if(newval)
	{
		self.var_30b1857a = util::playfxontag(localclientnum, level._effect[#"hash_63ffcbb6c8f4bc11"], self, "tag_origin");
	}
}

/*
	Name: function_3ab850d6
	Namespace: namespace_1bf74f9e
	Checksum: 0x26BA68CF
	Offset: 0x780
	Size: 0xB2
	Parameters: 7
	Flags: Linked
*/
function function_3ab850d6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_30b1857a))
	{
		stopfx(localclientnum, self.var_30b1857a);
		self.var_30b1857a = undefined;
	}
	if(newval)
	{
		self.var_30b1857a = util::playfxontag(localclientnum, level._effect[#"hash_62ee80337662b3cd"], self, "tag_origin");
	}
}

/*
	Name: function_c08eda18
	Namespace: namespace_1bf74f9e
	Checksum: 0xABBE797D
	Offset: 0x840
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_c08eda18(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		playfx(localclientnum, level._effect[#"hash_7ef82b98770c5c0d"], self.origin);
	}
}

/*
	Name: function_d19e8c30
	Namespace: namespace_1bf74f9e
	Checksum: 0x2F76424D
	Offset: 0x8C8
	Size: 0xEA
	Parameters: 7
	Flags: Linked
*/
function function_d19e8c30(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_7dbec3d0))
	{
		stopfx(localclientnum, self.var_7dbec3d0);
		self.var_7dbec3d0 = undefined;
	}
	if(newval)
	{
		if(self.archetype === #"bat")
		{
			str_tag = "tag_chest_ws";
		}
		else
		{
			str_tag = "tag_origin";
		}
		self.var_7dbec3d0 = self util::playfxontag(localclientnum, level._effect[#"hash_6ded20ebb8e016ba"], self, str_tag);
	}
}

/*
	Name: function_9c99bb9c
	Namespace: namespace_1bf74f9e
	Checksum: 0x5329BCDB
	Offset: 0x9C0
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_9c99bb9c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::playfxontag(localclientnum, level._effect[#"hash_c0e8acbde8dbc06"], self, "tag_origin");
}

/*
	Name: function_2a76a74e
	Namespace: namespace_1bf74f9e
	Checksum: 0xF3419159
	Offset: 0xA40
	Size: 0xEA
	Parameters: 7
	Flags: Linked
*/
function function_2a76a74e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_25092f46))
	{
		stopfx(localclientnum, self.var_25092f46);
		self.var_25092f46 = undefined;
		playfx(localclientnum, level._effect[#"hash_1789fef86cd8b57e"], self.origin);
	}
	if(newval)
	{
		self.var_25092f46 = self util::playfxontag(localclientnum, level._effect[#"hash_48c6d058e9587c19"], self, "tag_origin");
	}
}

/*
	Name: function_6bc1e300
	Namespace: namespace_1bf74f9e
	Checksum: 0x3E1E1F38
	Offset: 0xB38
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_6bc1e300(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		forcestreamxmodel(#"hash_36f02881e6dba006");
	}
	else
	{
		stopforcestreamingxmodel(#"hash_36f02881e6dba006");
	}
}

/*
	Name: function_fdbcb111
	Namespace: namespace_1bf74f9e
	Checksum: 0x68BF350A
	Offset: 0xBD0
	Size: 0xB2
	Parameters: 7
	Flags: Linked
*/
function function_fdbcb111(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_ebc53fb1))
	{
		stopfx(localclientnum, self.var_ebc53fb1);
		self.var_ebc53fb1 = undefined;
	}
	if(newval)
	{
		self.var_ebc53fb1 = util::playfxontag(localclientnum, level._effect[#"hash_486960f190957256"], self, "tag_origin");
	}
}

/*
	Name: function_ea733c8f
	Namespace: namespace_1bf74f9e
	Checksum: 0x2F81538C
	Offset: 0xC90
	Size: 0x7C
	Parameters: 7
	Flags: None
*/
function function_ea733c8f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_1e5190677354bcbb"], self, "tag_origin");
	}
}

/*
	Name: function_d96d1ec8
	Namespace: namespace_1bf74f9e
	Checksum: 0x8224004E
	Offset: 0xD18
	Size: 0xB2
	Parameters: 7
	Flags: Linked
*/
function function_d96d1ec8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_aea9f9ea))
	{
		stopfx(localclientnum, self.var_aea9f9ea);
		self.var_aea9f9ea = undefined;
	}
	if(newval)
	{
		self.var_aea9f9ea = self util::playfxontag(localclientnum, level._effect[#"hash_12e4702a9346b3d9"], self, "tag_origin");
	}
}

/*
	Name: ww_lvl3_crafting_table_fx
	Namespace: namespace_1bf74f9e
	Checksum: 0x4C79FC
	Offset: 0xDD8
	Size: 0xB2
	Parameters: 7
	Flags: Linked
*/
function ww_lvl3_crafting_table_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_88119a0f))
	{
		stopfx(localclientnum, self.var_88119a0f);
		self.var_88119a0f = undefined;
	}
	if(newval)
	{
		self.var_88119a0f = util::playfxontag(localclientnum, level._effect[#"ww_lvl3_crafting_table_fx"], self, "tag_origin");
	}
}

