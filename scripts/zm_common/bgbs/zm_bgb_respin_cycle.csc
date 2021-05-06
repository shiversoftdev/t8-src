// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_bgb.csc;

#namespace zm_bgb_respin_cycle;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_respin_cycle
	Checksum: 0x3EC9AFCE
	Offset: 0xE8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_bgb_respin_cycle", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_respin_cycle
	Checksum: 0x66197883
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_respin_cycle", "activated");
	clientfield::register("zbarrier", "zm_bgb_respin_cycle", 1, 1, "counter", &function_d1018763, 0, 0);
	level._effect["zm_bgb_respin_cycle"] = "zombie/fx_bgb_respin_cycle_box_flash_zmb";
}

/*
	Name: function_d1018763
	Namespace: zm_bgb_respin_cycle
	Checksum: 0x663D63AB
	Offset: 0x1F8
	Size: 0x9C
	Parameters: 7
	Flags: Linked
*/
function function_d1018763(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	playfx(localclientnum, level._effect["zm_bgb_respin_cycle"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
}

