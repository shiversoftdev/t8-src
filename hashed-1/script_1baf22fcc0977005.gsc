// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6b221588ece2c4aa;
#using script_8988fdbc78d6c53;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;
#using scripts\mp_common\util.gsc;

#namespace weaponobjects;

/*
	Name: function_89f2df9
	Namespace: weaponobjects
	Checksum: 0xA09E56A0
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"weaponobjects", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: weaponobjects
	Checksum: 0x3D318328
	Offset: 0x100
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
	callback::on_start_gametype(&start_gametype);
}

/*
	Name: start_gametype
	Namespace: weaponobjects
	Checksum: 0xE5D2B539
	Offset: 0x140
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function start_gametype()
{
	callback::on_connect(&on_player_connect);
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: on_player_spawned
	Namespace: weaponobjects
	Checksum: 0x80F724D1
	Offset: 0x190
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
}

