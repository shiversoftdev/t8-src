// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;
#using scripts\zm_common\zm_perks.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_perk_additionalprimaryweapon;

/*
	Name: function_89f2df9
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x6D2D1B25
	Offset: 0x198
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_perk_additionalprimaryweapon", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x30C43353
	Offset: 0x1E0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_additional_primary_weapon_perk_for_level();
	zm_perks::function_f3c80d73("zombie_perk_bottle_additionalprimaryweapon", "zombie_perk_totem_mule_kick");
}

/*
	Name: enable_additional_primary_weapon_perk_for_level
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0xDD9CA0A1
	Offset: 0x220
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function enable_additional_primary_weapon_perk_for_level()
{
	zm_perks::register_perk_clientfields(#"specialty_additionalprimaryweapon", &additional_primary_weapon_client_field_func, &additional_primary_weapon_code_callback_func);
	zm_perks::register_perk_effects(#"specialty_additionalprimaryweapon", "additionalprimaryweapon_light");
	zm_perks::register_perk_init_thread(#"specialty_additionalprimaryweapon", &init_additional_primary_weapon);
	zm_perks::function_b60f4a9f(#"specialty_additionalprimaryweapon", #"hash_38dbbd5ffd6720fb", "zombie/fx8_perk_altar_symbol_ambient_mule_kick", #"hash_5347ff402123307a");
}

/*
	Name: init_additional_primary_weapon
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x728CB54E
	Offset: 0x310
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function init_additional_primary_weapon()
{
	if(isdefined(level.enable_magic) && level.enable_magic)
	{
		level._effect[#"additionalprimaryweapon_light"] = "zombie/fx_perk_mule_kick_zmb";
	}
}

/*
	Name: additional_primary_weapon_client_field_func
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x89F44B6D
	Offset: 0x368
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function additional_primary_weapon_client_field_func()
{
	clientfield::register("clientuimodel", "hudItems.perks.additional_primary_weapon", 1, 2, "int", undefined, 0, 1);
}

/*
	Name: additional_primary_weapon_code_callback_func
	Namespace: zm_perk_additionalprimaryweapon
	Checksum: 0x80F724D1
	Offset: 0x3B0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function additional_primary_weapon_code_callback_func()
{
}

