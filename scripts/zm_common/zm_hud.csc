// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_4990d85086acf096;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_hud;

/*
	Name: __init__system__
	Namespace: zm_hud
	Checksum: 0xE1C2EAA8
	Offset: 0xA8
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_hud", &__init__, &__main__, #"zm_crafting");
}

/*
	Name: __init__
	Namespace: zm_hud
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
	Namespace: zm_hud
	Checksum: 0x80F724D1
	Offset: 0x130
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

