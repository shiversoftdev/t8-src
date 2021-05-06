// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;

#namespace namespace_e7bd6188;

/*
	Name: ignore_systems
	Namespace: namespace_e7bd6188
	Checksum: 0x6C6D7792
	Offset: 0x70
	Size: 0x104
	Parameters: 0
	Flags: AutoExec
*/
autoexec function ignore_systems()
{
	system::ignore(#"recon_car");
	system::ignore(#"planemortar");
	system::ignore(#"supplydrop");
	system::ignore(#"ultimate_turret");
	system::ignore(#"armor_station");
	system::ignore(#"counteruav");
	system::ignore(#"uav");
	system::ignore(#"hash_291bf0f079b2eb91");
}

