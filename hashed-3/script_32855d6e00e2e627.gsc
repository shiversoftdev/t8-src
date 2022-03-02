// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace namespace_256d0f31;

/*
	Name: function_89f2df9
	Namespace: namespace_256d0f31
	Checksum: 0x8EA16835
	Offset: 0x120
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_7ce6a9f15f5680e0", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_256d0f31
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
	Namespace: namespace_256d0f31
	Checksum: 0x3A9DC644
	Offset: 0x188
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_27473e44()
{
	zm_perks::register_perk_clientfields(#"hash_1b2d5c9444ac98f2", &function_37236662, &function_6705773b);
	zm_perks::register_perk_init_thread(#"hash_1b2d5c9444ac98f2", &init);
	zm_perks::function_b60f4a9f(#"hash_1b2d5c9444ac98f2", #"hash_2c7d417ffd8a2a0", "zombie/fx8_perk_altar_symbol_ambient_blaze_phase", #"hash_544b157a9fa6573d");
}

/*
	Name: init
	Namespace: namespace_256d0f31
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
	Name: function_37236662
	Namespace: namespace_256d0f31
	Checksum: 0xE7AB1721
	Offset: 0x260
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_37236662()
{
	clientfield::register("allplayers", "death_dash_pulse", 24000, 1, "counter", &play_death_dash_pulse, 0, 0);
}

/*
	Name: function_6705773b
	Namespace: namespace_256d0f31
	Checksum: 0x80F724D1
	Offset: 0x2B8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_6705773b()
{
}

/*
	Name: play_death_dash_pulse
	Namespace: namespace_256d0f31
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

