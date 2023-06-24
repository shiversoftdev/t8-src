// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace globallogic_actor;

/*
	Name: __init__system__
	Namespace: globallogic_actor
	Checksum: 0x9888AFF3
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"globallogic_actor", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: globallogic_actor
	Checksum: 0x4220F40D
	Offset: 0xE0
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._effect[#"rcbombexplosion"] = #"killstreaks/fx_rcxd_exp";
}

