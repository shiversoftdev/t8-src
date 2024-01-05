// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

#namespace zm_bgb_now_you_see_me;

/*
	Name: __init__system__
	Namespace: zm_bgb_now_you_see_me
	Checksum: 0x1FB0D2A5
	Offset: 0xD8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_now_you_see_me", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_now_you_see_me
	Checksum: 0xD35B1B05
	Offset: 0x128
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_now_you_see_me", "activated", 1, undefined, undefined, undefined, &activation);
	bgb::function_57eb02e(#"zm_bgb_now_you_see_me");
	bgb::function_1fee6b3(#"zm_bgb_now_you_see_me", 19);
	if(!isdefined(level.vsmgr_prio_visionset_zm_bgb_now_you_see_me))
	{
		level.vsmgr_prio_visionset_zm_bgb_now_you_see_me = 111;
	}
	visionset_mgr::register_info("visionset", "zm_bgb_now_you_see_me", 1, level.vsmgr_prio_visionset_zm_bgb_now_you_see_me, 31, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
	clientfield::register("toplayer", "" + #"hash_18be2b4b3936ee1f", 1, 1, "int");
}

/*
	Name: validation
	Namespace: zm_bgb_now_you_see_me
	Checksum: 0xA94A66AF
	Offset: 0x280
	Size: 0x36
	Parameters: 0
	Flags: None
*/
function validation()
{
	return !(isdefined(self bgb::get_active()) && self bgb::get_active());
}

/*
	Name: activation
	Namespace: zm_bgb_now_you_see_me
	Checksum: 0x2F7CEBE3
	Offset: 0x2C0
	Size: 0x17E
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self endon(#"disconnect");
	self.b_is_designated_target = 1;
	self thread bgb::run_timer(15);
	self playsound(#"zmb_bgb_nysm_start");
	self clientfield::set_to_player("" + #"hash_18be2b4b3936ee1f", 1);
	ret = undefined;
	ret = self waittilltimeout(14.5, #"bgb_about_to_take_on_bled_out", #"end_game", #"bgb_update", #"disconnect");
	self playsound(#"zmb_bgb_nysm_end");
	if("timeout" != ret._notify)
	{
		visionset_mgr::deactivate("visionset", "zm_bgb_now_you_see_me", self);
	}
	self clientfield::set_to_player("" + #"hash_18be2b4b3936ee1f", 0);
	self.b_is_designated_target = 0;
}

