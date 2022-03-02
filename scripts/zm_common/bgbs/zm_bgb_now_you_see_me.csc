// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;
#using scripts\zm_common\zm_bgb.csc;

#namespace zm_bgb_now_you_see_me;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_now_you_see_me
	Checksum: 0x4B930FCD
	Offset: 0xE0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_bgb_now_you_see_me", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_now_you_see_me
	Checksum: 0xCE84462C
	Offset: 0x130
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
	bgb::register(#"zm_bgb_now_you_see_me", "activated");
	visionset_mgr::register_visionset_info("zm_bgb_now_you_see_me", 1, 31, undefined, "zm_bgb_in_plain_sight");
	clientfield::register("toplayer", "" + #"hash_18be2b4b3936ee1f", 1, 1, "int", &function_387d8f36, 0, 0);
}

/*
	Name: function_387d8f36
	Namespace: zm_bgb_now_you_see_me
	Checksum: 0xCAA07518
	Offset: 0x208
	Size: 0x13C
	Parameters: 7
	Flags: Linked
*/
function function_387d8f36(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self thread postfx::playpostfxbundle(#"hash_129cb5a3537b76f4");
		if(!isdefined(self.var_ab7bde88))
		{
			self playsound(localclientnum, #"hash_7b2800dd9e263794");
			self.var_ab7bde88 = self playloopsound(#"hash_3045ef348e47e6b4");
		}
	}
	else
	{
		self postfx::stoppostfxbundle(#"hash_129cb5a3537b76f4");
		if(isdefined(self.var_ab7bde88))
		{
			self stoploopsound(self.var_ab7bde88);
			self playsound(localclientnum, #"hash_15703d934c79add1");
		}
	}
}

