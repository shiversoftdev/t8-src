// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace zm_perk_cooldown;

/*
	Name: __init__system__
	Namespace: zm_perk_cooldown
	Checksum: 0x7485C835
	Offset: 0x100
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_cooldown", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_cooldown
	Checksum: 0x52EA86D0
	Offset: 0x148
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_cooldown_perk_for_level();
}

/*
	Name: enable_cooldown_perk_for_level
	Namespace: zm_perk_cooldown
	Checksum: 0xA94FDF03
	Offset: 0x168
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function enable_cooldown_perk_for_level()
{
	zm_perks::register_perk_clientfields(#"specialty_cooldown", &function_683242be, &function_20945b84);
	zm_perks::register_perk_effects(#"specialty_cooldown", "divetonuke_light");
	zm_perks::register_perk_init_thread(#"specialty_cooldown", &init_cooldown);
	zm_perks::function_b60f4a9f(#"specialty_cooldown", #"p8_zm_vapor_altar_icon_01_timeslip", "zombie/fx8_perk_altar_symbol_ambient_timeslip", #"zmperkscooldown");
	zm_perks::function_f3c80d73("zombie_perk_bottle_cooldown", "zombie_perk_totem_timeslip");
}

/*
	Name: init_cooldown
	Namespace: zm_perk_cooldown
	Checksum: 0x6EA6FFB8
	Offset: 0x278
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function init_cooldown()
{
	if(isdefined(level.enable_magic) && level.enable_magic)
	{
		level._effect[#"divetonuke_light"] = #"hash_2225287695ddf9c9";
	}
}

/*
	Name: function_683242be
	Namespace: zm_perk_cooldown
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
	Namespace: zm_perk_cooldown
	Checksum: 0x80F724D1
	Offset: 0x2E8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_20945b84()
{
}

