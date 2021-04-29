// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_127edb82eabcb791;
#using script_3487c470617b596f;
#using script_6f708b088707e166;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\oob.csc;
#using scripts\core_common\renderoverridebundle.csc;

#namespace namespace_28cc2b2e;

/*
	Name: main
	Namespace: namespace_28cc2b2e
	Checksum: 0x1AF65440
	Offset: 0xB8
	Size: 0x64
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	namespace_13777bae::function_46e95cc7();
	namespace_13777bae::function_fa03fc55();
	level.ct_firebreak_multi_kill = ct_firebreak_multi_kill::register("ct_firebreak_multi_kill");
	namespace_154e6230::init();
}

