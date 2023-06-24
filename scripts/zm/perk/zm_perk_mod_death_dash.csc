// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace zm_perk_mod_death_dash;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_death_dash
	Checksum: 0x8EA16835
	Offset: 0x120
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_death_dash", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_death_dash
	Checksum: 0x151A0CE1
	Offset: 0x168
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_27473e44();
}

/*
	Name: function_27473e44
	Namespace: zm_perk_mod_death_dash
	Checksum: 0x3A9DC644
	Offset: 0x188
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_27473e44()
{
	zm_perks::register_perk_clientfields(#"specialty_mod_death_dash", &client_field_func, &code_callback_func);
	zm_perks::register_perk_init_thread(#"specialty_mod_death_dash", &init);
	zm_perks::function_b60f4a9f(#"specialty_mod_death_dash", #"p8_zm_vapor_altar_icon_01_blaze_phase", "zombie/fx8_perk_altar_symbol_ambient_blaze_phase", #"zmperksdeathdash");
}

/*
	Name: init
	Namespace: zm_perk_mod_death_dash
	Checksum: 0x80F724D1
	Offset: 0x250
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function init()
{
}

/*
	Name: client_field_func
	Namespace: zm_perk_mod_death_dash
	Checksum: 0xE7AB1721
	Offset: 0x260
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function client_field_func()
{
	clientfield::register("allplayers", "death_dash_pulse", 24000, 1, "counter", &play_death_dash_pulse, 0, 0);
}

/*
	Name: code_callback_func
	Namespace: zm_perk_mod_death_dash
	Checksum: 0x80F724D1
	Offset: 0x2B8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function code_callback_func()
{
}

/*
	Name: play_death_dash_pulse
	Namespace: zm_perk_mod_death_dash
	Checksum: 0x9FCF479D
	Offset: 0x2C8
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function play_death_dash_pulse(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::playfxontag(localclientnum, "zombie/fx8_perk_blaze_phase_flame_pulse", self, "j_spine4");
	self playsound(localclientnum, #"hash_531770ad2c5bf052");
}

