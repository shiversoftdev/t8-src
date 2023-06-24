// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace zm_perk_quick_revive;

/*
	Name: __init__system__
	Namespace: zm_perk_quick_revive
	Checksum: 0xFAA08F7F
	Offset: 0x110
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_quick_revive", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_quick_revive
	Checksum: 0x1AE57D2A
	Offset: 0x158
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_quick_revive_perk_for_level();
}

/*
	Name: enable_quick_revive_perk_for_level
	Namespace: zm_perk_quick_revive
	Checksum: 0x6D5BBE70
	Offset: 0x178
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function enable_quick_revive_perk_for_level()
{
	zm_perks::register_perk_clientfields(#"specialty_quickrevive", &quick_revive_client_field_func, &quick_revive_callback_func);
	zm_perks::register_perk_effects(#"specialty_quickrevive", "revive_light");
	zm_perks::register_perk_init_thread(#"specialty_quickrevive", &init_quick_revive);
	zm_perks::function_b60f4a9f(#"specialty_quickrevive", #"p8_zm_vapor_altar_icon_01_quickrevive", "zombie/fx8_perk_altar_symbol_ambient_quick_revive", #"zmperksquickrevive");
	zm_perks::function_f3c80d73("zombie_perk_bottle_revive", "zombie_perk_totem_quick_revive");
}

/*
	Name: init_quick_revive
	Namespace: zm_perk_quick_revive
	Checksum: 0xA9E40152
	Offset: 0x288
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function init_quick_revive()
{
	if(isdefined(level.enable_magic) && level.enable_magic)
	{
		level._effect[#"revive_light"] = #"zombie/fx_perk_quick_revive_zmb";
	}
}

/*
	Name: quick_revive_client_field_func
	Namespace: zm_perk_quick_revive
	Checksum: 0x80F724D1
	Offset: 0x2E8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function quick_revive_client_field_func()
{
}

/*
	Name: quick_revive_callback_func
	Namespace: zm_perk_quick_revive
	Checksum: 0x80F724D1
	Offset: 0x2F8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function quick_revive_callback_func()
{
}

