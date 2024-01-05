// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_perks.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace zm_perk_slider;

/*
	Name: __init__system__
	Namespace: zm_perk_slider
	Checksum: 0xB1DAA352
	Offset: 0x140
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_slider", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_slider
	Checksum: 0x52A45C80
	Offset: 0x188
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_slider_perk_for_level();
	level._effect[#"hash_7b8ad0ed3ef67813"] = "zombie/fx8_perk_phd_exp";
	zm_perks::function_f3c80d73("zombie_perk_bottle_slider", "zombie_perk_totem_slider");
}

/*
	Name: enable_slider_perk_for_level
	Namespace: zm_perk_slider
	Checksum: 0x218B45A6
	Offset: 0x1F0
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function enable_slider_perk_for_level()
{
	zm_perks::register_perk_clientfields(#"specialty_phdflopper", &function_4bb29d61, &function_90b5e96c);
	zm_perks::register_perk_effects(#"specialty_phdflopper", "divetonuke_light");
	zm_perks::register_perk_init_thread(#"specialty_phdflopper", &init_slider);
	zm_perks::function_b60f4a9f(#"specialty_phdflopper", #"p8_zm_vapor_altar_icon_01_phdslider", "zombie/fx8_perk_altar_symbol_ambient_slider", #"zmperksphdslider");
}

/*
	Name: init_slider
	Namespace: zm_perk_slider
	Checksum: 0x80F724D1
	Offset: 0x2E0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function init_slider()
{
}

/*
	Name: function_4bb29d61
	Namespace: zm_perk_slider
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
	Namespace: zm_perk_slider
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
	Namespace: zm_perk_slider
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

