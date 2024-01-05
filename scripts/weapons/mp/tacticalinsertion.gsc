// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\tacticalinsertion.gsc;
#using scripts\weapons\hacker_tool.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace tacticalinsertion;

/*
	Name: __init__system__
	Namespace: tacticalinsertion
	Checksum: 0xF5E45F65
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"tacticalinsertion", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: tacticalinsertion
	Checksum: 0xD60023D2
	Offset: 0xC8
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
	level.var_96ee56b5 = &function_e34f7002;
}

/*
	Name: function_e34f7002
	Namespace: tacticalinsertion
	Checksum: 0x2AEDCE3A
	Offset: 0x100
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_e34f7002()
{
	self hacker_tool::registerwithhackertool(level.equipmenthackertoolradius, level.equipmenthackertooltimems);
}

