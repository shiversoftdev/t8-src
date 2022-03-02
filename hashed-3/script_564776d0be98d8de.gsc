// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace zm_perk_staminup;

/*
	Name: function_89f2df9
	Namespace: zm_perk_staminup
	Checksum: 0x921667E
	Offset: 0x130
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_perk_staminup", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_staminup
	Checksum: 0xBBDF4997
	Offset: 0x178
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_staminup_perk_for_level();
}

/*
	Name: enable_staminup_perk_for_level
	Namespace: zm_perk_staminup
	Checksum: 0xAF84DD13
	Offset: 0x198
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function enable_staminup_perk_for_level()
{
	zm_perks::register_perk_clientfields(#"specialty_staminup", &staminup_client_field_func, &staminup_callback_func);
	zm_perks::register_perk_effects(#"specialty_staminup", "marathon_light");
	zm_perks::register_perk_init_thread(#"specialty_staminup", &init_staminup);
	zm_perks::function_b60f4a9f(#"specialty_staminup", #"hash_6c0474e5948852cb", "zombie/fx8_perk_altar_symbol_ambient_staminup", #"hash_3a15ddcc25d689f6");
	zm_perks::function_f3c80d73("zombie_perk_bottle_marathon", "zombie_perk_totem_staminup");
}

/*
	Name: init_staminup
	Namespace: zm_perk_staminup
	Checksum: 0x3D37AF16
	Offset: 0x2A8
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function init_staminup()
{
	if(isdefined(level.enable_magic) && level.enable_magic)
	{
		level._effect[#"marathon_light"] = "zombie/fx_perk_stamin_up_zmb";
	}
}

/*
	Name: staminup_client_field_func
	Namespace: zm_perk_staminup
	Checksum: 0x80F724D1
	Offset: 0x300
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function staminup_client_field_func()
{
}

/*
	Name: staminup_callback_func
	Namespace: zm_perk_staminup
	Checksum: 0x80F724D1
	Offset: 0x310
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function staminup_callback_func()
{
}

