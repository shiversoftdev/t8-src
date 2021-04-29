// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;

#namespace namespace_86eed980;

/*
	Name: init
	Namespace: namespace_86eed980
	Checksum: 0x38977010
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("allplayers", "zm_orange_force_challenge_model", 24000, 1, "int", &function_a1d393ad, 0, 0);
	forcestreamxmodel("p8_zm_ora_kitchenware_soup_pot");
}

/*
	Name: main
	Namespace: namespace_86eed980
	Checksum: 0x80F724D1
	Offset: 0x138
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function main()
{
}

/*
	Name: function_a1d393ad
	Namespace: namespace_86eed980
	Checksum: 0xE260EE12
	Offset: 0x148
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_a1d393ad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		forcestreamxmodel(#"p8_zm_gla_heart_zombie");
	}
	else
	{
		stopforcestreamingxmodel(#"p8_zm_gla_heart_zombie");
	}
}

