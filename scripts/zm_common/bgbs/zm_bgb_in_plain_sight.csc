// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;
#using scripts\zm_common\zm_bgb.csc;

#namespace zm_bgb_in_plain_sight;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_in_plain_sight
	Checksum: 0x618C8B23
	Offset: 0xC8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_bgb_in_plain_sight", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_in_plain_sight
	Checksum: 0x930CE5F5
	Offset: 0x118
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_in_plain_sight", "activated");
	visionset_mgr::register_visionset_info("zm_bgb_in_plain_sight", 1, 31, undefined, "zm_bgb_in_plain_sight");
	clientfield::register("toplayer", "" + #"hash_321b58d22755af74", 1, 1, "int", &function_8b05d1ce, 0, 0);
}

/*
	Name: function_8b05d1ce
	Namespace: zm_bgb_in_plain_sight
	Checksum: 0xEBE32FC8
	Offset: 0x1F0
	Size: 0x144
	Parameters: 7
	Flags: Linked
*/
function function_8b05d1ce(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self thread postfx::playpostfxbundle(#"hash_1e8cc5b28385a579");
		if(!isdefined(self.var_6fc0e881))
		{
			self playsound(localclientnum, #"hash_766f7e280a750ba8");
			self.var_6fc0e881 = self playloopsound(#"hash_38ea108cd6442868");
		}
	}
	else
	{
		self postfx::stoppostfxbundle(#"hash_1e8cc5b28385a579");
		if(isdefined(self.var_6fc0e881))
		{
			self playsound(localclientnum, #"hash_5d65ef28d3f9dc1d");
			self stoploopsound(self.var_6fc0e881);
		}
	}
}

