// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;

#namespace globallogic_score;

/*
	Name: __init__
	Namespace: globallogic_score
	Checksum: 0x93AF3D88
	Offset: 0x108
	Size: 0xE4
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__()
{
	clientfield::register("clientuimodel", "hudItems.scoreProtected", 1, 1, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.minorActions.action0", 1, 1, "counter", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.minorActions.action1", 1, 1, "counter", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.hotStreak.level", 1, 3, "int", undefined, 0, 0);
}

