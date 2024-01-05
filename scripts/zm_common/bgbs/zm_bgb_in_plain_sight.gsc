// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

#namespace zm_bgb_in_plain_sight;

/*
	Name: __init__system__
	Namespace: zm_bgb_in_plain_sight
	Checksum: 0xD0F0C244
	Offset: 0xE0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_in_plain_sight", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_in_plain_sight
	Checksum: 0x7B751CAE
	Offset: 0x130
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_in_plain_sight", "activated", 1, undefined, undefined, undefined, &activation);
	bgb::function_72469efe(#"zm_bgb_in_plain_sight", 1);
	bgb::function_8a5d8cfb(#"zm_bgb_in_plain_sight", 1);
	bgb::function_57eb02e(#"zm_bgb_in_plain_sight");
	if(!isdefined(level.vsmgr_prio_visionset_zm_bgb_in_plain_sight))
	{
		level.vsmgr_prio_visionset_zm_bgb_in_plain_sight = 110;
	}
	visionset_mgr::register_info("visionset", "zm_bgb_in_plain_sight", 1, level.vsmgr_prio_visionset_zm_bgb_in_plain_sight, 31, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
	clientfield::register("toplayer", "" + #"hash_321b58d22755af74", 1, 1, "int");
}

/*
	Name: validation
	Namespace: zm_bgb_in_plain_sight
	Checksum: 0xFAA993E8
	Offset: 0x2B0
	Size: 0x42
	Parameters: 0
	Flags: None
*/
function validation()
{
	if(self bgb::get_active() || (isdefined(self.var_800f306a) && self.var_800f306a))
	{
		return false;
	}
	return true;
}

/*
	Name: activation
	Namespace: zm_bgb_in_plain_sight
	Checksum: 0xB0BDAC6C
	Offset: 0x300
	Size: 0x1AE
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self endon(#"disconnect");
	self val::set(#"hash_69d303dd5e34b7b7", "ignoreme");
	self.bgb_in_plain_sight_active = 1;
	self playsound(#"zmb_bgb_plainsight_start");
	self thread bgb::run_timer(10);
	self clientfield::set_to_player("" + #"hash_321b58d22755af74", 1);
	ret = undefined;
	ret = self waittilltimeout(9.5, #"bgb_about_to_take_on_bled_out", #"end_game", #"bgb_update", #"disconnect", #"scene_igc_shot_started");
	self playsound(#"zmb_bgb_plainsight_end");
	self clientfield::set_to_player("" + #"hash_321b58d22755af74", 0);
	self val::reset(#"hash_69d303dd5e34b7b7", "ignoreme");
	self.bgb_in_plain_sight_active = undefined;
}

