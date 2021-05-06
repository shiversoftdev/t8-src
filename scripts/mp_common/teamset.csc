// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;

#namespace teamset;

/*
	Name: function_89f2df9
	Namespace: teamset
	Checksum: 0x34B177DC
	Offset: 0x70
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"teamset_seals", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: teamset
	Checksum: 0x6553C85D
	Offset: 0xB8
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.allies_team = #"allies";
	level.axis_team = #"axis";
}

