// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_20422991283c1b8;
#using script_387ae8d7955ac404;
#using script_442a4e554bcd7c3b;
#using script_4b4a4b9186e38fd6;
#using script_4c875fef517e2061;
#using script_6fdaa897ed596805;
#using script_763e5f4b26b4d8ce;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\exploder_shared.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_ec1f72a0;

/*
	Name: preload
	Namespace: namespace_ec1f72a0
	Checksum: 0xD8ECAD75
	Offset: 0xD8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	namespace_ff7e4f08::preload();
	namespace_1a68a5da::preload();
	namespace_bfc8ee03::preload();
	namespace_55999fe::preload();
	namespace_4b68b2b3::preload();
	namespace_13b4b4b::preload();
	clientfield::register("toplayer", "" + #"hash_668f474410d5c1d0", 24000, 1, "int", &clear_hud, 0, 0);
}

/*
	Name: clear_hud
	Namespace: namespace_ec1f72a0
	Checksum: 0x71D1A945
	Offset: 0x1A0
	Size: 0x6C
	Parameters: 7
	Flags: Linked
*/
function clear_hud(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self zm::function_92f0c63(localclientnum);
	self namespace_e1e7cabf::function_25410869(localclientnum);
}

