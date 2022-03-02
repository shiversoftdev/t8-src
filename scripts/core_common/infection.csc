// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;

#namespace infection;

/*
	Name: function_89f2df9
	Namespace: infection
	Checksum: 0x74506222
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"infection", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: infection
	Checksum: 0x80F724D1
	Offset: 0xC8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
}

/*
	Name: function_74650d7
	Namespace: infection
	Checksum: 0xF0B80AAE
	Offset: 0xD8
	Size: 0x48
	Parameters: 0
	Flags: None
*/
function function_74650d7()
{
	if(isdefined(getgametypesetting("infectionMode")) && getgametypesetting("infectionMode"))
	{
		return true;
	}
	return false;
}

