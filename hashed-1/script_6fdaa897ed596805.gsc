// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_624a704d0f6bf28d;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_4b68b2b3;

/*
	Name: preload
	Namespace: namespace_4b68b2b3
	Checksum: 0xFAF84FC3
	Offset: 0x108
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	level._effect[#"pap_soul"] = #"hash_59977c4c851916e0";
	level._effect[#"hash_1549a7f7c4a3d66e"] = #"hash_1a06427eff8dfe13";
	level._effect[#"pap_explosion"] = #"hash_c25bcbc2422f364";
	level._effect[#"pap_fire"] = #"hash_4847c0d5a4c9cd6";
	init_clientfields();
}

/*
	Name: main
	Namespace: namespace_4b68b2b3
	Checksum: 0x80F724D1
	Offset: 0x1E8
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function main()
{
}

/*
	Name: init_clientfields
	Namespace: namespace_4b68b2b3
	Checksum: 0x26B8E379
	Offset: 0x1F8
	Size: 0x2BC
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	namespace_617a54f4::function_d8383812(#"sc_pap_beach", 24000, "sc_pap_beach", 400, level._effect[#"pap_soul"], level._effect[#"hash_1549a7f7c4a3d66e"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_pap_boathouse", 24000, "sc_pap_boathouse", 400, level._effect[#"pap_soul"], level._effect[#"hash_1549a7f7c4a3d66e"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_pap_ship", 24000, "sc_pap_ship", 400, level._effect[#"pap_soul"], level._effect[#"hash_1549a7f7c4a3d66e"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_pap_lagoon", 24000, "sc_pap_lagoon", 400, level._effect[#"pap_soul"], level._effect[#"hash_1549a7f7c4a3d66e"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"sc_pap_island", 24000, "sc_pap_island", 400, level._effect[#"pap_soul"], level._effect[#"hash_1549a7f7c4a3d66e"], undefined, undefined, 1);
	clientfield::register("scriptmover", "" + #"hash_411947cf11cffb69", 24000, 1, "int", &pap_explosion, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_249c83f6060ea7ba", 24000, 1, "int", &pap_fire, 0, 0);
}

/*
	Name: pap_explosion
	Namespace: namespace_4b68b2b3
	Checksum: 0x8AF0FC12
	Offset: 0x4C0
	Size: 0x82
	Parameters: 7
	Flags: Linked
*/
function pap_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.fx_explosion = util::playfxontag(localclientnum, level._effect[#"pap_explosion"], self, "tag_origin");
	}
}

/*
	Name: pap_fire
	Namespace: namespace_4b68b2b3
	Checksum: 0x3772DA23
	Offset: 0x550
	Size: 0x82
	Parameters: 7
	Flags: Linked
*/
function pap_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.fx_fire = util::playfxontag(localclientnum, level._effect[#"pap_fire"], self, "tag_origin");
	}
}

