// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\vehicle_shared.csc;

#namespace wasp;

/*
	Name: function_89f2df9
	Namespace: wasp
	Checksum: 0xE18406E7
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"wasp", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: wasp
	Checksum: 0x11B591DD
	Offset: 0x120
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("vehicle", "rocket_wasp_hijacked", 1, 1, "int", &handle_lod_display_for_driver, 0, 0);
	level.sentinelbundle = struct::get_script_bundle("killstreak", "killstreak_sentinel");
	if(isdefined(level.sentinelbundle))
	{
		vehicle::add_vehicletype_callback(level.sentinelbundle.ksvehicle, &spawned);
	}
}

/*
	Name: spawned
	Namespace: wasp
	Checksum: 0xFE3E9F5B
	Offset: 0x1E0
	Size: 0x1E
	Parameters: 1
	Flags: Linked
*/
function spawned(localclientnum)
{
	self.killstreakbundle = level.sentinelbundle;
}

/*
	Name: handle_lod_display_for_driver
	Namespace: wasp
	Checksum: 0xEF060D7B
	Offset: 0x208
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function handle_lod_display_for_driver(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(isdefined(self))
	{
		if(self function_4add50a7())
		{
			self sethighdetail(1);
			waitframe(1);
			self vehicle::lights_off(localclientnum);
		}
	}
}

