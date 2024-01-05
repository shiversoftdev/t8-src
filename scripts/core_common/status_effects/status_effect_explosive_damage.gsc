// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace status_effect_explosive_damage;

/*
	Name: __init__system__
	Namespace: status_effect_explosive_damage
	Checksum: 0x1C499757
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"status_effect_explosive_damage", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: status_effect_explosive_damage
	Checksum: 0xEA476C41
	Offset: 0xE8
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	status_effect::function_6f4eaf88(getstatuseffect("explosive_damage"));
}

