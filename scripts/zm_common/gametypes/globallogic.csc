// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;

#namespace globallogic;

/*
	Name: function_89f2df9
	Namespace: globallogic
	Checksum: 0x7CA407B6
	Offset: 0xC0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"globallogic", &__init__, undefined, #"visionset_mgr");
}

/*
	Name: __init__
	Namespace: globallogic
	Checksum: 0x20C2FF47
	Offset: 0x110
	Size: 0x62
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	visionset_mgr::register_visionset_info("crithealth", 1, 25, undefined, "critical_health");
	level.new_health_model = getdvarint(#"new_health_model", 1) > 0;
}

