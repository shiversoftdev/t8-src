// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace status_effect_movement_speed;

/*
	Name: __init__system__
	Namespace: status_effect_movement_speed
	Checksum: 0xB0B7759C
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"status_effect_movement_speed", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: status_effect_movement_speed
	Checksum: 0xF241D5D2
	Offset: 0xD0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	status_effect::function_6f4eaf88(getstatuseffect("movement"));
	status_effect::function_5bae5120(8, &function_f7e9c0bb);
}

/*
	Name: function_f7e9c0bb
	Namespace: status_effect_movement_speed
	Checksum: 0x80F724D1
	Offset: 0x128
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_f7e9c0bb()
{
}

