// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_57f7003580bb15e0;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace status_effect_deaf;

/*
	Name: function_89f2df9
	Namespace: status_effect_deaf
	Checksum: 0x7F2162F6
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"status_effect_deaf", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: status_effect_deaf
	Checksum: 0xC45E05F4
	Offset: 0xD0
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	status_effect::register_status_effect_callback_apply(0, &deaf_apply);
	status_effect::function_5bae5120(0, &function_c5189bd);
	status_effect::function_6f4eaf88(function_4d1e7b48("deaf"));
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: on_player_spawned
	Namespace: status_effect_deaf
	Checksum: 0x80F724D1
	Offset: 0x168
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
}

/*
	Name: deaf_apply
	Namespace: status_effect_deaf
	Checksum: 0x51A69F95
	Offset: 0x178
	Size: 0x1C
	Parameters: 3
	Flags: Linked
*/
function deaf_apply(var_756fda07, weapon, var_84171a6c)
{
}

/*
	Name: function_c5189bd
	Namespace: status_effect_deaf
	Checksum: 0x80F724D1
	Offset: 0x1A0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_c5189bd()
{
}

