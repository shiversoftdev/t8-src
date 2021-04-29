// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_4990d85086acf096;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_2c9e6caa;

/*
	Name: function_89f2df9
	Namespace: namespace_2c9e6caa
	Checksum: 0xE1C2EAA8
	Offset: 0xA8
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_431ed482b5f316ae", &__init__, &__main__, #"hash_12378771db09fde7");
}

/*
	Name: __init__
	Namespace: namespace_2c9e6caa
	Checksum: 0xBE41D796
	Offset: 0x108
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_location::register("zm_location");
}

/*
	Name: __main__
	Namespace: namespace_2c9e6caa
	Checksum: 0x80F724D1
	Offset: 0x130
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

