// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_624a704d0f6bf28d;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\struct.csc;

#namespace zm_orange_mq_soapstone;

/*
	Name: preload
	Namespace: zm_orange_mq_soapstone
	Checksum: 0x13CD30D3
	Offset: 0xC8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	level._effect[#"soapstone_cold"] = #"hash_75215ea3c21f31d3";
	level._effect[#"soapstone_hot"] = #"hash_7cdf08df557a9b3f";
	init_clientfields();
}

/*
	Name: main
	Namespace: zm_orange_mq_soapstone
	Checksum: 0x80F724D1
	Offset: 0x148
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function main()
{
}

/*
	Name: init_clientfields
	Namespace: zm_orange_mq_soapstone
	Checksum: 0xDC24CF5E
	Offset: 0x158
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "soapstone_start_fx", 24000, 2, "int", &soapstone_fx, 0, 0);
}

/*
	Name: soapstone_fx
	Namespace: zm_orange_mq_soapstone
	Checksum: 0x768D3FE5
	Offset: 0x1B0
	Size: 0x10A
	Parameters: 7
	Flags: Linked
*/
function soapstone_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.fx_glow))
	{
		stopfx(localclientnum, self.fx_glow);
		self.fx_glow = undefined;
	}
	if(newval == 1)
	{
		self.fx_glow = util::playfxontag(localclientnum, level._effect[#"soapstone_cold"], self, "tag_origin");
	}
	else if(newval == 2)
	{
		self.fx_glow = util::playfxontag(localclientnum, level._effect[#"soapstone_hot"], self, "tag_origin");
	}
}

