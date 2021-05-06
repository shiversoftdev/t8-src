// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5a44cd71d81b3f86;
#using script_d116a14142e2250;
#using scripts\core_common\system_shared.csc;

#namespace killstreaks;

/*
	Name: function_89f2df9
	Namespace: killstreaks
	Checksum: 0x5043BA20
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"killstreaks", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: killstreaks
	Checksum: 0x6983C6E6
	Offset: 0xC8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
	namespace_231aa29a::init();
}

