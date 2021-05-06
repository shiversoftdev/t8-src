// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;

#namespace wz_ai;

/*
	Name: function_89f2df9
	Namespace: wz_ai
	Checksum: 0x7A2ED462
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"wz_ai", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: wz_ai
	Checksum: 0x516D429D
	Offset: 0xF8
	Size: 0x94
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	clientfield::register("vehicle", "enable_on_radar", 1, 1, "int", &function_c85f904d, 1, 1);
	clientfield::register("actor", "enable_on_radar", 1, 1, "int", &function_c85f904d, 1, 1);
}

/*
	Name: function_c85f904d
	Namespace: wz_ai
	Checksum: 0x12AA450E
	Offset: 0x198
	Size: 0x54
	Parameters: 7
	Flags: Linked
*/
function function_c85f904d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self enableonradar();
}

