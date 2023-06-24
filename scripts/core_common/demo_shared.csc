// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\filter_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\flagsys_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace demo;

/*
	Name: __init__system__
	Namespace: demo
	Checksum: 0x2F979049
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"demo", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: demo
	Checksum: 0x83F25ADF
	Offset: 0xE0
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdemoplaying())
	{
		return;
	}
}

