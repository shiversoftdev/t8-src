// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\filter_shared.csc;
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\visionset_mgr_shared.csc;

#namespace drown;

/*
	Name: __init__system__
	Namespace: drown
	Checksum: 0x7B67AD33
	Offset: 0xC8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"drown", &__init__, undefined, #"visionset_mgr");
}

/*
	Name: __init__
	Namespace: drown
	Checksum: 0x3FD12256
	Offset: 0x118
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "drown_stage", 1, 3, "int", &drown_stage_callback, 0, 0);
	callback::on_localplayer_spawned(&player_spawned);
	visionset_mgr::register_overlay_info_style_speed_blur("drown_blur", 1, 1, 0.04, 1, 1, 0, 0, 125, 125, 0);
	setup_radius_values();
}

/*
	Name: setup_radius_values
	Namespace: drown
	Checksum: 0x5A7A0B71
	Offset: 0x1E0
	Size: 0x53C
	Parameters: 0
	Flags: Linked
*/
function setup_radius_values()
{
	level.drown_radius[#"inner"][#"begin"][1] = 0.8;
	level.drown_radius[#"inner"][#"begin"][2] = 0.6;
	level.drown_radius[#"inner"][#"begin"][3] = 0.6;
	level.drown_radius[#"inner"][#"begin"][4] = 0.5;
	level.drown_radius[#"inner"][#"end"][1] = 0.5;
	level.drown_radius[#"inner"][#"end"][2] = 0.3;
	level.drown_radius[#"inner"][#"end"][3] = 0.3;
	level.drown_radius[#"inner"][#"end"][4] = 0.2;
	level.drown_radius[#"outer"][#"begin"][1] = 1;
	level.drown_radius[#"outer"][#"begin"][2] = 0.8;
	level.drown_radius[#"outer"][#"begin"][3] = 0.8;
	level.drown_radius[#"outer"][#"begin"][4] = 0.7;
	level.drown_radius[#"outer"][#"end"][1] = 0.8;
	level.drown_radius[#"outer"][#"end"][2] = 0.6;
	level.drown_radius[#"outer"][#"end"][3] = 0.6;
	level.drown_radius[#"outer"][#"end"][4] = 0.5;
	level.opacity[#"begin"][1] = 0.4;
	level.opacity[#"begin"][2] = 0.5;
	level.opacity[#"begin"][3] = 0.6;
	level.opacity[#"begin"][4] = 0.6;
	level.opacity[#"end"][1] = 0.5;
	level.opacity[#"end"][2] = 0.6;
	level.opacity[#"end"][3] = 0.7;
	level.opacity[#"end"][4] = 0.7;
}

/*
	Name: player_spawned
	Namespace: drown
	Checksum: 0x5F17167B
	Offset: 0x728
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function player_spawned(localclientnum)
{
	if(!self function_21c0fa55())
	{
		return;
	}
	self player_init_drown_values();
	self thread player_watch_drown_shutdown(localclientnum);
}

/*
	Name: player_init_drown_values
	Namespace: drown
	Checksum: 0x25406274
	Offset: 0x788
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function player_init_drown_values()
{
	if(!isdefined(self.drown_start_time))
	{
		self.drown_start_time = 0;
		self.drown_outerradius = 0;
		self.drown_innerradius = 0;
		self.drown_opacity = 0;
	}
}

/*
	Name: player_watch_drown_shutdown
	Namespace: drown
	Checksum: 0x8E9281A5
	Offset: 0x7D0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function player_watch_drown_shutdown(localclientnum)
{
	self waittill(#"death");
	self disable_drown(localclientnum);
}

/*
	Name: function_1a9dc208
	Namespace: drown
	Checksum: 0x4410EF61
	Offset: 0x818
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_1a9dc208()
{
	playerrole = self getrolefields();
	/#
		assert(isdefined(playerrole));
	#/
	if(isdefined(playerrole))
	{
		return int(playerrole.var_f0886300 * 1000);
	}
	return 2000;
}

/*
	Name: enable_drown
	Namespace: drown
	Checksum: 0xC9B3EE7E
	Offset: 0x8A0
	Size: 0xAA
	Parameters: 2
	Flags: Linked
*/
function enable_drown(localclientnum, stage)
{
	filter::init_filter_drowning_damage(localclientnum);
	filter::enable_filter_drowning_damage(localclientnum, 1);
	self.drown_start_time = getservertime(localclientnum) - (stage - 1) * self function_1a9dc208();
	self.drown_outerradius = 0;
	self.drown_innerradius = 0;
	self.drown_opacity = 0;
}

/*
	Name: disable_drown
	Namespace: drown
	Checksum: 0x1634943A
	Offset: 0x958
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function disable_drown(localclientnum)
{
	filter::disable_filter_drowning_damage(localclientnum, 1);
}

/*
	Name: player_drown_fx
	Namespace: drown
	Checksum: 0x886D0A11
	Offset: 0x988
	Size: 0x35E
	Parameters: 2
	Flags: Linked
*/
function player_drown_fx(localclientnum, stage)
{
	self endon(#"death");
	self endon(#"player_fade_out_drown_fx");
	self notify(#"player_drown_fx");
	self endon(#"player_drown_fx");
	self player_init_drown_values();
	var_f0886300 = self function_1a9dc208();
	lastoutwatertimestage = self.drown_start_time + ((stage - 1) * var_f0886300);
	stageduration = var_f0886300;
	if(stage == 1)
	{
		stageduration = 2000;
	}
	while(true)
	{
		currenttime = getservertime(localclientnum);
		elapsedtime = currenttime - self.drown_start_time;
		stageratio = math::clamp((currenttime - lastoutwatertimestage) / stageduration, 0, 1);
		if(!isdefined(stage))
		{
			stage = 1;
		}
		stage = math::clamp(stage, 1, 4);
		self.drown_outerradius = lerpfloat(level.drown_radius[#"outer"][#"begin"][stage], level.drown_radius[#"outer"][#"end"][stage], stageratio) * 1.41421;
		self.drown_innerradius = lerpfloat(level.drown_radius[#"inner"][#"begin"][stage], level.drown_radius[#"inner"][#"end"][stage], stageratio) * 1.41421;
		self.drown_opacity = lerpfloat(level.opacity[#"begin"][stage], level.opacity[#"end"][stage], stageratio);
		filter::set_filter_drowning_damage_inner_radius(localclientnum, 1, self.drown_innerradius);
		filter::set_filter_drowning_damage_outer_radius(localclientnum, 1, self.drown_outerradius);
		filter::set_filter_drowning_damage_opacity(localclientnum, 1, self.drown_opacity);
		waitframe(1);
	}
}

/*
	Name: player_fade_out_drown_fx
	Namespace: drown
	Checksum: 0xFDDA2F56
	Offset: 0xCF0
	Size: 0x1F4
	Parameters: 1
	Flags: Linked
*/
function player_fade_out_drown_fx(localclientnum)
{
	self endon(#"death");
	self endon(#"player_drown_fx");
	self notify(#"player_fade_out_drown_fx");
	self endon(#"player_fade_out_drown_fx");
	self player_init_drown_values();
	fadestarttime = getservertime(localclientnum);
	currenttime = getservertime(localclientnum);
	while(currenttime - fadestarttime < 250)
	{
		ratio = (currenttime - fadestarttime) / 250;
		outerradius = lerpfloat(self.drown_outerradius, 1.41421, ratio);
		innerradius = lerpfloat(self.drown_innerradius, 1.41421, ratio);
		opacity = lerpfloat(self.drown_opacity, 0, ratio);
		filter::set_filter_drowning_damage_outer_radius(localclientnum, 1, outerradius);
		filter::set_filter_drowning_damage_inner_radius(localclientnum, 1, innerradius);
		filter::set_filter_drowning_damage_opacity(localclientnum, 1, opacity);
		waitframe(1);
		currenttime = getservertime(localclientnum);
	}
	self disable_drown(localclientnum);
}

/*
	Name: drown_stage_callback
	Namespace: drown
	Checksum: 0xF74932CF
	Offset: 0xEF0
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function drown_stage_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval > 0)
	{
		self enable_drown(localclientnum, newval);
		self thread player_drown_fx(localclientnum, newval);
	}
	else
	{
		if(!bnewent)
		{
			self thread player_fade_out_drown_fx(localclientnum);
		}
		else
		{
			self disable_drown(localclientnum);
		}
	}
}

