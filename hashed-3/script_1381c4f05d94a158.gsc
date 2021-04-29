// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace namespace_a7cf6436;

/*
	Name: function_89f2df9
	Namespace: namespace_a7cf6436
	Checksum: 0xB1DAA352
	Offset: 0x140
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_2813a2fd40c93f23", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a7cf6436
	Checksum: 0x52A45C80
	Offset: 0x188
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_481123c();
	level._effect[#"hash_7b8ad0ed3ef67813"] = "zombie/fx8_perk_phd_exp";
	zm_perks::function_f3c80d73("zombie_perk_bottle_slider", "zombie_perk_totem_slider");
}

/*
	Name: function_481123c
	Namespace: namespace_a7cf6436
	Checksum: 0x218B45A6
	Offset: 0x1F0
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_481123c()
{
	zm_perks::register_perk_clientfields(#"specialty_phdflopper", &function_4bb29d61, &function_90b5e96c);
	zm_perks::register_perk_effects(#"specialty_phdflopper", "divetonuke_light");
	zm_perks::register_perk_init_thread(#"specialty_phdflopper", &function_15d03600);
	zm_perks::function_b60f4a9f(#"specialty_phdflopper", #"hash_5a4a8916573af691", "zombie/fx8_perk_altar_symbol_ambient_slider", #"hash_402b9d6529500b72");
}

/*
	Name: function_15d03600
	Namespace: namespace_a7cf6436
	Checksum: 0x80F724D1
	Offset: 0x2E0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_15d03600()
{
}

/*
	Name: function_4bb29d61
	Namespace: namespace_a7cf6436
	Checksum: 0x9739D33D
	Offset: 0x2F0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_4bb29d61()
{
	clientfield::register("allplayers", "" + #"hash_7b8ad0ed3ef67813", 1, 1, "counter", &function_4feff2f7, 0, 0);
}

/*
	Name: function_90b5e96c
	Namespace: namespace_a7cf6436
	Checksum: 0x80F724D1
	Offset: 0x358
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_90b5e96c()
{
}

/*
	Name: function_4feff2f7
	Namespace: namespace_a7cf6436
	Checksum: 0x45991C80
	Offset: 0x368
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function function_4feff2f7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_7b8ad0ed3ef67813"], self, "j_spine");
		self playsound(localclientnum, #"hash_25343ce78e1c9c6c");
	}
}

