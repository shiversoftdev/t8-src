// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\gametypes\ct_core.csc;
#using scripts\mp_common\gametypes\ct_crash_tutorial.csc;
#using scripts\core_common\clientfield_shared.csc;
#using script_38dc72b5220a1a67;
#using script_ef0f46d70331b6f;

#namespace ct_crash;

/*
	Name: main
	Namespace: ct_crash
	Checksum: 0x1C9A48E5
	Offset: 0x90
	Size: 0x3C
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	ct_core::function_46e95cc7();
	ct_core::function_fa03fc55();
	ct_crash_tutorial::init();
}

