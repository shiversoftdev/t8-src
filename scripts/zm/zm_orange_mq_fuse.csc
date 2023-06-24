// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_624a704d0f6bf28d;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;

#namespace zm_orange_mq_fuse;

/*
	Name: preload
	Namespace: zm_orange_mq_fuse
	Checksum: 0x9659CFF5
	Offset: 0xF8
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	level._effect[#"generator_soul"] = #"hash_59977c4c851916e0";
	level._effect[#"hash_25d427b0d162135a"] = #"hash_1a06427eff8dfe13";
	level._effect[#"elemental_shard_glow"] = #"hash_4310e1cb3f897c7c";
	init_clientfields();
}

/*
	Name: main
	Namespace: zm_orange_mq_fuse
	Checksum: 0x80F724D1
	Offset: 0x1A8
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function main()
{
}

/*
	Name: init_clientfields
	Namespace: zm_orange_mq_fuse
	Checksum: 0x43474752
	Offset: 0x1B8
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	namespace_617a54f4::function_d8383812(#"little_bird_1", 24000, "little_bird_1", 400, level._effect[#"generator_soul"], level._effect[#"hash_25d427b0d162135a"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"little_bird_2", 24000, "little_bird_2", 400, level._effect[#"generator_soul"], level._effect[#"hash_25d427b0d162135a"], undefined, undefined, 1);
	namespace_617a54f4::function_d8383812(#"little_bird_3", 24000, "little_bird_3", 400, level._effect[#"generator_soul"], level._effect[#"hash_25d427b0d162135a"], undefined, undefined, 1);
	clientfield::register("scriptmover", "elemental_shard_glow", 24000, 1, "int", &elemental_shard_glow, 0, 0);
}

/*
	Name: elemental_shard_glow
	Namespace: zm_orange_mq_fuse
	Checksum: 0x542EE9B0
	Offset: 0x348
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function elemental_shard_glow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self.fx_glow = util::playfxontag(localclientnum, level._effect[#"elemental_shard_glow"], self, "tag_origin");
	}
	else
	{
		stopfx(localclientnum, self.fx_glow);
	}
}

