// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace namespace_4a218d9b;

/*
	Name: function_89f2df9
	Namespace: namespace_4a218d9b
	Checksum: 0x7485C835
	Offset: 0x100
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_186f6603cca1bed7", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_4a218d9b
	Checksum: 0x52EA86D0
	Offset: 0x148
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_482ec336();
}

/*
	Name: function_482ec336
	Namespace: namespace_4a218d9b
	Checksum: 0xA94FDF03
	Offset: 0x168
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_482ec336()
{
	zm_perks::register_perk_clientfields(#"hash_37aa3a5919757781", &function_683242be, &function_20945b84);
	zm_perks::register_perk_effects(#"hash_37aa3a5919757781", "divetonuke_light");
	zm_perks::register_perk_init_thread(#"hash_37aa3a5919757781", &function_a2d341cc);
	zm_perks::function_b60f4a9f(#"hash_37aa3a5919757781", #"hash_7941823894380037", "zombie/fx8_perk_altar_symbol_ambient_timeslip", #"hash_1e9fb2463e6eee58");
	zm_perks::function_f3c80d73("zombie_perk_bottle_cooldown", "zombie_perk_totem_timeslip");
}

/*
	Name: function_a2d341cc
	Namespace: namespace_4a218d9b
	Checksum: 0x6EA6FFB8
	Offset: 0x278
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function function_a2d341cc()
{
	if(isdefined(level.enable_magic) && level.enable_magic)
	{
		level._effect[#"divetonuke_light"] = #"hash_2225287695ddf9c9";
	}
}

/*
	Name: function_683242be
	Namespace: namespace_4a218d9b
	Checksum: 0x80F724D1
	Offset: 0x2D8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_683242be()
{
}

/*
	Name: function_20945b84
	Namespace: namespace_4a218d9b
	Checksum: 0x80F724D1
	Offset: 0x2E8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_20945b84()
{
}

