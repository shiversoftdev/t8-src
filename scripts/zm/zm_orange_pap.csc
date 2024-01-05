// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace zm_orange_pap;

/*
	Name: init
	Namespace: zm_orange_pap
	Checksum: 0x10D5A108
	Offset: 0x138
	Size: 0x72
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_clientfields();
	level._effect[#"hash_604a40ef1ed899a4"] = #"hash_7d36c353ea2640ad";
	level._effect[#"hash_74f5897234e8d579"] = #"hash_59c49f21e6675534";
}

/*
	Name: init_clientfields
	Namespace: zm_orange_pap
	Checksum: 0x600410D
	Offset: 0x1B8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("world", "zm_orange_extinguish_fire", 24000, 2, "counter", &function_f65638a4, 0, 0);
	clientfield::register("scriptmover", "zm_orange_pap_rock_glow", 24000, 1, "int", &function_50758ed4, 0, 0);
}

/*
	Name: function_f65638a4
	Namespace: zm_orange_pap
	Checksum: 0x49AD9CB0
	Offset: 0x258
	Size: 0x154
	Parameters: 7
	Flags: Linked
*/
function function_f65638a4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		s_fx = struct::get("fire_extinguisher_l_fx_struct", "targetname");
		playfx(localclientnum, level._effect[#"hash_604a40ef1ed899a4"], s_fx.origin, anglestoforward(s_fx.angles));
	}
	else if(newval == 2)
	{
		s_fx = struct::get("fire_extinguisher_r_fx_struct", "targetname");
		playfx(localclientnum, level._effect[#"hash_604a40ef1ed899a4"], s_fx.origin, anglestoforward(s_fx.angles));
	}
}

/*
	Name: function_50758ed4
	Namespace: zm_orange_pap
	Checksum: 0x988730E9
	Offset: 0x3B8
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_50758ed4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, level._effect[#"hash_74f5897234e8d579"], self, "tag_origin");
}

