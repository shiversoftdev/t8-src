// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\heatseekingmissile.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace heatseekingmissile;

/*
	Name: __init__system__
	Namespace: heatseekingmissile
	Checksum: 0x5F80DC03
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"heatseekingmissile", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: heatseekingmissile
	Checksum: 0x95FB467C
	Offset: 0xC0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.lockoncloserange = 330;
	level.lockoncloseradiusscaler = 3;
	init_shared();
}

