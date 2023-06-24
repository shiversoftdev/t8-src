// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_4196ba3abca31535;
#using scripts\mp_common\gametypes\ct_core.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;

#namespace ct_torque;

/*
	Name: main
	Namespace: ct_torque
	Checksum: 0x12F1A5F6
	Offset: 0xC0
	Size: 0x96
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	ct_core::function_46e95cc7();
	ct_core::function_fa03fc55();
	clientfield::register("allplayers", "danger_pstfx", 1, 1, "counter", &danger_pstfx, 1, 0);
	level.hardpoint_bar = luielembar_ct::register("hardpoint_bar");
}

/*
	Name: danger_pstfx
	Namespace: ct_torque
	Checksum: 0x8B8E97D4
	Offset: 0x160
	Size: 0x84
	Parameters: 7
	Flags: None
*/
function danger_pstfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	postfx::playpostfxbundle(#"pstfx_danger");
	wait(1);
	postfx::stoppostfxbundle(#"pstfx_danger");
}

