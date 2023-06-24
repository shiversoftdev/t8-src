// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;
#using scripts\zm_common\zm_powerups.csc;

#namespace zm_perk_mod_wolf_protector;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_wolf_protector
	Checksum: 0x93289060
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_wolf_protector", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_wolf_protector
	Checksum: 0xD8424E4A
	Offset: 0x118
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(getdvarint(#"hash_4e1190045ef3588b", 0))
	{
		function_27473e44();
	}
}

/*
	Name: function_27473e44
	Namespace: zm_perk_mod_wolf_protector
	Checksum: 0x43E06B5E
	Offset: 0x160
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_27473e44()
{
	zm_perks::register_perk_clientfields(#"specialty_mod_wolf_protector", &client_field_func, &code_callback_func);
	zm_perks::register_perk_init_thread(#"specialty_mod_wolf_protector", &init);
	zm_perks::function_b60f4a9f(#"specialty_mod_wolf_protector", #"p8_zm_vapor_altar_icon_01_bloodwolf", "zombie/fx8_perk_altar_symbol_ambient_blood_wolf", #"zmperkswolfprotector");
	zm_powerups::include_zombie_powerup("wolf_bonus_points");
	zm_powerups::add_zombie_powerup("wolf_bonus_points");
}

/*
	Name: init
	Namespace: zm_perk_mod_wolf_protector
	Checksum: 0x80F724D1
	Offset: 0x258
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function init()
{
}

/*
	Name: client_field_func
	Namespace: zm_perk_mod_wolf_protector
	Checksum: 0x80F724D1
	Offset: 0x268
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function client_field_func()
{
}

/*
	Name: code_callback_func
	Namespace: zm_perk_mod_wolf_protector
	Checksum: 0x80F724D1
	Offset: 0x278
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function code_callback_func()
{
}

