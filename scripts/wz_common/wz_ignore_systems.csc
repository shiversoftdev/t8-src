// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;

#namespace wz_ignore_systems;

/*
	Name: ignore_systems
	Namespace: wz_ignore_systems
	Checksum: 0x60472F20
	Offset: 0x70
	Size: 0x104
	Parameters: 0
	Flags: AutoExec
*/
function autoexec ignore_systems()
{
	system::ignore(#"recon_car");
	system::ignore(#"planemortar");
	system::ignore(#"supplydrop");
	system::ignore(#"ultimate_turret");
	system::ignore(#"armor_station");
	system::ignore(#"counteruav");
	system::ignore(#"uav");
	system::ignore(#"supplypod");
}

