// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\gametypes\ct_firebreak_tutorial.csc;
#using scripts\mp_common\gametypes\ct_core.csc;
#using scripts\core_common\renderoverridebundle.csc;
#using scripts\core_common\oob.csc;
#using scripts\core_common\clientfield_shared.csc;
#using script_127edb82eabcb791;

#namespace ct_firebreak;

/*
	Name: main
	Namespace: ct_firebreak
	Checksum: 0x1AF65440
	Offset: 0xB8
	Size: 0x64
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	ct_core::function_46e95cc7();
	ct_core::function_fa03fc55();
	level.ct_firebreak_multi_kill = ct_firebreak_multi_kill::register("ct_firebreak_multi_kill");
	ct_firebreak_tutorial::init();
}

