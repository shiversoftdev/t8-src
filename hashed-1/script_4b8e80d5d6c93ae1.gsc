// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;

#namespace zombie_vortex;

/*
	Name: function_89f2df9
	Namespace: zombie_vortex
	Checksum: 0xB36F33FA
	Offset: 0x1E0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"vortex", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zombie_vortex
	Checksum: 0x8824C816
	Offset: 0x228
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	visionset_mgr::register_visionset_info("zm_idgun_vortex" + "_visionset", 1, 30, undefined, "zm_idgun_vortex");
	visionset_mgr::register_overlay_info_style_speed_blur("zm_idgun_vortex" + "_blur", 1, 1, 0.08, 0.75, 0.9);
	clientfield::register("scriptmover", "vortex_start", 1, 2, "counter", &function_8e7d94b, 0, 0);
	clientfield::register("allplayers", "vision_blur", 1, 1, "int", &vision_blur, 0, 0);
}

/*
	Name: function_8e7d94b
	Namespace: zombie_vortex
	Checksum: 0x138595F9
	Offset: 0x348
	Size: 0x1DC
	Parameters: 7
	Flags: Linked
*/
function function_8e7d94b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	self endon(#"disconnect");
	if(!isdefined(newval) || newval == 0)
	{
		return;
	}
	e_player = function_5c10bd79(localclientnum);
	var_3d2b5c8c = self.origin;
	newval = newval - oldval;
	if(newval == 2)
	{
		var_84c2624b = "zombie/fx_idgun_vortex_ug_zod_zmb";
		var_800bc32d = "zombie/fx_idgun_vortex_explo_ug_zod_zmb";
		n_vortex_time = 10;
	}
	else
	{
		var_84c2624b = "zombie/fx_idgun_vortex_zod_zmb";
		var_800bc32d = "zombie/fx_idgun_vortex_explo_zod_zmb";
		n_vortex_time = 5;
	}
	vortex_fx_handle = playfx(localclientnum, var_84c2624b, var_3d2b5c8c);
	setfxignorepause(localclientnum, vortex_fx_handle, 1);
	playsound(0, #"wpn_idgun_portal_start", var_3d2b5c8c);
	audio::playloopat("wpn_idgun_portal_loop", var_3d2b5c8c);
	self thread vortex_shake_and_rumble(localclientnum, var_3d2b5c8c);
	self thread function_2dd3c5bc(localclientnum, vortex_fx_handle, var_3d2b5c8c, var_800bc32d, n_vortex_time);
}

/*
	Name: vortex_shake_and_rumble
	Namespace: zombie_vortex
	Checksum: 0x6B4A5B90
	Offset: 0x530
	Size: 0x60
	Parameters: 2
	Flags: Linked
*/
function vortex_shake_and_rumble(localclientnum, v_vortex_origin)
{
	self endon(#"vortex_stop");
	while(true)
	{
		self playrumbleonentity(localclientnum, "zod_idgun_vortex_interior");
		wait(0.075);
	}
}

/*
	Name: vision_blur
	Namespace: zombie_vortex
	Checksum: 0xBAAD6B57
	Offset: 0x598
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function vision_blur(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		enablespeedblur(localclientnum, 0.1, 0.5, 0.75);
	}
	else
	{
		disablespeedblur(localclientnum);
	}
}

/*
	Name: function_2dd3c5bc
	Namespace: zombie_vortex
	Checksum: 0x8DBA4A53
	Offset: 0x630
	Size: 0x224
	Parameters: 5
	Flags: Linked
*/
function function_2dd3c5bc(localclientnum, vortex_fx_handle, var_3d2b5c8c, var_800bc32d, n_vortex_time)
{
	e_player = function_5c10bd79(localclientnum);
	n_starttime = e_player getclienttime();
	n_currtime = e_player getclienttime() - n_starttime;
	n_vortex_time = int(n_vortex_time * 1000);
	while(n_currtime < n_vortex_time)
	{
		waitframe(1);
		n_currtime = e_player getclienttime() - n_starttime;
	}
	stopfx(localclientnum, vortex_fx_handle);
	audio::stoploopat("wpn_idgun_portal_loop", var_3d2b5c8c);
	playsound(0, #"wpn_idgun_portal_stop", var_3d2b5c8c);
	wait(0.15);
	self notify(#"vortex_stop");
	var_ad8208a9 = playfx(localclientnum, var_800bc32d, var_3d2b5c8c);
	setfxignorepause(localclientnum, var_ad8208a9, 1);
	playsound(0, #"wpn_idgun_portal_explode", var_3d2b5c8c);
	waitframe(1);
	self playrumbleonentity(localclientnum, "zod_idgun_vortex_shockwave");
	vision_blur(localclientnum, undefined, 1);
	wait(0.1);
	vision_blur(localclientnum, undefined, 0);
}

