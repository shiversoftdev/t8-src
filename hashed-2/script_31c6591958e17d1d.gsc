// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace namespace_e03931f;

/*
	Name: function_89f2df9
	Namespace: namespace_e03931f
	Checksum: 0x9AD5FBAB
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_120f55104b05e7c6", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_e03931f
	Checksum: 0xC930B6EC
	Offset: 0xC8
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
	Namespace: namespace_e03931f
	Checksum: 0xD70599E2
	Offset: 0xE8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function enable_quick_revive_perk_for_level()
{
	zm_perks::register_perk_clientfields(#"hash_a6796d796a8d2b9", &quick_revive_client_field_func, &quick_revive_callback_func);
}

/*
	Name: quick_revive_client_field_func
	Namespace: namespace_e03931f
	Checksum: 0x80F724D1
	Offset: 0x138
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function quick_revive_client_field_func()
{
}

/*
	Name: quick_revive_callback_func
	Namespace: namespace_e03931f
	Checksum: 0x80F724D1
	Offset: 0x148
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function quick_revive_callback_func()
{
}

