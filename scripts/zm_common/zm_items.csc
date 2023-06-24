// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_items;

/*
	Name: __init__system__
	Namespace: zm_items
	Checksum: 0x4A38B31E
	Offset: 0xC8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_items", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_items
	Checksum: 0x390E7327
	Offset: 0x110
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("item", "highlight_item", 1, 2, "int", &function_39e7c9dd, 0, 0);
}

/*
	Name: function_39e7c9dd
	Namespace: zm_items
	Checksum: 0xE212F465
	Offset: 0x168
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_39e7c9dd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self playrenderoverridebundle("rob_sonar_set_friendly");
	}
	else
	{
		self stoprenderoverridebundle("rob_sonar_set_friendly");
	}
}

