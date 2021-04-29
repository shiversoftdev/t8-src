// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_4196ba3abca31535;
#using script_6f708b088707e166;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;

#namespace namespace_e8f4cf9c;

/*
	Name: main
	Namespace: namespace_e8f4cf9c
	Checksum: 0x12F1A5F6
	Offset: 0xC0
	Size: 0x96
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	namespace_13777bae::function_46e95cc7();
	namespace_13777bae::function_fa03fc55();
	clientfield::register("allplayers", "danger_pstfx", 1, 1, "counter", &danger_pstfx, 1, 0);
	level.hardpoint_bar = luielembar_ct::register("hardpoint_bar");
}

/*
	Name: danger_pstfx
	Namespace: namespace_e8f4cf9c
	Checksum: 0x8B8E97D4
	Offset: 0x160
	Size: 0x84
	Parameters: 7
	Flags: None
*/
function danger_pstfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	postfx::playpostfxbundle(#"hash_2582bf3c147b18a0");
	wait(1);
	postfx::stoppostfxbundle(#"hash_2582bf3c147b18a0");
}

