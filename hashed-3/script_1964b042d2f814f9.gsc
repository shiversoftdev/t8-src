// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_624a704d0f6bf28d;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_379af75a;

/*
	Name: preload
	Namespace: namespace_379af75a
	Checksum: 0x4E753469
	Offset: 0x1C0
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	level._effect[#"hash_6917a07f5944f8de"] = #"hash_59977c4c851916e0";
	level._effect[#"hash_6d2d7bab75c2c0"] = #"hash_1a06427eff8dfe13";
	level._effect[#"hash_3a4cca038b97b169"] = #"hash_487863cb3f012833";
	level._effect[#"hash_49758e8a3645e2b0"] = #"hash_6d8c75ffdf65fe0";
	init_clientfields();
	forcestreamxmodel("p8_zm_ora_specimen_container_lrg_cracked");
	forcestreamxmodel("p8_zm_ora_specimen_container_lrg_dmg");
	forcestreamxmodel("p8_zm_ora_yellow_snowball_pile");
}

/*
	Name: main
	Namespace: namespace_379af75a
	Checksum: 0x80F724D1
	Offset: 0x2E8
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function main()
{
}

/*
	Name: init_clientfields
	Namespace: namespace_379af75a
	Checksum: 0x515BBBEE
	Offset: 0x2F8
	Size: 0x214
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	namespace_617a54f4::function_d8383812(#"snowball_campfire_1", 24000, "snowball_campfire_1", 400, level._effect[#"hash_6917a07f5944f8de"], level._effect[#"hash_6d2d7bab75c2c0"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"snowball_campfire_2", 24000, "snowball_campfire_2", 400, level._effect[#"hash_6917a07f5944f8de"], level._effect[#"hash_6d2d7bab75c2c0"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"snowball_campfire_3", 24000, "snowball_campfire_3", 400, level._effect[#"hash_6917a07f5944f8de"], level._effect[#"hash_6d2d7bab75c2c0"], undefined, undefined, 1);
	clientfield::register("scriptmover", "fx8_reward_brazier_fire_blue", 24000, 1, "int", &function_6c0434ba, 0, 0);
	clientfield::register("scriptmover", "fx8_snowpile_swap", 24000, 1, "int", &function_7e05738b, 0, 0);
	clientfield::register("toplayer", "spleen_carry_sound", 20000, 1, "int", &spleen_carry_sound, 0, 0);
}

/*
	Name: function_6c0434ba
	Namespace: namespace_379af75a
	Checksum: 0xFB900E4B
	Offset: 0x518
	Size: 0x82
	Parameters: 7
	Flags: Linked
*/
function function_6c0434ba(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.fx_sparks = util::playfxontag(localclientnum, level._effect[#"hash_3a4cca038b97b169"], self, "tag_origin");
	}
}

/*
	Name: function_7e05738b
	Namespace: namespace_379af75a
	Checksum: 0x122BC02A
	Offset: 0x5A8
	Size: 0x82
	Parameters: 7
	Flags: Linked
*/
function function_7e05738b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.fx_sparks = util::playfxontag(localclientnum, level._effect[#"hash_49758e8a3645e2b0"], self, "tag_origin");
	}
}

/*
	Name: spleen_carry_sound
	Namespace: namespace_379af75a
	Checksum: 0x6145674E
	Offset: 0x638
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function spleen_carry_sound(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self.var_b93060b3 = self playloopsound(#"hash_59783b8d2accba79");
	}
	else
	{
		self playsound(localclientnum, #"hash_37f5db96bc2147cd");
		self stoploopsound(self.var_b93060b3);
		self.var_b93060b3 = undefined;
	}
}

